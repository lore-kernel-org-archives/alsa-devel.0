From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: tlv320aic32x4 Codec ADC and DAC must shutdown to alter
	clocks
Date: Wed, 12 Mar 2014 16:08:40 +0100
Message-ID: <53207878.2060107@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp09.online.nl (smtp09.online.nl [194.134.42.54])
 by alsa0.perex.cz (Postfix) with ESMTP id EE1A3264F07
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 16:08:40 +0100 (CET)
Received: from smtp09.online.nl (localhost [127.0.0.1])
 by smtp09.online.nl (Postfix) with ESMTP id 5ACEC1E162
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 16:08:40 +0100 (CET)
Received: from [192.168.1.11] (s55969068.adsl.online.nl [85.150.144.104])
 by smtp09.online.nl (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 16:08:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

My general question: If "my" codec needs to alter the state of the DAPM 
tree, how can the codec ask or inform the DAPM components of this?


This problem occurs on tlv320aic32x4 codecs, but probably applies to 
many others as well.

Using the tlv320aic32x4 a simple loop like this may "crash" the codec:

while true
do
    speaker-test -c 2 -t sine -l 1 -r 48000 > /dev/null
    speaker-test -c 2 -t sine -l 1 -r 44100 > /dev/null
done 


A "crash" means, in this respect that the chip loses some of its 
settings, malfunctions and often it results in NACKs on I2C commands.

I've been trying to properly fix this, but it just won't fit in the 
framework.

The cause is that the DAPM starts the DAC and/or ADC cores while the 
clocks aren't running, and stops the clocks before shutting down the cores.

There is the overall bug of the driver that starts and stops all the 
clocks in the aic32x4_set_bias_level in the wrong order - it should 
start them from source to sink, and stop them in the opposite direction, 
so the PLL must be the first to start and last to stop. Apparently this 
isn't really critical as I've never observed failure as a result of this.

What I cannot fix is that changing the parameters (like clock frequency) 
must stop the DAC core.

The DAPM framework just sets the BIAS to "ON" only once, and does not 
shut down until after a time out. Which is good.
But if the next stream to play needs a different clock setting, the DAC 
must be stopped first, the code must wait until the DAC has powered 
down, and then the clocks can be stopped and altered. When all settings 
are done, the DAC can be restarted.

Starting the DAC is the DAPM's task, it's this line that does the job:

SND_SOC_DAPM_DAC("Left DAC", "Left Playback", AIC32X4_DACSETUP, 7, 0),

I can detect the change in the hw_params, and on the first stream to 
play, this is called while still in STANDBY or lower levels. However, 
when the codec is already in ON bias level, how do I tell DAPM that I 
had to shut down the DAC in order to change the parameters? Just 
toggling the related bits will keep the DAC powered down. A routine to 
store and restore the power state is possible, but very ineffective. 
Especially since the "I must shutdown" conclusion can also be in the 
clock setting routine. That would result in multiple down-up cycles.


-- 
Mike Looijmans
