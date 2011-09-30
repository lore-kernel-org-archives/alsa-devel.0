From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 2/3] ASoC: omap: Convert bunch of machine
	drivers to use init time DAI format
Date: Fri, 30 Sep 2011 16:07:45 +0300
Message-ID: <1317388066-28443-2-git-send-email-jarkko.nikula@bitmer.com>
References: <1317388066-28443-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 57FEA103BB2
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

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
omap3beagle.c and ams-delta.c are left out as thet use either dynamic DAI
format or configure just the CPU DAI.
---
 sound/soc/omap/am3517evm.c    |   22 +-----------------
 sound/soc/omap/igep0020.c     |   23 +------------------
 sound/soc/omap/n810.c         |   19 +---------------
 sound/soc/omap/omap3evm.c     |   23 +------------------
 sound/soc/omap/omap3pandora.c |   20 +++--------------
 sound/soc/omap/osk5912.c      |   23 +------------------
 sound/soc/omap/overo.c        |   23 +------------------
 sound/soc/omap/rx51.c         |   20 +----------------
 sound/soc/omap/sdp3430.c      |   46 +++-------------------------------------
 sound/soc/omap/zoom2.c        |   46 +++-------------------------------------
 10 files changed, 26 insertions(+), 239 deletions(-)

diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index 73dde4a..48af0f8 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -43,26 +43,6 @@ static int am3517evm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_DSP_B |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_DSP_B |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set cpu DAI configuration\n");
-		return ret;
-	}
-
 	/* Set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
 			CODEC_CLOCK, SND_SOC_CLOCK_IN);
@@ -140,6 +120,8 @@ static struct snd_soc_dai_link am3517evm_dai = {
 	.codec_dai_name = "tlv320aic23-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "tlv320aic23-codec.2-001a",
+	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 	.init = am3517evm_aic23_init,
 	.ops = &am3517evm_ops,
 };
diff --git a/sound/soc/omap/igep0020.c b/sound/soc/omap/igep0020.c
index 0ae3470..84615a7 100644
--- a/sound/soc/omap/igep0020.c
+++ b/sound/soc/omap/igep0020.c
@@ -38,29 +38,8 @@ static int igep2_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set cpu DAI configuration\n");
-		return ret;
-	}
-
 	/* Set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
 					    SND_SOC_CLOCK_IN);
@@ -84,6 +63,8 @@ static struct snd_soc_dai_link igep2_dai = {
 	.codec_dai_name = "twl4030-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "twl4030-codec",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 	.ops = &igep2_ops,
 };
 
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 62e292f..c10d356 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -115,25 +115,8 @@ static int n810_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int err;
 
-	/* Set codec DAI configuration */
-	err = snd_soc_dai_set_fmt(codec_dai,
-					 SND_SOC_DAIFMT_I2S |
-					 SND_SOC_DAIFMT_NB_NF |
-					 SND_SOC_DAIFMT_CBM_CFM);
-	if (err < 0)
-		return err;
-
-	/* Set cpu DAI configuration */
-	err = snd_soc_dai_set_fmt(cpu_dai,
-				       SND_SOC_DAIFMT_I2S |
-				       SND_SOC_DAIFMT_NB_NF |
-				       SND_SOC_DAIFMT_CBM_CFM);
-	if (err < 0)
-		return err;
-
 	/* Set the codec system clock for DAC and ADC */
 	err = snd_soc_dai_set_sysclk(codec_dai, 0, 12000000,
 					    SND_SOC_CLOCK_IN);
@@ -312,6 +295,8 @@ static struct snd_soc_dai_link n810_dai = {
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "tlv320aic3x-codec.2-0018",
 	.codec_dai_name = "tlv320aic3x-hifi",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 	.init = n810_aic33_init,
 	.ops = &n810_ops,
 };
diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
index 0daa044..bf9ae2a 100644
--- a/sound/soc/omap/omap3evm.c
+++ b/sound/soc/omap/omap3evm.c
@@ -36,29 +36,8 @@ static int omap3evm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "Can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "Can't set cpu DAI configuration\n");
-		return ret;
-	}
-
 	/* Set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
 				     SND_SOC_CLOCK_IN);
@@ -82,6 +61,8 @@ static struct snd_soc_dai_link omap3evm_dai = {
 	.codec_dai_name = "twl4030-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "twl4030-codec",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 	.ops 		= &omap3evm_ops,
 };
 
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 8047c52..3ae87fd 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -48,24 +48,8 @@ static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		  SND_SOC_DAIFMT_CBS_CFS;
 	int ret;
 
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
-	if (ret < 0) {
-		pr_err(PREFIX "can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
-	if (ret < 0) {
-		pr_err(PREFIX "can't set cpu DAI configuration\n");
-		return ret;
-	}
-
 	/* Set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
 					    SND_SOC_CLOCK_IN);
@@ -231,6 +215,8 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
 		.codec_dai_name = "twl4030-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBS_CFS,
 		.ops = &omap3pandora_ops,
 		.init = omap3pandora_out_init,
 	}, {
@@ -240,6 +226,8 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
 		.codec_dai_name = "twl4030-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBS_CFS,
 		.ops = &omap3pandora_ops,
 		.init = omap3pandora_in_init,
 	}
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index 7e75e77..5978332 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -55,29 +55,8 @@ static int osk_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int err;
 
-	/* Set codec DAI configuration */
-	err = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_DSP_B |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (err < 0) {
-		printk(KERN_ERR "can't set codec DAI configuration\n");
-		return err;
-	}
-
-	/* Set cpu DAI configuration */
-	err = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_DSP_B |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (err < 0) {
-		printk(KERN_ERR "can't set cpu DAI configuration\n");
-		return err;
-	}
-
 	/* Set the codec system clock for DAC and ADC */
 	err =
 	    snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_CLOCK, SND_SOC_CLOCK_IN);
