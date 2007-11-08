From: Timur Tabi <timur@freescale.com>
Subject: Re: Any OSS changes from kernel 2.6.21 to 2.6.23?
 Something broke.
Date: Thu, 08 Nov 2007 13:33:17 -0600
Message-ID: <4733647D.9040601@freescale.com>
References: <472B4416.8060009@freescale.com> <s5hfxzkwyvo.wl%tiwai@suse.de>
	<47325517.2000407@freescale.com>
	<1194507244.16131.1220189539@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 07C9D2491D
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 20:33:23 +0100 (CET)
In-Reply-To: <1194507244.16131.1220189539@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Timur Tabi wrote:
>> It turns out that ALSA (when using mplayer to play a divx video file via OSS 
>> emulation) is rapidly sending back-to-back SNDRV_PCM_TRIGGER_STOP and 
>> SNDRV_PCM_TRIGGER_START commands.  Why would it do that?
> 
> To recover from underruns.

I've added some function traces to ALSA, and apparently ALSA is telling the 
driver to STOP when the driver calls snd_pcm_period_elapsed().  Here's a log:

snd_pcm_period_elapsed
snd_pcm_update_hw_ptr_interrupt:232  <- last line of this function
PERIOD	<- printk in the driver's ISR
snd_pcm_period_elapsed
snd_pcm_update_hw_ptr_interrupt:232
snd_pcm_update_hw_ptr_post
xrun
snd_pcm_stop
snd_pcm_action
snd_pcm_action_single
snd_pcm_do_stop
STOP 279 <- command to stop after sub-buffer #279, which is at the end of the period

Unfortunately, very little of the code in sound/core/pcm???.c is documented, so 
I'm having a hard time figuring out what's going on.  Why is ALSA telling the 
driver to stop during a period interrupt?

-- 
Timur Tabi
Linux kernel developer at Freescale
