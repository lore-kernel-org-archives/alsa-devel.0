From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v10 3/7] ASoC: imx-audmux: Read default configuration from
 devicetree
Date: Sat, 27 Jul 2013 13:31:52 +0200
Message-ID: <1374924716-23475-4-git-send-email-mpa@pengutronix.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Adds a function to parse a default port configuration from devicetree.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/sound/imx-audmux.txt       |  9 ++++
 sound/soc/fsl/imx-audmux.c                         | 62 ++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/imx-audmux.txt b/Documentation/devicetree/bindings/sound/imx-audmux.txt
index 215aa98..f88a00e 100644
--- a/Documentation/devicetree/bindings/sound/imx-audmux.txt
+++ b/Documentation/devicetree/bindings/sound/imx-audmux.txt
@@ -5,6 +5,15 @@ Required properties:
   or "fsl,imx31-audmux" for the version firstly used on i.MX31.
 - reg : Should contain AUDMUX registers location and length
 
+An initial configuration can be setup using child nodes.
+
+Required properties of optional child nodes:
+- fsl,audmux-port : Integer of the audmux port that is configured by this
+  child node.
+- fsl,port-config : List of configuration options for the specific port. For
+  imx31-audmux and above, it is a list of tuples <ptcr pdcr>. For
+  imx21-audmux it is a list of pcr values.
+
 Example:
 
 audmux@021d8000 {
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 1a5da1e..103d1b0 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -251,6 +251,66 @@ int imx_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 }
 EXPORT_SYMBOL_GPL(imx_audmux_v2_configure_port);
 
+static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
+		struct device_node *of_node)
+{
+	struct device_node *child;
+
+	for_each_available_child_of_node(of_node, child) {
+		unsigned int port;
+		unsigned int ptcr = 0;
+		unsigned int pdcr = 0;
+		unsigned int pcr = 0;
+		unsigned int val;
+		int ret;
+		int i = 0;
+
+		ret = of_property_read_u32(child, "fsl,audmux-port", &port);
+		if (ret) {
+			dev_warn(&pdev->dev, "Failed to get fsl,audmux-port of child node \"%s\"\n",
+					child->full_name);
+			continue;
+		}
+		if (!of_property_read_bool(child, "fsl,port-config")) {
+			dev_warn(&pdev->dev, "child node \"%s\" does not have property fsl,port-config\n",
+					child->full_name);
+			continue;
+		}
+
+		for (i = 0; (ret = of_property_read_u32_index(child,
+					"fsl,port-config\n", i, &val)) == 0;
+				++i) {
+			if (audmux_type == IMX31_AUDMUX) {
+				if (i % 2)
+					pdcr |= val;
+				else
+					ptcr |= val;
+			} else {
+				pcr |= val;
+			}
+		}
+
+		if (ret != -ENODATA) {
+			dev_err(&pdev->dev, "Failed to read u32 at index %d of child %s\n",
+					i, child->full_name);
+			continue;
+		}
+
+		if (audmux_type == IMX31_AUDMUX) {
+			if (i % 2) {
+				dev_err(&pdev->dev, "One pdcr value is missing in child node %s\n",
+						child->full_name);
+				continue;
+			}
+			imx_audmux_v2_configure_port(port, ptcr, pdcr);
+		} else {
+			imx_audmux_v1_configure_port(port, pcr);
+		}
+	}
+
+	return 0;
+}
+
 static int imx_audmux_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -275,6 +335,8 @@ static int imx_audmux_probe(struct platform_device *pdev)
 	if (audmux_type == IMX31_AUDMUX)
 		audmux_debugfs_init();
 
+	imx_audmux_parse_dt_defaults(pdev, pdev->dev.of_node);
+
 	return 0;
 }
 
-- 
1.8.3.2
