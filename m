From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 06/11] ASoC: rt5651: Improve headphone vs
	headset detection
Date: Tue, 20 Feb 2018 23:15:06 +0100
Message-ID: <20180220221511.22861-6-hdegoede@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id CBC2A26752D
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 23:15:26 +0100 (CET)
In-Reply-To: <20180220221511.22861-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Headphone vs headset detection relies on OVCD and testing on the rt5640 and
rt5651 (which seem to have the same OVCD detection) has shown that getting
OVCD detection to work reliabe on these codecs is somewhat finicky.

This commit ports my work to make this reliable on the rt5640 over to the
rt5651, making the following OVCD changes, each of which has been tested
individually and each of which has shown to be necessary on the rt5651:

1) When the mic-gnd contacts are short-circuited by a headphones plug, the
hardware periodically retries if it can apply the bias-current leading to
the OVCD status flip-flopping 1-0-1 with it being 0 about 10% of the time.
This commit enables the sticky bit for the OVCD status to deal with this.

2) When using RCCLK instead of MCLK / PLL1 the OVCD status often gets stuck
at its last value, force-enable the platform clock to avoid this.

3) Change the detection algorithm to require 5 identical OVCD values in a
row, as OVCD may bounce a bit after jack insertion.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this is based on the jack-detection work I've been doing for the rt5640,
I took a detour and ended up fixing this for rt5651 first, the rt5640 work
is almost ready too and I hope to post a version of that upstream soon.
---
 include/sound/rt5651.h                |   4 +
 sound/soc/codecs/rt5651.c             | 237 +++++++++++++++++++++++-----------
 sound/soc/codecs/rt5651.h             |   6 +-
 sound/soc/intel/boards/bytcr_rt5651.c |   2 +
 4 files changed, 171 insertions(+), 78 deletions(-)

