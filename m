From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Subject: [PATCH v2 4/5] ASoC: adau17x1: Add basic DT support for adau17x1
Date: Tue, 16 Feb 2016 13:56:44 +0100
Message-ID: <1455627405-18155-5-git-send-email-andire@axis.com>
References: <1455627405-18155-1-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455627405-18155-1-git-send-email-andire@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andire@axis.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andreas Irest=C3=A5l <andire@axis.com>
---
 sound/soc/codecs/adau1761-i2c.c | 12 ++++++++++++
 sound/soc/codecs/adau1761-spi.c | 12 ++++++++++++
 sound/soc/codecs/adau1781-i2c.c | 10 ++++++++++
 sound/soc/codecs/adau1781-spi.c | 10 ++++++++++
 4 files changed, 44 insertions(+)

diff --git a/sound/soc/codecs/adau1761-i2c.c b/sound/soc/codecs/adau176=
1-i2c.c
index a1b1267..8de010f 100644
--- a/sound/soc/codecs/adau1761-i2c.c
+++ b/sound/soc/codecs/adau1761-i2c.c
@@ -44,9 +44,21 @@ static const struct i2c_device_id adau1761_i2c_ids[]=
 =3D {
 };
 MODULE_DEVICE_TABLE(i2c, adau1761_i2c_ids);
=20
+#if defined(CONFIG_OF)
+static const struct of_device_id adau1761_i2c_dt_ids[] =3D {
+	{ .compatible =3D "adi,adau1361", },
+	{ .compatible =3D "adi,adau1461", },
+	{ .compatible =3D "adi,adau1761", },
+	{ .compatible =3D "adi,adau1961", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adau1761_i2c_dt_ids);
+#endif
+
 static struct i2c_driver adau1761_i2c_driver =3D {
 	.driver =3D {
 		.name =3D "adau1761",
+		.of_match_table =3D of_match_ptr(adau1761_i2c_dt_ids),
 	},
 	.probe =3D adau1761_i2c_probe,
 	.remove =3D adau1761_i2c_remove,
diff --git a/sound/soc/codecs/adau1761-spi.c b/sound/soc/codecs/adau176=
1-spi.c
index 1883349..d917124 100644
--- a/sound/soc/codecs/adau1761-spi.c
+++ b/sound/soc/codecs/adau1761-spi.c
@@ -61,9 +61,21 @@ static const struct spi_device_id adau1761_spi_id[] =
=3D {
 };
 MODULE_DEVICE_TABLE(spi, adau1761_spi_id);
=20
+#if defined(CONFIG_OF)
+static const struct of_device_id adau1761_spi_dt_ids[] =3D {
+	{ .compatible =3D "adi,adau1361", },
+	{ .compatible =3D "adi,adau1461", },
+	{ .compatible =3D "adi,adau1761", },
+	{ .compatible =3D "adi,adau1961", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adau1761_spi_dt_ids);
+#endif
+
 static struct spi_driver adau1761_spi_driver =3D {
 	.driver =3D {
 		.name =3D "adau1761",
+		.of_match_table =3D of_match_ptr(adau1761_spi_dt_ids),
 	},
 	.probe =3D adau1761_spi_probe,
 	.remove =3D adau1761_spi_remove,
diff --git a/sound/soc/codecs/adau1781-i2c.c b/sound/soc/codecs/adau178=
1-i2c.c
index 0e32bba..06cbca8 100644
--- a/sound/soc/codecs/adau1781-i2c.c
+++ b/sound/soc/codecs/adau1781-i2c.c
@@ -42,9 +42,19 @@ static const struct i2c_device_id adau1781_i2c_ids[]=
 =3D {
 };
 MODULE_DEVICE_TABLE(i2c, adau1781_i2c_ids);
=20
+#if defined(CONFIG_OF)
+static const struct of_device_id adau1781_i2c_dt_ids[] =3D {
+	{ .compatible =3D "adi,adau1381", },
+	{ .compatible =3D "adi,adau1781", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adau1781_i2c_dt_ids);
+#endif
+
 static struct i2c_driver adau1781_i2c_driver =3D {
 	.driver =3D {
 		.name =3D "adau1781",
+		.of_match_table =3D of_match_ptr(adau1781_i2c_dt_ids),
 	},
 	.probe =3D adau1781_i2c_probe,
 	.remove =3D adau1781_i2c_remove,
diff --git a/sound/soc/codecs/adau1781-spi.c b/sound/soc/codecs/adau178=
1-spi.c
index 33a73ff..3d965a0 100644
--- a/sound/soc/codecs/adau1781-spi.c
+++ b/sound/soc/codecs/adau1781-spi.c
@@ -59,9 +59,19 @@ static const struct spi_device_id adau1781_spi_id[] =
=3D {
 };
 MODULE_DEVICE_TABLE(spi, adau1781_spi_id);
=20
+#if defined(CONFIG_OF)
+static const struct of_device_id adau1781_spi_dt_ids[] =3D {
+	{ .compatible =3D "adi,adau1381", },
+	{ .compatible =3D "adi,adau1781", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adau1781_spi_dt_ids);
+#endif
+
 static struct spi_driver adau1781_spi_driver =3D {
 	.driver =3D {
 		.name =3D "adau1781",
+		.of_match_table =3D of_match_ptr(adau1781_spi_dt_ids),
 	},
 	.probe =3D adau1781_spi_probe,
 	.remove =3D adau1781_spi_remove,
--=20
2.1.4
