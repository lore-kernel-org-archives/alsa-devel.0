From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Subject: [PATCH] ASoC: ux500: Added */ to the next line
Date: Sat, 25 Feb 2017 21:33:22 +0200
Message-ID: <1488051202-8563-1-git-send-email-codrut.cristian.grosu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, colin.king@canonical.com, Codrut Grosu <codrut.cristian.grosu@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
---
 sound/soc/ux500/ux500_msp_dai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index b343efd..36e9bb2 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -482,7 +482,8 @@ static int ux500_msp_dai_prepare(struct snd_pcm_substream *substream,
 	if ((drvdata->fmt & SND_SOC_DAIFMT_MASTER_MASK) &&
 		(drvdata->msp->f_bitclk > 19200000)) {
 		/* If the bit-clock is higher than 19.2MHz, Vape should be
-		 * run in 100% OPP. Only when bit-clock is used (MSP master) */
+		 * run in 100% OPP. Only when bit-clock is used (MSP master)
+		 */
 		prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP,
 					"ux500-msp-i2s", 100);
 		drvdata->vape_opp_constraint = 1;
1.9.1
