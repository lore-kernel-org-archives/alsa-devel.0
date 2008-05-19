From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Clarify API for bias configuration
Date: Mon, 19 May 2008 11:20:39 +0100
Message-ID: <1211192441-28912-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A625245FB
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 12:20:43 +0200 (CEST)
In-Reply-To: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Currently the ASoC core configures the bias levels in the system using
a callback on codecs and machines called "dapm_event", passing it PCI
style power levels as SNDRV_CTL_POWER_ constants. This is more obscure
than it needs to be and has caused confusion to driver authors,
especially given that DAPM is also performing power management.

Address this by renaming the callback function to "set_bias_level" and
using constants explicitly representing the off, standby, pre-on and on
states which DAPM transitions through.

Also unexport the API for setting bias level: there are currently no
in-tree users of this API other than the core itself and it is likely
that the core would need to be extended to cater for any users.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 include/sound/soc-dapm.h       |    3 +-
 include/sound/soc.h            |   28 +++++++++++++++++++++---
 sound/soc/codecs/tlv320aic3x.c |   26 +++++++++++-----------
 sound/soc/codecs/wm8731.c      |   28 ++++++++++++------------
 sound/soc/codecs/wm8750.c      |   36 ++++++++++++++++----------------
 sound/soc/codecs/wm8753.c      |   36 ++++++++++++++++----------------
 sound/soc/codecs/wm9712.c      |   28 ++++++++++++------------
 sound/soc/codecs/wm9713.c      |   26 +++++++++++-----------
 sound/soc/soc-core.c           |   25 +++++++++++----------
 sound/soc/soc-dapm.c           |   44 +++++++++++++++++++--------------------
 10 files changed, 150 insertions(+), 130 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index bf4cf0c..f8223fa 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -221,7 +221,8 @@ int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
 /* dapm events */
 int snd_soc_dapm_stream_event(struct snd_soc_codec *codec, char *stream,
 	int event);
-int snd_soc_dapm_device_event(struct snd_soc_device *socdev, int event);
+int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
+	enum snd_soc_bias_level level);
 
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index d3c8c03..727c0ba 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -103,6 +103,24 @@
 	.private_value = (unsigned long)&xenum }
 
 /*
+ * Bias levels
+ *
+ * @ON:      Bias is fully on for audio playback and capture operations.
+ * @PREPARE: Prepare for audio operations. Called before DAPM switching for
+ *           stream start and stop operations.
+ * @STANDBY: Low power standby state when no playback/capture operations are
+ *           in progress. NOTE: The transition time between STANDBY and ON
+ *           should be as fast as possible and no longer than 10ms.
+ * @OFF:     Power Off. No restrictions on transition times.
+ */
+enum snd_soc_bias_level {
+	SND_SOC_BIAS_ON,
+	SND_SOC_BIAS_PREPARE,
+	SND_SOC_BIAS_STANDBY,
+	SND_SOC_BIAS_OFF,
+};
+
+/*
  * Digital Audio Interface (DAI) types
  */
 #define SND_SOC_DAI_AC97	0x1
