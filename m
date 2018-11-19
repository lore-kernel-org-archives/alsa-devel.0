From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2] ASoC: imx-audmux: complete dt-bindings for i.MX6
Date: Mon, 19 Nov 2018 11:47:18 +0100
Message-ID: <20181119104718.18716-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Colin Didier <colin.didier@devialet.com>, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Colin Didier <colin.didier@devialet.com>

The i.MX6 audmux differs from i.MX51.

This patch adds the audmux for i.MX6 family.

Signed-off-by: Colin Didier <colin.didier@devialet.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v2:
	Repost with ASoC maintainer and list

 include/dt-bindings/sound/fsl-imx-audmux.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bindings/sound/fsl-imx-audmux.h
index 15f138bebe16..a1d0741d9ed1 100644
--- a/include/dt-bindings/sound/fsl-imx-audmux.h
+++ b/include/dt-bindings/sound/fsl-imx-audmux.h
@@ -25,6 +25,14 @@
 #define MX51_AUDMUX_PORT6		5
 #define MX51_AUDMUX_PORT7		6
 
+#define MX6_AUDMUX_PORT1_SSI1		0
+#define MX6_AUDMUX_PORT2_SSI2		1
+#define MX6_AUDMUX_PORT3		2
+#define MX6_AUDMUX_PORT4		3
+#define MX6_AUDMUX_PORT5		4
+#define MX6_AUDMUX_PORT6		5
+#define MX6_AUDMUX_PORT7_SSI3		6
+
 /*
  * TFCSEL/RFCSEL (i.MX27) or TFSEL/TCSEL/RFSEL/RCSEL (i.MX31/51/53/6Q)
  * can be sourced from Rx/Tx.
-- 
2.19.1
