From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] ASoC: imx-audmux: default configuration parser fixups
Date: Sat, 10 Aug 2013 14:55:57 +0200
Message-ID: <1376139357-21089-1-git-send-email-mpa@pengutronix.de>
References: <20130809123712.GD13664@s25.your-server.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130809123712.GD13664@s25.your-server.de>
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

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/imx-audmux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index f37cd9c..b21b85f 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -270,7 +270,7 @@ static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
 		}
 
 		for (i = 0; (ret = of_property_read_u32_index(child,
-					"fsl,port-config\n", i, &val)) == 0;
+					"fsl,port-config", i, &val)) == 0;
 				++i) {
 			if (audmux_type == IMX31_AUDMUX) {
 				if (i % 2)
@@ -282,7 +282,7 @@ static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
 			}
 		}
 
-		if (ret != -ENODATA) {
+		if (ret != -EOVERFLOW) {
 			dev_err(&pdev->dev, "Failed to read u32 at index %d of child %s\n",
 					i, child->full_name);
 			continue;
-- 
1.8.3.2
