From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: Set cbj_en for ACPI devices
Date: Wed, 10 Sep 2014 09:40:33 +0800
Message-ID: <1410313233-585-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D10D260309
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 04:43:32 +0200 (CEST)
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

From: Bard Liao <bardliao@realtek.com>

This patch set cbj_en value for ACPI devices.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index e4f6102..d04616b 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1106,11 +1106,25 @@ static const struct acpi_device_id rt286_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, rt286_acpi_match);
 
+struct rt286_acpi_jack {
+	const char *acpi_id;
+	bool jack_combo;
+};
+
+/* list of devices using jack combo mode */
+static struct rt286_acpi_jack rt286_jack_combo[] = {
+	{ "INT343A", true },
+	{},
+};
+
 static int rt286_i2c_probe(struct i2c_client *i2c,
 			   const struct i2c_device_id *id)
 {
 	struct rt286_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt286_priv *rt286;
+	struct device *dev = &i2c->dev;
+	const struct acpi_device_id *acpiid;
+	struct rt286_acpi_jack *mach;
 	int i, ret;
 
 	rt286 = devm_kzalloc(&i2c->dev,	sizeof(*rt286),
@@ -1141,6 +1155,17 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		rt286->pdata = *pdata;
 
+	/* enable jack combo mode on supported devices */
+	acpiid = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (acpiid) {
+		for (mach = rt286_jack_combo; mach->acpi_id; mach++) {
+			if (!strcmp(mach->acpi_id, acpiid->id))
+				rt286->pdata.cbj_en =
+					rt286_jack_combo->jack_combo;
+
+		}
+	}
+
 	regmap_write(rt286->regmap, RT286_SET_AUDIO_POWER, AC_PWRST_D3);
 
 	for (i = 0; i < RT286_POWER_REG_LEN; i++)
-- 
1.8.1.1.439.g50a6b54
