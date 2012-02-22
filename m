From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC 1/7] ASoC: imx-ssi: Set dma data early
Date: Wed, 22 Feb 2012 10:49:05 +0100
Message-ID: <1329904151-5927-2-git-send-email-lars@metafoo.de>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-093.synserver.de
	[212.40.185.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D1998103B38
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 10:47:43 +0100 (CET)
In-Reply-To: <1329904151-5927-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Move the call to snd_soc_dai_set_dma_data from the hw_params callback to the
startup callback. This allows us to use the dma data in the pcm driver's open
callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/imx-ssi.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 01d1f74..dbf43f5 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -233,6 +233,23 @@ static int imx_ssi_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
+static int imx_ssi_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *cpu_dai)
+{
+	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct imx_pcm_dma_params *dma_data;
+
+	/* Tx/Rx config */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_data = &ssi->dma_params_tx;
+	else
+		dma_data = &ssi->dma_params_rx;
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
+
+	return 0;
+}
+
 /*
  * Should only be called when port is inactive (i.e. SSIEN = 0),
  * although can be called multiple times by upper layers.
@@ -242,23 +259,17 @@ static int imx_ssi_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
-	struct imx_pcm_dma_params *dma_data;
 	u32 reg, sccr;
 
 	/* Tx/Rx config */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = SSI_STCCR;
-		dma_data = &ssi->dma_params_tx;
-	} else {
+	else
 		reg = SSI_SRCCR;
-		dma_data = &ssi->dma_params_rx;
-	}
 
 	if (ssi->flags & IMX_SSI_SYN)
 		reg = SSI_STCCR;
 
-	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
-
 	sccr = readl(ssi->base + reg) & ~SSI_STCCR_WL_MASK;
 
 	/* DAI data (word) size */
@@ -343,6 +354,7 @@ static int imx_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 }
 
 static const struct snd_soc_dai_ops imx_ssi_pcm_dai_ops = {
+	.startup	= imx_ssi_startup,
 	.hw_params	= imx_ssi_hw_params,
 	.set_fmt	= imx_ssi_set_dai_fmt,
 	.set_clkdiv	= imx_ssi_set_dai_clkdiv,
-- 
1.7.9
