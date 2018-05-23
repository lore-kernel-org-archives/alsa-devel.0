From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v2] ASoC: imx-audmux: add RXFS/RXCLK defines
	for 6-wire connections
Date: Wed, 23 May 2018 11:43:00 +0200
Message-ID: <20180523094300.8780-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 41EDD26705D
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 11:43:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: fabio.estevam@nxp.com, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Philipp Zabel <p.zabel@pengutronix.de>

In asynchronous mode, a RxFS and RxClk connection needs to be made between
two ports. Add a define for the bit to be set in the *SEL fields.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
[m.felsch@pengutronix.de: fixed comment to include i.MX21 and 35]
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 include/dt-bindings/sound/fsl-imx-audmux.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bindings/sound/fsl-imx-audmux.h
index 751fe1416f95..15f138bebe16 100644
--- a/include/dt-bindings/sound/fsl-imx-audmux.h
+++ b/include/dt-bindings/sound/fsl-imx-audmux.h
@@ -25,6 +25,13 @@
 #define MX51_AUDMUX_PORT6		5
 #define MX51_AUDMUX_PORT7		6
 
+/*
+ * TFCSEL/RFCSEL (i.MX27) or TFSEL/TCSEL/RFSEL/RCSEL (i.MX31/51/53/6Q)
+ * can be sourced from Rx/Tx.
+ */
+#define IMX_AUDMUX_RXFS			0x8
+#define IMX_AUDMUX_RXCLK		0x8
+
 /* Register definitions for the i.MX21/27 Digital Audio Multiplexer */
 #define IMX_AUDMUX_V1_PCR_INMMASK(x)	((x) & 0xff)
 #define IMX_AUDMUX_V1_PCR_INMEN		(1 << 8)
-- 
2.17.0