@@ -374,7 +392,8 @@ struct snd_soc_codec {
 	struct mutex mutex;
 
 	/* callbacks */
-	int (*dapm_event)(struct snd_soc_codec *codec, int event);
+	int (*set_bias_level)(struct snd_soc_codec *,
+			      enum snd_soc_bias_level level);
 
 	/* runtime */
 	struct snd_card *card;
@@ -396,8 +415,8 @@ struct snd_soc_codec {
 	/* dapm */
 	struct list_head dapm_widgets;
 	struct list_head dapm_paths;
-	unsigned int dapm_state;
-	unsigned int suspend_dapm_state;
+	enum snd_soc_bias_level bias_level;
+	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
 
 	/* codec DAI's */
@@ -467,7 +486,8 @@ struct snd_soc_machine {
 	int (*resume_post)(struct platform_device *pdev);
 
 	/* callbacks */
-	int (*dapm_event)(struct snd_soc_machine *, int event);
+	int (*set_bias_level)(struct snd_soc_machine *,
+			      enum snd_soc_bias_level level);
 
 	/* CPU <--> Codec DAI links  */
 	struct snd_soc_dai_link *dai_link;
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index cb8365a..dc8a38d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -847,13 +847,14 @@ static int aic3x_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 	return 0;
 }
 
-static int aic3x_dapm_event(struct snd_soc_codec *codec, int event)
+static int aic3x_set_bias_level(struct snd_soc_codec *codec,
+				enum snd_soc_bias_level level)
 {
 	struct aic3x_priv *aic3x = codec->private_data;
 	u8 reg;
 
-	switch (event) {
-	case SNDRV_CTL_POWER_D0:
+	switch (level) {
+	case SND_SOC_BIAS_ON:
 		/* all power is driven by DAPM system */
 		if (aic3x->master) {
 			/* enable pll */
@@ -862,10 +863,9 @@ static int aic3x_dapm_event(struct snd_soc_codec *codec, int event)
 				    reg | PLL_ENABLE);
 		}
 		break;
-	case SNDRV_CTL_POWER_D1:
-	case SNDRV_CTL_POWER_D2:
+	case SND_SOC_BIAS_PREPARE:
 		break;
-	case SNDRV_CTL_POWER_D3hot:
+	case SND_SOC_BIAS_STANDBY:
 		/*
 		 * all power is driven by DAPM system,
 		 * so output power is safe if bypass was set
@@ -877,7 +877,7 @@ static int aic3x_dapm_event(struct snd_soc_codec *codec, int event)
 				    reg & ~PLL_ENABLE);
 		}
 		break;
-	case SNDRV_CTL_POWER_D3cold:
+	case SND_SOC_BIAS_OFF:
 		/* force all power off */
 		reg = aic3x_read_reg_cache(codec, LINE1L_2_LADC_CTRL);
 		aic3x_write(codec, LINE1L_2_LADC_CTRL, reg & ~LADC_PWR_ON);
@@ -913,7 +913,7 @@ static int aic3x_dapm_event(struct snd_soc_codec *codec, int event)
 		}
 		break;
 	}
-	codec->dapm_state = event;
+	codec->bias_level = level;
 
 	return 0;
 }
@@ -979,7 +979,7 @@ static int aic3x_suspend(struct platform_device *pdev, pm_message_t state)
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->codec;
 
-	aic3x_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
@@ -999,7 +999,7 @@ static int aic3x_resume(struct platform_device *pdev)
 		codec->hw_write(codec->control_data, data, 2);
 	}
 
-	aic3x_dapm_event(codec, codec->suspend_dapm_state);
+	aic3x_set_bias_level(codec, codec->suspend_bias_level);
 
 	return 0;
 }
@@ -1018,7 +1018,7 @@ static int aic3x_init(struct snd_soc_device *socdev)
 	codec->owner = THIS_MODULE;
 	codec->read = aic3x_read_reg_cache;
 	codec->write = aic3x_write;
-	codec->dapm_event = aic3x_dapm_event;
+	codec->set_bias_level = aic3x_set_bias_level;
 	codec->dai = &aic3x_dai;
 	codec->num_dai = 1;
 	codec->reg_cache_size = sizeof(aic3x_reg);
@@ -1100,7 +1100,7 @@ static int aic3x_init(struct snd_soc_device *socdev)
 	aic3x_write(codec, LINE2R_2_MONOLOPM_VOL, DEFAULT_VOL);
 
 	/* off, with power on */
-	aic3x_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
+	aic3x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* setup GPIO functions */
 	aic3x_write(codec, AIC3X_GPIO1_REG, (setup->gpio_func[0] & 0xf) << 4);
@@ -1271,7 +1271,7 @@ static int aic3x_remove(struct platform_device *pdev)
 
 	/* power down chip */
 	if (codec->control_data)
