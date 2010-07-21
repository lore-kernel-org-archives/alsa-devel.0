From: Timur Tabi <timur@freescale.com>
Subject: multi-component: determine which DAI is active?
Date: Wed, 21 Jul 2010 17:47:01 -0500
Message-ID: <4C4778E5.6090200@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id E99772445D
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 00:47:06 +0200 (CEST)
Received: from mail36-tx2 (localhost.localdomain [127.0.0.1])	by
	mail36-tx2-R.bigfish.com (Postfix) with ESMTP id DEF43D68986	for
	<alsa-devel@alsa-project.org>; Wed, 21 Jul 2010 22:47:04 +0000 (UTC)
Received: from TX2EHSMHS041.bigfish.com (unknown [10.9.14.238])	by
	mail36-tx2.bigfish.com (Postfix) with ESMTP id B634F1B5004E	for
	<alsa-devel@alsa-project.org>; Wed, 21 Jul 2010 22:47:04 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6LMl2qM028025	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 15:47:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6LMvvnT026177	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 17:57:57 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Liam,

In order to get fsl_dma.c to work with the WM8776, which has separate DAIs
for playback and capture, I've had to do this:

if (pcm->streams[0].substream) {
	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
		fsl_dma_hardware.buffer_bytes_max,
		&pcm->streams[0].substream->dma_buffer);
	if (ret) {
		dev_err(card->dev, "can't allocate playback dma buffer\n");
		return ret;
	}
}

if (pcm->streams[1].substream) {
	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
		fsl_dma_hardware.buffer_bytes_max,
		&pcm->streams[1].substream->dma_buffer);
	if (ret) {
		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
		dev_err(card->dev, "can't allocate capture dma buffer\n");
		return ret;
	}
}

That is, I need to check if the 'substream' pointer has been initialized.

This looks ugly to me.  In an earlier version of ASoC, I would have done this:

if (dai->playback.channels_min) {
...

if (dai->capture.channels_min) {
...


But dai->playback and dai->capture no longer exist.  How should I handle this?
