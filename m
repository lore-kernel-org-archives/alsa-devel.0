From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH] ASoC: bt-sco: Add devicetree support for bt-sco codec
Date: Tue,  5 May 2015 22:15:41 +0200
Message-ID: <1430856941-3938-1-git-send-email-marek@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add devicetree support for bt-sco generic bluetooth SCO link codec.

Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
---

 Documentation/devicetree/bindings/sound/bt-sco.txt    | 13 +++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +
 sound/soc/codecs/bt-sco.c                             | 10 ++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/bt-sco.txt

diff --git a/Documentation/devicetree/bindings/sound/bt-sco.txt b/Documentation/devicetree/bindings/sound/bt-sco.txt
new file mode 100644
index 0000000..7e6252f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/bt-sco.txt
@@ -0,0 +1,13 @@
+Bluetooth-SCO audio CODEC
+
+This device support generic Bluetooth SCO link.
+
+Required properties:
+
+  - compatible : "linux,bt-sco" or "delta,dfbmcs320"
+
+Example:
+
+codec: bt_sco {
+	compatible = "linux,bt-sco";
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ed3bd55..7a3a657 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -55,6 +55,7 @@ crystalfontz	Crystalfontz America, Inc.
 cubietech	Cubietech, Ltd.
 dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
 davicom	DAVICOM Semiconductor, Inc.
+delta	Delta Electronics, Inc.
 denx	Denx Software Engineering
 digi	Digi International Inc.
 digilent	Diglent, Inc.
diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index e7238b8..9002f2d 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -74,9 +74,19 @@ static struct platform_device_id bt_sco_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, bt_sco_driver_ids);
 
+#if defined(CONFIG_OF)
+static const struct of_device_id bt_sco_codec_of_match[] = {
+	{ .compatible = "delta,dfbmcs320", },
+	{ .compatible = "linux,bt-sco", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bt_sco_codec_of_match);
+#endif
+
 static struct platform_driver bt_sco_driver = {
 	.driver = {
 		.name = "bt-sco",
+		.of_match_table = of_match_ptr(bt_sco_codec_of_match),
 	},
 	.probe = bt_sco_probe,
 	.remove = bt_sco_remove,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
