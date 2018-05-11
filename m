From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: Add jack-detect support" to the
	asoc tree
Date: Fri, 11 May 2018 03:50:42 +0100 (BST)
Message-ID: <20180511025042.D8A0844007A@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-7-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0023933673990100701=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 744202677C6
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 04:50:50 +0200 (CEST)
In-Reply-To: <20180508153604.23711-7-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

--===============0023933673990100701==
Content-Type: text/plain

The patch

   ASoC: rt5640: Add jack-detect support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8210804bcf40b837f8560c99efb315c0bbfc8c7b Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 8 May 2018 17:35:51 +0200
Subject: [PATCH] ASoC: rt5640: Add jack-detect support

Add jack-detect support, loosely based on earlier work on this by:

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Francisco mendez <francisco.mendez@intel.com>

Note getting the OVCD to work reliable was sort of finicky, so there are
quite a few comments on this to hopefully avoid people breaking it in the
future.

This (and the follow-up button press support) has been tested on the
following devices:

Acer Iconia Tab 8 W1-810
Asus T100CHI
Asus T100TA
Asus T200TA
Axxo WT1011
Chuwi Vi8
Dell Venue 8 Pro 5830
HP Pavilion X2 10-n000nd
HP Stream 7
I.T. Works TW891
Lamina I8270
MSI S100
Peaq C1010
Pipo W4
PoV MobiiTAB-P800W (v2.0)
Toshiba Click Mini L9W-B

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=196377
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 286 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5640.h |  36 ++++-
 2 files changed, 318 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index d7c7b207f3cc..8e306f509601 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -24,6 +24,7 @@
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -2093,6 +2094,224 @@ int rt5640_sel_asrc_clk_src(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(rt5640_sel_asrc_clk_src);
 
+static void rt5640_enable_micbias1_for_ovcd(struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO2");
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "MICBIAS1");
+	/* OVCD is unreliable when used with RCCLK as sysclk-source */
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "Platform Clock");
+	snd_soc_dapm_sync_unlocked(dapm);
+	snd_soc_dapm_mutex_unlock(dapm);
+}
+
+static void rt5640_disable_micbias1_for_ovcd(struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	snd_soc_dapm_disable_pin_unlocked(dapm, "Platform Clock");
+	snd_soc_dapm_disable_pin_unlocked(dapm, "MICBIAS1");
+	snd_soc_dapm_disable_pin_unlocked(dapm, "LDO2");
+	snd_soc_dapm_sync_unlocked(dapm);
+	snd_soc_dapm_mutex_unlock(dapm);
+}
+
+static void rt5640_clear_micbias1_ovcd(struct snd_soc_component *component)
+{
+	snd_soc_component_update_bits(component, RT5640_IRQ_CTRL2,
+		RT5640_MB1_OC_STATUS, 0);
+}
+
+static bool rt5640_micbias1_ovcd(struct snd_soc_component *component)
+{
+	int val;
+
+	val = snd_soc_component_read32(component, RT5640_IRQ_CTRL2);
+	dev_dbg(component->dev, "irq ctrl2 %#04x\n", val);
+
+	return (val & RT5640_MB1_OC_STATUS);
+}
+
+static bool rt5640_jack_inserted(struct snd_soc_component *component)
+{
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
+	int val;
+
+	val = snd_soc_component_read32(component, RT5640_INT_IRQ_ST);
+	dev_dbg(component->dev, "irq status %#04x\n", val);
+
+	if (rt5640->jd_inverted)
+		return !(val & RT5640_JD_STATUS);
+	else
+		return (val & RT5640_JD_STATUS);
+}
+
+/* Jack detect timings */
+#define JACK_SETTLE_TIME	100 /* milli seconds */
+#define JACK_DETECT_COUNT	5
+#define JACK_DETECT_MAXCOUNT	20  /* Aprox. 2 seconds worth of tries */
+
+static int rt5640_detect_headset(struct snd_soc_component *component)
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
+		rt5640_clear_micbias1_ovcd(component);
+
+		msleep(JACK_SETTLE_TIME);
+
+		/* Check the jack is still connected before checking ovcd */
+		if (!rt5640_jack_inserted(component))
+			return 0;
+
+		if (rt5640_micbias1_ovcd(component)) {
+			/*
+			 * Over current detected, there is a short between the
+			 * 2nd ring contact and the ground, so a TRS connector
+			 * without a mic contact and thus plain headphones.
+			 */
+			dev_dbg(component->dev, "jack mic-gnd shorted\n");
+			headset_count = 0;
+			headphone_count++;
+			if (headphone_count == JACK_DETECT_COUNT)
+				return SND_JACK_HEADPHONE;
+		} else {
+			dev_dbg(component->dev, "jack mic-gnd open\n");
+			headphone_count = 0;
+			headset_count++;
+			if (headset_count == JACK_DETECT_COUNT)
+				return SND_JACK_HEADSET;
+		}
+	}
+
+	dev_err(component->dev, "Error detecting headset vs headphones, bad contact?, assuming headphones\n");
+	return SND_JACK_HEADPHONE;
+}
+
+static void rt5640_jack_work(struct work_struct *work)
+{
+	struct rt5640_priv *rt5640 =
+		container_of(work, struct rt5640_priv, jack_work);
+	struct snd_soc_component *component = rt5640->component;
+	int status;
+
+	if (!rt5640_jack_inserted(component)) {
+		/* Jack removed, or spurious IRQ? */
+		if (rt5640->jack->status & SND_JACK_HEADPHONE) {
+			snd_soc_jack_report(rt5640->jack, 0, SND_JACK_HEADSET);
+			dev_dbg(component->dev, "jack unplugged\n");
+		}
+	} else if (!(rt5640->jack->status & SND_JACK_HEADPHONE)) {
+		/* Jack inserted */
+		rt5640_enable_micbias1_for_ovcd(component);
+		status = rt5640_detect_headset(component);
+		rt5640_disable_micbias1_for_ovcd(component);
+
+		dev_dbg(component->dev, "detect status %#02x\n", status);
+		snd_soc_jack_report(rt5640->jack, status, SND_JACK_HEADSET);
+	}
+}
+
+static irqreturn_t rt5640_irq(int irq, void *data)
+{
+	struct rt5640_priv *rt5640 = data;
+
+	if (rt5640->jack)
+		queue_work(system_long_wq, &rt5640->jack_work);
+
+	return IRQ_HANDLED;
+}
+
+static void rt5640_cancel_work(void *data)
+{
+	struct rt5640_priv *rt5640 = data;
+
+	cancel_work_sync(&rt5640->jack_work);
+}
+
+static void rt5640_enable_jack_detect(struct snd_soc_component *component,
+				      struct snd_soc_jack *jack)
+{
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
+
+	/* Select JD-source */
+	snd_soc_component_update_bits(component, RT5640_JD_CTRL,
+		RT5640_JD_MASK, rt5640->jd_src);
+
+	/* Selecting GPIO01 as an interrupt */
+	snd_soc_component_update_bits(component, RT5640_GPIO_CTRL1,
+		RT5640_GP1_PIN_MASK, RT5640_GP1_PIN_IRQ);
+
+	/* Set GPIO1 output */
+	snd_soc_component_update_bits(component, RT5640_GPIO_CTRL3,
+		RT5640_GP1_PF_MASK, RT5640_GP1_PF_OUT);
+
+	/* Enabling jd2 in general control 1 */
+	snd_soc_component_write(component, RT5640_DUMMY1, 0x3f41);
+
+	/* Enabling jd2 in general control 2 */
+	snd_soc_component_write(component, RT5640_DUMMY2, 0x4001);
+
+	snd_soc_component_write(component, RT5640_PR_BASE + RT5640_BIAS_CUR4,
+		0xa800 | rt5640->ovcd_sf);
+
+	snd_soc_component_update_bits(component, RT5640_MICBIAS,
+		RT5640_MIC1_OVTH_MASK | RT5640_MIC1_OVCD_MASK,
+		rt5640->ovcd_th | RT5640_MIC1_OVCD_EN);
+
+	/*
+	 * The over-current-detect is only reliable in detecting the absence
+	 * of over-current, when the mic-contact in the jack is short-circuited,
+	 * the hardware periodically retries if it can apply the bias-current
+	 * leading to the ovcd status flip-flopping 1-0-1 with it being 0 about
+	 * 10% of the time, as we poll the ovcd status bit we might hit that
+	 * 10%, so we enable sticky mode and when checking OVCD we clear the
+	 * status, msleep() a bit and then check to get a reliable reading.
+	 */
+	snd_soc_component_update_bits(component, RT5640_IRQ_CTRL2,
+		RT5640_MB1_OC_STKY_MASK, RT5640_MB1_OC_STKY_EN);
+
+	snd_soc_component_write(component, RT5640_IRQ_CTRL1,
+				RT5640_IRQ_JD_NOR);
+
+	rt5640->jack = jack;
+	enable_irq(rt5640->irq);
+	/* sync initial jack state */
+	queue_work(system_long_wq, &rt5640->jack_work);
+}
+
+static void rt5640_disable_jack_detect(struct snd_soc_component *component)
+{
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
+
+	disable_irq(rt5640->irq);
+	rt5640_cancel_work(rt5640);
+
+	rt5640->jack = NULL;
+}
+
+static int rt5640_set_jack(struct snd_soc_component *component,
+			   struct snd_soc_jack *jack, void *data)
+{
+	if (jack)
+		rt5640_enable_jack_detect(component, jack);
+	else
+		rt5640_disable_jack_detect(component);
+
+	return 0;
+}
+
 static int rt5640_probe(struct snd_soc_component *component)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
