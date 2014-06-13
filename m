From: Shahina Shaik <shahina.s@samsung.com>
Subject: [PATCH 4/4] Sound: tlv320aic31xx: Fixed Coding Style Issues
Date: Fri, 13 Jun 2014 11:56:54 +0530
Message-ID: <1402640814-7037-1-git-send-email-shahina.s@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Shahina Shaik <sharab.shaik@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Shahina Shaik <sharab.shaik@gmail.com>

Fixed coding style issues of "Missing Blank line after declaration"
Signed-off-by: Shahina Shaik <sharab.shaik@gmail.com>
---
 sound/soc/codecs/tlv320aic31xx.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 2341910..a9c4a8b 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -329,6 +329,7 @@ static int aic31xx_wait_bits(struct aic31xx_priv *aic31xx, unsigned int reg,
 	unsigned int bits;
 	int counter = count;
 	int ret = regmap_read(aic31xx->regmap, reg, &bits);
+
 	while ((bits & mask) != wbits && counter && !ret) {
 		usleep_range(sleep, sleep * 2);
 		ret = regmap_read(aic31xx->regmap, reg, &bits);
@@ -435,6 +436,7 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
+
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		/* change mic bias voltage to user defined */
-- 
1.7.9.5
