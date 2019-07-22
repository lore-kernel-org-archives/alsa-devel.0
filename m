From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 08/10] ASoC: dt-bindings: Document fcomb_mode property
Date: Mon, 22 Jul 2019 15:48:31 +0300
Message-ID: <20190722124833.28757-9-daniel.baluta@nxp.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722124833.28757-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: festevam@gmail.com, perex@perex.cz, tiwai@suse.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de, l.stach@pengutronix.de, viorel.suman@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

This allows combining multiple-data-line FIFOs into a
single-data-line FIFO.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 59f4d965a5fb..ca27afd840ba 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -54,6 +54,10 @@ Optional properties:
 			  represents first data line, bit 1 represents second
 			  data line and so on. Data line is enabled if
 			  corresponding bit is set to 1.
+  - fsl,fcomb_mode	: list of two integers (first for RX, second for TX)
+			  representing FIFO combine mode. Possible values for
+			  combined mode are: 0 - disabled, 1 - Rx/Tx from shift
+			  registers, 2 - Rx/Tx by software, 3 - both.
 
 Optional properties (for mx6ul):
 
-- 
2.17.1
