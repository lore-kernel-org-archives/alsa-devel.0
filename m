From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 01/15] ASoC: multi-component - Samsung S3C
	Platform
Date: Sun, 27 Jun 2010 12:52:00 +0100
Message-ID: <1277639534-5104-2-git-send-email-lrg@slimlogic.co.uk>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5449110388D
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:31 +0200 (CEST)
Received: by wyf23 with SMTP id 23so919297wyf.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:30 -0700 (PDT)
In-Reply-To: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Update the Samsung platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o Added I2S DAI platform devices.
 o s3c_i2sv2_probe(), s3c_i2sv2_register_dai() and s3c2412_i2s_probe() now
   modified to use DAI platform devices passed in by DAI probe.
 o Added s3c2412_i2s_remove()

FIXME:
 o s3c24xx_uda134x has codec platform data defined in machine driver. This must
   be moved to a board file (but which one ??)

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 arch/arm/plat-s3c24xx/devs.c                   |   30 ++++-
 sound/soc/s3c24xx/jive_wm8750.c                |   23 +--
 sound/soc/s3c24xx/ln2440sbc_alc650.c           |   16 +--
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c       |   58 ++++----
 sound/soc/s3c24xx/neo1973_wm8753.c             |   37 ++---
 sound/soc/s3c24xx/s3c-ac97.c                   |   20 +--
 sound/soc/s3c24xx/s3c-ac97.h                   |    2 +-
 sound/soc/s3c24xx/s3c-dma.c                    |   43 ++++--
 sound/soc/s3c24xx/s3c-dma.h                    |    2 +-
 sound/soc/s3c24xx/s3c-i2s-v2.c                 |   50 ++----
 sound/soc/s3c24xx/s3c-i2s-v2.h                 |   11 +-
 sound/soc/s3c24xx/s3c-pcm.c                    |   37 ++---
 sound/soc/s3c24xx/s3c2412-i2s.c                |   51 +++++--
 sound/soc/s3c24xx/s3c2412-i2s.h                |    2 +-
 sound/soc/s3c24xx/s3c24xx-i2s.c                |   37 +++--
 sound/soc/s3c24xx/s3c24xx-i2s.h                |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec.c             |   15 +-
 sound/soc/s3c24xx/s3c24xx_simtec.h             |    4 +-
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |   25 +--
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |   21 +--
 sound/soc/s3c24xx/s3c24xx_uda134x.c            |   21 +--
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c             |   66 +++-----
 sound/soc/s3c24xx/s3c64xx-i2s.c                |  204 ++++++++++++++++--------
 sound/soc/s3c24xx/s3c64xx-i2s.h                |    6 +-
 sound/soc/s3c24xx/smdk2443_wm9710.c            |   17 +--
 sound/soc/s3c24xx/smdk64xx_wm8580.c            |   35 +++--
 sound/soc/s3c24xx/smdk_wm9713.c                |   18 +--
 27 files changed, 463 insertions(+), 390 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 452e184..9f8ee5e 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -481,7 +481,7 @@ static struct resource s3c_ac97_resource[] = {
 	},
 };
 
