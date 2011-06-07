From: Timur Tabi <timur@freescale.com>
Subject: Something broke in snd_soc_pcm_stream
Date: Tue, 7 Jun 2011 16:31:52 -0500
Message-ID: <4DEE98C8.2010706@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A43F245B1
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 23:32:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Mark,

I'm testing your for-3.1 branch on the P1022DS, and I'm getting a kernel panic
because a pointer is NULL where I don't expect it to be.  In fsl_dma_new(), I
have this code:

if (dai->driver->capture.channels_min) {
	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
		fsl_dma_hardware.buffer_bytes_max,
		&pcm->streams[1].substream->dma_buffer);
	if (ret) {
		dev_err(card->dev, "can't alloc capture dma buffer\n");
		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
		return ret;
	}
}

I test for channels_min because the playback stream is registered separately
from the capture stream, so I expect fsl_dma_new() to be called twice: once to
initialize playback, and again to initialize capture.

In the past, if dai->driver->capture.channels_min was equal to some non-zero
value, then pcm->streams[1].substream was also non-NULL.  This appears no longer
to be true.  Now it appears that playback.channels_min and capture.channels_min
are both set to 2 before fsl_dma_new() is called the first time.

I can change my code to do this:

if (pcm->streams[1].substream) {
	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
		fsl_dma_hardware.buffer_bytes_max,
		&pcm->streams[1].substream->dma_buffer);
	if (ret) {
		dev_err(card->dev, "can't alloc capture dma buffer\n");
		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
		return ret;
	}
}

But before I do that, I'd like to know if this is a bug in ASoC, or just a new
behavior that I need to handle.

-- 
Timur Tabi
Linux kernel developer at Freescale
