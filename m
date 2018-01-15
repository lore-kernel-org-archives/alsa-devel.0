From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v3 02/17] ASoC: fsl_ssi: Keep ssi->i2s_net updated
Date: Sun, 14 Jan 2018 20:21:12 -0800
Message-ID: <1515990087-11598-3-git-send-email-nicoleotsuka@gmail.com>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@tabi.org, broonie@kernel.org, mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

The hw_params() overwrites i2s_net settings for special cases like
mono-channel support, however, it doesn't update ssi->i2s_net as
set_dai_fmt() does.

This patch removes the local i2s_net variable and directly updates
ssi->i2s_net in the hw_params() so that the driver can simply look
up the ssi->i2s_net instead of reading the register.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 001e453..9847a1d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -838,16 +838,16 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (!fsl_ssi_is_ac97(ssi)) {
-		u8 i2s_net;
 		/* Normal + Network mode to send 16-bit data in 32-bit frames */
 		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
-			i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
-		else
-			i2s_net = ssi->i2s_net;
+			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
+
+		/* Use Normal mode to send mono data at 1st slot of 2 slots */
+		if (channels == 1)
+			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL;
 
 		regmap_update_bits(regs, REG_SSI_SCR,
-				   SSI_SCR_I2S_NET_MASK,
-				   channels == 1 ? 0 : i2s_net);
+				   SSI_SCR_I2S_NET_MASK, ssi->i2s_net);
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
-- 
2.7.4
