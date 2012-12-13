From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: wm8962: Add device tree support
Date: Wed, 12 Dec 2012 23:28:04 -0200
Message-ID: <1355362084-16460-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
 [209.85.161.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 611E62615CD
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 02:28:18 +0100 (CET)
Received: by mail-gg0-f179.google.com with SMTP id q1so339349gge.38
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 17:28:17 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add device tree support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/sound/wm8962.txt |   16 ++++++++++++++++
 sound/soc/codecs/wm8962.c                          |    7 +++++++
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8962.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8962.txt b/Documentation/devicetree/bindings/sound/wm8962.txt
new file mode 100644
index 0000000..dceb3b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8962.txt
@@ -0,0 +1,16 @@
+WM8962 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+  - compatible : "wlf,wm8962"
+
+  - reg : the I2C address of the device.
+
+Example:
+
+codec: wm8962@1a {
+	compatible = "wlf,wm8962";
+	reg = <0x1a>;
+};
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8fd38cb..1ebeff4 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3758,10 +3758,17 @@ static const struct i2c_device_id wm8962_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8962_i2c_id);
 
+static const struct of_device_id wm8962_of_match[] = {
+	{ .compatible = "wlf,wm8962", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8962_of_match);
+
 static struct i2c_driver wm8962_i2c_driver = {
 	.driver = {
 		.name = "wm8962",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8962_of_match,
 		.pm = &wm8962_pm,
 	},
 	.probe =    wm8962_i2c_probe,
-- 
1.7.9.5
