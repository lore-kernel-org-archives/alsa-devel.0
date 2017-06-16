From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Introduce proper table for ACPI
	enumeration" to the asoc tree
Date: Fri, 16 Jun 2017 17:53:03 +0100
Message-ID: <E1dLuUZ-0003xs-NC@debutante>
References: <20170609204954.40310-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E5C4266C99
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 18:53:14 +0200 (CEST)
In-Reply-To: <20170609204954.40310-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: Introduce proper table for ACPI enumeration

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

>From a36afb0ab6488eaa2c9672d6c20a966a7c08ef65 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 15 Jun 2017 15:46:36 +0300
Subject: [PATCH] ASoC: rt5677: Introduce proper table for ACPI enumeration

I2C devices are enumerated by IDs, and not by instances.
Make it clear by using proper module device table for ACPI case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 65ac4518ad06..64cf6cc41ad1 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5030,7 +5030,6 @@ static const struct regmap_config rt5677_regmap = {
 static const struct i2c_device_id rt5677_i2c_id[] = {
 	{ "rt5677", RT5677 },
 	{ "rt5676", RT5676 },
-	{ "RT5677CE:00", RT5677 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
@@ -5041,6 +5040,14 @@ static const struct of_device_id rt5677_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rt5677_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rt5677_acpi_match[] = {
+	{ "RT5677CE", RT5677 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rt5677_acpi_match);
+#endif
+
 static const struct acpi_gpio_params plug_det_gpio = { RT5677_GPIO_PLUG_DET, 0, false };
 static const struct acpi_gpio_params mic_present_gpio = { RT5677_GPIO_MIC_PRESENT_L, 0, false };
 static const struct acpi_gpio_params headphone_enable_gpio = { RT5677_GPIO_HP_AMP_SHDN_L, 0, false };
@@ -5301,6 +5308,7 @@ static struct i2c_driver rt5677_i2c_driver = {
 	.driver = {
 		.name = "rt5677",
 		.of_match_table = rt5677_of_match,
+		.acpi_match_table = ACPI_PTR(rt5677_acpi_match),
 	},
 	.probe = rt5677_i2c_probe,
 	.remove   = rt5677_i2c_remove,
-- 
2.11.0
