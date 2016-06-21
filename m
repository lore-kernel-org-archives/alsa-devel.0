From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v4 2/2] ASoC: da7219: Convert driver to use
 generic device/fwnode functions
Date: Tue, 21 Jun 2016 18:50:21 +0100
Message-ID: <fe52fc8951c961391c75907e670cad5348e460ff.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 16ACD266C6E
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 19:50:23 +0200 (CEST)
In-Reply-To: <cover.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, Support Opensource <support.opensource@diasemi.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

This change converts the driver from using the of_* functions to using
the device_* and fwnode_* functions for accssing FW related data.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes in v4:
 - Rebase to v4.7-rc4

Changes in v3:
 - Rebase to v4.7-rc1
 - Remove unnecesary brackets in if statement for AAD pdata checking.
 - Move assignment of add_np to be immediately prior to NULL check, for ease of
   reading.

Changes in v2:
 - Rename functions to use _fw_ instead of _of_, to align with generic access.
 - Use new device property function to find named child, rather than local
   function.
 - Remove checking for DT/ACPI fwnode types, and perform FW reading if platform
   data not already provided.
 - Remove ACPI and OF includes for AAD code, as no longer needed.
 - Restore accidentally removed blank line.

 sound/soc/codecs/da7219-aad.c | 103 +++++++++++++++++++++---------------------
 sound/soc/codecs/da7219.c     |  34 +++++++-------
 2 files changed, 68 insertions(+), 69 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 9459593..f0057cd 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -13,8 +13,8 @@

 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/i2c.h>
+#include <linux/property.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -382,11 +382,11 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 }

 /*
- * DT to pdata conversion
+ * DT/ACPI to pdata conversion
  */

 static enum da7219_aad_micbias_pulse_lvl
