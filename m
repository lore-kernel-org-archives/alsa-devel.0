From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: avoid unused variable warning
	for rt5659_acpi_match" to the asoc tree
Date: Thu, 21 Jan 2016 16:56:05 +0000
Message-ID: <E1aMIWj-0008Ep-Q7@debutante>
References: <1957179.2R1q7SBuPk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0B232606A8
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 17:56:16 +0100 (CET)
In-Reply-To: <1957179.2R1q7SBuPk@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5659: avoid unused variable warning for rt5659_acpi_match

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2256b8d2ff6c8e994161ab15b6e6d0314d3174ae Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Jan 2016 12:46:24 +0100
Subject: [PATCH] ASoC: rt5659: avoid unused variable warning for
 rt5659_acpi_match

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

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
-- 
2.7.0.rc3
