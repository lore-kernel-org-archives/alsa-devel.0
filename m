From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH] ASoC: Fix DMA channel leak in imx-pcm-dma-mx2
	driver.
Date: Thu, 12 Jan 2012 12:30:38 +0100
Message-ID: <1326367838-12947-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8617B2412E
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 12:30:48 +0100 (CET)
Received: by wibhm6 with SMTP id hm6so1219954wib.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 03:30:48 -0800 (PST)
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, Javier Martin <javier.martin@vista-silicon.com>, arnaud.patard@rtp-net.org
List-Id: alsa-devel@alsa-project.org

"snd_imx_pcm_hw_params" callback can be called
several times by the user (i.e. OSS emulation)
leading to a DMA channel leak.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/imx/imx-pcm-dma-mx2.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index 43fdc24..d2bb1cb 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -88,11 +88,13 @@ static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream,
 	iprtd->dma_data.dma_request = dma_params->dma;
 
 	/* Try to grab a DMA channel */
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	iprtd->dma_chan = dma_request_channel(mask, filter, iprtd);
-	if (!iprtd->dma_chan)
-		return -EINVAL;
+	if (!iprtd->dma_chan) {
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		iprtd->dma_chan = dma_request_channel(mask, filter, iprtd);
+		if (!iprtd->dma_chan)
+			return -EINVAL;
+	}
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-- 
1.7.0.4
