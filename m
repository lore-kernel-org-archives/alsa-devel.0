From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/17] ASoC: spear: Setup dma data in DAI probe
Date: Mon, 15 Apr 2013 19:19:53 +0200
Message-ID: <1366046404-8759-7-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id DC1B726523C
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:15 +0200 (CEST)
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
this when converting spear to generic DMA engine PCM driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/spear/spdif_in.c  | 12 ++++--------
 sound/soc/spear/spdif_out.c |  7 ++++---
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 14d57e8..82c8387 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -49,15 +49,12 @@ static void spdif_in_configure(struct spdif_in_dev *host)
 	writel(0xF, host->io_base + SPDIF_IN_IRQ_MASK);
 }
 
-static int spdif_in_startup(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *cpu_dai)
+static int spdif_in_dai_probe(struct snd_soc_dai *dai)
 {
-	struct spdif_in_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
+	struct spdif_in_dev *host = snd_soc_dai_get_drvdata(dai);
 
-	if (substream->stream != SNDRV_PCM_STREAM_CAPTURE)
-		return -EINVAL;
+	dai->capture_dma_data = &host->dma_params;
 
-	snd_soc_dai_set_dma_data(cpu_dai, substream, (void *)&host->dma_params);
 	return 0;
 }
 
@@ -70,7 +67,6 @@ static void spdif_in_shutdown(struct snd_pcm_substream *substream,
 		return;
 
 	writel(0x0, host->io_base + SPDIF_IN_IRQ_MASK);
-	snd_soc_dai_set_dma_data(dai, substream, NULL);
 }
 
 static void spdif_in_format(struct spdif_in_dev *host, u32 format)
@@ -151,13 +147,13 @@ static int spdif_in_trigger(struct snd_pcm_substream *substream, int cmd,
 }
 
 static struct snd_soc_dai_ops spdif_in_dai_ops = {
-	.startup	= spdif_in_startup,
 	.shutdown	= spdif_in_shutdown,
 	.trigger	= spdif_in_trigger,
 	.hw_params	= spdif_in_hw_params,
 };
 
 struct snd_soc_dai_driver spdif_in_dai = {
+	.probe = spdif_in_dai_probe,
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
index 1e3c3dd..12b4f2f 100644
--- a/sound/soc/spear/spdif_out.c
+++ b/sound/soc/spear/spdif_out.c
@@ -62,8 +62,6 @@ static int spdif_out_startup(struct snd_pcm_substream *substream,
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
 		return -EINVAL;
 
-	snd_soc_dai_set_dma_data(cpu_dai, substream, (void *)&host->dma_params);
-
 	ret = clk_enable(host->clk);
 	if (ret)
 		return ret;
@@ -84,7 +82,6 @@ static void spdif_out_shutdown(struct snd_pcm_substream *substream,
 
 	clk_disable(host->clk);
 	host->running = false;
-	snd_soc_dai_set_dma_data(dai, substream, NULL);
 }
 
 static void spdif_out_clock(struct spdif_out_dev *host, u32 core_freq,
@@ -245,6 +242,10 @@ static const struct snd_kcontrol_new spdif_out_controls[] = {
 
 int spdif_soc_dai_probe(struct snd_soc_dai *dai)
 {
+	struct spdif_out_dev *host = snd_soc_dai_get_drvdata(dai);
+
+	dai->playback_dma_data = &host->dma_params;
+
 	return snd_soc_add_dai_controls(dai, spdif_out_controls,
 				ARRAY_SIZE(spdif_out_controls));
 }
-- 
1.8.0
