From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 5/5] staging: max98927: Removed an obsolete variable
Date: Thu, 18 May 2017 20:02:13 -0700
Message-ID: <1495162933-21663-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 sound/soc/codecs/max98927.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index 3069a09..3551e7d 100644
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -263,7 +263,6 @@
 struct max98927_priv {
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
-	struct max98927_pdata *pdata;
 	unsigned int spk_gain;
 	unsigned int sysclk;
 	unsigned int v_l_slot;
-- 
2.7.4
