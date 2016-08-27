From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 1/4] ASoC: dapm: Fix possible uninitialized variable in snd_soc_dapm_get_volsw()
Date: Sat, 27 Aug 2016 19:27:58 +0800
Message-ID: <20160827112801.31010-2-wens@csie.org>
References: <20160827112801.31010-1-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160827112801.31010-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If soc_dapm_read() fails, val will be uninitialized, and bogus values
will be written later:

	ret = soc_dapm_read(dapm, reg, &val);
	val = (val >> shift) & mask;

However, the compiler does not give a warning. Return on error before
val is really used to avoid this.

This is similar to the commit 6912831623c5 ("ASoC: dapm: Fix
uninitialized variable in snd_soc_dapm_get_enum_double()")

Fixes: ce0fc93ae56e ("ASoC: Add DAPM support at the component level")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/soc-dapm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8698c26773b3..0b442fee0b62 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3049,6 +3049,9 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	}
 	mutex_unlock(&card->dapm_mutex);
 
+	if (ret)
+		return ret;
+
 	if (invert)
 		ucontrol->value.integer.value[0] = max - val;
 	else
-- 
2.9.3
