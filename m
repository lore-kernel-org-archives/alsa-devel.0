From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt286: Add customize setting for
	Dell Dino
Date: Thu, 5 Feb 2015 16:40:34 +0800
Message-ID: <1423125634-8367-2-git-send-email-bardliao@realtek.com>
References: <1423125634-8367-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B6BA62604FA
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 09:40:48 +0100 (CET)
In-Reply-To: <1423125634-8367-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch add the customize setting for Dell Dino project.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 25 ++++++++++++++++++++++++-
 sound/soc/codecs/rt286.h |  7 +++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 3d69cb4..8121c97 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1191,6 +1191,17 @@ static struct dmi_system_id force_combo_jack_table[] = {
 	{ }
 };
 
+static struct dmi_system_id dmi_dell_dino[] = {
+	{
+		.ident = "Dell Dino",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "0144P8")
+		}
+	},
+	{ }
+};
+
 static int rt286_i2c_probe(struct i2c_client *i2c,
 			   const struct i2c_device_id *id)
 {
@@ -1226,7 +1237,8 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		rt286->pdata = *pdata;
 
-	if (dmi_check_system(force_combo_jack_table))
+	if (dmi_check_system(force_combo_jack_table) ||
+		dmi_check_system(dmi_dell_dino))
 		rt286->pdata.cbj_en = true;
 
 	regmap_write(rt286->regmap, RT286_SET_AUDIO_POWER, AC_PWRST_D3);
@@ -1265,6 +1277,17 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL3, 0xf777, 0x4737);
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL4, 0x00ff, 0x003f);
 
+	if (dmi_check_system(dmi_dell_dino)) {
+		regmap_update_bits(rt286->regmap,
+			RT286_SET_GPIO_MASK, 0x40, 0x40);
+		regmap_update_bits(rt286->regmap,
+			RT286_SET_GPIO_DIRECTION, 0x40, 0x40);
+		regmap_update_bits(rt286->regmap,
+			RT286_SET_GPIO_DATA, 0x40, 0x40);
+		regmap_update_bits(rt286->regmap,
+			RT286_GPIO_CTRL, 0xc, 0x8);
+	}
+
 	if (rt286->i2c->irq) {
 		ret = request_threaded_irq(rt286->i2c->irq, NULL, rt286_irq,
 			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt286", rt286);
diff --git a/sound/soc/codecs/rt286.h b/sound/soc/codecs/rt286.h
index b539b73..7130edb 100644
--- a/sound/soc/codecs/rt286.h
+++ b/sound/soc/codecs/rt286.h
@@ -117,6 +117,12 @@
 	VERB_CMD(AC_VERB_SET_COEF_INDEX, RT286_VENDOR_REGISTERS, 0)
 #define RT286_PROC_COEF\
 	VERB_CMD(AC_VERB_SET_PROC_COEF, RT286_VENDOR_REGISTERS, 0)
+#define RT286_SET_GPIO_MASK\
+	VERB_CMD(AC_VERB_SET_GPIO_MASK, RT286_AUDIO_FUNCTION_GROUP, 0)
+#define RT286_SET_GPIO_DIRECTION\
+	VERB_CMD(AC_VERB_SET_GPIO_DIRECTION, RT286_AUDIO_FUNCTION_GROUP, 0)
+#define RT286_SET_GPIO_DATA\
+	VERB_CMD(AC_VERB_SET_GPIO_DATA, RT286_AUDIO_FUNCTION_GROUP, 0)
 
 /* Index registers */
 #define RT286_A_BIAS_CTRL1	0x01
@@ -131,6 +137,7 @@
 #define RT286_POWER_CTRL3	0x0f
 #define RT286_MIC1_DET_CTRL	0x19
 #define RT286_MISC_CTRL1	0x20
+#define RT286_GPIO_CTRL		0x29
 #define RT286_IRQ_CTRL		0x33
 #define RT286_PLL_CTRL1		0x49
 #define RT286_CBJ_CTRL1		0x4f
-- 
1.8.1.1.439.g50a6b54
