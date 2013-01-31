From: Gary Zhang <b13634@freescale.com>
Subject: [PATCH] ASOC: imx: audmux: add a integrated
	configuration function
Date: Thu, 31 Jan 2013 14:42:46 +0800
Message-ID: <1359614566-4660-1-git-send-email-b13634@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 2870D26171B
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 08:41:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, shawn.guo@linaro.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

based on imx_audmux_v2_configure_port(), add a integrated
interface to configure audmux port conveniently

Signed-off-by: Gary Zhang <b13634@freescale.com>
---
 sound/soc/fsl/imx-audmux.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 251f4d9..ebd38a0 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
  * Copyright 2012 Linaro Ltd.
  * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
  *
@@ -244,6 +244,47 @@ int imx_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 }
 EXPORT_SYMBOL_GPL(imx_audmux_v2_configure_port);
 
+int imx_audmux_configure_port(unsigned int int_port, unsigned int ext_port)
+{
+	int ret;
+
+	if ((int_port > 7) || (ext_port > 7))
+		return -EINVAL;
+
+	if (audmux_type != IMX31_AUDMUX)
+		return -EINVAL;
+
+	if (!audmux_base)
+		return -ENOSYS;
+
+	if (audmux_clk)
+		clk_prepare_enable(audmux_clk);
+
+	int_port--;
+	ext_port--;
+	ret = imx_audmux_v2_configure_port(int_port,
+			IMX_AUDMUX_V2_PTCR_SYN |
+			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
+			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
+			IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR,
+			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
+	if (ret) {
+		pr_err("audmux internal port setup failed\n");
+		return ret;
+	}
+	imx_audmux_v2_configure_port(ext_port,
+			IMX_AUDMUX_V2_PTCR_SYN,
+			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
+	if (ret) {
+		pr_err("audmux external port setup failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imx_audmux_configure_port);
+
 static int imx_audmux_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-- 
1.7.0.4
