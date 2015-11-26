From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v2 4/6] ASoC: fsl_ssi: Fix samples being
	dropped as Playback startup
Date: Thu, 26 Nov 2015 16:05:39 +0100
Message-ID: <1448550341-11765-5-git-send-email-arnaud.mouiche@invoxia.com>
References: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id A6CAA261A7C
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 16:06:13 +0100 (CET)
Received: by wmvv187 with SMTP id v187so35376830wmv.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 07:06:13 -0800 (PST)
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

If the capture is already running while playback is started, it is highly
probable (>80% in a 8 channels scenario) that samples are lost between
the DMA and TX fifo.

The reason is that SIER.TDMAE is set before STCR.TFEN0, leaving a time
window where the FIFO doesn't receive the samples written by the DMA.

This particular case happened only if capture is already enabled as
SCR.SSIEN is already set at the playback startup instant.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 243c9af..78ea6e1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -404,9 +404,9 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 * (online configuration)
 	 */
 	if (enable) {
-		regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
 		regmap_update_bits(regs, CCSR_SSI_SRCR, vals->srcr, vals->srcr);
 		regmap_update_bits(regs, CCSR_SSI_STCR, vals->stcr, vals->stcr);
+		regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
 	} else {
 		u32 sier;
 		u32 srcr;
-- 
1.9.1
