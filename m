From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 2/4] ASoC: dapm: Fix value setting for _ENUM_DOUBLE MUX's second channel
Date: Sat, 27 Aug 2016 19:27:59 +0800
Message-ID: <20160827112801.31010-3-wens@csie.org>
References: <20160827112801.31010-1-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160827112801.31010-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The value for the second channel in _ENUM_DOUBLE (double channel) MUXs
is not correctly updated, due to using the wrong bit shift.

Use the correct bit shift, so both channels toggle together.

Fixes: 3727b4968453 ("ASoC: dapm: Consolidate MUXs and value MUXs")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0b442fee0b62..9be076bc14b5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3203,7 +3203,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	if (e->shift_l != e->shift_r) {
 		if (item[1] > e->items)
 			return -EINVAL;
-		val |= snd_soc_enum_item_to_val(e, item[1]) << e->shift_l;
+		val |= snd_soc_enum_item_to_val(e, item[1]) << e->shift_r;
 		mask |= e->mask << e->shift_r;
 	}
 
-- 
2.9.3
