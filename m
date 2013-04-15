From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/17] ASoC: omap: Setup dma data in DAI probe
Date: Mon, 15 Apr 2013 19:20:00 +0200
Message-ID: <1366046404-8759-14-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B900265264
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:30 +0200 (CEST)
In-Reply-To: <1366046404-8759-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

This allows us to access the DAI DMA data when we create the PCM. We'll use
this when converting omap to generic DMA engine PCM driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/omap-dmic.c  |  4 +++-
 sound/soc/omap/omap-hdmi.c  | 12 ++++++++++--
 sound/soc/omap/omap-mcbsp.c |  6 +++---
 sound/soc/omap/omap-mcpdm.c |  7 ++++---
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 2ad0370..257b5e5 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -114,7 +114,6 @@ static int omap_dmic_dai_startup(struct snd_pcm_substream *substream,
 
 	mutex_unlock(&dmic->mutex);
 
-	snd_soc_dai_set_dma_data(dai, substream, &dmic->dma_data);
 	return ret;
 }
 
@@ -418,6 +417,9 @@ static int omap_dmic_probe(struct snd_soc_dai *dai)
 
 	/* Configure DMIC threshold value */
 	dmic->threshold = OMAP_DMIC_THRES_MAX - 3;
+
+	dai->playback_dma_data = &dmic->dma_data;
+
 	return 0;
 }
 
diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index ced3b88..d5c5cf4 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -69,8 +69,6 @@ static int omap_hdmi_dai_startup(struct snd_pcm_substream *substream,
 		return -ENODEV;
 	}
 
-	snd_soc_dai_set_dma_data(dai, substream, &priv->dma_data);
-
 	return 0;
 }
 
@@ -250,7 +248,17 @@ static const struct snd_soc_dai_ops omap_hdmi_dai_ops = {
 	.shutdown	= omap_hdmi_dai_shutdown,
 };
 
+static int omap_hdmi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct hdmi_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	dai->playback_dma_data = &priv->dma_data;
+
+	return 0;
+}
+
 static struct snd_soc_dai_driver omap_hdmi_dai = {
+	.probe = omap_hdmi_dai_probe,
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 8,
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index eadbfb6..dd74933 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -149,9 +149,6 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 2);
 	}
 
-	snd_soc_dai_set_dma_data(cpu_dai, substream,
-				 &mcbsp->dma_data[substream->stream]);
-
 	return err;
 }
 
@@ -554,6 +551,9 @@ static int omap_mcbsp_probe(struct snd_soc_dai *dai)
 
 	pm_runtime_enable(mcbsp->dev);
 
+	dai->playback_dma_data = &mcbsp->dma_data[0];
+	dai->capture_dma_data = &mcbsp->dma_data[1];
+
 	return 0;
 }
 
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index eb05c7e..d8817a6 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -266,9 +266,6 @@ static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
 	}
 	mutex_unlock(&mcpdm->mutex);
 
-	snd_soc_dai_set_dma_data(dai, substream,
-				 &mcpdm->dma_data[substream->stream]);
-
 	return 0;
 }
 
@@ -407,6 +404,10 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
 	mcpdm->config[SNDRV_PCM_STREAM_PLAYBACK].threshold = 2;
 	mcpdm->config[SNDRV_PCM_STREAM_CAPTURE].threshold =
 							MCPDM_UP_THRES_MAX - 3;
+
+	dai->playback_dma_data = &mcpdm->dma_data[0];
+	dai->capture_dma_data = &mcpdm->dma_data[1];
+
 	return ret;
 }
 
-- 
1.8.0
