From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v3 5/6] ASoC: fsl_ssi: Fix channel slipping in
	Playback at startup
Date: Mon, 18 Jan 2016 16:26:10 +0100
Message-ID: <1453130771-24419-6-git-send-email-arnaud.mouiche@invoxia.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 07577265104
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 16:26:49 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id n5so69398615wmn.0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 07:26:49 -0800 (PST)
In-Reply-To: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Caleb Crome <caleb@crome.org>
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
index c9ba8ca..530d592 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -520,8 +520,40 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 
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