diff --git a/include/sound/rt5651.h b/include/sound/rt5651.h
index 7b000406589c..7122236aec60 100644
--- a/include/sound/rt5651.h
+++ b/include/sound/rt5651.h
@@ -45,12 +45,16 @@ struct rt5651_platform_data {
 	bool in2_diff;
 	/* Configure GPIO2 as DMIC1 SCL */
 	bool dmic_en;
+	/* Jack detect is inverted */
+	bool jd_inverted;
 	/* Jack detect source or JD_NULL to disable jack-detect */
 	enum rt5651_jd_src jd_src;
 	/* Jack micbias overcurrent detect current threshold */
 	enum rt5651_ovth_curr ovth_curr;
 	/* Jack micbias overcurrent detect current scale-factor */
 	enum rt5651_ovcd_sf ovth_sf;
+	/* Platform clock dapm supply name */
+	const char *clk;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 1e20cdb8b569..2a2ce0a7d870 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1552,13 +1552,153 @@ static int rt5651_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+/*
+ * Note we do not toggle the RT5651_MIC1_OVCD_EN bit in these 2 functions,
+ * to ensure reliable OVCD operation it *must* be enabled before enabling
+ * the supplies, which may already be enabled.
+ */
+static void rt5651_enable_micbias1_ovcd(struct snd_soc_codec *codec)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO");
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "micbias1");
+	/* OVCD is unreliable when used with RCCLK as sysclk-source */
+	if (rt5651->pdata.clk)
+		snd_soc_dapm_force_enable_pin_unlocked(dapm, rt5651->pdata.clk);
+	snd_soc_dapm_sync_unlocked(dapm);
+	snd_soc_dapm_mutex_unlock(dapm);
+}
+
+static void rt5651_disable_micbias1_ovcd(struct snd_soc_codec *codec)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	if (rt5651->pdata.clk)
+		snd_soc_dapm_disable_pin_unlocked(dapm, rt5651->pdata.clk);
+	snd_soc_dapm_disable_pin_unlocked(dapm, "micbias1");
+	snd_soc_dapm_disable_pin_unlocked(dapm, "LDO");
+	snd_soc_dapm_sync_unlocked(dapm);
+	snd_soc_dapm_mutex_unlock(dapm);
+}
+
+static void rt5651_clear_micbias1_ovcd(struct snd_soc_codec *codec)
+{
+	snd_soc_update_bits(codec, RT5651_IRQ_CTRL2, RT5651_MB1_OC_STATUS, 0);
+}
+
+static bool rt5651_micbias1_ovcd(struct snd_soc_codec *codec)
+{
+	int val;
+
+	val = snd_soc_read(codec, RT5651_IRQ_CTRL2);
+	dev_dbg(codec->dev, "irq ctrl2 %#04x\n", val);
+
+	return (val & RT5651_MB1_OC_STATUS);
+}
+
+static bool rt5651_jack_inserted(struct snd_soc_codec *codec)
+{
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+	int val;
+
+	val = snd_soc_read(codec, RT5651_INT_IRQ_ST);
+	dev_dbg(codec->dev, "irq status %#04x\n", val);
+
+	switch (rt5651->pdata.jd_src) {
+	case RT5651_JD1_1:
+		val &= 0x1000;
+		break;
+	case RT5651_JD1_2:
+		val &= 0x2000;
+		break;
+	case RT5651_JD2:
+		val &= 0x4000;
+		break;
+	default:
+		break;
+	}
+
+	if (rt5651->pdata.jd_inverted)
+		return val == 0;
+	else
+		return val != 0;
+}
+
+/* Jack detect and button-press timings */
+#define JACK_SETTLE_TIME	100 /* milli seconds */
+#define JACK_DETECT_COUNT	5
+#define JACK_DETECT_MAXCOUNT	20  /* Aprox. 2 seconds worth of tries */
+
+static int rt5651_detect_headset(struct snd_soc_codec *codec)
+{
+	int i, headset_count = 0, headphone_count = 0;
+
+	/*
+	 * We get the insertion event before the jack is fully inserted at which
+	 * point the second ring on a TRRS connector may short the 2nd ring and
+	 * sleeve contacts, also the overcurrent detection is not entirely
+	 * reliable. So we try several times with a wait in between until we
+	 * detect the same type JACK_DETECT_COUNT times in a row.
+	 */
+	for (i = 0; i < JACK_DETECT_MAXCOUNT; i++) {
+		/* Clear any previous over-current status flag */
+		rt5651_clear_micbias1_ovcd(codec);
+
+		msleep(JACK_SETTLE_TIME);
+
+		/* Check the jack is still connected before checking ovcd */
+		if (!rt5651_jack_inserted(codec))
+			return 0;
+
+		if (rt5651_micbias1_ovcd(codec)) {
+			/*
+			 * Over current detected, there is a short between the
+			 * 2nd ring contact and the ground, so a TRS connector
+			 * without a mic contact and thus plain headphones.
+			 */
+			dev_dbg(codec->dev, "%s: mic-gnd shorted\n", __func__);
+			headset_count = 0;
+			headphone_count++;
+			if (headphone_count == JACK_DETECT_COUNT)
+				return SND_JACK_HEADPHONE;
+		} else {
+			dev_dbg(codec->dev, "%s: mic-gnd open\n", __func__);
+			headphone_count = 0;
+			headset_count++;
+			if (headset_count == JACK_DETECT_COUNT)
+				return SND_JACK_HEADSET;
+		}
+	}
+
+	dev_err(codec->dev, "Error detecting headset vs headphones, bad contact?, assuming headphones\n");
+	return SND_JACK_HEADPHONE;
+}
+
+static void rt5651_jack_detect_work(struct work_struct *work)
+{
+	struct rt5651_priv *rt5651 =
+		container_of(work, struct rt5651_priv, jack_detect_work);
+	int report = 0;
+
+	if (rt5651_jack_inserted(rt5651->codec)) {
+		rt5651_enable_micbias1_ovcd(rt5651->codec);
+		report = rt5651_detect_headset(rt5651->codec);
+		rt5651_disable_micbias1_ovcd(rt5651->codec);
+	}
+
+	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
+}
+
 static irqreturn_t rt5651_irq(int irq, void *data)
 {
 	struct rt5651_priv *rt5651 = data;
 
-	queue_delayed_work(system_power_efficient_wq,
-			   &rt5651->jack_detect_work, msecs_to_jiffies(250));
-
+	queue_work(system_power_efficient_wq, &rt5651->jack_detect_work);
 	return IRQ_HANDLED;
 }
 
