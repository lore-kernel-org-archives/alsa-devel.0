From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: fsl_sai: Remove expensive print in irq handler
Date: Fri, 18 Jan 2019 14:26:46 +0000
Message-ID: <20190118142623.17720-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

When stopping audio, ASoC will first stop DMA then CPU DAI.
Sometimes there is a delay between DMA stop and CPU DAI stop, which
triggers an underrun error. Now, because of the delay introduced
by dev_err another underrun error will occur causing a vicious circle
making impossible to stop CPU DAI.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 4163f2cfc06f..db9e0872f73d 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -62,10 +62,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 		dev_dbg(dev, "isr: Start of Tx word detected\n");
=20
 	if (flags & FSL_SAI_CSR_SEF)
-		dev_warn(dev, "isr: Tx Frame sync error detected\n");
+		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
=20
 	if (flags & FSL_SAI_CSR_FEF) {
-		dev_warn(dev, "isr: Transmit underrun detected\n");
+		dev_dbg(dev, "isr: Transmit underrun detected\n");
 		/* FIFO reset for safety */
 		xcsr |=3D FSL_SAI_CSR_FR;
 	}
@@ -96,10 +96,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 		dev_dbg(dev, "isr: Start of Rx word detected\n");
=20
 	if (flags & FSL_SAI_CSR_SEF)
-		dev_warn(dev, "isr: Rx Frame sync error detected\n");
+		dev_dbg(dev, "isr: Rx Frame sync error detected\n");
=20
 	if (flags & FSL_SAI_CSR_FEF) {
-		dev_warn(dev, "isr: Receive overflow detected\n");
+		dev_dbg(dev, "isr: Receive overflow detected\n");
 		/* FIFO reset for safety */
 		xcsr |=3D FSL_SAI_CSR_FR;
 	}
--=20
2.17.1
