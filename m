From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v11 6/8] ASoC: fsl-ssi: add SSIEN errata work around
Date: Mon, 19 Aug 2013 17:05:59 +0200
Message-ID: <1376924761-4054-7-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

The chip errata for the i.MX35, Rev.2 has the following errata:

ENGcm06222: SSI:Transmission does not take place in bit length early frame sync
	    configuration

The workaround states, that TX_EN and SSI_EN bits should be set in the same
register write. As the next errata in the document (ENGcm06532) says to always
write RX_EN and TX_EN in the same register write in network mode.

Therefore include the whole write to
	CCSR_SSI_SCR_TE and CCSR_SSI_SCR_RE
into the write to
	CCSR_SSI_SCR_SSIEN

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 827af75..3af15e9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -424,15 +424,12 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 		write_ssi(0x300, &ssi->saccen);
 
 		/*
-		 * Enable SSI
+		 * Enable SSI, Transmit and Receive
 		 */
-		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN);
-		write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
+		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN |
+				CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
 
-		/*
-		 * Enable Transmit and Receive
-		 */
-		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
+		write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
 	}
 
 	return 0;
-- 
1.8.4.rc3
