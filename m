From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 1/8] ASoC: fsl-ssi: Move ac97 specific setup to
	seperate function
Date: Wed, 20 Nov 2013 10:04:15 +0100
Message-ID: <1384938262-20554-2-git-send-email-mpa@pengutronix.de>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 69DA0264FEE
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 10:04:52 +0100 (CET)
In-Reply-To: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This is a pure cleanup patch to increase code readability.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 57 +++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 35e2773..fb8f52a 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -321,6 +321,36 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	return ret;
 }
 
+static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
+{
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+
+	/*
+	 * Setup the clock control register
+	 */
+	write_ssi(CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13),
+			&ssi->stccr);
+	write_ssi(CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13),
+			&ssi->srccr);
+
+	/*
+	 * Enable AC97 mode and startup the SSI
+	 */
+	write_ssi(CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV,
+			&ssi->sacnt);
+	write_ssi(0xff, &ssi->saccdis);
+	write_ssi(0x300, &ssi->saccen);
+
+	/*
+	 * Enable SSI, Transmit and Receive. AC97 has to communicate with the
+	 * codec before a stream is started.
+	 */
+	write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN |
+			CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
+
+	write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
+}
+
 static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 {
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
@@ -387,31 +417,8 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 	 * because it is also running without an active substream. Normally SSI
 	 * is only enabled when there is a substream.
 	 */
-	if (ssi_private->imx_ac97) {
-		/*
-		 * Setup the clock control register
-		 */
-		write_ssi(CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13),
-				&ssi->stccr);
-		write_ssi(CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13),
-				&ssi->srccr);
-
-		/*
-		 * Enable AC97 mode and startup the SSI
-		 */
-		write_ssi(CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV,
-				&ssi->sacnt);
-		write_ssi(0xff, &ssi->saccdis);
-		write_ssi(0x300, &ssi->saccen);
-
-		/*
-		 * Enable SSI, Transmit and Receive
-		 */
-		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN |
-				CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
-
-		write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
-	}
+	if (ssi_private->imx_ac97)
+		fsl_ssi_setup_ac97(ssi_private);
 
 	return 0;
 }
-- 
1.8.4.2
