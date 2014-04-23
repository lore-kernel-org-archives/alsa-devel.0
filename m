From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH] ASoC: max98095: Add an explicit of_match_table
Date: Wed, 23 Apr 2014 14:43:58 +0530
Message-ID: <1398244438-2124-1-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 1436B2608EA
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 11:15:07 +0200 (CEST)
Received: by mail-pb0-f50.google.com with SMTP id md12so590050pbc.37
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 02:15:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, rdunlap@infradead.org, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

Create an explicit of_match_table entry for MAX98095 codec. Also
add a binding Documentation for this compatible string.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 .../devicetree/bindings/sound/max98095.txt         |   16 ++++++++++++++++
 sound/soc/codecs/max98095.c                        |    7 +++++++
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98095.txt

diff --git a/Documentation/devicetree/bindings/sound/max98095.txt b/Documentation/devicetree/bindings/sound/max98095.txt
new file mode 100644
index 0000000..bacbeaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98095.txt
@@ -0,0 +1,16 @@
+MAX98095 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "maxim,max98095".
+
+- reg : The I2C address of the device.
+
+Example:
+
+max98095: codec@11 {
+	compatible = "maxim,max98095";
+	reg = <0x11>;
+};
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 03f0536..8e548af 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2399,10 +2399,17 @@ static const struct i2c_device_id max98095_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max98095_i2c_id);
 
+static const struct of_device_id max98095_of_match[] = {
+	{ .compatible = "maxim,max98095", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max98095_of_match);
+
 static struct i2c_driver max98095_i2c_driver = {
 	.driver = {
 		.name = "max98095",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(max98095_of_match),
 	},
 	.probe  = max98095_i2c_probe,
 	.remove = max98095_i2c_remove,
-- 
1.7.9.5
