From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: multi-component: determine which DAI is active?
Date: Thu, 22 Jul 2010 09:09:35 +0100
Message-ID: <1279786175.3083.14.camel@odin>
References: <4C4778E5.6090200@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 84FA810380C
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 10:09:39 +0200 (CEST)
Received: by wwb22 with SMTP id 22so1569042wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 01:09:39 -0700 (PDT)
In-Reply-To: <4C4778E5.6090200@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-07-21 at 17:47 -0500, Timur Tabi wrote:
> Liam,
> 
> In order to get fsl_dma.c to work with the WM8776, which has separate DAIs
> for playback and capture, I've had to do this:
> 
> if (pcm->streams[0].substream) {
> 	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
> 		fsl_dma_hardware.buffer_bytes_max,
> 		&pcm->streams[0].substream->dma_buffer);
> 	if (ret) {
> 		dev_err(card->dev, "can't allocate playback dma buffer\n");
> 		return ret;
> 	}
> }
> 
> if (pcm->streams[1].substream) {
> 	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
> 		fsl_dma_hardware.buffer_bytes_max,
> 		&pcm->streams[1].substream->dma_buffer);
> 	if (ret) {
> 		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
> 		dev_err(card->dev, "can't allocate capture dma buffer\n");
> 		return ret;
> 	}
> }
> 
> That is, I need to check if the 'substream' pointer has been initialized.
> 
> This looks ugly to me.  In an earlier version of ASoC, I would have done this:
> 
> if (dai->playback.channels_min) {
> ...
> 
> if (dai->capture.channels_min) {
> ...
> 
> 
> But dai->playback and dai->capture no longer exist.  How should I handle this?
> 

Since the DAI driver max/min supported number of channels is driver
specific and static, it's now in the DAI driver :-

if (dai->driver->playback.channels_min) {

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
