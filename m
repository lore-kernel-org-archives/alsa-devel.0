From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2] ASoC: bt-sco: Add devicetree support for bt-sco codec
Date: Fri,  8 May 2015 21:02:34 +0200
Message-ID: <1431111754-14562-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: alsa-devel@alsa-project.org

Add devicetree support for bluetooth SCO link codec.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
changes from v1:
- removed "linux,bt-sco" compatible property + update documentation

 Documentation/devicetree/bindings/sound/bt-sco.txt    | 13 +++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +
 sound/soc/codecs/bt-sco.c                             |  9 +++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/bt-sco.txt

diff --git a/Documentation/devicetree/bindings/sound/bt-sco.txt b/Documentation/devicetree/bindings/sound/bt-sco.txt
new file mode 100644
index 0000000..29b8e5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/bt-sco.txt
@@ -0,0 +1,13 @@
+Bluetooth-SCO audio CODEC
+
+This device support generic Bluetooth SCO link.
+
+Required properties:
+
+  - compatible : "delta,dfbmcs320"
+
+Example:
+
+codec: bt_sco {
+	compatible = "delta,dfbmcs320";
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
index e7238b8..18c9357 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -74,9 +74,18 @@ static struct platform_device_id bt_sco_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, bt_sco_driver_ids);
 
+#if defined(CONFIG_OF)
+static const struct of_device_id bt_sco_codec_of_match[] = {
+	{ .compatible = "delta,dfbmcs320", },
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
