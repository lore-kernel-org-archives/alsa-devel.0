From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Fix channel swap on playback
	start
Date: Fri, 31 Mar 2017 19:15:03 -0300
Message-ID: <1490998503-1191-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id C92DB2668F6
 for <alsa-devel@alsa-project.org>; Sat,  1 Apr 2017 00:15:22 +0200 (CEST)
Received: by mail-qt0-f196.google.com with SMTP id n37so11981198qtb.3
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:15:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, arnaud.mouiche@invoxia.com, timur@tabi.org, caleb@crome.org, nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, max.krummenacher@toradex.com, mpa@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit f8fdf5375e2005f2 ("ASoC: fsl-ssi: add SSIEN errata work around")
implemented  the workaround for the following erratum found on i.MX35
errata document:

ENGcm06222: SSI:Transmission does not take place in bit length early
frame sync configuration

and also for ENGcm06222 from the same document.

However it has been only applied for AC97 mode. Apply it to I2S mode
as well so that it can fix audio channel swap during playback start.

The channel swap can be noticed in about 10% of the times an audio track
starts.

With the recommended workaround in place no more channel swap
happened after running audio start/stop sequence in more than
2000 times.

Tested on a mx6dl-wandboard.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl_ssi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fde08660..17f92b8 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -93,6 +93,9 @@
 		CCSR_SSI_SIER_TLS_EN | CCSR_SSI_SIER_TFS_EN | \
 		CCSR_SSI_SIER_TUE0_EN | CCSR_SSI_SIER_TFRC_EN)
 
+#define FSLSSI_SSIEN_WORKAROUND (CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | \
+				 CCSR_SSI_SCR_RE)
+
 enum fsl_ssi_type {
 	FSL_SSI_MCP8610,
 	FSL_SSI_MX21,
@@ -559,7 +562,8 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 			int i;
 			int max_loop = 100;
 			regmap_update_bits(regs, CCSR_SSI_SCR,
-					CCSR_SSI_SCR_SSIEN, CCSR_SSI_SCR_SSIEN);
+					   FSLSSI_SSIEN_WORKAROUND,
+					   FSLSSI_SSIEN_WORKAROUND);
 			for (i = 0; i < max_loop; i++) {
 				u32 sfcsr;
 				regmap_read(regs, CCSR_SSI_SFCSR, &sfcsr);
@@ -650,8 +654,7 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
 	 * codec before a stream is started.
 	 */
 	regmap_update_bits(regs, CCSR_SSI_SCR,
-			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
-			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
+			   FSLSSI_SSIEN_WORKAROUND, FSLSSI_SSIEN_WORKAROUND);
 
 	regmap_write(regs, CCSR_SSI_SOR, CCSR_SSI_SOR_WAIT(3));
 }
-- 
2.7.4
