From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-audmux: add RXFS/RXCLK defines for
	6-wire connections" to the asoc tree
Date: Wed, 30 May 2018 12:02:42 +0100
Message-ID: <E1fNysM-0006fs-FS@debutante>
References: <20180523094300.8780-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BAE622676D7
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 13:02:47 +0200 (CEST)
In-Reply-To: <20180523094300.8780-1-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, Marco Felsch <m.felsch@pengutronix.de>, nicoleotsuka@gmail.com, broonie@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: imx-audmux: add RXFS/RXCLK defines for 6-wire connections

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c25f2566250cc58491a489c854013aecdf75dfef Mon Sep 17 00:00:00 2001
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 23 May 2018 11:43:00 +0200
Subject: [PATCH] ASoC: imx-audmux: add RXFS/RXCLK defines for 6-wire
 connections

In asynchronous mode, a RxFS and RxClk connection needs to be made between
two ports. Add a define for the bit to be set in the *SEL fields.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
[m.felsch@pengutronix.de: fixed comment to include i.MX21 and 35]
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
