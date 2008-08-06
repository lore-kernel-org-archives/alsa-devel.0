From: Timur Tabi <timur@freescale.com>
Subject: Re: How to report error in _pointer function?
Date: Wed, 06 Aug 2008 16:54:38 -0500
Message-ID: <489A1D9E.7040709@freescale.com>
References: <ed82fe3e0807300856q6c6daf99n224df8ae4bfe6954@mail.gmail.com>
	<s5hhca7s64k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id EFD7B10399E
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 23:54:45 +0200 (CEST)
In-Reply-To: <s5hhca7s64k.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> You can return SNDRV_PCM_POS_XRUN from the pointer callback (with
> kernel messages if you like).  Then the PCM stream is stopped and the
> status is changed to SND_PCM_STATUS_XRUN.  Further access will result
> in -EPIPE.

This doesn't seem to work.  I don't get any more underrun/overrun messages, but
 the application doesn't know that something's failed.

With mplayer, I see this message:

alsa-lib: pcm_hw.c:405:(snd_pcm_hw_hwsync) SNDRV_PCM_IOCTL_HWSYNC failed: Broken
pipe

And then mplayer hangs with the status bar here:

A:   0.0 (00.0) of 249.0 (04:09.0) ??,?% $<50>

aplay just hangs.

I also tried adding this code to my _pointer function:

	snd_pcm_stream_lock_irqsave(substream, flags);

	if (snd_pcm_running(substream))
		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);

	snd_pcm_stream_unlock_irqrestore(substream, flags);

but it didn't make any difference.

-- 
Timur Tabi
Linux kernel developer at Freescale
