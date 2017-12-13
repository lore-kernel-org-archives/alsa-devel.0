From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v3 08/11] ASoC: fsl_ssi: Rename scr_val to scr
Date: Wed, 13 Dec 2017 15:18:25 -0800
Message-ID: <1513207108-30430-9-git-send-email-nicoleotsuka@gmail.com>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org, mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Simplify the variable name. This reduces one over-80-character line.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 83d6e3d..08258c4 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -448,12 +448,12 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_reg_val *avals;
 	int nr_active_streams;
-	u32 scr_val;
+	u32 scr;
 	int keep_active;
 
-	regmap_read(regs, REG_SSI_SCR, &scr_val);
+	regmap_read(regs, REG_SSI_SCR, &scr);
 
-	nr_active_streams = !!(scr_val & SSI_SCR_TE) + !!(scr_val & SSI_SCR_RE);
+	nr_active_streams = !!(scr & SSI_SCR_TE) + !!(scr & SSI_SCR_RE);
 
 	if (nr_active_streams - 1 > 0)
 		keep_active = 1;
@@ -795,11 +795,11 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	unsigned int sample_size = params_width(hw_params);
 	u32 wl = SSI_SxCCR_WL(sample_size);
 	int ret;
-	u32 scr_val;
+	u32 scr;
 	int enabled;
 
-	regmap_read(regs, REG_SSI_SCR, &scr_val);
-	enabled = scr_val & SSI_SCR_SSIEN;
+	regmap_read(regs, REG_SSI_SCR, &scr);
+	enabled = scr & SSI_SCR_SSIEN;
 
 	/*
 	 * SSI is properly configured if it is enabled and running in
-- 
2.1.4
