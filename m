From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: imx: imx-audmux: Fix section mismatch
Date: Wed, 7 Mar 2012 15:18:46 -0300
Message-ID: <1331144326-32153-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe005.messaging.microsoft.com [213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 599B110410D
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 19:19:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, s.hauer@pengutronix.de, richard.zhao@linaro.org
List-Id: alsa-devel@alsa-project.org

Fix the following section mismatch warning:

WARNING: vmlinux.o(.data+0x35be8): Section mismatch in reference from the variable imx_audmux_driver to the function .init.text:imx_audmux_probe()
The variable imx_audmux_driver references
the function __init imx_audmux_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/imx/imx-audmux.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/imx/imx-audmux.c b/sound/soc/imx/imx-audmux.c
index ef425ad..601df80 100644
--- a/sound/soc/imx/imx-audmux.c
+++ b/sound/soc/imx/imx-audmux.c
@@ -167,7 +167,7 @@ static void __init audmux_debugfs_init(void)
 	}
 }
 
-static void __exit audmux_debugfs_remove(void)
+static void __devexit audmux_debugfs_remove(void)
 {
 	debugfs_remove_recursive(audmux_debugfs_root);
 }
@@ -249,7 +249,7 @@ int imx_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 }
 EXPORT_SYMBOL_GPL(imx_audmux_v2_configure_port);
 
-static int __init imx_audmux_probe(struct platform_device *pdev)
+static int __devinit imx_audmux_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	const struct of_device_id *of_id =
@@ -276,7 +276,7 @@ static int __init imx_audmux_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __exit imx_audmux_remove(struct platform_device *pdev)
+static int __devexit imx_audmux_remove(struct platform_device *pdev)
 {
 	if (audmux_type == IMX31_AUDMUX)
 		audmux_debugfs_remove();
@@ -287,7 +287,7 @@ static int __exit imx_audmux_remove(struct platform_device *pdev)
 
 static struct platform_driver imx_audmux_driver = {
 	.probe		= imx_audmux_probe,
-	.remove		= __exit_p(imx_audmux_remove),
+	.remove		= __devexit_p(imx_audmux_remove),
 	.id_table	= imx_audmux_ids,
 	.driver	= {
 		.name	= DRIVER_NAME,
-- 
1.7.1
