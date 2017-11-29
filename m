From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 03/19] ASoC: tlv320aic31xx: Move ACPI table next to OF table
Date: Wed, 29 Nov 2017 15:32:44 -0600
Message-ID: <20171129213300.20021-4-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171129213300.20021-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