-static u64 s3c_device_ac97_dmamask = 0xffffffffUL;
+static u64 s3c_device_audio_dmamask = 0xffffffffUL;
 
 struct platform_device s3c_device_ac97 = {
 	.name		  = "s3c-ac97",
@@ -489,11 +489,37 @@ struct platform_device s3c_device_ac97 = {
 	.num_resources	  = ARRAY_SIZE(s3c_ac97_resource),
 	.resource	  = s3c_ac97_resource,
 	.dev              = {
-		.dma_mask = &s3c_device_ac97_dmamask,
+		.dma_mask = &s3c_device_audio_dmamask,
 		.coherent_dma_mask = 0xffffffffUL
 	}
 };
 
 EXPORT_SYMBOL(s3c_device_ac97);
 
+/* ASoC PCM DMA */
+
+struct platform_device s3c_device_pcm = {
+	.name		  = "s3c24xx-pcm-audio",
+	.id		  = -1,
+	.dev              = {
+		.dma_mask = &s3c_device_audio_dmamask,
+		.coherent_dma_mask = 0xffffffffUL
+	}
+};
+
+EXPORT_SYMBOL(s3c_device_pcm);
+
+/* ASoC I2S */
+
+struct platform_device s3c2412_device_iis = {
+	.name		  = "s3c2412-iis",
+	.id		  = -1,
+	.dev              = {
+		.dma_mask = &s3c_device_audio_dmamask,
+		.coherent_dma_mask = 0xffffffffUL
+	}
+};
+
+EXPORT_SYMBOL(s3c2412_device_iis);
+
 #endif // CONFIG_CPU_S32440
diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
index 8c108b1..c8f8c4c 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/s3c24xx/jive_wm8750.c
@@ -49,8 +49,8 @@ static int jive_hw_params(struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct s3c_i2sv2_rate_calc div;
 	unsigned int clk = 0;
 	int ret = 0;
@@ -108,8 +108,9 @@ static struct snd_soc_ops jive_ops = {
 	.hw_params	= jive_hw_params,
 };
 
-static int jive_wm8750_init(struct snd_soc_codec *codec)
+static int jive_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	int err;
 
 	/* These endpoints are not being used. */
@@ -138,8 +139,10 @@ static int jive_wm8750_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link jive_dai = {
 	.name		= "wm8750",
 	.stream_name	= "WM8750",
-	.cpu_dai	= &s3c2412_i2s_dai,
-	.codec_dai	= &wm8750_dai,
+	.cpu_dai_drv 	= &s3c2412_i2s_dai,
+	.codec_dai_drv 	= &wm8750_dai,
+	.platform_drv	= &s3c24xx_soc_platform,
+	.codec_drv 	= &soc_codec_dev_wm8750,
 	.init		= jive_wm8750_init,
 	.ops		= &jive_ops,
 };
@@ -147,17 +150,10 @@ static struct snd_soc_dai_link jive_dai = {
 /* jive audio machine driver */
 static struct snd_soc_card snd_soc_machine_jive = {
 	.name		= "Jive",
-	.platform	= &s3c24xx_soc_platform,
 	.dai_link	= &jive_dai,
 	.num_links	= 1,
 };
 
-/* jive audio subsystem */
-static struct snd_soc_device jive_snd_devdata = {
-	.card		= &snd_soc_machine_jive,
-	.codec_dev	= &soc_codec_dev_wm8750,
-};
-
 static struct platform_device *jive_snd_device;
 
 static int __init jive_init(void)
@@ -173,8 +169,7 @@ static int __init jive_init(void)
 	if (!jive_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(jive_snd_device, &jive_snd_devdata);
-	jive_snd_devdata.dev = &jive_snd_device->dev;
+	platform_set_drvdata(jive_snd_device, &snd_soc_machine_jive);
 	ret = platform_device_add(jive_snd_device);
 
 	if (ret)
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index ffa954f..97e3c11 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -33,23 +33,19 @@ static struct snd_soc_dai_link ln2440sbc_dai[] = {
 {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
-	.codec_dai = &ac97_dai,
+	.cpu_dai_drv = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
+	.codec_dai_drv = &ac97_dai,
+	.codec_drv = &soc_codec_dev_ac97,
+	.platform_drv = &s3c24xx_soc_platform,
 },
 };
 
 static struct snd_soc_card ln2440sbc = {
 	.name = "LN2440SBC",
-	.platform = &s3c24xx_soc_platform,
 	.dai_link = ln2440sbc_dai,
 	.num_links = ARRAY_SIZE(ln2440sbc_dai),
 };
 
-static struct snd_soc_device ln2440sbc_snd_ac97_devdata = {
-	.card = &ln2440sbc,
-	.codec_dev = &soc_codec_dev_ac97,
-};
-
 static struct platform_device *ln2440sbc_snd_ac97_device;
 
 static int __init ln2440sbc_init(void)
@@ -60,9 +56,7 @@ static int __init ln2440sbc_init(void)
 	if (!ln2440sbc_snd_ac97_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(ln2440sbc_snd_ac97_device,
-				&ln2440sbc_snd_ac97_devdata);
-	ln2440sbc_snd_ac97_devdata.dev = &ln2440sbc_snd_ac97_device->dev;
+	platform_set_drvdata(ln2440sbc_snd_ac97_device, &ln2440sbc);
 	ret = platform_device_add(ln2440sbc_snd_ac97_device);
 
 	if (ret)
diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
index 209c259..6082fd6 100644
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
@@ -41,8 +41,8 @@ static int neo1973_gta02_hifi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int pll_out = 0, bclk = 0;
 	int ret = 0;
 	unsigned long iis_clkrate;
@@ -130,7 +130,7 @@ static int neo1973_gta02_hifi_hw_params(struct snd_pcm_substream *substream,
 static int neo1973_gta02_hifi_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 
 	/* disable the PLL */
 	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL1, 0, 0, 0);
@@ -149,7 +149,7 @@ static int neo1973_gta02_voice_hw_params(
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	unsigned int pcmdiv = 0;
 	int ret = 0;
 	unsigned long iis_clkrate;
@@ -194,7 +194,7 @@ static int neo1973_gta02_voice_hw_params(
 static int neo1973_gta02_voice_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 
 	/* disable the PLL */
 	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL2, 0, 0, 0);
@@ -262,7 +262,7 @@ static int lm4853_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *k,
 			int event)
 {
-	gpio_set_value(GTA02_GPIO_AMP_SHUT, SND_SOC_DAPM_EVENT_OFF(value));
+	gpio_set_value(GTA02_GPIO_AMP_SHUT, SND_SOC_DAPM_EVENT_OFF(event));
 
 	return 0;
 }
@@ -330,8 +330,9 @@ static const struct snd_kcontrol_new wm8753_neo1973_gta02_controls[] = {
  * This is an example machine initialisation for a wm8753 connected to a
  * neo1973 GTA02.
  */
-static int neo1973_gta02_wm8753_init(struct snd_soc_codec *codec)
+static int neo1973_gta02_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	int err;
 
 	/* set up NC codec pins */
@@ -378,9 +379,8 @@ static int neo1973_gta02_wm8753_init(struct snd_soc_codec *codec)
 /*
  * BT Codec DAI
  */
-static struct snd_soc_dai bt_dai = {
+static struct snd_soc_dai_driver bt_dai = {
 	.name = "Bluetooth",
-	.id = 0,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 1,
@@ -397,32 +397,32 @@ static struct snd_soc_dai_link neo1973_gta02_dai[] = {
 { /* Hifi Playback - for similatious use with voice below */
 	.name = "WM8753",
 	.stream_name = "WM8753 HiFi",
-	.cpu_dai = &s3c24xx_i2s_dai,
-	.codec_dai = &wm8753_dai[WM8753_DAI_HIFI],
+	.cpu_dai_drv = &s3c24xx_i2s_dai,
+	.codec_dai_drv = &wm8753_dai[WM8753_DAI_HIFI],
+	.codec_dai_id = WM8753_DAI_HIFI,
 	.init = neo1973_gta02_wm8753_init,
+	.platform_drv = &s3c24xx_soc_platform,
+	.codec_drv = &soc_codec_dev_wm8753,
 	.ops = &neo1973_gta02_hifi_ops,
 },
 { /* Voice via BT */
 	.name = "Bluetooth",
 	.stream_name = "Voice",
-	.cpu_dai = &bt_dai,
-	.codec_dai = &wm8753_dai[WM8753_DAI_VOICE],
+	.cpu_dai_drv = &bt_dai,
+	.codec_dai_drv = &wm8753_dai[WM8753_DAI_VOICE],
+	.codec_dai_id = WM8753_DAI_VOICE,
 	.ops = &neo1973_gta02_voice_ops,
+	.codec_drv = &soc_codec_dev_wm8753,
+	.platform_drv = &s3c24xx_soc_platform,
 },
 };
 
 static struct snd_soc_card neo1973_gta02 = {
 	.name = "neo1973-gta02",
-	.platform = &s3c24xx_soc_platform,
 	.dai_link = neo1973_gta02_dai,
 	.num_links = ARRAY_SIZE(neo1973_gta02_dai),
 };
 
-static struct snd_soc_device neo1973_gta02_snd_devdata = {
-	.card = &neo1973_gta02,
-	.codec_dev = &soc_codec_dev_wm8753,
-};
-
 static struct platform_device *neo1973_gta02_snd_device;
 
 static int __init neo1973_gta02_init(void)
@@ -435,18 +435,18 @@ static int __init neo1973_gta02_init(void)
 		return -ENODEV;
 	}
 
-	/* register bluetooth DAI here */
-	ret = snd_soc_register_dai(&bt_dai);
-	if (ret)
-		return ret;
-
 	neo1973_gta02_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!neo1973_gta02_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(neo1973_gta02_snd_device,
-			&neo1973_gta02_snd_devdata);
-	neo1973_gta02_snd_devdata.dev = &neo1973_gta02_snd_device->dev;
+	/* register bluetooth DAI here */
+	ret = snd_soc_register_dai(&neo1973_gta02_snd_device->dev, -1, &bt_dai);
+	if (ret) {
+		platform_device_put(neo1973_gta02_snd_device);
+		return ret;
+	}
+
+	platform_set_drvdata(neo1973_gta02_snd_device, &neo1973_gta02);
 	ret = platform_device_add(neo1973_gta02_snd_device);
 
 	if (ret) {
@@ -461,7 +461,7 @@ static int __init neo1973_gta02_init(void)
 		goto err_unregister_device;
 	}
 
-	ret = gpio_direction_output(GTA02_GPIO_AMP_HP_IN, 1);
+	ret = gpio_direction_output(GTA02_GPIO_HP_IN, 1);
 	if (ret) {
 		pr_err("gta02_wm8753: Failed to configure GPIO %d\n", GTA02_GPIO_HP_IN);
 		goto err_free_gpio_hp_in;
@@ -493,7 +493,7 @@ module_init(neo1973_gta02_init);
 
 static void __exit neo1973_gta02_exit(void)
 {
-	snd_soc_unregister_dai(&bt_dai);
+	snd_soc_unregister_dai(&neo1973_gta02_snd_device->dev, -1);
 	platform_device_unregister(neo1973_gta02_snd_device);
 	gpio_free(GTA02_GPIO_HP_IN);
 	gpio_free(GTA02_GPIO_AMP_SHUT);
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 0cb4f86..2df3d06 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -57,8 +57,8 @@ static int neo1973_hifi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int pll_out = 0, bclk = 0;
 	int ret = 0;
 	unsigned long iis_clkrate;
@@ -147,7 +147,7 @@ static int neo1973_hifi_hw_params(struct snd_pcm_substream *substream,
 static int neo1973_hifi_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -167,7 +167,7 @@ static int neo1973_voice_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	unsigned int pcmdiv = 0;
 	int ret = 0;
 	unsigned long iis_clkrate;
@@ -213,7 +213,7 @@ static int neo1973_voice_hw_params(struct snd_pcm_substream *substream,
 static int neo1973_voice_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -499,8 +499,9 @@ static const struct snd_kcontrol_new wm8753_neo1973_controls[] = {
  * neo1973 II. It is missing logic to detect hp/mic insertions and logic
  * to re-route the audio in such an event.
  */
-static int neo1973_wm8753_init(struct snd_soc_codec *codec)
+static int neo1973_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	int err;
 
 	pr_debug("Entered %s\n", __func__);
@@ -539,7 +540,6 @@ static int neo1973_wm8753_init(struct snd_soc_codec *codec)
  */
 static struct snd_soc_dai bt_dai = {
 	.name = "Bluetooth",
-	.id = 0,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 1,
@@ -556,32 +556,32 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 { /* Hifi Playback - for similatious use with voice below */
 	.name = "WM8753",
 	.stream_name = "WM8753 HiFi",
-	.cpu_dai = &s3c24xx_i2s_dai,
-	.codec_dai = &wm8753_dai[WM8753_DAI_HIFI],
+	.platform_drv = &s3c24xx_soc_platform,
+	.cpu_dai_drv = &s3c24xx_i2s_dai,
+	.codec_dai_drv = &wm8753_dai[WM8753_DAI_HIFI],
+	.codec_dai_id = WM8753_DAI_HIFI,
+	.codec_drv = &soc_codec_dev_wm8753,
 	.init = neo1973_wm8753_init,
 	.ops = &neo1973_hifi_ops,
 },
 { /* Voice via BT */
 	.name = "Bluetooth",
 	.stream_name = "Voice",
-	.cpu_dai = &bt_dai,
-	.codec_dai = &wm8753_dai[WM8753_DAI_VOICE],
+	.platform_drv = &s3c24xx_soc_platform,
+	.cpu_dai_drv = &bt_dai,
+	.codec_dai_drv = &wm8753_dai[WM8753_DAI_VOICE],
+	.codec_dai_id = WM8753_DAI_VOICE,
+	.codec_drv = &soc_codec_dev_wm8753,
 	.ops = &neo1973_voice_ops,
 },
 };
 
 static struct snd_soc_card neo1973 = {
 	.name = "neo1973",
-	.platform = &s3c24xx_soc_platform,
 	.dai_link = neo1973_dai,
 	.num_links = ARRAY_SIZE(neo1973_dai),
 };
 
-static struct snd_soc_device neo1973_snd_devdata = {
-	.card = &neo1973,
-	.codec_dev = &soc_codec_dev_wm8753,
-};
-
 static int lm4857_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
@@ -673,8 +673,7 @@ static int __init neo1973_init(void)
 	if (!neo1973_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(neo1973_snd_device, &neo1973_snd_devdata);
-	neo1973_snd_devdata.dev = &neo1973_snd_device->dev;
+	platform_set_drvdata(neo1973_snd_device, &neo1973);
 	ret = platform_device_add(neo1973_snd_device);
 
 	if (ret) {
diff --git a/sound/soc/s3c24xx/s3c-ac97.c b/sound/soc/s3c24xx/s3c-ac97.c
index 31f6d45..86ff977 100644
--- a/sound/soc/s3c24xx/s3c-ac97.c
+++ b/sound/soc/s3c24xx/s3c-ac97.c
@@ -222,7 +222,7 @@ static int s3c_ac97_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct s3c_dma_params *dma_data;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -241,7 +241,7 @@ static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 	u32 ac_glbctrl;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct s3c_dma_params *dma_data =
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
@@ -277,7 +277,7 @@ static int s3c_ac97_hw_mic_params(struct snd_pcm_substream *substream,
 				      struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
@@ -293,7 +293,7 @@ static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
 	u32 ac_glbctrl;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct s3c_dma_params *dma_data =
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
 	ac_glbctrl &= ~S3C_AC97_GLBCTRL_MICINTM_MASK;
@@ -328,10 +328,9 @@ static struct snd_soc_dai_ops s3c_ac97_mic_dai_ops = {
 	.trigger	= s3c_ac97_mic_trigger,
 };
 
-struct snd_soc_dai s3c_ac97_dai[] = {
+struct snd_soc_dai_driver s3c_ac97_dai[] = {
 	[S3C_AC97_DAI_PCM] = {
 		.name =	"s3c-ac97",
-		.id = S3C_AC97_DAI_PCM,
 		.ac97_control = 1,
 		.playback = {
 			.stream_name = "AC97 Playback",
@@ -349,7 +348,6 @@ struct snd_soc_dai s3c_ac97_dai[] = {
 	},
 	[S3C_AC97_DAI_MIC] = {
 		.name = "s3c-ac97-mic",
-		.id = S3C_AC97_DAI_MIC,
 		.ac97_control = 1,
 		.capture = {
 			.stream_name = "AC97 Mic Capture",
@@ -449,10 +447,8 @@ static __devinit int s3c_ac97_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
-	s3c_ac97_dai[S3C_AC97_DAI_PCM].dev = &pdev->dev;
-	s3c_ac97_dai[S3C_AC97_DAI_MIC].dev = &pdev->dev;
-
-	ret = snd_soc_register_dais(s3c_ac97_dai, ARRAY_SIZE(s3c_ac97_dai));
+	ret = snd_soc_register_dais(&pdev->dev, s3c_ac97_dai,
+			ARRAY_SIZE(s3c_ac97_dai));
 	if (ret)
 		goto err5;
 
@@ -476,7 +472,7 @@ static __devexit int s3c_ac97_remove(struct platform_device *pdev)
 {
 	struct resource *mem_res, *irq_res;
 
-	snd_soc_unregister_dais(s3c_ac97_dai, ARRAY_SIZE(s3c_ac97_dai));
+	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(s3c_ac97_dai));
 
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res)
diff --git a/sound/soc/s3c24xx/s3c-ac97.h b/sound/soc/s3c24xx/s3c-ac97.h
index 2781983..376e7c5 100644
--- a/sound/soc/s3c24xx/s3c-ac97.h
+++ b/sound/soc/s3c24xx/s3c-ac97.h
@@ -18,6 +18,6 @@
 #define S3C_AC97_DAI_PCM 0
 #define S3C_AC97_DAI_MIC 1
 
-extern struct snd_soc_dai s3c_ac97_dai[];
+extern struct snd_soc_dai_driver s3c_ac97_dai[];
 
 #endif /* __S3C_AC97_H_ */
diff --git a/sound/soc/s3c24xx/s3c-dma.c b/sound/soc/s3c24xx/s3c-dma.c
index 1b61c23..3d1a685 100644
--- a/sound/soc/s3c24xx/s3c-dma.c
+++ b/sound/soc/s3c24xx/s3c-dma.c
@@ -147,7 +147,7 @@ static int s3c_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	unsigned long totbytes = params_buffer_bytes(params);
 	struct s3c_dma_params *dma =
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 	int ret = 0;
 
 
@@ -441,14 +441,14 @@ static int s3c_dma_new(struct snd_card *card,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = 0xffffffff;
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = s3c_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto out;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = s3c_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
@@ -458,25 +458,46 @@ static int s3c_dma_new(struct snd_card *card,
 	return ret;
 }
 
-struct snd_soc_platform s3c24xx_soc_platform = {
+struct snd_soc_platform_driver s3c24xx_soc_platform = {
 	.name		= "s3c24xx-audio",
-	.pcm_ops 	= &s3c_dma_ops,
+	.ops 		= &s3c_dma_ops,
 	.pcm_new	= s3c_dma_new,
 	.pcm_free	= s3c_dma_free_dma_buffers,
 };
 EXPORT_SYMBOL_GPL(s3c24xx_soc_platform);
 
-static int __init s3c24xx_soc_platform_init(void)
+static int __devinit s3c24xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&s3c24xx_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, -1, &s3c24xx_soc_platform);
 }
-module_init(s3c24xx_soc_platform_init);
 
-static void __exit s3c24xx_soc_platform_exit(void)
+static int __devexit s3c24xx_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&s3c24xx_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev, -1);
+	return 0;
+}
+
+static struct platform_driver s3c24xx_pcm_driver = {
+	.driver = {
+			.name = "s3c24xx-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = s3c24xx_soc_platform_probe,
+	.remove = __devexit_p(s3c24xx_soc_platform_remove),
+};
+
+static int __init snd_s3c24xx_pcm_init(void)
+{
+	return platform_driver_register(&s3c24xx_pcm_driver);
+}
+module_init(snd_s3c24xx_pcm_init);
+
+static void __exit snd_s3c24xx_pcm_exit(void)
+{
+	platform_driver_unregister(&s3c24xx_pcm_driver);
 }
-module_exit(s3c24xx_soc_platform_exit);
+module_exit(snd_s3c24xx_pcm_exit);
 
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("Samsung S3C Audio DMA module");
diff --git a/sound/soc/s3c24xx/s3c-dma.h b/sound/soc/s3c24xx/s3c-dma.h
index 69bb6bf..3bf4985 100644
--- a/sound/soc/s3c24xx/s3c-dma.h
+++ b/sound/soc/s3c24xx/s3c-dma.h
@@ -25,7 +25,7 @@ struct s3c_dma_params {
 #define S3C24XX_DAI_I2S			0
 
 /* platform data */
-extern struct snd_soc_platform s3c24xx_soc_platform;
+extern struct snd_soc_platform_driver s3c24xx_soc_platform;
 extern struct snd_ac97_bus_ops s3c24xx_ac97_ops;
 
 #endif
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 13311c8..6575410 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -48,7 +48,7 @@
 
 static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
 {
-	return cpu_dai->private_data;
+	return snd_soc_dai_get_drvdata(cpu_dai);
 }
 
 #define bit_set(v, b) (((v) & (b)) ? 1 : 0)
@@ -306,11 +306,9 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 
 static int s3c_i2sv2_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
-				 struct snd_soc_dai *socdai)
+				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai_link *dai = rtd->dai;
-	struct s3c_i2sv2_info *i2s = to_info(dai->cpu_dai);
+	struct s3c_i2sv2_info *i2s = to_info(dai);
 	struct s3c_dma_params *dma_data;
 	u32 iismod;
 
@@ -321,7 +319,7 @@ static int s3c_i2sv2_hw_params(struct snd_pcm_substream *substream,
 	else
 		dma_data = i2s->dma_capture;
 
-	snd_soc_dai_set_dma_data(dai->cpu_dai, substream, dma_data);
+	snd_soc_dai_set_dma_data(dai, substream, dma_data);
 
 	/* Working copies of register */
 	iismod = readl(i2s->regs + S3C2412_IISMOD);
@@ -395,12 +393,12 @@ static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c_i2sv2_info *i2s = to_info(rtd->dai->cpu_dai);
+	struct s3c_i2sv2_info *i2s = to_info(rtd->cpu_dai);
 	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 	unsigned long irqs;
 	int ret = 0;
 	struct s3c_dma_params *dma_data =
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -639,36 +637,17 @@ int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
 }
 EXPORT_SYMBOL_GPL(s3c_i2sv2_iis_calc_rate);
 
-int s3c_i2sv2_probe(struct platform_device *pdev,
-		    struct snd_soc_dai *dai,
+int s3c_i2sv2_probe(struct snd_soc_dai *dai,
 		    struct s3c_i2sv2_info *i2s,
 		    unsigned long base)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = dai->dev;
 	unsigned int iismod;
 
 	i2s->dev = dev;
 
 	/* record our i2s structure for later use in the callbacks */
-	dai->private_data = i2s;
-
-	if (!base) {
-		struct resource *res = platform_get_resource(pdev,
-							     IORESOURCE_MEM,
-							     0);
-		if (!res) {
-			dev_err(dev, "Unable to get register resource\n");
-			return -ENXIO;
-		}
-
-		if (!request_mem_region(res->start, resource_size(res),
-					"s3c64xx-i2s-v4")) {
-			dev_err(dev, "Unable to request register region\n");
-			return -EBUSY;
-		}
-
-		base = res->start;
-	}
+	snd_soc_dai_set_drvdata(dai, i2s);
 
 	i2s->regs = ioremap(base, 0x100);
 	if (i2s->regs == NULL) {
@@ -751,9 +730,10 @@ static int s3c2412_i2s_resume(struct snd_soc_dai *dai)
 #define s3c2412_i2s_resume  NULL
 #endif
 
-int s3c_i2sv2_register_dai(struct snd_soc_dai *dai)
+int s3c_i2sv2_register_dai(struct device *dev, int id,
+		struct snd_soc_dai_driver *drv)
 {
-	struct snd_soc_dai_ops *ops = dai->ops;
+	struct snd_soc_dai_ops *ops = drv->ops;
 
 	ops->trigger = s3c2412_i2s_trigger;
 	if (!ops->hw_params)
@@ -766,10 +746,10 @@ int s3c_i2sv2_register_dai(struct snd_soc_dai *dai)
 	if (!ops->delay)
 		ops->delay = s3c2412_i2s_delay;
 
-	dai->suspend = s3c2412_i2s_suspend;
-	dai->resume = s3c2412_i2s_resume;
+	drv->suspend = s3c2412_i2s_suspend;
+	drv->resume = s3c2412_i2s_resume;
 
-	return snd_soc_register_dai(dai);
+	return snd_soc_register_dai(dev, id, drv);
 }
 EXPORT_SYMBOL_GPL(s3c_i2sv2_register_dai);
 
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.h b/sound/soc/s3c24xx/s3c-i2s-v2.h
index 766f43a..c2a4bad 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.h
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.h
@@ -81,23 +81,24 @@ extern int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
 
 /**
  * s3c_i2sv2_probe - probe for i2s device helper
- * @pdev: The platform device supplied to the original probe.
  * @dai: The ASoC DAI structure supplied to the original probe.
  * @i2s: Our local i2s structure to fill in.
  * @base: The base address for the registers.
  */
-extern int s3c_i2sv2_probe(struct platform_device *pdev,
-			   struct snd_soc_dai *dai,
+extern int s3c_i2sv2_probe(struct snd_soc_dai *dai,
 			   struct s3c_i2sv2_info *i2s,
 			   unsigned long base);
 
 /**
  * s3c_i2sv2_register_dai - register dai with soc core
- * @dai: The snd_soc_dai structure to register
+ * @dev: DAI device
+ * @id: DAI ID
+ * @drv: The driver structure to register
  *
  * Fill in any missing fields and then register the given dai with the
  * soc core.
  */
-extern int s3c_i2sv2_register_dai(struct snd_soc_dai *dai);
+extern int s3c_i2sv2_register_dai(struct device *dev, int id,
+		struct snd_soc_dai_driver *drv);
 
 #endif /* __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H */
diff --git a/sound/soc/s3c24xx/s3c-pcm.c b/sound/soc/s3c24xx/s3c-pcm.c
index 326f0a9..218b60a 100644
--- a/sound/soc/s3c24xx/s3c-pcm.c
+++ b/sound/soc/s3c24xx/s3c-pcm.c
@@ -64,11 +64,6 @@ static struct s3c_dma_params s3c_pcm_stereo_in[] = {
 
 static struct s3c_pcm_info s3c_pcm[2];
 
-static inline struct s3c_pcm_info *to_info(struct snd_soc_dai *cpu_dai)
-{
-	return cpu_dai->private_data;
-}
-
 static void s3c_pcm_snd_txctrl(struct s3c_pcm_info *pcm, int on)
 {
 	void __iomem *regs = pcm->regs;
@@ -132,7 +127,7 @@ static int s3c_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c_pcm_info *pcm = to_info(rtd->dai->cpu_dai);
+	struct s3c_pcm_info *pcm = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	unsigned long flags;
 
 	dev_dbg(pcm->dev, "Entered %s\n", __func__);
@@ -176,8 +171,7 @@ static int s3c_pcm_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *socdai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai_link *dai = rtd->dai;
-	struct s3c_pcm_info *pcm = to_info(dai->cpu_dai);
+	struct s3c_pcm_info *pcm = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct s3c_dma_params *dma_data;
 	void __iomem *regs = pcm->regs;
 	struct clk *clk;
@@ -192,7 +186,7 @@ static int s3c_pcm_hw_params(struct snd_pcm_substream *substream,
 	else
 		dma_data = pcm->dma_capture;
 
-	snd_soc_dai_set_dma_data(dai->cpu_dai, substream, dma_data);
+	snd_soc_dai_set_dma_data(rtd->cpu_dai, substream, dma_data);
 
 	/* Strictly check for sample size */
 	switch (params_format(params)) {
@@ -242,7 +236,7 @@ static int s3c_pcm_hw_params(struct snd_pcm_substream *substream,
 static int s3c_pcm_set_fmt(struct snd_soc_dai *cpu_dai,
 			       unsigned int fmt)
 {
-	struct s3c_pcm_info *pcm = to_info(cpu_dai);
+	struct s3c_pcm_info *pcm = snd_soc_dai_get_drvdata(cpu_dai);
 	void __iomem *regs = pcm->regs;
 	unsigned long flags;
 	int ret = 0;
@@ -313,7 +307,7 @@ exit:
 static int s3c_pcm_set_clkdiv(struct snd_soc_dai *cpu_dai,
 						int div_id, int div)
 {
-	struct s3c_pcm_info *pcm = to_info(cpu_dai);
+	struct s3c_pcm_info *pcm = snd_soc_dai_get_drvdata(cpu_dai);
 
 	switch (div_id) {
 	case S3C_PCM_SCLK_PER_FS:
@@ -330,7 +324,7 @@ static int s3c_pcm_set_clkdiv(struct snd_soc_dai *cpu_dai,
 static int s3c_pcm_set_sysclk(struct snd_soc_dai *cpu_dai,
 				  int clk_id, unsigned int freq, int dir)
 {
-	struct s3c_pcm_info *pcm = to_info(cpu_dai);
+	struct s3c_pcm_info *pcm = snd_soc_dai_get_drvdata(cpu_dai);
 	void __iomem *regs = pcm->regs;
 	u32 clkctl = readl(regs + S3C_PCM_CLKCTL);
 
@@ -366,10 +360,9 @@ static struct snd_soc_dai_ops s3c_pcm_dai_ops = {
 
 #define S3C_PCM_RATES  SNDRV_PCM_RATE_8000_96000
 
-#define S3C_PCM_DECLARE(n)			\
+#define S3C_PCM_DECLARE			\
 {								\
 	.name		 = "samsung-pcm",			\
-	.id		 = (n),				\
 	.symmetric_rates = 1,					\
 	.ops = &s3c_pcm_dai_ops,				\
 	.playback = {						\
@@ -386,16 +379,15 @@ static struct snd_soc_dai_ops s3c_pcm_dai_ops = {
 	},							\
 }
 
-struct snd_soc_dai s3c_pcm_dai[] = {
-	S3C_PCM_DECLARE(0),
-	S3C_PCM_DECLARE(1),
+struct snd_soc_dai_driver s3c_pcm_dai[] = {
+	S3C_PCM_DECLARE,
+	S3C_PCM_DECLARE,
 };
 EXPORT_SYMBOL_GPL(s3c_pcm_dai);
 
 static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct s3c_pcm_info *pcm;
-	struct snd_soc_dai *dai;
 	struct resource *mem_res, *dmatx_res, *dmarx_res;
 	struct s3c_audio_pdata *pcm_pdata;
 	int ret;
@@ -437,9 +429,6 @@ static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
 
 	spin_lock_init(&pcm->lock);
 
-	dai = &s3c_pcm_dai[pdev->id];
-	dai->dev = &pdev->dev;
-
 	/* Default is 128fs */
 	pcm->sclk_per_fs = 128;
 
@@ -452,7 +441,7 @@ static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
 	clk_enable(pcm->cclk);
 
 	/* record our pcm structure for later use in the callbacks */
-	dai->private_data = pcm;
+	dev_set_drvdata(&pdev->dev, pcm);
 
 	if (!request_mem_region(mem_res->start,
 				resource_size(mem_res), "samsung-pcm")) {
@@ -476,7 +465,7 @@ static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
 	}
 	clk_enable(pcm->pclk);
 
-	ret = snd_soc_register_dai(dai);
+	ret = snd_soc_register_dai(&pdev->dev, pdev->id, s3c_pcm_dai);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "failed to get pcm_clock\n");
 		goto err5;
@@ -514,6 +503,8 @@ static __devexit int s3c_pcm_dev_remove(struct platform_device *pdev)
 	struct s3c_pcm_info *pcm = &s3c_pcm[pdev->id];
 	struct resource *mem_res;
 
+	snd_soc_unregister_dai(&pdev->dev, pdev->id);
+
 	iounmap(pcm->regs);
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index 709adef..b67277a 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -65,26 +65,20 @@ static struct s3c_dma_params s3c2412_i2s_pcm_stereo_in = {
 
 static struct s3c_i2sv2_info s3c2412_i2s;
 
-static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
-{
-	return cpu_dai->private_data;
-}
-
-static int s3c2412_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
+static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
 {
 	int ret;
 
 	pr_debug("Entered %s\n", __func__);
 
-	ret = s3c_i2sv2_probe(pdev, dai, &s3c2412_i2s, S3C2410_PA_IIS);
+	ret = s3c_i2sv2_probe(dai, &s3c2412_i2s, S3C2410_PA_IIS);
 	if (ret)
 		return ret;
 
 	s3c2412_i2s.dma_capture = &s3c2412_i2s_pcm_stereo_in;
 	s3c2412_i2s.dma_playback = &s3c2412_i2s_pcm_stereo_out;
 
-	s3c2412_i2s.iis_cclk = clk_get(&pdev->dev, "i2sclk");
+	s3c2412_i2s.iis_cclk = clk_get(dai->dev, "i2sclk");
 	if (s3c2412_i2s.iis_cclk == NULL) {
 		pr_err("failed to get i2sclk clock\n");
 		iounmap(s3c2412_i2s.regs);
@@ -108,11 +102,20 @@ static int s3c2412_i2s_probe(struct platform_device *pdev,
 	return 0;
 }
 
+static int s3c2412_i2s_remove(struct snd_soc_dai *dai)
+{
+	clk_disable(s3c2412_i2s.iis_cclk);
+	clk_put(s3c2412_i2s.iis_cclk);
+	iounmap(s3c2412_i2s.regs);
+
+	return 0;
+}
+
 static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *cpu_dai)
 {
-	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	struct s3c_i2sv2_info *i2s = snd_soc_dai_get_drvdata(cpu_dai);
 	struct s3c_dma_params *dma_data;
 	u32 iismod;
 
@@ -152,10 +155,10 @@ static struct snd_soc_dai_ops s3c2412_i2s_dai_ops = {
 	.hw_params	= s3c2412_i2s_hw_params,
 };
 
-struct snd_soc_dai s3c2412_i2s_dai = {
+struct snd_soc_dai_driver s3c2412_i2s_dai = {
 	.name		= "s3c2412-i2s",
-	.id		= 0,
 	.probe		= s3c2412_i2s_probe,
+	.remove	= s3c2412_i2s_remove,
 	.playback = {
 		.channels_min	= 2,
 		.channels_max	= 2,
@@ -172,15 +175,35 @@ struct snd_soc_dai s3c2412_i2s_dai = {
 };
 EXPORT_SYMBOL_GPL(s3c2412_i2s_dai);
 
+static __devinit int s3c2412_iis_dev_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dai(&pdev->dev, -1, &s3c2412_i2s_dai);
+}
+
+static __devexit int s3c2412_iis_dev_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&pdev->dev, -1);
+	return 0;
+}
+
+static struct platform_driver s3c2412_iis_driver = {
+	.probe  = s3c2412_iis_dev_probe,
+	.remove = s3c2412_iis_dev_remove,
+	.driver = {
+		.name = "s3c2412-iis",
+		.owner = THIS_MODULE,
+	},
+};
+
 static int __init s3c2412_i2s_init(void)
 {
-	return  s3c_i2sv2_register_dai(&s3c2412_i2s_dai);
+	return platform_driver_register(&s3c2412_iis_driver);
 }
 module_init(s3c2412_i2s_init);
 
 static void __exit s3c2412_i2s_exit(void)
 {
-	snd_soc_unregister_dai(&s3c2412_i2s_dai);
+	platform_driver_unregister(&s3c2412_iis_driver);
 }
 module_exit(s3c2412_i2s_exit);
 
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.h b/sound/soc/s3c24xx/s3c2412-i2s.h
index 0b5686b..f2ae80a 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.h
+++ b/sound/soc/s3c24xx/s3c2412-i2s.h
@@ -24,6 +24,6 @@
 #define S3C2412_CLKSRC_PCLK	S3C_I2SV2_CLKSRC_PCLK
 #define S3C2412_CLKSRC_I2SCLK	S3C_I2SV2_CLKSRC_AUDIOBUS
 
-extern struct snd_soc_dai s3c2412_i2s_dai;
+extern struct snd_soc_dai_driver s3c2412_i2s_dai;
 
 #endif /* __SND_SOC_S3C24XX_S3C2412_I2S_H */
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index c3ac890..0ada400 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -252,7 +252,7 @@ static int s3c24xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	else
 		dma_data = &s3c24xx_i2s_pcm_stereo_in;
 
-	snd_soc_dai_set_dma_data(rtd->dai->cpu_dai, substream, dma_data);
+	snd_soc_dai_set_dma_data(rtd->cpu_dai, substream, dma_data);
 
 	/* Working copies of register */
 	iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
@@ -280,9 +280,8 @@ static int s3c24xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
 	int ret = 0;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct s3c_dma_params *dma_data =
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+		snd_soc_dai_get_dma_data(dai, substream);
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -387,8 +386,7 @@ u32 s3c24xx_i2s_get_clockrate(void)
 }
 EXPORT_SYMBOL_GPL(s3c24xx_i2s_get_clockrate);
 
-static int s3c24xx_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
+static int s3c24xx_i2s_probe(struct snd_soc_dai *dai)
 {
 	pr_debug("Entered %s\n", __func__);
 
@@ -396,7 +394,7 @@ static int s3c24xx_i2s_probe(struct platform_device *pdev,
 	if (s3c24xx_i2s.regs == NULL)
 		return -ENXIO;
 
-	s3c24xx_i2s.iis_clk = clk_get(&pdev->dev, "iis");
+	s3c24xx_i2s.iis_clk = clk_get(dai->dev, "iis");
 	if (s3c24xx_i2s.iis_clk == NULL) {
 		pr_err("failed to get iis_clock\n");
 		iounmap(s3c24xx_i2s.regs);
@@ -465,9 +463,8 @@ static struct snd_soc_dai_ops s3c24xx_i2s_dai_ops = {
 	.set_sysclk	= s3c24xx_i2s_set_sysclk,
 };
 
-struct snd_soc_dai s3c24xx_i2s_dai = {
+struct snd_soc_dai_driver s3c24xx_i2s_dai = {
 	.name = "s3c24xx-i2s",
-	.id = 0,
 	.probe = s3c24xx_i2s_probe,
 	.suspend = s3c24xx_i2s_suspend,
 	.resume = s3c24xx_i2s_resume,
@@ -485,15 +482,35 @@ struct snd_soc_dai s3c24xx_i2s_dai = {
 };
 EXPORT_SYMBOL_GPL(s3c24xx_i2s_dai);
 
+static __devinit int s3c24xx_iis_dev_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dai(&pdev->dev, -1, &s3c24xx_i2s_dai);
+}
+
+static __devexit int s3c24xx_iis_dev_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&pdev->dev, -1);
+	return 0;
+}
+
+static struct platform_driver s3c24xx_iis_driver = {
+	.probe  = s3c24xx_iis_dev_probe,
+	.remove = s3c24xx_iis_dev_remove,
+	.driver = {
+		.name = "s3c24xx-iis",
+		.owner = THIS_MODULE,
+	},
+};
+
 static int __init s3c24xx_i2s_init(void)
 {
-	return snd_soc_register_dai(&s3c24xx_i2s_dai);
+	return platform_driver_register(&s3c24xx_iis_driver);
 }
 module_init(s3c24xx_i2s_init);
 
 static void __exit s3c24xx_i2s_exit(void)
 {
-	snd_soc_unregister_dai(&s3c24xx_i2s_dai);
+	platform_driver_unregister(&s3c24xx_iis_driver);
 }
 module_exit(s3c24xx_i2s_exit);
 
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.h b/sound/soc/s3c24xx/s3c24xx-i2s.h
index 726d91c..118388b 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.h
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.h
@@ -32,6 +32,6 @@
 
 u32 s3c24xx_i2s_get_clockrate(void);
 
-extern struct snd_soc_dai s3c24xx_i2s_dai;
+extern struct snd_soc_dai_driver s3c24xx_i2s_dai;
 
 #endif /*S3C24XXI2S_H_*/
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec.c b/sound/soc/s3c24xx/s3c24xx_simtec.c
index 4984754..c4c1114 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec.c
@@ -139,8 +139,10 @@ static const struct snd_kcontrol_new amp_unmute_controls[] = {
 		       speaker_unmute_get, speaker_unmute_put),
 };
 
-void simtec_audio_init(struct snd_soc_codec *codec)
+void simtec_audio_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	if (pdata->amp_gpio > 0) {
 		pr_debug("%s: adding amp routes\n", __func__);
 
@@ -170,8 +172,8 @@ static int simtec_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* Set the CODEC as the bus clock master, I2S */
@@ -319,12 +321,12 @@ EXPORT_SYMBOL_GPL(simtec_audio_pmops);
 #endif
 
 int __devinit simtec_audio_core_probe(struct platform_device *pdev,
-				      struct snd_soc_device *socdev)
+				      struct snd_soc_card *card)
 {
 	struct platform_device *snd_dev;
 	int ret;
 
-	socdev->card->dai_link->ops = &simtec_snd_ops;
+	card->dai_link->ops = &simtec_snd_ops;
 
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -353,8 +355,7 @@ int __devinit simtec_audio_core_probe(struct platform_device *pdev,
 		goto err_gpio;
 	}
 
-	platform_set_drvdata(snd_dev, socdev);
-	socdev->dev = &snd_dev->dev;
+	platform_set_drvdata(snd_dev, card);
 
 	ret = platform_device_add(snd_dev);
 	if (ret) {
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec.h b/sound/soc/s3c24xx/s3c24xx_simtec.h
index e18faee..e63d5ff 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec.h
+++ b/sound/soc/s3c24xx/s3c24xx_simtec.h
@@ -7,10 +7,10 @@
  * published by the Free Software Foundation.
 */
 
-extern void simtec_audio_init(struct snd_soc_codec *codec);
+extern void simtec_audio_init(struct snd_soc_pcm_runtime *rtd);
 
 extern int simtec_audio_core_probe(struct platform_device *pdev,
-				   struct snd_soc_device *socdev);
+				   struct snd_soc_card *card);
 
 extern int simtec_audio_remove(struct platform_device *pdev);
 
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
index bdf8951..02be124 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
@@ -73,8 +73,10 @@ static const struct snd_soc_dapm_route base_map[] = {
  * Attach our controls and configure the necessary codec
  * mappings for our sound card instance.
 */
-static int simtec_hermes_init(struct snd_soc_codec *codec)
+static int simtec_hermes_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	snd_soc_dapm_new_controls(codec, dapm_widgets,
 				  ARRAY_SIZE(dapm_widgets));
 
@@ -85,42 +87,33 @@ static int simtec_hermes_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_enable_pin(codec, "Line Out");
 	snd_soc_dapm_enable_pin(codec, "Mic Jack");
 
-	simtec_audio_init(codec);
+	simtec_audio_init(rtd);
 	snd_soc_dapm_sync(codec);
 
 	return 0;
 }
 
-static struct aic3x_setup_data codec_setup = {
-};
-
 static struct snd_soc_dai_link simtec_dai_aic33 = {
 	.name		= "tlv320aic33",
 	.stream_name	= "TLV320AIC33",
-	.cpu_dai	= &s3c24xx_i2s_dai,
-	.codec_dai	= &aic3x_dai,
+	.codec_drv	= &soc_codec_dev_aic3x,
+	.cpu_dai_drv 	= &s3c24xx_i2s_dai,
+	.codec_dai_drv 	= &aic3x_dai,
+	.platform_drv	= &s3c24xx_soc_platform,
 	.init		= simtec_hermes_init,
 };
 
 /* simtec audio machine driver */
 static struct snd_soc_card snd_soc_machine_simtec_aic33 = {
 	.name		= "Simtec-Hermes",
-	.platform	= &s3c24xx_soc_platform,
 	.dai_link	= &simtec_dai_aic33,
 	.num_links	= 1,
 };
 
-/* simtec audio subsystem */
-static struct snd_soc_device simtec_snd_devdata_aic33 = {
-	.card		= &snd_soc_machine_simtec_aic33,
-	.codec_dev	= &soc_codec_dev_aic3x,
-	.codec_data	= &codec_setup,
-};
-
 static int __devinit simtec_audio_hermes_probe(struct platform_device *pd)
 {
 	dev_info(&pd->dev, "probing....\n");
-	return simtec_audio_core_probe(pd, &simtec_snd_devdata_aic33);
+	return simtec_audio_core_probe(pd, &snd_soc_machine_simtec_aic33);
 }
 
 static struct platform_driver simtec_audio_hermes_platdrv = {
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
index 185c0ac..1dab2f5 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
@@ -62,8 +62,10 @@ static const struct snd_soc_dapm_route base_map[] = {
  * Attach our controls and configure the necessary codec
  * mappings for our sound card instance.
 */
-static int simtec_tlv320aic23_init(struct snd_soc_codec *codec)
+static int simtec_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	snd_soc_dapm_new_controls(codec, dapm_widgets,
 				  ARRAY_SIZE(dapm_widgets));
 
@@ -74,7 +76,7 @@ static int simtec_tlv320aic23_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_enable_pin(codec, "Line Out");
 	snd_soc_dapm_enable_pin(codec, "Mic Jack");
 
-	simtec_audio_init(codec);
+	simtec_audio_init(rtd);
 	snd_soc_dapm_sync(codec);
 
 	return 0;
@@ -83,28 +85,23 @@ static int simtec_tlv320aic23_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link simtec_dai_aic23 = {
 	.name		= "tlv320aic23",
 	.stream_name	= "TLV320AIC23",
-	.cpu_dai	= &s3c24xx_i2s_dai,
-	.codec_dai	= &tlv320aic23_dai,
+	.cpu_dai_drv 	= &s3c24xx_i2s_dai,
+	.codec_dai_drv 	= &tlv320aic23_dai,
+	.platform_drv	= &s3c24xx_soc_platform,
+	.codec_drv	= &soc_codec_dev_tlv320aic23,
 	.init		= simtec_tlv320aic23_init,
 };
 
 /* simtec audio machine driver */
 static struct snd_soc_card snd_soc_machine_simtec_aic23 = {
 	.name		= "Simtec",
-	.platform	= &s3c24xx_soc_platform,
 	.dai_link	= &simtec_dai_aic23,
 	.num_links	= 1,
 };
 
-/* simtec audio subsystem */
-static struct snd_soc_device simtec_snd_devdata_aic23 = {
-	.card		= &snd_soc_machine_simtec_aic23,
-	.codec_dev	= &soc_codec_dev_tlv320aic23,
-};
-
 static int __devinit simtec_audio_tlv320aic23_probe(struct platform_device *pd)
 {
-	return simtec_audio_core_probe(pd, &simtec_snd_devdata_aic23);
+	return simtec_audio_core_probe(pd, &snd_soc_machine_simtec_aic23);
 }
 
 static struct platform_driver simtec_audio_tlv320aic23_platdrv = {
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index 052d596..5625b3f 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -133,8 +133,8 @@ static int s3c24xx_uda134x_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int clk = 0;
 	int ret = 0;
 	int clk_source, fs_mode;
@@ -227,14 +227,15 @@ static struct snd_soc_ops s3c24xx_uda134x_ops = {
 static struct snd_soc_dai_link s3c24xx_uda134x_dai_link = {
 	.name = "UDA134X",
 	.stream_name = "UDA134X",
-	.codec_dai = &uda134x_dai,
-	.cpu_dai = &s3c24xx_i2s_dai,
+	.codec_drv = &soc_codec_dev_uda134x,
+	.codec_dai_drv = &uda134x_dai,
+	.cpu_dai_drv = &s3c24xx_i2s_dai,
 	.ops = &s3c24xx_uda134x_ops,
+	.platform_drv = &s3c24xx_soc_platform,
 };
 
 static struct snd_soc_card snd_soc_s3c24xx_uda134x = {
 	.name = "S3C24XX_UDA134X",
-	.platform = &s3c24xx_soc_platform,
 	.dai_link = &s3c24xx_uda134x_dai_link,
 	.num_links = 1,
 };
@@ -256,6 +257,7 @@ static void setmode(int v)
 	gpio_set_value(s3c24xx_uda134x_l3_pins->l3_mode, v > 0);
 }
 
+/* FIXME - This must be codec platform data but in which board file ?? */
 static struct uda134x_platform_data s3c24xx_uda134x = {
 	.l3 = {
 		.setdat = setdat,
@@ -270,12 +272,6 @@ static struct uda134x_platform_data s3c24xx_uda134x = {
 	},
 };
 
-static struct snd_soc_device s3c24xx_uda134x_snd_devdata = {
-	.card = &snd_soc_s3c24xx_uda134x,
-	.codec_dev = &soc_codec_dev_uda134x,
-	.codec_data = &s3c24xx_uda134x,
-};
-
 static int s3c24xx_uda134x_setup_pin(int pin, char *fun)
 {
 	if (gpio_request(pin, "s3c24xx_uda134x") < 0) {
@@ -325,8 +321,7 @@ static int s3c24xx_uda134x_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(s3c24xx_uda134x_snd_device,
-			     &s3c24xx_uda134x_snd_devdata);
-	s3c24xx_uda134x_snd_devdata.dev = &s3c24xx_uda134x_snd_device->dev;
+			     &snd_soc_s3c24xx_uda134x);
 	ret = platform_device_add(s3c24xx_uda134x_snd_device);
 	if (ret) {
 		printk(KERN_ERR "S3C24XX_UDA134X SoC Audio: Unable to add\n");
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
index 06db130..72708af 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
@@ -39,16 +39,7 @@ static struct s3c_dma_params s3c64xx_i2sv4_pcm_stereo_out;
 static struct s3c_dma_params s3c64xx_i2sv4_pcm_stereo_in;
 static struct s3c_i2sv2_info s3c64xx_i2sv4;
 
-struct snd_soc_dai s3c64xx_i2s_v4_dai;
-EXPORT_SYMBOL_GPL(s3c64xx_i2s_v4_dai);
-
-static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
-{
-	return cpu_dai->private_data;
-}
-
-static int s3c64xx_i2sv4_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
+static int s3c64xx_i2sv4_probe(struct snd_soc_dai *dai)
 {
 	/* configure GPIO for i2s port */
 	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
@@ -66,7 +57,7 @@ static int s3c_i2sv4_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *cpu_dai)
 {
-	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	struct s3c_i2sv2_info *i2s = snd_soc_dai_get_drvdata(cpu_dai);
 	struct s3c_dma_params *dma_data;
 	u32 iismod;
 
@@ -104,35 +95,32 @@ static struct snd_soc_dai_ops s3c64xx_i2sv4_dai_ops = {
 	.hw_params	= s3c_i2sv4_hw_params,
 };
 
+struct snd_soc_dai_driver s3c64xx_i2s_v4_dai = {
+	.name = "s3c64xx-i2s-v4",
+	.symmetric_rates = 1,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = S3C64XX_I2S_RATES,
+		.formats = S3C64XX_I2S_FMTS,
+	},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = S3C64XX_I2S_RATES,
+		.formats = S3C64XX_I2S_FMTS,
+	},
+	.probe = s3c64xx_i2sv4_probe,
+	.ops = &s3c64xx_i2sv4_dai_ops,
+};
+EXPORT_SYMBOL_GPL(s3c64xx_i2s_v4_dai);
+
 static __devinit int s3c64xx_i2sv4_dev_probe(struct platform_device *pdev)
 {
 	struct s3c_i2sv2_info *i2s;
-	struct snd_soc_dai *dai;
 	int ret;
 
 	i2s = &s3c64xx_i2sv4;
-	dai = &s3c64xx_i2s_v4_dai;
-
-	if (dai->dev) {
-		dev_dbg(dai->dev, "%s: \
-			I2Sv4 instance already registered!\n", __func__);
-		return -EBUSY;
-	}
-
-	dai->dev = &pdev->dev;
-	dai->name = "s3c64xx-i2s-v4";
-	dai->id = 0;
-	dai->symmetric_rates = 1;
-	dai->playback.channels_min = 2;
-	dai->playback.channels_max = 2;
-	dai->playback.rates = S3C64XX_I2S_RATES;
-	dai->playback.formats = S3C64XX_I2S_FMTS;
-	dai->capture.channels_min = 2;
-	dai->capture.channels_max = 2;
-	dai->capture.rates = S3C64XX_I2S_RATES;
-	dai->capture.formats = S3C64XX_I2S_FMTS;
-	dai->probe = s3c64xx_i2sv4_probe;
-	dai->ops = &s3c64xx_i2sv4_dai_ops;
 
 	i2s->feature |= S3C_FEATURE_CDCLKCON;
 
@@ -158,19 +146,13 @@ static __devinit int s3c64xx_i2sv4_dev_probe(struct platform_device *pdev)
 
 	clk_enable(i2s->iis_cclk);
 
-	ret = s3c_i2sv2_probe(pdev, dai, i2s, 0);
-	if (ret)
-		goto err_clk;
-
-	ret = s3c_i2sv2_register_dai(dai);
+	ret = snd_soc_register_dai(&pdev->dev, pdev->id, &s3c64xx_i2s_v4_dai);
 	if (ret != 0)
 		goto err_i2sv2;
 
 	return 0;
 
 err_i2sv2:
-	/* Not implemented for I2Sv2 core yet */
-err_clk:
 	clk_put(i2s->iis_cclk);
 err:
 	return ret;
@@ -178,7 +160,7 @@ err:
 
 static __devexit int s3c64xx_i2sv4_dev_remove(struct platform_device *pdev)
 {
-	dev_err(&pdev->dev, "Device removal not yet supported\n");
+	snd_soc_unregister_dai(&pdev->dev, pdev->id);
 	return 0;
 }
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 1d85cb8..ad92e10 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -12,15 +12,18 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <linux/slab.h>
 
 #include <sound/soc.h>
 
 #include <mach/gpio-bank-d.h>
 #include <mach/gpio-bank-e.h>
 #include <plat/gpio-cfg.h>
+#include <plat/audio.h>
 
 #include <mach/map.h>
 #include <mach/dma.h>
@@ -44,85 +47,82 @@ static struct s3c2410_dma_client s3c64xx_dma_client_in = {
 
 static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_out[MAX_I2SV3];
 static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_in[MAX_I2SV3];
-static struct s3c_i2sv2_info s3c64xx_i2s[MAX_I2SV3];
 
-struct snd_soc_dai s3c64xx_i2s_dai[MAX_I2SV3];
-EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
-
-static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
+static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
+				  int clk_id, unsigned int freq, int dir)
 {
-	return cpu_dai->private_data;
-}
+	struct s3c_i2sv2_info *i2s = snd_soc_dai_get_drvdata(cpu_dai);
+	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
 
-static int s3c64xx_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
-{
-	/* configure GPIO for i2s port */
-	switch (dai->id) {
-	case 0:
-		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_I2S0_CLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_I2S0_CDCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_I2S0_LRCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_I2S0_DI);
-		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_I2S0_D0);
+	switch (clk_id) {
+	case S3C64XX_CLKSRC_PCLK:
+		iismod &= ~S3C64XX_IISMOD_IMS_SYSMUX;
 		break;
-	case 1:
-		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_I2S1_CLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_I2S1_CDCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_I2S1_LRCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
-		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
+
+	case S3C64XX_CLKSRC_MUX:
+		iismod |= S3C64XX_IISMOD_IMS_SYSMUX;
+		break;
+
+	case S3C64XX_CLKSRC_CDCLK:
+		switch (dir) {
+		case SND_SOC_CLOCK_IN:
+			iismod |= S3C64XX_IISMOD_CDCLKCON;
+			break;
+		case SND_SOC_CLOCK_OUT:
+			iismod &= ~S3C64XX_IISMOD_CDCLKCON;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		return -EINVAL;
 	}
 
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
+
 	return 0;
 }
 
+struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai)
+{
+	struct s3c_i2sv2_info *i2s = snd_soc_dai_get_drvdata(dai);
+	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
 
-static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops;
+	if (iismod & S3C64XX_IISMOD_IMS_SYSMUX)
+		return i2s->iis_cclk;
+	else
+		return i2s->iis_pclk;
+}
+EXPORT_SYMBOL_GPL(s3c64xx_i2s_get_clock);
 
-static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
+static int s3c64xx_i2s_probe(struct snd_soc_dai *dai)
 {
 	struct s3c_i2sv2_info *i2s;
-	struct snd_soc_dai *dai;
 	int ret;
 
-	if (pdev->id >= MAX_I2SV3) {
-		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
-		return -EINVAL;
-	}
+	i2s = kzalloc(sizeof(struct s3c_i2sv2_info), GFP_KERNEL);
+	if (i2s == NULL)
+		return -ENOMEM;
+	snd_soc_dai_set_drvdata(dai, i2s);
 
-	i2s = &s3c64xx_i2s[pdev->id];
-	dai = &s3c64xx_i2s_dai[pdev->id];
-	dai->dev = &pdev->dev;
-	dai->name = "s3c64xx-i2s";
-	dai->id = pdev->id;
-	dai->symmetric_rates = 1;
-	dai->playback.channels_min = 2;
-	dai->playback.channels_max = 2;
-	dai->playback.rates = S3C64XX_I2S_RATES;
-	dai->playback.formats = S3C64XX_I2S_FMTS;
-	dai->capture.channels_min = 2;
-	dai->capture.channels_max = 2;
-	dai->capture.rates = S3C64XX_I2S_RATES;
-	dai->capture.formats = S3C64XX_I2S_FMTS;
-	dai->probe = s3c64xx_i2s_probe;
-	dai->ops = &s3c64xx_i2s_dai_ops;
-
-	i2s->feature |= S3C_FEATURE_CDCLKCON;
-
-	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
-	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[pdev->id];
-
-	if (pdev->id == 0) {
+	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[dai->id];
+	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[dai->id];
+
+	switch (dai->id) {
+	case 0:
 		i2s->dma_capture->channel = DMACH_I2S0_IN;
 		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISRXD;
 		i2s->dma_playback->channel = DMACH_I2S0_OUT;
 		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISTXD;
-	} else {
+		break;
+	case 1:
 		i2s->dma_capture->channel = DMACH_I2S1_IN;
 		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISRXD;
 		i2s->dma_playback->channel = DMACH_I2S1_OUT;
 		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISTXD;
+		break;
 	}
 
 	i2s->dma_capture->client = &s3c64xx_dma_client_in;
@@ -130,36 +130,102 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 	i2s->dma_playback->client = &s3c64xx_dma_client_out;
 	i2s->dma_playback->dma_size = 4;
 
-	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
+	i2s->iis_cclk = clk_get(dai->dev, "audio-bus");
 	if (IS_ERR(i2s->iis_cclk)) {
-		dev_err(&pdev->dev, "failed to get audio-bus\n");
+		dev_err(dai->dev, "failed to get audio-bus\n");
 		ret = PTR_ERR(i2s->iis_cclk);
 		goto err;
 	}
 
 	clk_enable(i2s->iis_cclk);
 
-	ret = s3c_i2sv2_probe(pdev, dai, i2s, 0);
-	if (ret)
-		goto err_clk;
-
-	ret = s3c_i2sv2_register_dai(dai);
-	if (ret != 0)
-		goto err_i2sv2;
+	/* configure GPIO for i2s port */
+	switch (dai->id) {
+	case 0:
+		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_I2S0_CLK);
+		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_I2S0_CDCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_I2S0_LRCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_I2S0_DI);
+		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_I2S0_D0);
+		break;
+	case 1:
+		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_I2S1_CLK);
+		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_I2S1_CDCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_I2S1_LRCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
+		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
+	}
 
 	return 0;
 
-err_i2sv2:
-	/* Not implemented for I2Sv2 core yet */
-err_clk:
-	clk_put(i2s->iis_cclk);
 err:
+	kfree(i2s);
 	return ret;
 }
 
+static int s3c64xx_i2s_remove(struct snd_soc_dai *dai)
+{
+	struct s3c_i2sv2_info *i2s = snd_soc_dai_get_drvdata(dai);
+
+	clk_disable(i2s->iis_cclk);
+	clk_put(i2s->iis_cclk);
+	kfree(i2s);
+	return 0;
+}
+
+static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops;
+
+struct snd_soc_dai_driver s3c64xx_i2s_dai[MAX_I2SV3] = {
+{
+	.name = "s3c64xx-i2s-0",
+	.probe = s3c64xx_i2s_probe,
+	.remove = s3c64xx_i2s_remove,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = S3C64XX_I2S_RATES,
+		.formats = S3C64XX_I2S_FMTS,},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = S3C64XX_I2S_RATES,
+		.formats = S3C64XX_I2S_FMTS,},
+	.ops = &s3c64xx_i2s_dai_ops,
+	.symmetric_rates = 1,
+}, {
+	.name = "s3c64xx-i2s-1",
+	.probe = s3c64xx_i2s_probe,
+	.remove = s3c64xx_i2s_remove,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = S3C64XX_I2S_RATES,
+		.formats = S3C64XX_I2S_FMTS,},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = S3C64XX_I2S_RATES,
+		.formats = S3C64XX_I2S_FMTS,},
+	.ops = &s3c64xx_i2s_dai_ops,
+	.symmetric_rates = 1,
+},};
+EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
+
+static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
+{
+
+	if (pdev->id >= MAX_I2SV3) {
+		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
+		return -EINVAL;
+	}
+
+	return snd_soc_register_dais(&pdev->dev, s3c64xx_i2s_dai,
+			ARRAY_SIZE(s3c64xx_i2s_dai));
+}
+
 static __devexit int s3c64xx_iis_dev_remove(struct platform_device *pdev)
 {
-	dev_err(&pdev->dev, "Device removal not yet supported\n");
+	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(s3c64xx_i2s_dai));
 	return 0;
 }
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.h b/sound/soc/s3c24xx/s3c64xx-i2s.h
index 7a40f43..5e3d36c 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.h
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.h
@@ -36,7 +36,9 @@ struct clk;
 	(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |\
 	 SNDRV_PCM_FMTBIT_S24_LE)
 
-extern struct snd_soc_dai s3c64xx_i2s_dai[];
-extern struct snd_soc_dai s3c64xx_i2s_v4_dai;
+
+extern struct snd_soc_dai_driver s3c64xx_i2s_v4_dai;
+extern struct snd_soc_dai_driver s3c64xx_i2s_dai[];
+
 
 #endif /* __SND_SOC_S3C24XX_S3C64XX_I2S_H */
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
index 3622588..eee03d2 100644
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
@@ -29,23 +29,20 @@ static struct snd_soc_dai_link smdk2443_dai[] = {
 {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
-	.codec_dai = &ac97_dai,
+	.cpu_dai_drv = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
+	.cpu_dai_id = S3C_AC97_DAI_PCM,
+	.codec_dai_drv = &ac97_dai,
+	.codec_drv = &soc_codec_dev_ac97,
+	.platform_drv = &s3c24xx_soc_platform,
 },
 };
 
 static struct snd_soc_card smdk2443 = {
 	.name = "SMDK2443",
-	.platform = &s3c24xx_soc_platform,
 	.dai_link = smdk2443_dai,
 	.num_links = ARRAY_SIZE(smdk2443_dai),
 };
 
-static struct snd_soc_device smdk2443_snd_ac97_devdata = {
-	.card = &smdk2443,
-	.codec_dev = &soc_codec_dev_ac97,
-};
-
 static struct platform_device *smdk2443_snd_ac97_device;
 
 static int __init smdk2443_init(void)
@@ -56,9 +53,7 @@ static int __init smdk2443_init(void)
 	if (!smdk2443_snd_ac97_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(smdk2443_snd_ac97_device,
-				&smdk2443_snd_ac97_devdata);
-	smdk2443_snd_ac97_devdata.dev = &smdk2443_snd_ac97_device->dev;
+	platform_set_drvdata(smdk2443_snd_ac97_device, &smdk2443);
 	ret = platform_device_add(smdk2443_snd_ac97_device);
 
 	if (ret)
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 07e8e51..0b4b996 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -29,8 +29,8 @@ static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	unsigned int pll_out;
 	int bfs, rfs, ret;
 
@@ -174,8 +174,10 @@ static const struct snd_soc_dapm_route audio_map_rx[] = {
 	{"Rear-L/R", NULL, "VOUT3R"},
 };
 
-static int smdk64xx_wm8580_init_paiftx(struct snd_soc_codec *codec)
+static int smdk64xx_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	/* Add smdk64xx specific Capture widgets */
 	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_cpt,
 				  ARRAY_SIZE(wm8580_dapm_widgets_cpt));
@@ -194,8 +196,10 @@ static int smdk64xx_wm8580_init_paiftx(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int smdk64xx_wm8580_init_paifrx(struct snd_soc_codec *codec)
+static int smdk64xx_wm8580_init_paifrx(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	/* Add smdk64xx specific Playback widgets */
 	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_pbk,
 				  ARRAY_SIZE(wm8580_dapm_widgets_pbk));
@@ -213,16 +217,22 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 { /* Primary Playback i/f */
 	.name = "WM8580 PAIF RX",
 	.stream_name = "Playback",
-	.cpu_dai = &s3c64xx_i2s_v4_dai,
-	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFRX],
+	.cpu_dai_drv = &s3c64xx_i2s_v4_dai,
+	.codec_dai_drv = &wm8580_dai[WM8580_DAI_PAIFRX],
+	.codec_dai_id = WM8580_DAI_PAIFRX,
+	.platform_drv = &s3c24xx_soc_platform,
+	.codec_drv = &soc_codec_dev_wm8580,
 	.init = smdk64xx_wm8580_init_paifrx,
 	.ops = &smdk64xx_ops,
 },
 { /* Primary Capture i/f */
 	.name = "WM8580 PAIF TX",
 	.stream_name = "Capture",
-	.cpu_dai = &s3c64xx_i2s_v4_dai,
-	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFTX],
+	.cpu_dai_drv = &s3c64xx_i2s_v4_dai,
+	.codec_dai_drv = &wm8580_dai[WM8580_DAI_PAIFTX],
+	.codec_dai_id = WM8580_DAI_PAIFTX,
+	.platform_drv = &s3c24xx_soc_platform,
+	.codec_drv = &soc_codec_dev_wm8580,
 	.init = smdk64xx_wm8580_init_paiftx,
 	.ops = &smdk64xx_ops,
 },
@@ -230,16 +240,10 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 
 static struct snd_soc_card smdk64xx = {
 	.name = "smdk64xx",
-	.platform = &s3c24xx_soc_platform,
 	.dai_link = smdk64xx_dai,
 	.num_links = ARRAY_SIZE(smdk64xx_dai),
 };
 
-static struct snd_soc_device smdk64xx_snd_devdata = {
-	.card = &smdk64xx,
-	.codec_dev = &soc_codec_dev_wm8580,
-};
-
 static struct platform_device *smdk64xx_snd_device;
 
 static int __init smdk64xx_audio_init(void)
@@ -250,8 +254,7 @@ static int __init smdk64xx_audio_init(void)
 	if (!smdk64xx_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(smdk64xx_snd_device, &smdk64xx_snd_devdata);
-	smdk64xx_snd_devdata.dev = &smdk64xx_snd_device->dev;
+	platform_set_drvdata(smdk64xx_snd_device, &smdk64xx);
 	ret = platform_device_add(smdk64xx_snd_device);
 
 	if (ret)
diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
index 5527b9e..001c2dd 100644
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -46,22 +46,20 @@ static struct snd_soc_card smdk;
 static struct snd_soc_dai_link smdk_dai = {
 	.name = "AC97",
 	.stream_name = "AC97 PCM",
-	.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
-	.codec_dai = &wm9713_dai[WM9713_DAI_AC97_HIFI],
+	.platform_drv = &s3c24xx_soc_platform,
+	.cpu_dai_drv = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
+	.cpu_dai_id = S3C_AC97_DAI_PCM,
+	.codec_dai_drv = &wm9713_dai[WM9713_DAI_AC97_HIFI],
+	.codec_dai_id = WM9713_DAI_AC97_HIFI,
+	.codec_drv = &soc_codec_dev_wm9713,
 };
 
 static struct snd_soc_card smdk = {
 	.name = "SMDK",
-	.platform = &s3c24xx_soc_platform,
 	.dai_link = &smdk_dai,
 	.num_links = 1,
 };
 
-static struct snd_soc_device smdk_snd_ac97_devdata = {
-	.card = &smdk,
-	.codec_dev = &soc_codec_dev_wm9713,
-};
-
 static struct platform_device *smdk_snd_ac97_device;
 
 static int __init smdk_init(void)
@@ -72,9 +70,7 @@ static int __init smdk_init(void)
 	if (!smdk_snd_ac97_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(smdk_snd_ac97_device,
-			     &smdk_snd_ac97_devdata);
-	smdk_snd_ac97_devdata.dev = &smdk_snd_ac97_device->dev;
+	platform_set_drvdata(smdk_snd_ac97_device, &smdk);
 
 	ret = platform_device_add(smdk_snd_ac97_device);
 	if (ret)
-- 
1.7.0.4