@@ -2176,6 +2395,53 @@ static int rt5640_probe(struct snd_soc_component *component)
 	if (dmic_en)
 		rt5640_dmic_enable(component, dmic1_data_pin, dmic2_data_pin);
 
+	if (device_property_read_u32(component->dev,
+				     "realtek,jack-detect-source", &val) == 0) {
+		if (val <= RT5640_JD_SRC_GPIO4)
+			rt5640->jd_src = val << RT5640_JD_SFT;
+		else
+			dev_warn(component->dev, "Warning: Invalid jack-detect-source value: %d, leaving jack-detect disabled\n",
+				 val);
+	}
+
+	if (!device_property_read_bool(component->dev, "realtek,jack-detect-not-inverted"))
+		rt5640->jd_inverted = true;
+
+	/*
+	 * Testing on various boards has shown that good defaults for the OVCD
+	 * threshold and scale-factor are 2000µA and 0.75. For an effective
+	 * limit of 1500µA, this seems to be more reliable then 1500µA and 1.0.
+	 */
+	rt5640->ovcd_th = RT5640_MIC1_OVTH_2000UA;
+	rt5640->ovcd_sf = RT5640_MIC_OVCD_SF_0P75;
+
+	if (device_property_read_u32(component->dev,
+			"realtek,over-current-threshold-microamp", &val) == 0) {
+		switch (val) {
+		case 600:
+			rt5640->ovcd_th = RT5640_MIC1_OVTH_600UA;
+			break;
+		case 1500:
+			rt5640->ovcd_th = RT5640_MIC1_OVTH_1500UA;
+			break;
+		case 2000:
+			rt5640->ovcd_th = RT5640_MIC1_OVTH_2000UA;
+			break;
+		default:
+			dev_warn(component->dev, "Warning: Invalid over-current-threshold-microamp value: %d, defaulting to 2000uA\n",
+				 val);
+		}
+	}
+
+	if (device_property_read_u32(component->dev,
+			"realtek,over-current-scale-factor", &val) == 0) {
+		if (val <= RT5640_OVCD_SF_1P5)
+			rt5640->ovcd_sf = val << RT5640_MIC_OVCD_SF_SFT;
+		else
+			dev_warn(component->dev, "Warning: Invalid over-current-scale-factor value: %d, defaulting to 0.75\n",
+				 val);
+	}
+
 	return 0;
 }
 
