From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v2 5/6] ASoC: fsl_ssi: Fix channel slipping in
	Playback at startup
Date: Thu, 26 Nov 2015 16:05:40 +0100
Message-ID: <1448550341-11765-6-git-send-email-arnaud.mouiche@invoxia.com>
References: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 87AF12606F6
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 16:06:14 +0100 (CET)
Received: by wmec201 with SMTP id c201so25968209wme.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 07:06:14 -0800 (PST)
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

Previously, SCR.SSIEN and SCR.TE were enabled at once if no capture
stream was also running.
This may not give a chance for the DMA to write the first sample in
TX FIFO before the streaming starts on the PCM bus, inserting void
samples first.
Those void samples are then responsible for slipping the channels.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
---
 sound/soc/fsl/fsl_ssi.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 78ea6e1..9d5c677 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -436,8 +436,40 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 
 config_done:
 	/* Enabling of subunits is done after configuration */
-	if (enable)
+	if (enable) {
+		if (ssi_private->use_dma && (vals->scr & CCSR_SSI_SCR_TE)) {
+			/*
+			 * Be sure the Tx FIFO is filled when TE is set.
+			 * Otherwise, there are some chances to start the
+			 * playback with some void samples inserted first,
+			 * generating a channel slip.
+			 *
+			 * First, SSIEN must be set, to let the FIFO be filled.
+			 *
+			 * Notes:
+			 * - Limit this fix to the DMA case until FIQ cases can
+			 *   be tested.
+			 * - Limit the length of the busy loop to not lock the
+			 *   system too long, even if 1-2 loops are sufficient
+			 *   in general.
+			 */
+			int i;
+			int max_loop = 100;
+			regmap_update_bits(regs, CCSR_SSI_SCR,
+					CCSR_SSI_SCR_SSIEN, CCSR_SSI_SCR_SSIEN);
+			for (i = 0; i < max_loop; i++) {
+				u32 sfcsr;
+				regmap_read(regs, CCSR_SSI_SFCSR, &sfcsr);
+				if (CCSR_SSI_SFCSR_TFCNT0(sfcsr))
+					break;
+			}
+			if (i == max_loop) {
+				dev_err(ssi_private->dev,
+					"Timeout waiting TX FIFO filling\n");
+			}
+		}
 		regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
+	}
 }
 
 
-- 
1.9.1
