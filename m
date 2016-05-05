From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/3] ASoC: da7219: Convert driver to use
 generic device/fwnode functions
Date: Thu, 5 May 2016 11:53:04 +0100
Message-ID: <4783487c3caa1d66f0a1d5b25c9b341aee1118e4.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.163])
 by alsa0.perex.cz (Postfix) with ESMTP id B8509265DCD
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 12:53:07 +0200 (CEST)
In-Reply-To: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This change converts the driver from using the of_* functions to using
the device_* and fwnode_* functions for accssing DT related data.
This is in preparation for updates to support ACPI based initialisation.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Tested-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
---
 sound/soc/codecs/da7219-aad.c | 64 +++++++++++++++++++++++++++----------------
 sound/soc/codecs/da7219.c     | 21 +++++++-------
 2 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 9459593..c4853a8 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -13,8 +13,9 @@

 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/i2c.h>
 #include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/property.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -538,10 +539,30 @@ static enum da7219_aad_adc_1bit_rpt
 	}
 }

+static struct fwnode_handle *da7219_aad_of_named_fwhandle(struct device *dev,
+							  const char *name)
+{
+	struct fwnode_handle *child;
+	struct device_node *of_node;
+
+	/* Find first matching child node */
+	device_for_each_child_node(dev, child) {
+		if (is_of_node(child)) {
+			of_node = to_of_node(child);
+			if (of_node_cmp(of_node->name, name) == 0)
+				return child;
+		}
+	}
+
+	return NULL;
+}
+
 static struct da7219_aad_pdata *da7219_aad_of_to_pdata(struct snd_soc_codec *codec)
 {
-	struct device_node *np = codec->dev->of_node;
-	struct device_node *aad_np = of_find_node_by_name(np, "da7219_aad");
+	struct device *dev = codec->dev;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct fwnode_handle *aad_np =
+		da7219_aad_of_named_fwhandle(dev, "da7219_aad");
 	struct da7219_aad_pdata *aad_pdata;
 	const char *of_str;
 	u32 of_val32;
@@ -551,84 +572,81 @@ static struct da7219_aad_pdata *da7219_aad_of_to_pdata(struct snd_soc_codec *cod

 	aad_pdata = devm_kzalloc(codec->dev, sizeof(*aad_pdata), GFP_KERNEL);
 	if (!aad_pdata)
-		goto out;
+		return NULL;

-	aad_pdata->irq = irq_of_parse_and_map(np, 0);
+	aad_pdata->irq = i2c->irq;

-	if (of_property_read_u32(aad_np, "dlg,micbias-pulse-lvl",
-				 &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,micbias-pulse-lvl",
+				     &of_val32) >= 0)
 		aad_pdata->micbias_pulse_lvl =
 			da7219_aad_of_micbias_pulse_lvl(codec, of_val32);
 	else
 		aad_pdata->micbias_pulse_lvl = DA7219_AAD_MICBIAS_PULSE_LVL_OFF;

-	if (of_property_read_u32(aad_np, "dlg,micbias-pulse-time",
-				 &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,micbias-pulse-time",
+				     &of_val32) >= 0)
 		aad_pdata->micbias_pulse_time = of_val32;

-	if (of_property_read_u32(aad_np, "dlg,btn-cfg", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,btn-cfg", &of_val32) >= 0)
 		aad_pdata->btn_cfg = da7219_aad_of_btn_cfg(codec, of_val32);
 	else
 		aad_pdata->btn_cfg = DA7219_AAD_BTN_CFG_10MS;

-	if (of_property_read_u32(aad_np, "dlg,mic-det-thr", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,mic-det-thr", &of_val32) >= 0)
 		aad_pdata->mic_det_thr =
 			da7219_aad_of_mic_det_thr(codec, of_val32);
 	else
 		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_500_OHMS;

-	if (of_property_read_u32(aad_np, "dlg,jack-ins-deb", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,jack-ins-deb", &of_val32) >= 0)
 		aad_pdata->jack_ins_deb =
 			da7219_aad_of_jack_ins_deb(codec, of_val32);
 	else
 		aad_pdata->jack_ins_deb = DA7219_AAD_JACK_INS_DEB_20MS;

-	if (!of_property_read_string(aad_np, "dlg,jack-det-rate", &of_str))
+	if (!fwnode_property_read_string(aad_np, "dlg,jack-det-rate", &of_str))
 		aad_pdata->jack_det_rate =
 			da7219_aad_of_jack_det_rate(codec, of_str);
 	else
 		aad_pdata->jack_det_rate = DA7219_AAD_JACK_DET_RATE_256_512MS;

-	if (of_property_read_u32(aad_np, "dlg,jack-rem-deb", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,jack-rem-deb", &of_val32) >= 0)
 		aad_pdata->jack_rem_deb =
 			da7219_aad_of_jack_rem_deb(codec, of_val32);
 	else
 		aad_pdata->jack_rem_deb = DA7219_AAD_JACK_REM_DEB_1MS;

-	if (of_property_read_u32(aad_np, "dlg,a-d-btn-thr", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,a-d-btn-thr", &of_val32) >= 0)
 		aad_pdata->a_d_btn_thr = (u8) of_val32;
 	else
 		aad_pdata->a_d_btn_thr = 0xA;

-	if (of_property_read_u32(aad_np, "dlg,d-b-btn-thr", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,d-b-btn-thr", &of_val32) >= 0)
 		aad_pdata->d_b_btn_thr = (u8) of_val32;
 	else
 		aad_pdata->d_b_btn_thr = 0x16;

-	if (of_property_read_u32(aad_np, "dlg,b-c-btn-thr", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,b-c-btn-thr", &of_val32) >= 0)
 		aad_pdata->b_c_btn_thr = (u8) of_val32;
 	else
 		aad_pdata->b_c_btn_thr = 0x21;

-	if (of_property_read_u32(aad_np, "dlg,c-mic-btn-thr", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,c-mic-btn-thr", &of_val32) >= 0)
 		aad_pdata->c_mic_btn_thr = (u8) of_val32;
 	else
 		aad_pdata->c_mic_btn_thr = 0x3E;

-	if (of_property_read_u32(aad_np, "dlg,btn-avg", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,btn-avg", &of_val32) >= 0)
 		aad_pdata->btn_avg = da7219_aad_of_btn_avg(codec, of_val32);
 	else
 		aad_pdata->btn_avg = DA7219_AAD_BTN_AVG_2;

-	if (of_property_read_u32(aad_np, "dlg,adc-1bit-rpt", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,adc-1bit-rpt", &of_val32) >= 0)
 		aad_pdata->adc_1bit_rpt =
 			da7219_aad_of_adc_1bit_rpt(codec, of_val32);
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;

-out:
-	of_node_put(aad_np);
-
 	return aad_pdata;
 }

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 7c7824c..6c6c8db 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
@@ -1427,7 +1428,7 @@ static const struct of_device_id da7219_of_match[] = {
 MODULE_DEVICE_TABLE(of, da7219_of_match);

 static enum da7219_micbias_voltage
-	da7219_of_micbias_lvl(struct snd_soc_codec *codec, u32 val)
+	da7219_of_micbias_lvl(struct device *dev, u32 val)
 {
 	switch (val) {
 	case 1600:
@@ -1443,13 +1444,13 @@ static enum da7219_micbias_voltage
 	case 2600:
 		return DA7219_MICBIAS_2_6V;
 	default:
-		dev_warn(codec->dev, "Invalid micbias level");
+		dev_warn(dev, "Invalid micbias level");
 		return DA7219_MICBIAS_2_2V;
 	}
 }

 static enum da7219_mic_amp_in_sel
-	da7219_of_mic_amp_in_sel(struct snd_soc_codec *codec, const char *str)
+	da7219_of_mic_amp_in_sel(struct device *dev, const char *str)
 {
 	if (!strcmp(str, "diff")) {
 		return DA7219_MIC_AMP_IN_SEL_DIFF;
@@ -1458,29 +1459,29 @@ static enum da7219_mic_amp_in_sel
 	} else if (!strcmp(str, "se_n")) {
 		return DA7219_MIC_AMP_IN_SEL_SE_N;
 	} else {
-		dev_warn(codec->dev, "Invalid mic input type selection");
+		dev_warn(dev, "Invalid mic input type selection");
 		return DA7219_MIC_AMP_IN_SEL_DIFF;
 	}
 }

 static struct da7219_pdata *da7219_of_to_pdata(struct snd_soc_codec *codec)
 {
-	struct device_node *np = codec->dev->of_node;
+	struct device *dev = codec->dev;
 	struct da7219_pdata *pdata;
 	const char *of_str;
 	u32 of_val32;

-	pdata = devm_kzalloc(codec->dev, sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;

-	if (of_property_read_u32(np, "dlg,micbias-lvl", &of_val32) >= 0)
-		pdata->micbias_lvl = da7219_of_micbias_lvl(codec, of_val32);
+	if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
+		pdata->micbias_lvl = da7219_of_micbias_lvl(dev, of_val32);
 	else
 		pdata->micbias_lvl = DA7219_MICBIAS_2_2V;

-	if (!of_property_read_string(np, "dlg,mic-amp-in-sel", &of_str))
-		pdata->mic_amp_in_sel = da7219_of_mic_amp_in_sel(codec, of_str);
+	if (!device_property_read_string(dev, "dlg,mic-amp-in-sel", &of_str))
+		pdata->mic_amp_in_sel = da7219_of_mic_amp_in_sel(dev, of_str);
 	else
 		pdata->mic_amp_in_sel = DA7219_MIC_AMP_IN_SEL_DIFF;

--
1.9.3
