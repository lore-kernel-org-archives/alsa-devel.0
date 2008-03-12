From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: AK4114 - capturing spdif input stops the stream
Date: Wed, 12 Mar 2008 23:50:08 +0100
Message-ID: <47D85E20.7060109@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E8491038B1
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 23:50:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

here is my scenario:

ICE1724 card, trying to record from SPDIF input via AK4114, ICE1724 
slaved to SPDIF clock from the receiver.

The card detects SPDIF input rate correctly (in my case ESI Juli where 
AK4114 is provided with independent clock signal to enable the rate 
detection). Let's say it is 192000.

Now I want to arecord the input stream, let's say in CD quality, using 
the plug plugin. The command fails, because of the check in ak4114.c:

res = external_rate(rcs1);
	if (!(flags & AK4114_CHECK_NO_RATE) && runtime && runtime->rate != res) {
		snd_pcm_stream_lock_irqsave(ak4114->capture_substream, _flags);
		if (snd_pcm_running(ak4114->capture_substream)) {
			printk(KERN_DEBUG "rate changed (%i <- %i)\n", runtime->rate, res);
			snd_pcm_stop(ak4114->capture_substream, SNDRV_PCM_STATE_DRAINING);
			res = 1;
		}
		snd_pcm_stream_unlock_irqrestore(ak4114->capture_substream, _flags);
	}

The stream gets stopped because res = 192000 and runtime->rate = 44100.

The problem is that the capture device still offers all the available 
rates, instead of the single SPDIF input one. Thus, the plug plugin is 
not forced to convert from 192000 to 44100 and runtime->rate is 44100 
instead of 192000.

Of course recording at 192000 works fine.

What would be the best way to force the SPDIF capture device to offer 
(advertise) only the current rate? This functionality would have to be 
applicable only to the few cards correctly detecting incoming rate 
(unlike most ice1724 cards without independent clock in slave mode).

If the card cannot detect input frequency reliably (the driver developer 
should know), I guess it should not do the check in ak4114.c at all - I 
can prepare a simple patch for that.

The same will most probably apply to cards with AK4117 as the code looks 
the same.

I know it is a minor issue but if a user hits this problem, it will take 
him a lot of effort to fix his setup appropriately.

Thanks,

Pavel.
