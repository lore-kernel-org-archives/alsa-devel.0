From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ALSA: ASoC: ak4104: add DT bindings
Date: Sun,  7 Oct 2012 17:51:24 +0200
Message-ID: <1349625084-15639-2-git-send-email-zonque@gmail.com>
References: <1349625084-15639-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id E32B126160C
 for <alsa-devel@alsa-project.org>; Sun,  7 Oct 2012 17:51:40 +0200 (CEST)
In-Reply-To: <1349625084-15639-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 Documentation/devicetree/bindings/sound/ak4104.txt | 17 +++++++++++++++++
 sound/soc/codecs/ak4104.c                          |  7 +++++++
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4104.txt

diff --git a/Documentation/devicetree/bindings/sound/ak4104.txt b/Documentation/devicetree/bindings/sound/ak4104.txt
new file mode 100644
index 0000000..1f8e506
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak4104.txt
@@ -0,0 +1,17 @@
+AK4104 S/PDIF transmitter
+
+This device supports SPI mode only.
+
+Required properties:
+
+  - compatible : "asahi-kasei,ak4104"
+
+  - reg : The chip select number on the SPI bus
+
+Example:
+
+spdif: ak4104@0 {
+	compatible = "asahi-kasei,ak4104";
+	reg = <0>;
+	spi-max-frequency = <5000000>;
+};
diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index d14163f..d4d4858 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -258,10 +258,17 @@ static int __devexit ak4104_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id ak4104_of_match[] = {
+	{ .compatible = "asahi-kasei,ak4104", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ak4104_of_match);
+
 static struct spi_driver ak4104_spi_driver = {
 	.driver  = {
 		.name   = DRV_NAME,
 		.owner  = THIS_MODULE,
+		.of_match_table = ak4104_of_match,
 	},
 	.probe  = ak4104_spi_probe,
 	.remove = __devexit_p(ak4104_spi_remove),
-- 
1.7.11.4
