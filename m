From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH] ASoC: imx-audmux: add RXFS/RXCLK defines for
	6-wire connections
Date: Thu, 17 May 2018 16:26:01 +0200
Message-ID: <20180517142601.19587-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id B797C266F4E
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 16:26:09 +0200 (CEST)
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
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 include/dt-bindings/sound/fsl-imx-audmux.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bindings/sound/fsl-imx-audmux.h
index 751fe1416f95..6120696abe63 100644
--- a/include/dt-bindings/sound/fsl-imx-audmux.h
+++ b/include/dt-bindings/sound/fsl-imx-audmux.h
@@ -25,6 +25,10 @@
 #define MX51_AUDMUX_PORT6		5
 #define MX51_AUDMUX_PORT7		6
 
+/* TFSEL/TCSEL/RFSEL/RCSEL can be sourced from Rx/Tx clocks on i.MX51/53/6Q */
+#define IMX_AUDMUX_RXFS			0x8
+#define IMX_AUDMUX_RXCLK		0x8
+
 /* Register definitions for the i.MX21/27 Digital Audio Multiplexer */
 #define IMX_AUDMUX_V1_PCR_INMMASK(x)	((x) & 0xff)
 #define IMX_AUDMUX_V1_PCR_INMEN		(1 << 8)
-- 
2.17.0
