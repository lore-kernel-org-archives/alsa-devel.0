From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: rt5665: remove redundant assignment to variable idx
Date: Fri,  5 Jul 2019 08:53:03 +0100
Message-ID: <20190705075303.14692-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The variable idx is being initialized with a value that is never
read and it is being updated later with a new value. The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/rt5665.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 87263317085a..c050d84a6916 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1478,7 +1478,7 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct rt5665_priv *rt5665 = snd_soc_component_get_drvdata(component);
-	int pd, idx = -EINVAL;
+	int pd, idx;
 
 	pd = rl6231_get_pre_div(rt5665->regmap,
 		RT5665_ADDA_CLK_1, RT5665_I2S_PD1_SFT);
-- 
2.20.1
