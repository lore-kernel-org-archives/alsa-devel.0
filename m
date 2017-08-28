From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 5/9] ASoC: max98927: Removed obsolete variables
Date: Mon, 28 Aug 2017 16:30:57 -0700
Message-ID: <1503963061-14763-5-git-send-email-ryans.lee@maximintegrated.com>
References: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 sound/soc/codecs/max98927.h | 4 ----
 1 file changed, 4 deletions(-)
 mode change 100644 => 100755 sound/soc/codecs/max98927.h

diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
old mode 100644
new mode 100755
index 3069a09..30cc40a
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -263,16 +263,12 @@
 struct max98927_priv {
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
-	struct max98927_pdata *pdata;
-	unsigned int spk_gain;
 	unsigned int sysclk;
 	unsigned int v_l_slot;
 	unsigned int i_l_slot;
 	bool interleave_mode;
 	unsigned int ch_size;
-	unsigned int rate;
 	unsigned int iface;
 	unsigned int master;
-	unsigned int digital_gain;
 };
 #endif
-- 
1.9.1
