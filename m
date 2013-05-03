From: Marek Belisko <marek.belisko@gmail.com>
Subject: [PATCH] ASoC: McASP: Fix receive clock polarity in DAIFMT_NB_NF mode.
Date: Fri,  3 May 2013 07:37:36 +0200
Message-ID: <1367559456-20208-1-git-send-email-marek.belisko@streamunlimited.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: zonque@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Marek Belisko <marek.belisko@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org

According documentation bit ACLKRPOL is set to 0 (receiver samples data
on falling edge) and when set to 1 (receiver samples data on rising edge).

I2S data are always sampled on falling edge and valid during rising edge
of bit clock. So in case of capture data transmitter sample data on falling
edge and macsp must read then on rising edge.

Signed-off-by: Marek Belisko <marek.belisko@streamunlimited.com>
---
 sound/soc/davinci/davinci-mcasp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 849a187..c46112e 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -568,7 +568,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_set_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
 		mcasp_clr_bits(base + DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
 
-		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
 		mcasp_clr_bits(base + DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
 		break;
 
-- 
1.7.9.5
