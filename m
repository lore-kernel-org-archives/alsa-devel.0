From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: dmic codec: Support for DT
Date: Tue,  8 May 2012 14:55:57 +0300
Message-ID: <1336478157-27526-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 446AA2439A
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 13:56:05 +0200 (CEST)
Received: by lahj13 with SMTP id j13so1047888lah.11
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 04:56:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Add bindings to be able to probe the dmic codec driver via device tree.
The device tree entry of a machine driver can use phandle to provide
the device node for it's dai link structure.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/dmic-codec.txt       |   18 ++++++++++++++++++
 sound/soc/codecs/dmic.c                            |    6 ++++++
 2 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/dmic-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/dmic-codec.txt b/Documentation/devicetree/bindings/sound/dmic-codec.txt
new file mode 100644
index 0000000..f23f2e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dmic-codec.txt
@@ -0,0 +1,18 @@
+Generic platform independent codec driver to represent digital microphones
+
+The dmic codec driver basically a dummy driver which exports the needed hooks
+to be used with digital microphone interfaces.
+
+Required properties:
+- compatible : Must be "generic,dmic-codec";
+
+Example:
+
+dmic_codec: dmic_codec@0 { /* generic DMIC codec */
+	compatible = "generic,dmic-codec";
+};
+
+sound { /* ASoC machine dirver */
+	...
+	dai-link,codec = <&dmic_codec>;
+};
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 3e929f0..90e92f5 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -78,12 +78,18 @@ static int __devexit dmic_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id dmic_of_match[] = {
+	{.compatible = "generic,dmic-codec", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, dmic_of_match);
 MODULE_ALIAS("platform:dmic-codec");
 
 static struct platform_driver dmic_driver = {
 	.driver = {
 		.name = "dmic-codec",
 		.owner = THIS_MODULE,
+		.of_match_table = dmic_of_match,
 	},
 	.probe = dmic_dev_probe,
 	.remove = __devexit_p(dmic_dev_remove),
-- 
1.7.8.6