-		aic3x_dapm_event(codec, SNDRV_CTL_POWER_D3);
+		aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 006923b..5acf43a 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -427,29 +427,29 @@ static int wm8731_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 	return 0;
 }
 
-static int wm8731_dapm_event(struct snd_soc_codec *codec, int event)
+static int wm8731_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
 {
 	u16 reg = wm8731_read_reg_cache(codec, WM8731_PWR) & 0xff7f;
 
-	switch (event) {
-	case SNDRV_CTL_POWER_D0: /* full On */
+	switch (level) {
+	case SND_SOC_BIAS_ON:
 		/* vref/mid, osc on, dac unmute */
 		wm8731_write(codec, WM8731_PWR, reg);
 		break;
-	case SNDRV_CTL_POWER_D1: /* partial On */
-	case SNDRV_CTL_POWER_D2: /* partial On */
+	case SND_SOC_BIAS_PREPARE:
 		break;
-	case SNDRV_CTL_POWER_D3hot: /* Off, with power */
+	case SND_SOC_BIAS_STANDBY:
 		/* everything off except vref/vmid, */
 		wm8731_write(codec, WM8731_PWR, reg | 0x0040);
 		break;
-	case SNDRV_CTL_POWER_D3cold: /* Off, without power */
+	case SND_SOC_BIAS_OFF:
 		/* everything off, dac mute, inactive */
 		wm8731_write(codec, WM8731_ACTIVE, 0x0);
 		wm8731_write(codec, WM8731_PWR, 0xffff);
 		break;
 	}
-	codec->dapm_state = event;
+	codec->bias_level = level;
 	return 0;
 }
 
@@ -495,7 +495,7 @@ static int wm8731_suspend(struct platform_device *pdev, pm_message_t state)
 	struct snd_soc_codec *codec = socdev->codec;
 
 	wm8731_write(codec, WM8731_ACTIVE, 0x0);
-	wm8731_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+	wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
@@ -513,8 +513,8 @@ static int wm8731_resume(struct platform_device *pdev)
 		data[1] = cache[i] & 0x00ff;
 		codec->hw_write(codec->control_data, data, 2);
 	}
-	wm8731_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
-	wm8731_dapm_event(codec, codec->suspend_dapm_state);
+	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	wm8731_set_bias_level(codec, codec->suspend_bias_level);
 	return 0;
 }
 
@@ -531,7 +531,7 @@ static int wm8731_init(struct snd_soc_device *socdev)
 	codec->owner = THIS_MODULE;
 	codec->read = wm8731_read_reg_cache;
 	codec->write = wm8731_write;
-	codec->dapm_event = wm8731_dapm_event;
+	codec->set_bias_level = wm8731_set_bias_level;
 	codec->dai = &wm8731_dai;
 	codec->num_dai = 1;
 	codec->reg_cache_size = sizeof(wm8731_reg);
@@ -549,7 +549,7 @@ static int wm8731_init(struct snd_soc_device *socdev)
 	}
 
 	/* power on device */
-	wm8731_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
+	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* set the update bits */
 	reg = wm8731_read_reg_cache(codec, WM8731_LOUT1V);
@@ -722,7 +722,7 @@ static int wm8731_remove(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->codec;
 
 	if (codec->control_data)
-		wm8731_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+		wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 9c7b0e8..1f11ad2 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -678,29 +678,29 @@ static int wm8750_mute(struct snd_soc_codec_dai *dai, int mute)
 	return 0;
 }
 
