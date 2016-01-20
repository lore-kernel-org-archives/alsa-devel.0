From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: avoid unused variable warning for
	rt5659_acpi_match
Date: Wed, 20 Jan 2016 12:46:24 +0100
Message-ID: <1957179.2R1q7SBuPk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CEDE260544
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 12:46:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The newly added rt5659 codec driver unconditionally defines an
ACPI device match table but then uses ACPI_PTR() to remove the
only reference to it, so we get a harmless build warning:

sound/soc/codecs/rt5659.c:4200:30: warning: 'rt5659_acpi_match' defined but not used [-Wunused-variable]
 static struct acpi_device_id rt5659_acpi_match[] = {

This changes both the OF match table and the ACPI match table
to follow the same style, using ACPI_PTR/of_match_ptr to
make the reference conditional, and using an #ifdef to hide
the table. This also adds the missing MODULE_DEVICE_TABLE for
the OF case and adapts the formatting to the same style.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: actually builds with CONFIG_OF enabled, testing in a couple of
configurations with and without OF

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index c166d9394c69..fb8ea05c0de1 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4183,24 +4183,29 @@ void rt5659_i2c_shutdown(struct i2c_client *client)
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id rt5659_of_match[] = {
 	{ .compatible = "realtek,rt5658", },
 	{ .compatible = "realtek,rt5659", },
-	{},
+	{ },
 };
+MODULE_DEVICE_TABLE(of, rt5659_of_match);
+#endif
 
+#ifdef CONFIG_ACPI
 static struct acpi_device_id rt5659_acpi_match[] = {
-		{ "10EC5658", 0},
-		{ "10EC5659", 0},
-		{ },
+	{ "10EC5658", 0, },
+	{ "10EC5659", 0, },
+	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5659_acpi_match);
+#endif
 
 struct i2c_driver rt5659_i2c_driver = {
 	.driver = {
 		.name = "rt5659",
 		.owner = THIS_MODULE,
-		.of_match_table = rt5659_of_match,
+		.of_match_table = of_match_ptr(rt5659_of_match),
 		.acpi_match_table = ACPI_PTR(rt5659_acpi_match),
 	},
 	.probe = rt5659_i2c_probe,
