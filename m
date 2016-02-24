From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1: Add basic DT support for
	adau17x1" to the asoc tree
Date: Wed, 24 Feb 2016 13:15:10 +0900
Message-ID: <E1aYQr0-0000pH-IM@finisterre>
References: <1455627405-18155-5-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4565261083402804787=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7695E261484
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 05:15:22 +0100 (CET)
In-Reply-To: <1455627405-18155-5-git-send-email-andire@axis.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============4565261083402804787==
Content-Type: text/plain

The patch

   ASoC: adau17x1: Add basic DT support for adau17x1

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

>From aaf0f3aeeb6f9e5e874fccc8a0e56b00fea537c3 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Date: Tue, 16 Feb 2016 13:56:44 +0100
Subject: [PATCH] ASoC: adau17x1: Add basic DT support for adau17x1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Andreas Irestål <andire@axis.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1761-i2c.c | 12 ++++++++++++
 sound/soc/codecs/adau1761-spi.c | 12 ++++++++++++
 sound/soc/codecs/adau1781-i2c.c | 10 ++++++++++
 sound/soc/codecs/adau1781-spi.c | 10 ++++++++++
 4 files changed, 44 insertions(+)

diff --git a/sound/soc/codecs/adau1761-i2c.c b/sound/soc/codecs/adau1761-i2c.c
index a1b12671c307..8de010f758cd 100644
--- a/sound/soc/codecs/adau1761-i2c.c
+++ b/sound/soc/codecs/adau1761-i2c.c
@@ -44,9 +44,21 @@ static const struct i2c_device_id adau1761_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adau1761_i2c_ids);
 
+#if defined(CONFIG_OF)
+static const struct of_device_id adau1761_i2c_dt_ids[] = {
+	{ .compatible = "adi,adau1361", },
+	{ .compatible = "adi,adau1461", },
+	{ .compatible = "adi,adau1761", },
+	{ .compatible = "adi,adau1961", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adau1761_i2c_dt_ids);
+#endif
+
 static struct i2c_driver adau1761_i2c_driver = {
 	.driver = {
 		.name = "adau1761",
+		.of_match_table = of_match_ptr(adau1761_i2c_dt_ids),
 	},
 	.probe = adau1761_i2c_probe,
 	.remove = adau1761_i2c_remove,
diff --git a/sound/soc/codecs/adau1761-spi.c b/sound/soc/codecs/adau1761-spi.c
index 188334928c23..d9171245bd9f 100644
--- a/sound/soc/codecs/adau1761-spi.c
+++ b/sound/soc/codecs/adau1761-spi.c
@@ -61,9 +61,21 @@ static const struct spi_device_id adau1761_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, adau1761_spi_id);
 
+#if defined(CONFIG_OF)
+static const struct of_device_id adau1761_spi_dt_ids[] = {
+	{ .compatible = "adi,adau1361", },
+	{ .compatible = "adi,adau1461", },
+	{ .compatible = "adi,adau1761", },
+	{ .compatible = "adi,adau1961", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adau1761_spi_dt_ids);
+#endif
+
 static struct spi_driver adau1761_spi_driver = {
 	.driver = {
 		.name = "adau1761",
+		.of_match_table = of_match_ptr(adau1761_spi_dt_ids),
 	},
 	.probe = adau1761_spi_probe,
 	.remove = adau1761_spi_remove,
diff --git a/sound/soc/codecs/adau1781-i2c.c b/sound/soc/codecs/adau1781-i2c.c
index 0e32bba92339..06cbca84cf02 100644
--- a/sound/soc/codecs/adau1781-i2c.c
+++ b/sound/soc/codecs/adau1781-i2c.c
@@ -42,9 +42,19 @@ static const struct i2c_device_id adau1781_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adau1781_i2c_ids);
 
+#if defined(CONFIG_OF)
+static const struct of_device_id adau1781_i2c_dt_ids[] = {
+	{ .compatible = "adi,adau1381", },
+	{ .compatible = "adi,adau1781", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adau1781_i2c_dt_ids);
+#endif
+
 static struct i2c_driver adau1781_i2c_driver = {
 	.driver = {
 		.name = "adau1781",
+		.of_match_table = of_match_ptr(adau1781_i2c_dt_ids),
 	},
 	.probe = adau1781_i2c_probe,
 	.remove = adau1781_i2c_remove,
diff --git a/sound/soc/codecs/adau1781-spi.c b/sound/soc/codecs/adau1781-spi.c
index 33a73ff78de4..3d965a01b99c 100644
--- a/sound/soc/codecs/adau1781-spi.c
+++ b/sound/soc/codecs/adau1781-spi.c
@@ -59,9 +59,19 @@ static const struct spi_device_id adau1781_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, adau1781_spi_id);
 
+#if defined(CONFIG_OF)
+static const struct of_device_id adau1781_spi_dt_ids[] = {
+	{ .compatible = "adi,adau1381", },
+	{ .compatible = "adi,adau1781", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adau1781_spi_dt_ids);
+#endif
+
 static struct spi_driver adau1781_spi_driver = {
 	.driver = {
 		.name = "adau1781",
+		.of_match_table = of_match_ptr(adau1781_spi_dt_ids),
 	},
 	.probe = adau1781_spi_probe,
 	.remove = adau1781_spi_remove,
-- 
2.7.0


--===============4565261083402804787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4565261083402804787==--
