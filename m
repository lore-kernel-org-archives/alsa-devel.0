From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/5] ASoC: pxa: pxa-ssp: add DT bindings
Date: Mon, 12 Aug 2013 10:42:38 +0200
Message-ID: <1376296961-20564-3-git-send-email-zonque@gmail.com>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376296961-20564-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: broonie@kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, eric.y.miao@gmail.com, arnd@arndb.de, s.neumann@raumfeld.com, Daniel Mack <zonque@gmail.com>, haojian.zhuang@linaro.org, rmk+kernel@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

The pxa ssp DAI acts as a user of a pxa ssp port, and needs an
appropriate 'port' phandle in DT to reference the upstream.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/sound/mrvl,pxa-ssp.txt     | 28 ++++++++++++++++
 sound/soc/pxa/pxa-ssp.c                            | 37 ++++++++++++++++++----
 2 files changed, 59 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt

diff --git a/Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt b/Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
new file mode 100644
index 0000000..74c9ba6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
@@ -0,0 +1,28 @@
+Marvell PXA SSP CPU DAI bindings
+
+Required properties:
+
+	compatible	Must be "mrvl,pxa-ssp-dai"
+	port		A phandle reference to a PXA ssp upstream device
+
+Example:
+
+	/* upstream device */
+
+	ssp0: ssp@41000000 {
+		compatible = "mrvl,pxa3xx-ssp";
+		reg = <0x41000000 0x40>;
+		interrupts = <24>;
+		clock-names = "pxa27x-ssp.0";
+		dmas = <&dma 13
+			&dma 14>;
+		dma-names = "rx", "tx";
+	};
+
+	/* DAI as user */
+
+	ssp_dai0: ssp_dai@0 {
+		compatible = "mrvl,pxa-ssp-dai";
+		port = <&ssp0>;
+	};
+
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 6f4dd75..19296f2 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/pxa2xx_ssp.h>
+#include <linux/of.h>
 
 #include <asm/irq.h>
 
@@ -719,6 +720,7 @@ static int pxa_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
 
 static int pxa_ssp_probe(struct snd_soc_dai *dai)
 {
+	struct device *dev = dai->dev;
 	struct ssp_priv *priv;
 	int ret;
 
@@ -726,10 +728,26 @@ static int pxa_ssp_probe(struct snd_soc_dai *dai)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->ssp = pxa_ssp_request(dai->id + 1, "SoC audio");
-	if (priv->ssp == NULL) {
-		ret = -ENODEV;
-		goto err_priv;
+	if (dev->of_node) {
+		struct device_node *ssp_handle;
+
+		ssp_handle = of_parse_phandle(dev->of_node, "port", 0);
+		if (!ssp_handle) {
+			dev_err(dev, "unable to get 'port' phandle\n");
+			return -ENODEV;
+		}
+
+		priv->ssp = pxa_ssp_request_of(ssp_handle, "SoC audio");
+		if (priv->ssp == NULL) {
+			ret = -ENODEV;
+			goto err_priv;
+		}
+	} else {
+		priv->ssp = pxa_ssp_request(dai->id + 1, "SoC audio");
+		if (priv->ssp == NULL) {
+			ret = -ENODEV;
+			goto err_priv;
+		}
 	}
 
 	priv->dai_fmt = (unsigned int) -1;
@@ -798,6 +816,12 @@ static const struct snd_soc_component_driver pxa_ssp_component = {
 	.name		= "pxa-ssp",
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id pxa_ssp_of_ids[] = {
+	{ .compatible = "mrvl,pxa-ssp-dai" },
+};
+#endif
+
 static int asoc_ssp_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_component(&pdev->dev, &pxa_ssp_component,
@@ -812,8 +836,9 @@ static int asoc_ssp_remove(struct platform_device *pdev)
 
 static struct platform_driver asoc_ssp_driver = {
 	.driver = {
-			.name = "pxa-ssp-dai",
-			.owner = THIS_MODULE,
+		.name = "pxa-ssp-dai",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(pxa_ssp_of_ids),
 	},
 
 	.probe = asoc_ssp_probe,
-- 
1.8.3.1
