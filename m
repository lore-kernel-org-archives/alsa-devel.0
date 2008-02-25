From: Timur Tabi <timur@freescale.com>
Subject: Re: How does ALSA detect underrun in OSS emulation?
Date: Mon, 25 Feb 2008 09:38:38 -0600
Message-ID: <47C2E0FE.2020207@freescale.com>
References: <47C2DD41.9070408@freescale.com> <s5hhcfxt5ih.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 0499224388
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 16:38:42 +0100 (CET)
In-Reply-To: <s5hhcfxt5ih.wl%tiwai@suse.de>
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

> It's just as same as on ALSA native API, checks the validity of the
> current position reported by pointer callback in
> snd_pcm_period_elapsed().

Are you talking about this code in snd_pcm_update_hw_ptr_pos?

	pos = substream->ops->pointer(substream);
	if (pos == SNDRV_PCM_POS_XRUN)
		return pos; /* XRUN */

What if my 'pointer' function never returns SNDRV_PCM_POS_XRUN?  How else can I 
get an underrun detected?

-- 
Timur Tabi
Linux kernel developer at Freescale
