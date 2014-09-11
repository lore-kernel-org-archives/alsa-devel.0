From: <bardliao@realtek.com>
Subject: [PATCH v2] ASoC: rt286: Set cbj_en for ACPI devices
Date: Thu, 11 Sep 2014 09:40:54 +0800
Message-ID: <1410399654-10371-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A2AD2655FD
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 03:41:23 +0200 (CEST)
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
 sound/soc/codecs/rt286.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index e4f6102..7dfca82 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1100,8 +1100,14 @@ static const struct i2c_device_id rt286_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt286_i2c_id);
 
+/* the default platform data for acpi devices */
+static struct rt286_platform_data rt286_acpi_data = {
+	.cbj_en = true,
+	.gpio2_en = false,
+};
+
 static const struct acpi_device_id rt286_acpi_match[] = {
-	{ "INT343A", 0 },
+	{ "INT343A", (unsigned long)&rt286_acpi_data },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt286_acpi_match);
@@ -1111,6 +1117,8 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 {
 	struct rt286_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt286_priv *rt286;
+	struct device *dev = &i2c->dev;
+	const struct acpi_device_id *acpiid;
 	int i, ret;
 
 	rt286 = devm_kzalloc(&i2c->dev,	sizeof(*rt286),
@@ -1141,6 +1149,13 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		rt286->pdata = *pdata;
 
+	/* enable jack combo mode on supported devices */
+	acpiid = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (acpiid) {
+		rt286->pdata = *(struct rt286_platform_data *)
+				acpiid->driver_data;
+	}
+
 	regmap_write(rt286->regmap, RT286_SET_AUDIO_POWER, AC_PWRST_D3);
 
 	for (i = 0; i < RT286_POWER_REG_LEN; i++)
-- 
1.8.1.1.439.g50a6b54
