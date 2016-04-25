From: Caleb Crome <caleb@crome.org>
Subject: [PATCH 1/1] ASoC: fsl_ssi: add CCSR_SSI_SOR to volatile register list
Date: Mon, 25 Apr 2016 10:50:24 -0700
Message-ID: <1461606624-130216-1-git-send-email-caleb@crome.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org

Due to caching, SOR wasn't written when it should have been.  This
patch simply adds SOR to the volatile list.

Signed-off-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 216e3cb..2f3bf9c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -151,6 +151,7 @@ static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
 	case CCSR_SSI_SACDAT:
 	case CCSR_SSI_SATAG:
 	case CCSR_SSI_SACCST:
+	case CCSR_SSI_SOR:
 		return true;
 	default:
 		return false;
-- 
1.9.1