-	da7219_aad_of_micbias_pulse_lvl(struct snd_soc_codec *codec, u32 val)
+	da7219_aad_fw_micbias_pulse_lvl(struct snd_soc_codec *codec, u32 val)
 {
 	switch (val) {
 	case 2800:
@@ -400,7 +400,7 @@ static enum da7219_aad_micbias_pulse_lvl
 }

 static enum da7219_aad_btn_cfg
-	da7219_aad_of_btn_cfg(struct snd_soc_codec *codec, u32 val)
+	da7219_aad_fw_btn_cfg(struct snd_soc_codec *codec, u32 val)
 {
 	switch (val) {
 	case 2:
@@ -424,7 +424,7 @@ static enum da7219_aad_btn_cfg
 }

 static enum da7219_aad_mic_det_thr
-	da7219_aad_of_mic_det_thr(struct snd_soc_codec *codec, u32 val)
+	da7219_aad_fw_mic_det_thr(struct snd_soc_codec *codec, u32 val)
 {
 	switch (val) {
 	case 200:
@@ -442,7 +442,7 @@ static enum da7219_aad_mic_det_thr
 }

 static enum da7219_aad_jack_ins_deb
-	da7219_aad_of_jack_ins_deb(struct snd_soc_codec *codec, u32 val)
+	da7219_aad_fw_jack_ins_deb(struct snd_soc_codec *codec, u32 val)
 {
 	switch (val) {
 	case 5:
@@ -468,7 +468,7 @@ static enum da7219_aad_jack_ins_deb
 }

 static enum da7219_aad_jack_det_rate
-	da7219_aad_of_jack_det_rate(struct snd_soc_codec *codec, const char *str)
+	da7219_aad_fw_jack_det_rate(struct snd_soc_codec *codec, const char *str)
 {
 	if (!strcmp(str, "32ms_64ms")) {
 		return DA7219_AAD_JACK_DET_RATE_32_64MS;
@@ -485,7 +485,7 @@ static enum da7219_aad_jack_det_rate
 }

 static enum da7219_aad_jack_rem_deb
-	da7219_aad_of_jack_rem_deb(struct snd_soc_codec *codec, u32 val)
+	da7219_aad_fw_jack_rem_deb(struct snd_soc_codec *codec, u32 val)
 {
 	switch (val) {
 	case 1:
@@ -503,7 +503,7 @@ static enum da7219_aad_jack_rem_deb
 }

 static enum da7219_aad_btn_avg
-	da7219_aad_of_btn_avg(struct snd_soc_codec *codec, u32 val)
+	da7219_aad_fw_btn_avg(struct snd_soc_codec *codec, u32 val)
 {
 	switch (val) {
 	case 1:
@@ -521,7 +521,7 @@ static enum da7219_aad_btn_avg
 }

 static enum da7219_aad_adc_1bit_rpt
-	da7219_aad_of_adc_1bit_rpt(struct snd_soc_codec *codec, u32 val)
+	da7219_aad_fw_adc_1bit_rpt(struct snd_soc_codec *codec, u32 val)
 {
 	switch (val) {
 	case 1:
@@ -538,97 +538,96 @@ static enum da7219_aad_adc_1bit_rpt
 	}
 }

-static struct da7219_aad_pdata *da7219_aad_of_to_pdata(struct snd_soc_codec *codec)
+static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct snd_soc_codec *codec)
 {
-	struct device_node *np = codec->dev->of_node;
-	struct device_node *aad_np = of_find_node_by_name(np, "da7219_aad");
+	struct device *dev = codec->dev;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct fwnode_handle *aad_np;
 	struct da7219_aad_pdata *aad_pdata;
-	const char *of_str;
-	u32 of_val32;
+	const char *fw_str;
+	u32 fw_val32;

+	aad_np = device_get_named_child_node(dev, "da7219_aad");
 	if (!aad_np)
 		return NULL;

 	aad_pdata = devm_kzalloc(codec->dev, sizeof(*aad_pdata), GFP_KERNEL);
 	if (!aad_pdata)
-		goto out;
+		return NULL;

-	aad_pdata->irq = irq_of_parse_and_map(np, 0);
+	aad_pdata->irq = i2c->irq;

-	if (of_property_read_u32(aad_np, "dlg,micbias-pulse-lvl",
-				 &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,micbias-pulse-lvl",
+				     &fw_val32) >= 0)
 		aad_pdata->micbias_pulse_lvl =
-			da7219_aad_of_micbias_pulse_lvl(codec, of_val32);
+			da7219_aad_fw_micbias_pulse_lvl(codec, fw_val32);
 	else
 		aad_pdata->micbias_pulse_lvl = DA7219_AAD_MICBIAS_PULSE_LVL_OFF;

-	if (of_property_read_u32(aad_np, "dlg,micbias-pulse-time",
-				 &of_val32) >= 0)
-		aad_pdata->micbias_pulse_time = of_val32;
+	if (fwnode_property_read_u32(aad_np, "dlg,micbias-pulse-time",
+				     &fw_val32) >= 0)
+		aad_pdata->micbias_pulse_time = fw_val32;

-	if (of_property_read_u32(aad_np, "dlg,btn-cfg", &of_val32) >= 0)
-		aad_pdata->btn_cfg = da7219_aad_of_btn_cfg(codec, of_val32);
+	if (fwnode_property_read_u32(aad_np, "dlg,btn-cfg", &fw_val32) >= 0)
+		aad_pdata->btn_cfg = da7219_aad_fw_btn_cfg(codec, fw_val32);
 	else
 		aad_pdata->btn_cfg = DA7219_AAD_BTN_CFG_10MS;

-	if (of_property_read_u32(aad_np, "dlg,mic-det-thr", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,mic-det-thr", &fw_val32) >= 0)
 		aad_pdata->mic_det_thr =
-			da7219_aad_of_mic_det_thr(codec, of_val32);
+			da7219_aad_fw_mic_det_thr(codec, fw_val32);
 	else
 		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_500_OHMS;

-	if (of_property_read_u32(aad_np, "dlg,jack-ins-deb", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,jack-ins-deb", &fw_val32) >= 0)
 		aad_pdata->jack_ins_deb =
-			da7219_aad_of_jack_ins_deb(codec, of_val32);
+			da7219_aad_fw_jack_ins_deb(codec, fw_val32);
 	else
 		aad_pdata->jack_ins_deb = DA7219_AAD_JACK_INS_DEB_20MS;

-	if (!of_property_read_string(aad_np, "dlg,jack-det-rate", &of_str))
+	if (!fwnode_property_read_string(aad_np, "dlg,jack-det-rate", &fw_str))
 		aad_pdata->jack_det_rate =
-			da7219_aad_of_jack_det_rate(codec, of_str);
+			da7219_aad_fw_jack_det_rate(codec, fw_str);
 	else
 		aad_pdata->jack_det_rate = DA7219_AAD_JACK_DET_RATE_256_512MS;

-	if (of_property_read_u32(aad_np, "dlg,jack-rem-deb", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,jack-rem-deb", &fw_val32) >= 0)
 		aad_pdata->jack_rem_deb =
-			da7219_aad_of_jack_rem_deb(codec, of_val32);
+			da7219_aad_fw_jack_rem_deb(codec, fw_val32);
 	else
 		aad_pdata->jack_rem_deb = DA7219_AAD_JACK_REM_DEB_1MS;

-	if (of_property_read_u32(aad_np, "dlg,a-d-btn-thr", &of_val32) >= 0)
-		aad_pdata->a_d_btn_thr = (u8) of_val32;
+	if (fwnode_property_read_u32(aad_np, "dlg,a-d-btn-thr", &fw_val32) >= 0)
+		aad_pdata->a_d_btn_thr = (u8) fw_val32;
 	else
 		aad_pdata->a_d_btn_thr = 0xA;

-	if (of_property_read_u32(aad_np, "dlg,d-b-btn-thr", &of_val32) >= 0)
-		aad_pdata->d_b_btn_thr = (u8) of_val32;
+	if (fwnode_property_read_u32(aad_np, "dlg,d-b-btn-thr", &fw_val32) >= 0)
+		aad_pdata->d_b_btn_thr = (u8) fw_val32;
 	else
 		aad_pdata->d_b_btn_thr = 0x16;

-	if (of_property_read_u32(aad_np, "dlg,b-c-btn-thr", &of_val32) >= 0)
-		aad_pdata->b_c_btn_thr = (u8) of_val32;
+	if (fwnode_property_read_u32(aad_np, "dlg,b-c-btn-thr", &fw_val32) >= 0)
+		aad_pdata->b_c_btn_thr = (u8) fw_val32;
 	else
 		aad_pdata->b_c_btn_thr = 0x21;

-	if (of_property_read_u32(aad_np, "dlg,c-mic-btn-thr", &of_val32) >= 0)
-		aad_pdata->c_mic_btn_thr = (u8) of_val32;
+	if (fwnode_property_read_u32(aad_np, "dlg,c-mic-btn-thr", &fw_val32) >= 0)
+		aad_pdata->c_mic_btn_thr = (u8) fw_val32;
 	else
 		aad_pdata->c_mic_btn_thr = 0x3E;

-	if (of_property_read_u32(aad_np, "dlg,btn-avg", &of_val32) >= 0)
-		aad_pdata->btn_avg = da7219_aad_of_btn_avg(codec, of_val32);
+	if (fwnode_property_read_u32(aad_np, "dlg,btn-avg", &fw_val32) >= 0)
+		aad_pdata->btn_avg = da7219_aad_fw_btn_avg(codec, fw_val32);
 	else
 		aad_pdata->btn_avg = DA7219_AAD_BTN_AVG_2;

-	if (of_property_read_u32(aad_np, "dlg,adc-1bit-rpt", &of_val32) >= 0)
+	if (fwnode_property_read_u32(aad_np, "dlg,adc-1bit-rpt", &fw_val32) >= 0)
 		aad_pdata->adc_1bit_rpt =
-			da7219_aad_of_adc_1bit_rpt(codec, of_val32);
+			da7219_aad_fw_adc_1bit_rpt(codec, fw_val32);
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;

-out:
-	of_node_put(aad_np);
-
 	return aad_pdata;
 }

@@ -769,9 +768,9 @@ int da7219_aad_init(struct snd_soc_codec *codec)
 	da7219->aad = da7219_aad;
 	da7219_aad->codec = codec;

-	/* Handle any DT/platform data */
-	if ((codec->dev->of_node) && (da7219->pdata))
-		da7219->pdata->aad_pdata = da7219_aad_of_to_pdata(codec);
+	/* Handle any DT/ACPI/platform data */
+	if (da7219->pdata && !da7219->pdata->aad_pdata)
+		da7219->pdata->aad_pdata = da7219_aad_fw_to_pdata(codec);

 	da7219_aad_handle_pdata(codec);

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 5c93899..50ea943 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
@@ -1418,7 +1419,7 @@ static struct snd_soc_dai_driver da7219_dai = {


 /*
- * DT
+ * DT/ACPI
  */

 static const struct of_device_id da7219_of_match[] = {
@@ -1434,7 +1435,7 @@ static const struct acpi_device_id da7219_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, da7219_acpi_match);

 static enum da7219_micbias_voltage
-	da7219_of_micbias_lvl(struct snd_soc_codec *codec, u32 val)
+	da7219_fw_micbias_lvl(struct device *dev, u32 val)
 {
 	switch (val) {
 	case 1600:
@@ -1450,13 +1451,13 @@ static enum da7219_micbias_voltage
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
+	da7219_fw_mic_amp_in_sel(struct device *dev, const char *str)
 {
 	if (!strcmp(str, "diff")) {
 		return DA7219_MIC_AMP_IN_SEL_DIFF;
@@ -1465,29 +1466,29 @@ static enum da7219_mic_amp_in_sel
 	} else if (!strcmp(str, "se_n")) {
 		return DA7219_MIC_AMP_IN_SEL_SE_N;
 	} else {
-		dev_warn(codec->dev, "Invalid mic input type selection");
+		dev_warn(dev, "Invalid mic input type selection");
 		return DA7219_MIC_AMP_IN_SEL_DIFF;
 	}
 }

-static struct da7219_pdata *da7219_of_to_pdata(struct snd_soc_codec *codec)
+static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_codec *codec)
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
+		pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
 	else
 		pdata->micbias_lvl = DA7219_MICBIAS_2_2V;

-	if (!of_property_read_string(np, "dlg,mic-amp-in-sel", &of_str))
-		pdata->mic_amp_in_sel = da7219_of_mic_amp_in_sel(codec, of_str);
+	if (!device_property_read_string(dev, "dlg,mic-amp-in-sel", &of_str))
+		pdata->mic_amp_in_sel = da7219_fw_mic_amp_in_sel(dev, of_str);
 	else
 		pdata->mic_amp_in_sel = DA7219_MIC_AMP_IN_SEL_DIFF;

@@ -1662,11 +1663,10 @@ static int da7219_probe(struct snd_soc_codec *codec)
 		break;
 	}

-	/* Handle DT/Platform data */
-	if (codec->dev->of_node)
-		da7219->pdata = da7219_of_to_pdata(codec);
-	else
-		da7219->pdata = dev_get_platdata(codec->dev);
+	/* Handle DT/ACPI/Platform data */
+	da7219->pdata = dev_get_platdata(codec->dev);
+	if (!da7219->pdata)
+		da7219->pdata = da7219_fw_to_pdata(codec);

 	da7219_handle_pdata(codec);

--
1.9.3
