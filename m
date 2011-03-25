From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/3] ASoC: imx: fix burstsize for DMA
Date: Fri, 25 Mar 2011 16:51:45 +0100
Message-ID: <1301068306-11997-3-git-send-email-w.sang@pengutronix.de>
References: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A91D7103A7F
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 16:52:01 +0100 (CET)
In-Reply-To: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, open list <linux-kernel@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

SSI counts in words, the DMA engine in bytes. (Wrong) factor got removed
in bf974a0 (ASoC i.MX: switch to new DMA api).

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 sound/soc/imx/imx-pcm-dma-mx2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index b2ed764..aab7765 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -110,12 +110,12 @@ static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream,
 		slave_config.direction = DMA_TO_DEVICE;
 		slave_config.dst_addr = dma_params->dma_addr;
 		slave_config.dst_addr_width = buswidth;
-		slave_config.dst_maxburst = dma_params->burstsize;
+		slave_config.dst_maxburst = dma_params->burstsize * buswidth;
 	} else {
 		slave_config.direction = DMA_FROM_DEVICE;
 		slave_config.src_addr = dma_params->dma_addr;
 		slave_config.src_addr_width = buswidth;
-		slave_config.src_maxburst = dma_params->burstsize;
+		slave_config.src_maxburst = dma_params->burstsize * buswidth;
 	}
 
 	ret = dmaengine_slave_config(iprtd->dma_chan, &slave_config);
-- 
1.7.2.5
