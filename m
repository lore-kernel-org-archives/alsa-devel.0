From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v5 17/17] ASoC: fsl_ssi: Use ssi->streams instead of reading register
Date: Tue, 16 Jan 2018 22:51:42 -0800
Message-ID: <1516171902-32669-18-git-send-email-nicoleotsuka@gmail.com>
References: <1516171902-32669-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516171902-32669-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@tabi.org, broonie@kernel.org, mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Since ssi->streams is being updated along with SCR register and
its SSIEN bit, it's simpler to use it instead.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index a8a040d..c6c1b07 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -803,11 +803,6 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	unsigned int sample_size = params_width(hw_params);
 	u32 wl = SSI_SxCCR_WL(sample_size);
 	int ret;
-	u32 scr;
-	int enabled;
-
-	regmap_read(regs, REG_SSI_SCR, &scr);
-	enabled = scr & SSI_SCR_SSIEN;
 
 	/*
 	 * SSI is properly configured if it is enabled and running in
@@ -815,7 +810,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	 * that should set separate configurations for STCCR and SRCCR
 	 * despite running in the synchronous mode.
 	 */
-	if (enabled && ssi->synchronous)
+	if (ssi->streams && ssi->synchronous)
 		return 0;
 
 	if (fsl_ssi_is_i2s_master(ssi)) {
-- 
2.7.4
