From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v4 4/6] ASoC: fsl_ssi: Fix samples being
	dropped at Playback startup
Date: Tue,  3 May 2016 14:13:58 +0200
Message-ID: <1462277640-20052-5-git-send-email-arnaud.mouiche@invoxia.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CDD5265CA5
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 14:14:14 +0200 (CEST)
Received: by mail-wm0-f46.google.com with SMTP id n129so144261973wmn.1
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2016 05:14:14 -0700 (PDT)
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
index 695f041..3917741 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -476,9 +476,9 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
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