@@ -1614,6 +1754,8 @@ static int rt5651_set_jack(struct snd_soc_codec *codec,
 
 	/*
 	 * Set OVCD threshold current and scale-factor from pdata.
+	 * OVCD seems to be more reliable when enabled before enabling the
+	 * LDO2 / MICBIAS1 supplies, so we enable it here once.
 	 */
 	regmap_write(rt5651->regmap, RT5651_PR_BASE + RT5651_BIAS_CUR4, 0xa800 |
 		     (rt5651->pdata.ovth_sf << RT5651_MIC_OVCD_SF_SFT));
@@ -1623,11 +1765,23 @@ static int rt5651_set_jack(struct snd_soc_codec *codec,
 			   RT5651_MIC1_OVTH_MASK |
 			   RT5651_PWR_CLK12M_MASK |
 			   RT5651_PWR_MB_MASK,
-			   RT5651_MIC1_OVCD_DIS |
+			   RT5651_MIC1_OVCD_EN |
 			   (rt5651->pdata.ovth_curr << RT5651_MIC1_OVTH_SFT) |
 			   RT5651_PWR_MB_PU |
 			   RT5651_PWR_CLK12M_PU);
 
+	/*
+	 * The over-current-detect is only reliable in detecting the absence
+	 * of over-current, when the mic-contact in the jack is short-circuited,
+	 * the hardware periodically retries if it can apply the bias-current
+	 * leading to the ovcd status flip-flopping 1-0-1 with it being 0 about
+	 * 10% of the time, as we poll the ovcd status bit we might hit that
+	 * 10%, so we enable sticky mode and when checking OVCD we clear the
+	 * status, msleep() a bit and then check to get a reliable reading.
+	 */
+	snd_soc_update_bits(codec, RT5651_IRQ_CTRL2, RT5651_MB1_OC_STKY_MASK,
+			    RT5651_MB1_OC_STKY_EN);
+
 	ret = devm_request_threaded_irq(codec->dev, rt5651->irq, NULL,
 					rt5651_irq,
 					IRQF_TRIGGER_RISING |
@@ -1639,7 +1793,8 @@ static int rt5651_set_jack(struct snd_soc_codec *codec,
 	}
 
 	rt5651->hp_jack = hp_jack;
-	rt5651_irq(0, rt5651);
+	/* Get initial jack status */
+	queue_work(system_power_efficient_wq, &rt5651->jack_detect_work);
 
 	return 0;
 }
@@ -1797,74 +1952,6 @@ static int rt5651_parse_dt(struct rt5651_priv *rt5651, struct device_node *np)
 	return 0;
 }
 
