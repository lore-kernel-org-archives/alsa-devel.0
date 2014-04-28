From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v4 03/17] ASoC: fsl-ssi: Use dev_name for DAI driver struct
Date: Mon, 28 Apr 2014 12:54:44 +0200
Message-ID: <1398682498-24357-4-git-send-email-mpa@pengutronix.de>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Instead of creating a name using string manipulation functions, we can
simply use the device name for the DAI driver struct.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 344f752..65d9da1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1027,17 +1027,13 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (!strcmp(sprop, "ac97-slave"))
 		ac97 = true;
 
-	/* The DAI name is the last part of the full name of the node. */
-	p = strrchr(np->full_name, '/') + 1;
-	ssi_private = devm_kzalloc(&pdev->dev, sizeof(*ssi_private) + strlen(p),
-			      GFP_KERNEL);
+	ssi_private = devm_kzalloc(&pdev->dev, sizeof(*ssi_private),
+			GFP_KERNEL);
 	if (!ssi_private) {
 		dev_err(&pdev->dev, "could not allocate DAI object\n");
 		return -ENOMEM;
 	}
 
-	strcpy(ssi_private->name, p);
-
 	ssi_private->use_dma = !of_property_read_bool(np,
 			"fsl,fiq-stream-filter");
 	ssi_private->hw_type = hw_type;
@@ -1055,7 +1051,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
 		       sizeof(fsl_ssi_dai_template));
 	}
-	ssi_private->cpu_dai_drv.name = ssi_private->name;
+	ssi_private->cpu_dai_drv.name = dev_name(&pdev->dev);
 
 	/* Get the addresses and IRQ */
 	ret = of_address_to_resource(np, 0, &res);
@@ -1203,7 +1199,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	 * different writeable interrupt status registers.
 	 */
 	if (ssi_private->use_dma) {
-		/* The 'name' should not have any slashes in it. */
 		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
 					fsl_ssi_isr, 0, ssi_private->name,
 					ssi_private);
-- 
1.9.1