@@ -141,6 +120,8 @@ static struct snd_soc_dai_link osk_dai = {
 	.codec_dai_name = "tlv320aic23-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "tlv320aic23-codec",
+	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 	.init = osk_tlv320aic23_init,
 	.ops = &osk_ops,
 };
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
index bbcf380..739efe9 100644
--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -38,29 +38,8 @@ static int overo_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set cpu DAI configuration\n");
-		return ret;
-	}
-
 	/* Set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
 					    SND_SOC_CLOCK_IN);
@@ -84,6 +63,8 @@ static struct snd_soc_dai_link overo_dai = {
 	.codec_dai_name = "twl4030-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "twl4030-codec",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 	.ops = &overo_ops,
 };
 
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 893300a..7164db5 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -115,24 +115,6 @@ static int rx51_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int err;
-
-	/* Set codec DAI configuration */
-	err = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_DSP_A |
-				  SND_SOC_DAIFMT_IB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (err < 0)
-		return err;
-
-	/* Set cpu DAI configuration */
-	err = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_DSP_A |
-				  SND_SOC_DAIFMT_IB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (err < 0)
-		return err;
 
 	/* Set the codec system clock for DAC and ADC */
 	return snd_soc_dai_set_sysclk(codec_dai, 0, 19200000,
@@ -377,6 +359,8 @@ static struct snd_soc_dai_link rx51_dai[] = {
 		.codec_dai_name = "tlv320aic3x-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "tlv320aic3x-codec.2-0018",
+		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
+			   SND_SOC_DAIFMT_CBM_CFM,
 		.init = rx51_aic34_init,
 		.ops = &rx51_ops,
 	},
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 9f6a758..2ff5f7b 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -53,29 +53,8 @@ static int sdp3430_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set cpu DAI configuration\n");
-		return ret;
-	}
-
 	/* Set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
 					    SND_SOC_CLOCK_IN);
@@ -96,29 +75,8 @@ static int sdp3430_hw_voice_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-				SND_SOC_DAIFMT_DSP_A |
-				SND_SOC_DAIFMT_IB_NF |
-				SND_SOC_DAIFMT_CBM_CFM);
-	if (ret) {
-		printk(KERN_ERR "can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-				SND_SOC_DAIFMT_DSP_A |
-				SND_SOC_DAIFMT_IB_NF |
-				SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set cpu DAI configuration\n");
-		return ret;
-	}
-
 	/* Set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
 					    SND_SOC_CLOCK_IN);
@@ -267,6 +225,8 @@ static struct snd_soc_dai_link sdp3430_dai[] = {
 		.codec_dai_name = "twl4030-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBM_CFM,
 		.init = sdp3430_twl4030_init,
 		.ops = &sdp3430_ops,
 	},
@@ -277,6 +237,8 @@ static struct snd_soc_dai_link sdp3430_dai[] = {
 		.codec_dai_name = "twl4030-voice",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
+		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
+			   SND_SOC_DAIFMT_CBM_CFM,
 		.init = sdp3430_twl4030_voice_init,
 		.ops = &sdp3430_voice_ops,
 	},
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 9a2666f..c124562 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -44,29 +44,8 @@ static int zoom2_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set cpu DAI configuration\n");
-		return ret;
-	}
-
 	/* Set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
 					SND_SOC_CLOCK_IN);
@@ -87,29 +66,8 @@ static int zoom2_hw_voice_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-				SND_SOC_DAIFMT_DSP_A |
-				SND_SOC_DAIFMT_IB_NF |
-				SND_SOC_DAIFMT_CBM_CFM);
-	if (ret) {
-		printk(KERN_ERR "can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-				SND_SOC_DAIFMT_DSP_A |
-				SND_SOC_DAIFMT_IB_NF |
-				SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set cpu DAI configuration\n");
-		return ret;
-	}
-
 	/* Set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
 					SND_SOC_CLOCK_IN);
@@ -217,6 +175,8 @@ static struct snd_soc_dai_link zoom2_dai[] = {
 		.codec_dai_name = "twl4030-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBM_CFM,
 		.init = zoom2_twl4030_init,
 		.ops = &zoom2_ops,
 	},
@@ -227,6 +187,8 @@ static struct snd_soc_dai_link zoom2_dai[] = {
 		.codec_dai_name = "twl4030-voice",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
+		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
+			   SND_SOC_DAIFMT_CBM_CFM,
 		.init = zoom2_twl4030_voice_init,
 		.ops = &zoom2_voice_ops,
 	},
-- 
1.7.6.3