-static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
-{
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	int jack_type;
-
-	if (jack_insert) {
-		snd_soc_dapm_mutex_lock(dapm);
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO");
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "micbias1");
-		snd_soc_dapm_sync_unlocked(dapm);
-		snd_soc_dapm_mutex_unlock(dapm);
-
-		snd_soc_update_bits(codec, RT5651_MICBIAS,
-				    RT5651_MIC1_OVCD_MASK,
-				    RT5651_MIC1_OVCD_EN);
-		msleep(100);
-		if (snd_soc_read(codec, RT5651_IRQ_CTRL2) & RT5651_MB1_OC_CLR)
-			jack_type = SND_JACK_HEADPHONE;
-		else
-			jack_type = SND_JACK_HEADSET;
-		snd_soc_update_bits(codec, RT5651_IRQ_CTRL2,
-				    RT5651_MB1_OC_CLR, 0);
-
-		snd_soc_dapm_mutex_lock(dapm);
-		snd_soc_dapm_disable_pin_unlocked(dapm, "micbias1");
-		snd_soc_dapm_disable_pin_unlocked(dapm, "LDO");
-		snd_soc_dapm_sync_unlocked(dapm);
-		snd_soc_dapm_mutex_unlock(dapm);
-	} else { /* jack out */
-		jack_type = 0;
-
-		snd_soc_update_bits(codec, RT5651_MICBIAS,
-				    RT5651_MIC1_OVCD_MASK,
-				    RT5651_MIC1_OVCD_DIS);
-	}
-
-	return jack_type;
-}
-
-static void rt5651_jack_detect_work(struct work_struct *work)
-{
-	struct rt5651_priv *rt5651 =
-		container_of(work, struct rt5651_priv, jack_detect_work.work);
-
-	int report, val = 0;
-
-	if (!rt5651->codec)
-		return;
-
-	switch (rt5651->pdata.jd_src) {
-	case RT5651_JD1_1:
-		val = snd_soc_read(rt5651->codec, RT5651_INT_IRQ_ST) & 0x1000;
-		break;
-	case RT5651_JD1_2:
-		val = snd_soc_read(rt5651->codec, RT5651_INT_IRQ_ST) & 0x2000;
-		break;
-	case RT5651_JD2:
-		val = snd_soc_read(rt5651->codec, RT5651_INT_IRQ_ST) & 0x4000;
-		break;
-	default:
-		break;
-	}
-
-	report = rt5651_jack_detect(rt5651->codec, !val);
-
-	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
-}
-
 static void rt5651_apply_pdata(struct rt5651_priv *rt5651)
 {
 	if (rt5651->pdata.in2_diff)
@@ -1932,7 +2019,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 
 	rt5651->irq = i2c->irq;
 	rt5651->hp_mute = 1;
-	INIT_DELAYED_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
+	INIT_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5651,
 				rt5651_dai, ARRAY_SIZE(rt5651_dai));
@@ -1944,7 +2031,7 @@ static int rt5651_i2c_remove(struct i2c_client *i2c)
 {
 	struct rt5651_priv *rt5651 = i2c_get_clientdata(i2c);
 
-	cancel_delayed_work_sync(&rt5651->jack_detect_work);
+	cancel_work_sync(&rt5651->jack_detect_work);
 	snd_soc_unregister_codec(&i2c->dev);
 
 	return 0;
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 96168a1e87c1..9d5f764ba467 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -1598,8 +1598,8 @@
 #define RT5651_MB1_OC_P_NOR			(0x0 << 7)
 #define RT5651_MB1_OC_P_INV			(0x1 << 7)
 #define RT5651_MB2_OC_P_MASK			(0x1 << 6)
-#define RT5651_MB1_OC_CLR			(0x1 << 3)
-#define RT5651_MB1_OC_CLR_SFT			3
+#define RT5651_MB1_OC_STATUS			(0x1 << 3)
+#define RT5651_MB1_OC_STATUS_SFT		3
 #define RT5651_STA_GPIO8			(0x1)
 #define RT5651_STA_GPIO8_BIT			0
 
@@ -2073,7 +2073,7 @@ struct rt5651_priv {
 	struct rt5651_platform_data pdata;
 	struct regmap *regmap;
 	struct snd_soc_jack *hp_jack;
-	struct delayed_work jack_detect_work;
+	struct work_struct jack_detect_work;
 
 	int irq;
 	int sysclk;
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index a6cc0bc85db8..dfe5bd3dbb6c 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -394,6 +394,8 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 			dev_err(card->dev, "unable to set MCLK rate\n");
 	}
 
+	pdata.clk = "Platform Clock";
+	pdata.jd_inverted = true;
 	pdata.jd_src = BYT_RT5651_JDSRC(byt_rt5651_quirk);
 	pdata.ovth_curr = BYT_RT5651_OVTH(byt_rt5651_quirk);
 	pdata.ovth_sf = BYT_RT5651_OVCD_SF(byt_rt5651_quirk);
-- 
2.14.3
