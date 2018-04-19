From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: rt5668: fix incorrect 'and' operator
Date: Thu, 19 Apr 2018 15:34:31 +0100
Message-ID: <20180419143431.13173-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Currently logical and is being used instead of bitwise and. Fix this.

Detected by CoverityScan, CID#1468008 ("Logical vs bitwise operator")

Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/rt5668.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 52a343f96eb2..3c19d03f2446 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -1194,7 +1194,7 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 	int ref, val, reg, idx = -EINVAL;
 	static const int div[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48};
 
-	val = snd_soc_component_read32(component, RT5668_GPIO_CTRL_1) &&
+	val = snd_soc_component_read32(component, RT5668_GPIO_CTRL_1) &
 		RT5668_GP4_PIN_MASK;
 	if (w->shift == RT5668_PWR_ADC_S1F_BIT &&
 		val == RT5668_GP4_PIN_ADCDAT2)
-- 
2.17.0