@@ -2276,6 +2542,7 @@ static const struct snd_soc_component_driver soc_component_dev_rt5640 = {
 	.suspend		= rt5640_suspend,
 	.resume			= rt5640_resume,
 	.set_bias_level		= rt5640_set_bias_level,
+	.set_jack		= rt5640_set_jack,
 	.controls		= rt5640_snd_controls,
 	.num_controls		= ARRAY_SIZE(rt5640_snd_controls),
 	.dapm_widgets		= rt5640_dapm_widgets,
@@ -2409,6 +2676,25 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 				RT5640_MCLK_DET, RT5640_MCLK_DET);
 
 	rt5640->hp_mute = 1;
+	rt5640->irq = i2c->irq;
+	INIT_WORK(&rt5640->jack_work, rt5640_jack_work);
+
+	/* Make sure work is stopped on probe-error / remove */
+	ret = devm_add_action_or_reset(&i2c->dev, rt5640_cancel_work, rt5640);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(&i2c->dev, rt5640->irq, rt5640_irq,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
+			       | IRQF_ONESHOT, "rt5640", rt5640);
+	if (ret == 0) {
+		/* Gets re-enabled by rt5640_set_jack() */
+		disable_irq(rt5640->irq);
+	} else {
+		dev_warn(&i2c->dev, "Failed to reguest IRQ %d: %d\n",
+			 rt5640->irq, ret);
+		rt5640->irq = -ENXIO;
+	}
 
 	return devm_snd_soc_register_component(&i2c->dev,
 				      &soc_component_dev_rt5640,
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 2db6586f5ab4..9d08471734b3 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -13,6 +13,8 @@
 #define _RT5640_H
 
 #include <linux/clk.h>
+#include <linux/workqueue.h>
+#include <dt-bindings/sound/rt5640.h>
 
 /* Info */
 #define RT5640_RESET				0x00
@@ -145,6 +147,7 @@
 
 
 /* Index of Codec Private Register definition */
+#define RT5640_BIAS_CUR4			0x15
 #define RT5640_CHPUMP_INT_REG1			0x24
 #define RT5640_MAMP_INT_REG2			0x37
 #define RT5640_3D_SPK				0x63
@@ -1606,10 +1609,17 @@
 #define RT5640_MB2_OC_P_SFT			6
 #define RT5640_MB2_OC_P_NOR			(0x0 << 6)
 #define RT5640_MB2_OC_P_INV			(0x1 << 6)
-#define RT5640_MB1_OC_CLR			(0x1 << 3)
-#define RT5640_MB1_OC_CLR_SFT			3
-#define RT5640_MB2_OC_CLR			(0x1 << 2)
-#define RT5640_MB2_OC_CLR_SFT			2
+#define RT5640_MB1_OC_STATUS			(0x1 << 3)
+#define RT5640_MB1_OC_STATUS_SFT		3
+#define RT5640_MB2_OC_STATUS			(0x1 << 2)
+#define RT5640_MB2_OC_STATUS_SFT		2
+
+/* GPIO and Internal Status (0xbf) */
+#define RT5640_GPIO1_STATUS			(0x1 << 8)
+#define RT5640_GPIO2_STATUS			(0x1 << 7)
+#define RT5640_JD_STATUS			(0x1 << 4)
+#define RT5640_OVT_STATUS			(0x1 << 3)
+#define RT5640_CLS_D_OVCD_STATUS		(0x1 << 0)
 
 /* GPIO Control 1 (0xc0) */
 #define RT5640_GP1_PIN_MASK			(0x1 << 15)
@@ -1977,6 +1987,15 @@
 #define RT5640_MCLK_DET				(0x1 << 11)
 
 /* Codec Private Register definition */
+
+/* MIC Over current threshold scale factor (0x15) */
+#define RT5640_MIC_OVCD_SF_MASK			(0x3 << 8)
+#define RT5640_MIC_OVCD_SF_SFT			8
+#define RT5640_MIC_OVCD_SF_0P5			(0x0 << 8)
+#define RT5640_MIC_OVCD_SF_0P75			(0x1 << 8)
+#define RT5640_MIC_OVCD_SF_1P0			(0x2 << 8)
+#define RT5640_MIC_OVCD_SF_1P5			(0x3 << 8)
+
 /* 3D Speaker Control (0x63) */
 #define RT5640_3D_SPK_MASK			(0x1 << 15)
 #define RT5640_3D_SPK_SFT			15
@@ -2106,6 +2125,7 @@ struct rt5640_priv {
 	struct clk *mclk;
 
 	int ldo1_en; /* GPIO for LDO1_EN */
+	int irq;
 	int sysclk;
 	int sysclk_src;
 	int lrck[RT5640_AIFS];
@@ -2118,6 +2138,14 @@ struct rt5640_priv {
 
 	bool hp_mute;
 	bool asrc_en;
+
+	/* Jack detect data */
+	struct work_struct jack_work;
+	struct snd_soc_jack *jack;
+	unsigned int jd_src;
+	bool jd_inverted;
+	unsigned int ovcd_th;
+	unsigned int ovcd_sf;
 };
 
 int rt5640_dmic_enable(struct snd_soc_component *component,
-- 
2.17.0


--===============0023933673990100701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0023933673990100701==--
