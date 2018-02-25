From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 01/32] ASoC: rt5651: Remove unused
	rt5651_platform_data
Date: Sun, 25 Feb 2018 11:46:42 +0100
Message-ID: <20180225104713.4745-2-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 28BF1267372
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:19 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

There are no in tree users of platform-data for the rt5651 codec driver,
so lets remove support for it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/sound/rt5651.h    |  8 --------
 sound/soc/codecs/rt5651.c | 47 +++++++++--------------------------------------
 sound/soc/codecs/rt5651.h |  2 +-
 3 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/include/sound/rt5651.h b/include/sound/rt5651.h
index 18b79a761f10..1612462bf5ad 100644
--- a/include/sound/rt5651.h
+++ b/include/sound/rt5651.h
@@ -18,12 +18,4 @@ enum rt5651_jd_src {
 	RT5651_JD2,
 };
 
-struct rt5651_platform_data {
-	/* IN2 can optionally be differential */
-	bool in2_diff;
-
-	bool dmic_en;
-	enum rt5651_jd_src jd_src;
-};
-
 #endif
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index de9034418ce3..2aa070554743 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -33,8 +33,6 @@
 #include "rt5651.h"
 
 #define RT5651_JD_MAP(quirk)	((quirk) & GENMASK(7, 0))
-#define RT5651_IN2_DIFF		BIT(16)
-#define RT5651_DMIC_EN		BIT(17)
 
 #define RT5651_DEVICE_ID_VALUE 0x6281
 
@@ -1569,7 +1567,7 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
 		snd_soc_component_write(component, RT5651_PWR_DIG2, 0x0000);
 		snd_soc_component_write(component, RT5651_PWR_VOL, 0x0000);
 		snd_soc_component_write(component, RT5651_PWR_MIXER, 0x0000);
-		if (rt5651->pdata.jd_src) {
+		if (rt5651->jd_src) {
 			snd_soc_component_write(component, RT5651_PWR_ANLG2, 0x0204);
 			snd_soc_component_write(component, RT5651_PWR_ANLG1, 0x0002);
 		} else {
@@ -1604,7 +1602,7 @@ static int rt5651_probe(struct snd_soc_component *component)
 
 	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
-	if (rt5651->pdata.jd_src) {
+	if (rt5651->jd_src) {
 		snd_soc_dapm_force_enable_pin(dapm, "JD Power");
 		snd_soc_dapm_force_enable_pin(dapm, "LDO");
 		snd_soc_dapm_sync(dapm);
@@ -1765,26 +1763,6 @@ static const struct dmi_system_id rt5651_quirk_table[] = {
 	{}
 };
 
-static int rt5651_parse_dt(struct rt5651_priv *rt5651, struct device_node *np)
-{
-	if (of_property_read_bool(np, "realtek,in2-differential"))
-		rt5651_quirk |= RT5651_IN2_DIFF;
-	if (of_property_read_bool(np, "realtek,dmic-en"))
-		rt5651_quirk |= RT5651_DMIC_EN;
-
-	return 0;
-}
-
-static void rt5651_set_pdata(struct rt5651_priv *rt5651)
-{
-	if (rt5651_quirk & RT5651_IN2_DIFF)
-		rt5651->pdata.in2_diff = true;
-	if (rt5651_quirk & RT5651_DMIC_EN)
-		rt5651->pdata.dmic_en = true;
-	if (RT5651_JD_MAP(rt5651_quirk))
-		rt5651->pdata.jd_src = RT5651_JD_MAP(rt5651_quirk);
-}
-
 static irqreturn_t rt5651_irq(int irq, void *data)
 {
 	struct rt5651_priv *rt5651 = data;
@@ -1841,7 +1819,7 @@ static void rt5651_jack_detect_work(struct work_struct *work)
 	if (!rt5651->component)
 		return;
 
-	switch (rt5651->pdata.jd_src) {
+	switch (rt5651->jd_src) {
 	case RT5651_JD1_1:
 		val = snd_soc_component_read32(rt5651->component, RT5651_INT_IRQ_ST) & 0x1000;
 		break;
@@ -1875,7 +1853,6 @@ EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
 static int rt5651_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
-	struct rt5651_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5651_priv *rt5651;
 	int ret;
 
@@ -1886,14 +1863,8 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, rt5651);
 
-	if (pdata)
-		rt5651->pdata = *pdata;
-	else if (i2c->dev.of_node)
-		rt5651_parse_dt(rt5651, i2c->dev.of_node);
-	else
-		dmi_check_system(rt5651_quirk_table);
-
-	rt5651_set_pdata(rt5651);
+	dmi_check_system(rt5651_quirk_table);
+	rt5651->jd_src = RT5651_JD_MAP(rt5651_quirk);
 
 	rt5651->regmap = devm_regmap_init_i2c(i2c, &rt5651_regmap);
 	if (IS_ERR(rt5651->regmap)) {
@@ -1917,23 +1888,23 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
-	if (rt5651->pdata.in2_diff)
+	if (device_property_read_bool(&i2c->dev, "realtek,in2-differential"))
 		regmap_update_bits(rt5651->regmap, RT5651_IN1_IN2,
 					RT5651_IN_DF2, RT5651_IN_DF2);
 
-	if (rt5651->pdata.dmic_en)
+	if (device_property_read_bool(&i2c->dev, "realtek,dmic-en"))
 		regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
 				RT5651_GP2_PIN_MASK, RT5651_GP2_PIN_DMIC1_SCL);
 
 	rt5651->hp_mute = 1;
 
-	if (rt5651->pdata.jd_src) {
+	if (rt5651->jd_src) {
 
 		/* IRQ output on GPIO1 */
 		regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
 				   RT5651_GP1_PIN_MASK, RT5651_GP1_PIN_IRQ);
 
-		switch (rt5651->pdata.jd_src) {
+		switch (rt5651->jd_src) {
 		case RT5651_JD1_1:
 			regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
 					   RT5651_JD_TRG_SEL_MASK,
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 1ef38429e6a0..148e139e6a26 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2060,10 +2060,10 @@ struct rt5651_pll_code {
 
 struct rt5651_priv {
 	struct snd_soc_component *component;
-	struct rt5651_platform_data pdata;
 	struct regmap *regmap;
 	struct snd_soc_jack *hp_jack;
 	struct delayed_work jack_detect_work;
+	enum rt5651_jd_src jd_src;
 
 	int sysclk;
 	int sysclk_src;
-- 
2.14.3