-static int wm8750_dapm_event(struct snd_soc_codec *codec, int event)
+static int wm8750_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
 {
 	u16 pwr_reg = wm8750_read_reg_cache(codec, WM8750_PWR1) & 0xfe3e;
 
-	switch (event) {
-	case SNDRV_CTL_POWER_D0: /* full On */
+	switch (level) {
+	case SND_SOC_BIAS_ON:
 		/* set vmid to 50k and unmute dac */
 		wm8750_write(codec, WM8750_PWR1, pwr_reg | 0x00c0);
 		break;
-	case SNDRV_CTL_POWER_D1: /* partial On */
-	case SNDRV_CTL_POWER_D2: /* partial On */
+	case SND_SOC_BIAS_PREPARE:
 		/* set vmid to 5k for quick power up */
 		wm8750_write(codec, WM8750_PWR1, pwr_reg | 0x01c1);
 		break;
-	case SNDRV_CTL_POWER_D3hot: /* Off, with power */
+	case SND_SOC_BIAS_STANDBY:
 		/* mute dac and set vmid to 500k, enable VREF */
 		wm8750_write(codec, WM8750_PWR1, pwr_reg | 0x0141);
 		break;
-	case SNDRV_CTL_POWER_D3cold: /* Off, without power */
+	case SND_SOC_BIAS_OFF:
 		wm8750_write(codec, WM8750_PWR1, 0x0001);
 		break;
 	}
-	codec->dapm_state = event;
+	codec->bias_level = level;
 	return 0;
 }
 
@@ -740,7 +740,7 @@ static void wm8750_work(struct work_struct *work)
 {
 	struct snd_soc_codec *codec =
 		container_of(work, struct snd_soc_codec, delayed_work.work);
-	wm8750_dapm_event(codec, codec->dapm_state);
+	wm8750_set_bias_level(codec, codec->bias_level);
 }
 
 static int wm8750_suspend(struct platform_device *pdev, pm_message_t state)
@@ -748,7 +748,7 @@ static int wm8750_suspend(struct platform_device *pdev, pm_message_t state)
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->codec;
 
-	wm8750_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+	wm8750_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
@@ -769,12 +769,12 @@ static int wm8750_resume(struct platform_device *pdev)
 		codec->hw_write(codec->control_data, data, 2);
 	}
 
-	wm8750_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
+	wm8750_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* charge wm8750 caps */
-	if (codec->suspend_dapm_state == SNDRV_CTL_POWER_D0) {
-		wm8750_dapm_event(codec, SNDRV_CTL_POWER_D2);
-		codec->dapm_state = SNDRV_CTL_POWER_D0;
+	if (codec->suspend_bias_level == SND_SOC_BIAS_ON) {
+		wm8750_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
+		codec->bias_level = SND_SOC_BIAS_ON;
 		schedule_delayed_work(&codec->delayed_work,
 					msecs_to_jiffies(1000));
 	}
@@ -795,7 +795,7 @@ static int wm8750_init(struct snd_soc_device *socdev)
 	codec->owner = THIS_MODULE;
 	codec->read = wm8750_read_reg_cache;
 	codec->write = wm8750_write;
-	codec->dapm_event = wm8750_dapm_event;
+	codec->set_bias_level = wm8750_set_bias_level;
 	codec->dai = &wm8750_dai;
 	codec->num_dai = 1;
 	codec->reg_cache_size = sizeof(wm8750_reg);
@@ -813,8 +813,8 @@ static int wm8750_init(struct snd_soc_device *socdev)
 	}
 
 	/* charge output caps */
-	wm8750_dapm_event(codec, SNDRV_CTL_POWER_D2);
-	codec->dapm_state = SNDRV_CTL_POWER_D3hot;
+	wm8750_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
+	codec->bias_level = SND_SOC_BIAS_STANDBY;
 	schedule_delayed_work(&codec->delayed_work, msecs_to_jiffies(1000));
 
 	/* set the update bits */
@@ -1013,7 +1013,7 @@ static int wm8750_remove(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->codec;
 
 	if (codec->control_data)
-		wm8750_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+		wm8750_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	run_delayed_work(&codec->delayed_work);
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 2bc49ab..c32e632 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1265,29 +1265,29 @@ static int wm8753_mute(struct snd_soc_codec_dai *dai, int mute)
 	return 0;
 }
 
