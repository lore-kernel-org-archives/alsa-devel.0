From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 1/2] ASoC: imx-audmux: add RXFS/RXCLK
	defines for 6-wire connections
Date: Thu, 30 Jan 2014 10:44:17 +0100
Message-ID: <1391075058-3731-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 2661A2652F8
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 10:44:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, kernel@pengutronix.de, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

In asynchronous mode, a RxFS and RxClk connection needs to be made between
two ports. Add a define for the bit to be set in the *SEL fields.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/dt-bindings/sound/fsl-imx-audmux.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bindings/sound/fsl-imx-audmux.h
index 50b09e9..63b48f8 100644
--- a/include/dt-bindings/sound/fsl-imx-audmux.h
+++ b/include/dt-bindings/sound/fsl-imx-audmux.h
@@ -24,6 +24,10 @@
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
1.8.5.3
