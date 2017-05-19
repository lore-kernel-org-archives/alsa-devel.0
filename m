From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7213: Update driver to use
 device_property* FW functions
Date: Fri, 19 May 2017 15:32:25 +0100
Message-ID: <20170519143225.089823FBCD@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.167])
 by alsa0.perex.cz (Postfix) with ESMTP id C56A32667A5
 for <alsa-devel@alsa-project.org>; Fri, 19 May 2017 16:32:26 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The driver now supports ACPI based initialisation as well as DT
and old pdata methods. However the FW data handling still uses
DT specific calls to read firmware data (of_property*) so for
ACPI based initialisation the FW data will only be set to default
values. This patch updates the FW handling to use device_property*
calls instead so that both ACPI and DT are handled as expected.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7213.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 024d83f..c3e1189 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -13,6 +13,8 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -1606,12 +1608,12 @@ static int da7213_set_bias_level(struct snd_soc_codec *codec,
 }
 
 static struct da7213_platform_data
-	*da7213_of_to_pdata(struct snd_soc_codec *codec)
+	*da7213_fw_to_pdata(struct snd_soc_codec *codec)
 {
-	struct device_node *np = codec->dev->of_node;
+	struct device *dev = codec->dev;
 	struct da7213_platform_data *pdata;
-	const char *of_str;
-	u32 of_val32;
+	const char *fw_str;
+	u32 fw_val32;
 
 	pdata = devm_kzalloc(codec->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
@@ -1619,29 +1621,29 @@ static int da7213_set_bias_level(struct snd_soc_codec *codec,
 		return NULL;
 	}
 
-	if (of_property_read_u32(np, "dlg,micbias1-lvl", &of_val32) >= 0)
-		pdata->micbias1_lvl = da7213_of_micbias_lvl(codec, of_val32);
+	if (device_property_read_u32(dev, "dlg,micbias1-lvl", &fw_val32) >= 0)
+		pdata->micbias1_lvl = da7213_of_micbias_lvl(codec, fw_val32);
 	else
 		pdata->micbias1_lvl = DA7213_MICBIAS_2_2V;
 
-	if (of_property_read_u32(np, "dlg,micbias2-lvl", &of_val32) >= 0)
-		pdata->micbias2_lvl = da7213_of_micbias_lvl(codec, of_val32);
+	if (device_property_read_u32(dev, "dlg,micbias2-lvl", &fw_val32) >= 0)
+		pdata->micbias2_lvl = da7213_of_micbias_lvl(codec, fw_val32);
 	else
 		pdata->micbias2_lvl = DA7213_MICBIAS_2_2V;
 
-	if (!of_property_read_string(np, "dlg,dmic-data-sel", &of_str))
-		pdata->dmic_data_sel = da7213_of_dmic_data_sel(codec, of_str);
+	if (!device_property_read_string(dev, "dlg,dmic-data-sel", &fw_str))
+		pdata->dmic_data_sel = da7213_of_dmic_data_sel(codec, fw_str);
 	else
 		pdata->dmic_data_sel = DA7213_DMIC_DATA_LRISE_RFALL;
 
-	if (!of_property_read_string(np, "dlg,dmic-samplephase", &of_str))
+	if (!device_property_read_string(dev, "dlg,dmic-samplephase", &fw_str))
 		pdata->dmic_samplephase =
-			da7213_of_dmic_samplephase(codec, of_str);
+			da7213_of_dmic_samplephase(codec, fw_str);
 	else
 		pdata->dmic_samplephase = DA7213_DMIC_SAMPLE_ON_CLKEDGE;
 
-	if (of_property_read_u32(np, "dlg,dmic-clkrate", &of_val32) >= 0)
-		pdata->dmic_clk_rate = da7213_of_dmic_clkrate(codec, of_val32);
+	if (device_property_read_u32(dev, "dlg,dmic-clkrate", &fw_val32) >= 0)
+		pdata->dmic_clk_rate = da7213_of_dmic_clkrate(codec, fw_val32);
 	else
 		pdata->dmic_clk_rate = DA7213_DMIC_CLK_3_0MHZ;
 
@@ -1713,10 +1715,9 @@ static int da7213_probe(struct snd_soc_codec *codec)
 			    DA7213_LINE_AMP_OE, DA7213_LINE_AMP_OE);
 
 	/* Handle DT/Platform data */
-	if (codec->dev->of_node)
-		da7213->pdata = da7213_of_to_pdata(codec);
-	else
-		da7213->pdata = dev_get_platdata(codec->dev);
+	da7213->pdata = dev_get_platdata(codec->dev);
+	if (!da7213->pdata)
+		da7213->pdata = da7213_fw_to_pdata(codec);
 
 	/* Set platform data values */
 	if (da7213->pdata) {
-- 
1.9.1
