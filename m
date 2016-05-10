From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 5/5] ASoC: da7213: Allow PLL disable/bypass when using 32KHz
 sysclk
Date: Tue, 10 May 2016 16:11:08 +0100
Message-ID: <4af28c42abc15713e6746ea39d82869f98ddf771.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Current checking for PLL 32KHz mode fails in driver code when
bypassing the PLL. This is due to an incorrect check of PLL
source type when 32KHz clock is provided. Removal of this check
resolves the issue.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7213.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index a233fe7..e5527bc 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1342,7 +1342,7 @@ static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	pll_ctrl = 0;
 
 	/* Workout input divider based on MCLK rate */
-	if ((da7213->mclk_rate == 32768) && (source == DA7213_SYSCLK_PLL)) {
+	if (da7213->mclk_rate == 32768) {
 		/* 32KHz PLL Mode */
 		indiv_bits = DA7213_PLL_INDIV_9_TO_18_MHZ;
 		indiv = DA7213_PLL_INDIV_9_TO_18_MHZ_VAL;
-- 
1.9.3
