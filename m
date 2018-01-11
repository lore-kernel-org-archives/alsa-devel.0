From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2 01/16] ASoC: fsl_ssi: Keep ssi->i2s_net
	updated
Date: Wed, 10 Jan 2018 22:43:00 -0800
Message-ID: <1515652995-15996-2-git-send-email-nicoleotsuka@gmail.com>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id C180F266E70
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 07:44:05 +0100 (CET)
Received: by mail-pf0-f195.google.com with SMTP id u19so875200pfa.12
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 22:44:05 -0800 (PST)
In-Reply-To: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org, broonie@kernel.org, mail@maciej.szmigiero.name
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
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
index aecd00f..c8bd353 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -834,16 +834,16 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
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