-static int wm8753_dapm_event(struct snd_soc_codec *codec, int event)
+static int wm8753_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
 {
 	u16 pwr_reg = wm8753_read_reg_cache(codec, WM8753_PWR1) & 0xfe3e;
 
-	switch (event) {
-	case SNDRV_CTL_POWER_D0: /* full On */
+	switch (level) {
+	case SND_SOC_BIAS_ON:
 		/* set vmid to 50k and unmute dac */
 		wm8753_write(codec, WM8753_PWR1, pwr_reg | 0x00c0);
 		break;
-	case SNDRV_CTL_POWER_D1: /* partial On */
-	case SNDRV_CTL_POWER_D2: /* partial On */
+	case SND_SOC_BIAS_PREPARE:
 		/* set vmid to 5k for quick power up */
 		wm8753_write(codec, WM8753_PWR1, pwr_reg | 0x01c1);
 		break;
-	case SNDRV_CTL_POWER_D3hot: /* Off, with power */
+	case SND_SOC_BIAS_STANDBY:
 		/* mute dac and set vmid to 500k, enable VREF */
 		wm8753_write(codec, WM8753_PWR1, pwr_reg | 0x0141);
 		break;
-	case SNDRV_CTL_POWER_D3cold: /* Off, without power */
+	case SND_SOC_BIAS_OFF:
 		wm8753_write(codec, WM8753_PWR1, 0x0001);
 		break;
 	}
-	codec->dapm_state = event;
+	codec->bias_level = level;
 	return 0;
 }
 
@@ -1491,7 +1491,7 @@ static void wm8753_work(struct work_struct *work)
 {
 	struct snd_soc_codec *codec =
 		container_of(work, struct snd_soc_codec, delayed_work.work);
-	wm8753_dapm_event(codec, codec->dapm_state);
+	wm8753_set_bias_level(codec, codec->bias_level);
 }
 
 static int wm8753_suspend(struct platform_device *pdev, pm_message_t state)
@@ -1503,7 +1503,7 @@ static int wm8753_suspend(struct platform_device *pdev, pm_message_t state)
 	if (!codec->card)
 		return 0;
 
-	wm8753_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+	wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
@@ -1528,12 +1528,12 @@ static int wm8753_resume(struct platform_device *pdev)
 		codec->hw_write(codec->control_data, data, 2);
 	}
 
-	wm8753_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
+	wm8753_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* charge wm8753 caps */
-	if (codec->suspend_dapm_state == SNDRV_CTL_POWER_D0) {
-		wm8753_dapm_event(codec, SNDRV_CTL_POWER_D2);
-		codec->dapm_state = SNDRV_CTL_POWER_D0;
+	if (codec->suspend_bias_level == SND_SOC_BIAS_ON) {
+		wm8753_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
+		codec->bias_level = SND_SOC_BIAS_ON;
 		schedule_delayed_work(&codec->delayed_work,
 			msecs_to_jiffies(caps_charge));
 	}
@@ -1554,7 +1554,7 @@ static int wm8753_init(struct snd_soc_device *socdev)
 	codec->owner = THIS_MODULE;
 	codec->read = wm8753_read_reg_cache;
 	codec->write = wm8753_write;
-	codec->dapm_event = wm8753_dapm_event;
+	codec->set_bias_level = wm8753_set_bias_level;
 	codec->dai = wm8753_dai;
 	codec->num_dai = 2;
 	codec->reg_cache_size = sizeof(wm8753_reg);
@@ -1575,8 +1575,8 @@ static int wm8753_init(struct snd_soc_device *socdev)
 	}
 
 	/* charge output caps */
-	wm8753_dapm_event(codec, SNDRV_CTL_POWER_D2);
-	codec->dapm_state = SNDRV_CTL_POWER_D3hot;
+	wm8753_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
+	codec->bias_level = SND_SOC_BIAS_STANDBY;
 	schedule_delayed_work(&codec->delayed_work,
 		msecs_to_jiffies(caps_charge));
 
