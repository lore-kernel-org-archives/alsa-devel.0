From: Timur Tabi <timur@freescale.com>
Subject: asoc: fsl_dma_hw_free being called twice at end of
	playback
Date: Mon, 03 May 2010 15:51:04 -0500
Message-ID: <4BDF3738.3070900@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id C7EB8246ED
	for <alsa-devel@alsa-project.org>;
	Mon,  3 May 2010 22:51:12 +0200 (CEST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o43Kp5mE001525
	for <alsa-devel@alsa-project.org>; Mon, 3 May 2010 13:51:08 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o43L1PC4012199
	for <alsa-devel@alsa-project.org>; Mon, 3 May 2010 16:01:26 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

In my 8610 ASoC driver, I'm seeing the DMA driver's .hw_free function being
called twice whenever playback ends.  I've added some printk's to demonstrate:

snd_pcm_common_ioctl1:2543
snd_pcm_hw_free:543
soc_pcm_hw_free:761 c023983c
fsl_dma_hw_free:720 substream=df029d00 dma_private=df440000 stream=0
snd_pcm_release_substream:2022
soc_pcm_hw_free:761 c023983c
fsl_dma_hw_free:720 substream=df029d00 dma_private=df440000 stream=0
fsl_dma_close:759 substream=df029d00 dma_private=df440000

So the ioctl is being called only once, but the both snd_pcm_hw_free() and
snd_pcm_release_substream() are calling the .hw_free function.

Is this normal?  I don't know how to handle this, other than to add some
boolean to my private data structure that indicates whether the resources
have been freed or not.

-- 
Timur Tabi
Linux kernel developer at Freescale
