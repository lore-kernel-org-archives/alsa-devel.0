From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 3/3] ASoC: max98927: Removed obsolete variables
Date: Fri,  1 Sep 2017 14:35:08 -0700
Message-ID: <1504301708-24389-3-git-send-email-ryans.lee@maximintegrated.com>
References: <1504301708-24389-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504301708-24389-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Changelog:
	Removed obsolete variables that have never been referred from driver before.

 sound/soc/codecs/max98927.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index 98b5f17..d215f60 100644
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -263,17 +263,13 @@
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
 	bool tdm_mode;
 };
 #endif
-- 
1.9.1