@@ -1783,7 +1783,7 @@ static int wm8753_remove(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->codec;
 
 	if (codec->control_data)
-		wm8753_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+		wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	run_delayed_work(&codec->delayed_work);
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 5ca0eb1..d9789f1 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -564,23 +564,23 @@ struct snd_soc_codec_dai wm9712_dai[] = {
 };
 EXPORT_SYMBOL_GPL(wm9712_dai);
 
-static int wm9712_dapm_event(struct snd_soc_codec *codec, int event)
+static int wm9712_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
 {
-	switch (event) {
-	case SNDRV_CTL_POWER_D0: /* full On */
-	case SNDRV_CTL_POWER_D1: /* partial On */
-	case SNDRV_CTL_POWER_D2: /* partial On */
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
 		break;
-	case SNDRV_CTL_POWER_D3hot: /* Off, with power */
+	case SND_SOC_BIAS_STANDBY:
 		ac97_write(codec, AC97_POWERDOWN, 0x0000);
 		break;
-	case SNDRV_CTL_POWER_D3cold: /* Off, without power */
+	case SND_SOC_BIAS_OFF:
 		/* disable everything including AC link */
 		ac97_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
 		ac97_write(codec, AC97_POWERDOWN, 0xffff);
 		break;
 	}
-	codec->dapm_state = event;
+	codec->bias_level = level;
 	return 0;
 }
 
@@ -608,7 +608,7 @@ static int wm9712_soc_suspend(struct platform_device *pdev,
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->codec;
 
-	wm9712_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+	wm9712_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
@@ -625,7 +625,7 @@ static int wm9712_soc_resume(struct platform_device *pdev)
 		return ret;
 	}
 
-	wm9712_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
+	wm9712_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	if (ret == 0) {
 		/* Sync reg_cache with the hardware after cold reset */
@@ -637,8 +637,8 @@ static int wm9712_soc_resume(struct platform_device *pdev)
 		}
 	}
 
-	if (codec->suspend_dapm_state == SNDRV_CTL_POWER_D0)
-		wm9712_dapm_event(codec, SNDRV_CTL_POWER_D0);
+	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
+		wm9712_set_bias_level(codec, SND_SOC_BIAS_ON);
 
 	return ret;
 }
@@ -672,7 +672,7 @@ static int wm9712_soc_probe(struct platform_device *pdev)
 	codec->num_dai = ARRAY_SIZE(wm9712_dai);
 	codec->write = ac97_write;
 	codec->read = ac97_read;
-	codec->dapm_event = wm9712_dapm_event;
+	codec->set_bias_level = wm9712_set_bias_level;
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
@@ -696,7 +696,7 @@ static int wm9712_soc_probe(struct platform_device *pdev)
 	/* set alc mux to none */
 	ac97_write(codec, AC97_VIDEO, ac97_read(codec, AC97_VIDEO) | 0x3000);
 
-	wm9712_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
+	wm9712_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	wm9712_add_controls(codec);
 	wm9712_add_widgets(codec);
 	ret = snd_soc_register_card(socdev);
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 86c1445..4f516a5 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1087,33 +1087,33 @@ int wm9713_reset(struct snd_soc_codec *codec, int try_warm)
 }
 EXPORT_SYMBOL_GPL(wm9713_reset);
 
