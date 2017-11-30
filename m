From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Move ACPI table next to
	OF table" to the asoc tree
Date: Thu, 30 Nov 2017 12:32:50 +0000
Message-ID: <E1eKO1K-0000S4-EY@debutante>
References: <20171129213300.20021-4-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 216BF2679BE
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 13:32:55 +0100 (CET)
In-Reply-To: <20171129213300.20021-4-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Move ACPI table next to OF table

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 09303601bacda714220048a61f6864f88594b231 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 15:32:44 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: Move ACPI table next to OF table

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 0563a49cc5e4..d974e8651e30 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1285,6 +1285,14 @@ static void aic31xx_pdata_from_of(struct aic31xx_priv *aic31xx)
 }
 #endif /* CONFIG_OF */
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id aic31xx_acpi_match[] = {
+	{ "10TI3100", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, aic31xx_acpi_match);
+#endif
+
 static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
 {
 	int ret, i;
@@ -1382,14 +1390,6 @@ static const struct i2c_device_id aic31xx_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, aic31xx_i2c_id);
 
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id aic31xx_acpi_match[] = {
-	{ "10TI3100", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, aic31xx_acpi_match);
-#endif
-
 static struct i2c_driver aic31xx_i2c_driver = {
 	.driver = {
 		.name	= "tlv320aic31xx-codec",
-- 
2.15.0
