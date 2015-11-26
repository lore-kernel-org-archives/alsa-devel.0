From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v2 6/6] ASoC: fsl_ssi: Fix channel slipping on
	capture (or playback) restart in full duplex.
Date: Thu, 26 Nov 2015 16:05:41 +0100
Message-ID: <1448550341-11765-7-git-send-email-arnaud.mouiche@invoxia.com>
References: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 355D7261A8C
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 16:06:15 +0100 (CET)
Received: by wmec201 with SMTP id c201so35188306wme.0
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 07:06:15 -0800 (PST)
In-Reply-To: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>, Roberto Fichera <kernel@tekno-soft.it>, Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

Happened when the Playback (or Capture) is running continuously
and Capture (or Playback) is restarted (xrun, manual stop/start...)

Since the RX (or TX) FIFO are only reset when the whole SSI is disabled,
pending samples from previous capture (or playback) session may still
be present. They must be erased to not introduce channel slipping.

FIFO Clear register fields are documented in IMX51, IMX35 reference manual.
They are not documented in IMX50 or IMX6 RM, despite they are
working as expected on IMX6SL.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
---
 sound/soc/fsl/fsl_ssi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9d5c677..0fd548e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -404,6 +404,22 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 * (online configuration)
 	 */
 	if (enable) {
+		/*
+		 * Clear RX or TX FIFO to remove samples from the previous
+		 * stream session which may be still present in the FIFO and
+		 * may introduce bad samples and/or channel slipping.
+		 *
+		 * Note: The SOR is not documented in recent IMX datasheet, but
+		 * is described in IMX51 reference manual at section 56.3.3.15.
+		 */
+		if (vals->scr & CCSR_SSI_SCR_RE) {
+			regmap_update_bits(regs, CCSR_SSI_SOR,
+				CCSR_SSI_SOR_RX_CLR, CCSR_SSI_SOR_RX_CLR);
+		} else {
+			regmap_update_bits(regs, CCSR_SSI_SOR,
+				CCSR_SSI_SOR_TX_CLR, CCSR_SSI_SOR_TX_CLR);
+		}
+
 		regmap_update_bits(regs, CCSR_SSI_SRCR, vals->srcr, vals->srcr);
 		regmap_update_bits(regs, CCSR_SSI_STCR, vals->stcr, vals->stcr);
 		regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
-- 
1.9.1