-static int wm9713_dapm_event(struct snd_soc_codec *codec, int event)
+static int wm9713_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
 {
 	u16 reg;
 
-	switch (event) {
-	case SNDRV_CTL_POWER_D0: /* full On */
+	switch (level) {
+	case SND_SOC_BIAS_ON:
 		/* enable thermal shutdown */
 		reg = ac97_read(codec, AC97_EXTENDED_MID) & 0x1bff;
 		ac97_write(codec, AC97_EXTENDED_MID, reg);
 		break;
-	case SNDRV_CTL_POWER_D1: /* partial On */
-	case SNDRV_CTL_POWER_D2: /* partial On */
+	case SND_SOC_BIAS_PREPARE:
 		break;
-	case SNDRV_CTL_POWER_D3hot: /* Off, with power */
+	case SND_SOC_BIAS_STANDBY:
 		/* enable master bias and vmid */
 		reg = ac97_read(codec, AC97_EXTENDED_MID) & 0x3bff;
 		ac97_write(codec, AC97_EXTENDED_MID, reg);
 		ac97_write(codec, AC97_POWERDOWN, 0x0000);
 		break;
-	case SNDRV_CTL_POWER_D3cold: /* Off, without power */
+	case SND_SOC_BIAS_OFF:
 		/* disable everything including AC link */
 		ac97_write(codec, AC97_EXTENDED_MID, 0xffff);
 		ac97_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
 		ac97_write(codec, AC97_POWERDOWN, 0xffff);
 		break;
 	}
-	codec->dapm_state = event;
+	codec->bias_level = level;
 	return 0;
 }
 
@@ -1150,7 +1150,7 @@ static int wm9713_soc_resume(struct platform_device *pdev)
 		return ret;
 	}
 
-	wm9713_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
+	wm9713_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* do we need to re-start the PLL ? */
 	if (wm9713->pll_out)
@@ -1166,8 +1166,8 @@ static int wm9713_soc_resume(struct platform_device *pdev)
 		}
 	}
 
-	if (codec->suspend_dapm_state == SNDRV_CTL_POWER_D0)
-		wm9713_dapm_event(codec, SNDRV_CTL_POWER_D0);
+	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
+		wm9713_set_bias_level(codec, SND_SOC_BIAS_ON);
 
 	return ret;
 }
@@ -1206,7 +1206,7 @@ static int wm9713_soc_probe(struct platform_device *pdev)
 	codec->num_dai = ARRAY_SIZE(wm9713_dai);
 	codec->write = ac97_write;
 	codec->read = ac97_read;
-	codec->dapm_event = wm9713_dapm_event;
+	codec->set_bias_level = wm9713_set_bias_level;
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
@@ -1228,7 +1228,7 @@ static int wm9713_soc_probe(struct platform_device *pdev)
 		goto reset_err;
 	}
 
-	wm9713_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
+	wm9713_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* unmute the adc - move to kcontrol */
 	reg = ac97_read(codec, AC97_CD) & 0x7fff;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0318d8a..a05b345 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -283,12 +283,12 @@ static void close_delayed_work(struct work_struct *work)
 		/* are we waiting on this codec DAI stream */
 		if (codec_dai->pop_wait == 1) {
 
-			/* power down the codec to D1 if no longer active */
+			/* Reduce power if no longer active */
 			if (codec->active == 0) {
 				dbg("pop wq D1 %s %s\n", codec->name,
 					codec_dai->playback.stream_name);
-				snd_soc_dapm_device_event(socdev,
-					SNDRV_CTL_POWER_D1);
+				snd_soc_dapm_set_bias_level(socdev,
+					SND_SOC_BIAS_PREPARE);
 			}
 
 			codec_dai->pop_wait = 0;
@@ -296,12 +296,12 @@ static void close_delayed_work(struct work_struct *work)
 				codec_dai->playback.stream_name,
 				SND_SOC_DAPM_STREAM_STOP);
 
-			/* power down the codec power domain if no longer active */
+			/* Fall into standby if no longer active */
 			if (codec->active == 0) {
 				dbg("pop wq D3 %s %s\n", codec->name,
 					codec_dai->playback.stream_name);
-				snd_soc_dapm_device_event(socdev,
-					SNDRV_CTL_POWER_D3hot);
+				snd_soc_dapm_set_bias_level(socdev,
+					SND_SOC_BIAS_STANDBY);
 			}
 		}
 	}
@@ -361,8 +361,8 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 			SND_SOC_DAPM_STREAM_STOP);
 
 		if (codec->active == 0 && codec_dai->pop_wait == 0)
-			snd_soc_dapm_device_event(socdev,
-						SNDRV_CTL_POWER_D3hot);
+			snd_soc_dapm_set_bias_level(socdev,
+						SND_SOC_BIAS_STANDBY);
 	}
 
 	mutex_unlock(&pcm_mutex);
