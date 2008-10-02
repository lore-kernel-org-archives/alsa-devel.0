From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: Add destination and source port for
	DMA on OMAP1
Date: Thu,  2 Oct 2008 11:02:27 +0100
Message-ID: <1222941751-3238-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081002100200.GA3025@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3DB7E24513
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 12:02:33 +0200 (CEST)
In-Reply-To: <20081002100200.GA3025@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

From: Arun KS <arunks@mistralsolutions.com>

Adds destination and source port for dma in platform driver as
required by OMAP1

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-pcm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 690bfea..e9084fd 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -97,7 +97,7 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
 	prtd->dma_data = dma_data;
 	err = omap_request_dma(dma_data->dma_req, dma_data->name,
 			       omap_pcm_dma_irq, substream, &prtd->dma_ch);
-	if (!cpu_is_omap1510()) {
+	if (!err & !cpu_is_omap1510()) {
 		/*
 		 * Link channel with itself so DMA doesn't need any
 		 * reprogramming while looping the buffer
@@ -147,12 +147,14 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 		dma_params.src_or_dst_synch	= OMAP_DMA_DST_SYNC;
 		dma_params.src_start		= runtime->dma_addr;
 		dma_params.dst_start		= dma_data->port_addr;
+		dma_params.dst_port		= OMAP_DMA_PORT_MPUI;
 	} else {
 		dma_params.src_amode		= OMAP_DMA_AMODE_CONSTANT;
 		dma_params.dst_amode		= OMAP_DMA_AMODE_POST_INC;
 		dma_params.src_or_dst_synch	= OMAP_DMA_SRC_SYNC;
 		dma_params.src_start		= dma_data->port_addr;
 		dma_params.dst_start		= runtime->dma_addr;
+		dma_params.src_port		= OMAP_DMA_PORT_MPUI;
 	}
 	/*
 	 * Set DMA transfer frame size equal to ALSA period size and frame
-- 
1.5.6.5
