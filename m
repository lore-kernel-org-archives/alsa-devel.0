From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 3/3] ASoC: omap: Use single hw_params callback
	in sdp3430 and zoom2
Date: Fri, 30 Sep 2011 16:07:46 +0300
Message-ID: <1317388066-28443-3-git-send-email-jarkko.nikula@bitmer.com>
References: <1317388066-28443-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 37868103B91
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 15:08:16 +0200 (CEST)
In-Reply-To: <1317388066-28443-1-git-send-email-jarkko.nikula@bitmer.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

There is no need to use two hw_params callbacks in sdp3430 and zoom2 as
thet are now identical. Use instead the same snd_soc_ops structure and
hw_params callback for both DAI links.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdp3430.c |   24 +-----------------------
 sound/soc/omap/zoom2.c   |   24 +-----------------------
 2 files changed, 2 insertions(+), 46 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 2ff5f7b..269aded 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -70,28 +70,6 @@ static struct snd_soc_ops sdp3430_ops = {
 	.hw_params = sdp3430_hw_params,
 };
 
-static int sdp3430_hw_voice_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	/* Set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
-					    SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec system clock\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct snd_soc_ops sdp3430_voice_ops = {
-	.hw_params = sdp3430_hw_voice_params,
-};
-
 /* Headset jack */
 static struct snd_soc_jack hs_jack;
 
@@ -240,7 +218,7 @@ static struct snd_soc_dai_link sdp3430_dai[] = {
 		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
 			   SND_SOC_DAIFMT_CBM_CFM,
 		.init = sdp3430_twl4030_voice_init,
-		.ops = &sdp3430_voice_ops,
+		.ops = &sdp3430_ops,
 	},
 };
 
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index c124562..8b1ebbc 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -61,28 +61,6 @@ static struct snd_soc_ops zoom2_ops = {
 	.hw_params = zoom2_hw_params,
 };
 
-static int zoom2_hw_voice_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	/* Set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
-					SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec system clock\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct snd_soc_ops zoom2_voice_ops = {
-	.hw_params = zoom2_hw_voice_params,
-};
-
 /* Zoom2 machine DAPM */
 static const struct snd_soc_dapm_widget zoom2_twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Ext Mic", NULL),
@@ -190,7 +168,7 @@ static struct snd_soc_dai_link zoom2_dai[] = {
 		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
 			   SND_SOC_DAIFMT_CBM_CFM,
 		.init = zoom2_twl4030_voice_init,
-		.ops = &zoom2_voice_ops,
+		.ops = &zoom2_ops,
 	},
 };
 
-- 
1.7.6.3