@@ -435,9 +435,10 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		}
 	} else {
 		/* no delayed work - do we need to power up codec */
-		if (codec->dapm_state != SNDRV_CTL_POWER_D0) {
+		if (codec->bias_level != SND_SOC_BIAS_ON) {
 
-			snd_soc_dapm_device_event(socdev,  SNDRV_CTL_POWER_D1);
+			snd_soc_dapm_set_bias_level(socdev,
+						    SND_SOC_BIAS_PREPARE);
 
 			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 				snd_soc_dapm_stream_event(codec,
@@ -448,7 +449,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 					codec_dai->capture.stream_name,
 					SND_SOC_DAPM_STREAM_START);
 
-			snd_soc_dapm_device_event(socdev, SNDRV_CTL_POWER_D0);
+			snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_ON);
 			if (codec_dai->dai_ops.digital_mute)
 				codec_dai->dai_ops.digital_mute(codec_dai, 0);
 
@@ -658,7 +659,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 
 	/* close any waiting streams and save state */
 	run_delayed_work(&socdev->delayed_work);
-	codec->suspend_dapm_state = codec->dapm_state;
+	codec->suspend_bias_level = codec->bias_level;
 
 	for(i = 0; i < codec->num_dai; i++) {
 		char *stream = codec->dai[i].playback.stream_name;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8a3192b..728f3ac 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -763,21 +763,18 @@ static ssize_t dapm_widget_show(struct device *dev,
 		}
 	}
 
-	switch(codec->dapm_state){
-	case SNDRV_CTL_POWER_D0:
-		state = "D0";
+	switch (codec->bias_level) {
+	case SND_SOC_BIAS_ON:
+		state = "On";
 		break;
-	case SNDRV_CTL_POWER_D1:
-		state = "D1";
+	case SND_SOC_BIAS_PREPARE:
+		state = "Prepare";
 		break;
-	case SNDRV_CTL_POWER_D2:
-		state = "D2";
+	case SND_SOC_BIAS_STANDBY:
+		state = "Standby";
 		break;
-	case SNDRV_CTL_POWER_D3hot:
-		state = "D3hot";
-		break;
-	case SNDRV_CTL_POWER_D3cold:
-		state = "D3cold";
+	case SND_SOC_BIAS_OFF:
+		state = "Off";
 		break;
 	}
 	count += sprintf(buf + count, "PM State: %s\n", state);
@@ -1358,27 +1355,28 @@ int snd_soc_dapm_stream_event(struct snd_soc_codec *codec,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_stream_event);
 
 /**
- * snd_soc_dapm_device_event - send a device event to the dapm core
+ * snd_soc_dapm_set_bias_level - set the bias level for the system
  * @socdev: audio device
- * @event: device event
+ * @level: level to configure
  *
- * Sends a device event to the dapm core. The core then makes any
- * necessary machine or codec power changes..
+ * Configure the bias (power) levels for the SoC audio device.
  *
  * Returns 0 for success else error.
  */
-int snd_soc_dapm_device_event(struct snd_soc_device *socdev, int event)
+int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
+				enum snd_soc_bias_level level)
 {
 	struct snd_soc_codec *codec = socdev->codec;
 	struct snd_soc_machine *machine = socdev->machine;
+	int ret = 0;
 
-	if (machine->dapm_event)
-		machine->dapm_event(machine, event);
-	if (codec->dapm_event)
-		codec->dapm_event(codec, event);
-	return 0;
+	if (machine->set_bias_level)
+		ret = machine->set_bias_level(machine, level);
+	if (ret == 0 && codec->set_bias_level)
+		ret = codec->set_bias_level(codec, level);
+
+	return ret;
 }
-EXPORT_SYMBOL_GPL(snd_soc_dapm_device_event);
 
 /**
  * snd_soc_dapm_set_endpoint - set audio endpoint status
-- 
1.5.5.1
