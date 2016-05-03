From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v4 6/6] ASoC: fsl_ssi: Fix channel slipping on
	capture (or playback) restart in full duplex.
Date: Tue,  3 May 2016 14:14:00 +0200
Message-ID: <1462277640-20052-7-git-send-email-arnaud.mouiche@invoxia.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id EB7CB266564
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 14:14:17 +0200 (CEST)
Received: by mail-wm0-f53.google.com with SMTP id e201so143696943wme.0
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2016 05:14:17 -0700 (PDT)
In-Reply-To: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, festevam@gmail.com, caleb@crome.org
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

Happened when the Playback (or Capture) is running continuously
and Capture (or Playback) is restarted (xrun, manual stop/start...)

Since the RX (or TX) FIFO are only reset when the whole SSI is disabled,
pending samples from previous capture (or playback) session may still
be present. They must be erased to not introduce channel slipping.

FIFO Clear register fields are documented in IMX51, IMX35 reference manual.
They are not documented in IMX50 or IMX6 RM, despite they are
working as expected on IMX6SL and IMX6solo.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
---
 sound/soc/fsl/fsl_ssi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 6c0c72f..632ecc0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -402,6 +402,26 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi_private *ssi_private,
 }
 
 /*
+ * Clear RX or TX FIFO to remove samples from the previous
+ * stream session which may be still present in the FIFO and
+ * may introduce bad samples and/or channel slipping.
+ *
+ * Note: The SOR is not documented in recent IMX datasheet, but
+ * is described in IMX51 reference manual at section 56.3.3.15.
+ */
+static void fsl_ssi_fifo_clear(struct fsl_ssi_private *ssi_private,
+		bool is_rx)
+{
+	if (is_rx) {
+		regmap_update_bits(ssi_private->regs, CCSR_SSI_SOR,
+			CCSR_SSI_SOR_RX_CLR, CCSR_SSI_SOR_RX_CLR);
+	} else {
+		regmap_update_bits(ssi_private->regs, CCSR_SSI_SOR,
+			CCSR_SSI_SOR_TX_CLR, CCSR_SSI_SOR_TX_CLR);
+	}
+}
+
+/*
  * Calculate the bits that have to be disabled for the current stream that is
  * getting disabled. This keeps the bits enabled that are necessary for the
  * second stream to work if 'stream_active' is true.
@@ -476,6 +496,8 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 * (online configuration)
 	 */
 	if (enable) {
+		fsl_ssi_fifo_clear(ssi_private, vals->scr & CCSR_SSI_SCR_RE);
+
 		regmap_update_bits(regs, CCSR_SSI_SRCR, vals->srcr, vals->srcr);
 		regmap_update_bits(regs, CCSR_SSI_STCR, vals->stcr, vals->stcr);
 		regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
-- 
1.9.1
