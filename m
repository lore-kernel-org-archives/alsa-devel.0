From: Timur Tabi <timur@freescale.com>
Subject: Re: Requiring the same sample rate for playback and
 record?
Date: Fri, 25 Jul 2008 14:55:32 -0500
Message-ID: <488A2FB4.7040202@freescale.com>
References: <485C0042.4050008@freescale.com>
	<s5h7icg4dsd.wl%tiwai@suse.de>	<487BC430.8040109@freescale.com>
	<s5hmyki14d5.wl%tiwai@suse.de>	<487E49CF.7010709@freescale.com>
	<s5h7ibk3joa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 019DB2441C
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jul 2008 21:55:36 +0200 (CEST)
In-Reply-To: <s5h7ibk3joa.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Then you can call like:
> 
>      snd_pcm_hw_constraint_minmax(substream->runtime,
> 		SNDRV_PCM_HW_PARAM_RATE, fixed_rate, fixed_rate);

Ok, I think I got this working.  However, I'm not sure how to handle the sample
size.  I have this:

	struct snd_pcm_runtime *first_runtime =
		ssi_private->first_stream->runtime;

	snd_pcm_hw_constraint_minmax(substream->runtime,
		SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
		first_runtime->sample_bits, first_runtime->sample_bits);

Is SNDRV_PCM_HW_PARAM_SAMPLE_BITS for the logical or physical width?  That is,
if my first stream is playing S24_BE samples, do I restrict the second stream to
24 bits or 32 bits?

-- 
Timur Tabi
Linux kernel developer at Freescale
