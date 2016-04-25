From: "J.D. Schroeder" <Linux.HWI@garmin.com>
Subject: [PATCH] ASoC: davinci-mcasp: Fix overwriting of ahclkx
Date: Mon, 25 Apr 2016 11:08:10 -0500
Message-ID: <1461600490-19504-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, jsarha@ti.com, alsa-devel@alsa-project.org
Cc: Jim Lodes <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: alsa-devel@alsa-project.org

From: Jim Lodes <jim.lodes@garmin.com>

The mcasp davinci_mcasp_set_dai_fmt function was overriding ahclkx
input/output status that had already been set by the
davinci_mcasp_set_sysclk function. This commit removes clearing
of the ahclkx input/output status from davinci_mcasp_set_dai_fmt.

Signed-off-by: Jim Lodes <jim.lodes@garmin.com>
Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index e132498..a1197ad 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -489,7 +489,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG,
-			       ACLKX | AHCLKX | AFSX | ACLKR | AHCLKR | AFSR);
+			       ACLKX | AFSX | ACLKR | AHCLKR | AFSR);
 		mcasp->bclk_master = 0;
 		break;
 	default:
-- 
1.9.1
