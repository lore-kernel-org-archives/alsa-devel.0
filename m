From: Timur Tabi <timur@freescale.com>
Subject: Re: Possible problem with snd_pcm_oss_sync()
Date: Wed, 21 May 2008 09:15:06 -0500
Message-ID: <48342E6A.6060005@freescale.com>
References: <4832F65E.5070008@freescale.com> <s5hr6bwvsvl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 0807B24360
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 16:15:10 +0200 (CEST)
In-Reply-To: <s5hr6bwvsvl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> The sync ioctl is to block the operation until all samples are
> played.  But, it's a bit strange that the stream stops after this.  It
> should be an underrun instead (and OSS recovers by itself).

I figured it out.  When the application starts, my driver gets a call to the
_hw_params and _prepare functions.  When the app calls SNDCTL_DSP_SYNC, those
two functions get called again.  At that point, the DMA controller gets
re-programmed.  For some reason, it doesn't like that.  The DMA never actually
starts.

I moved some of the DMA programming code to my _open function (where it belongs,
anyway), and now bplay works.

Well, almost.  After about a second into playback, it skips a little bit.  And
then about 4-5 seconds later, bplay calls SNDCTL_DSP_SYNC, and that causes
playback to pause for about a second.

I need to figure out why bplay is calling sync, and why the audio skips in the
beginning.

-- 
Timur Tabi
Linux kernel developer at Freescale
