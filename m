From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: rt5640: remove unused variable
Date: Tue,  8 Mar 2016 13:35:31 +0530
Message-ID: <1457424331-15639-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

We are getting build warning about:
sound/soc/codecs/rt5640.c:1892:11: warning: unused variable 'dai_sel'

The use of the variable was removed but the variable itself was not
removed.

Fixes: c467fc0e010b ("ASoC: rt5640: Set PLL src according to source")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 sound/soc/codecs/rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index af9b5f1..e8b5ba0 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1889,7 +1889,7 @@ static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 	struct rl6231_pll_code pll_code;
-	int ret, dai_sel;
+	int ret;
 
 	if (source == rt5640->pll_src && freq_in == rt5640->pll_in &&
 	    freq_out == rt5640->pll_out)
-- 
1.9.1
