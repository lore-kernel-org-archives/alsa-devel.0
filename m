From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v4 08/10] ASoC: fsl: remove the fatal error
	checking on codec-handle
Date: Mon, 12 Mar 2012 19:58:55 +0800
Message-ID: <1331553537-19789-9-git-send-email-shawn.guo@linaro.org>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ED6C1103FDA
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 12:59:32 +0100 (CET)
Received: by yhnn12 with SMTP id n12so2511497yhn.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 04:59:32 -0700 (PDT)
In-Reply-To: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

As Documentation/devicetree/bindings/powerpc/fsl/ssi.txt documented,
codec-handle is an optional property, so missing it should not be a
fatal error.

More importantly, the imx machine drivers to be added working with
fsl_ssi will not have this property, as they use new ASoC machine
driver binding mechanism.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index db9a734..0192c02 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -642,12 +642,6 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
-	/* Check for a codec-handle property. */
-	if (!of_get_property(np, "codec-handle", NULL)) {
-		dev_err(&pdev->dev, "missing codec-handle property\n");
-		return -ENODEV;
-	}
-
 	/* We only support the SSI in "I2S Slave" mode */
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (!sprop || strcmp(sprop, "i2s-slave")) {
-- 
1.7.5.4
