From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 03/12] ASoC: tda7419: use true and false for boolean values
Date: Sat, 4 Aug 2018 16:50:27 -0500
Message-ID: <416bb8bb94ce77ee42986942de717101dd78b4a4.1533418275.git.gustavo@embeddedor.com>
References: <cover.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533418275.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/tda7419.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tda7419.c b/sound/soc/codecs/tda7419.c
index 225c210..7f3b79c 100644
--- a/sound/soc/codecs/tda7419.c
+++ b/sound/soc/codecs/tda7419.c
@@ -142,9 +142,9 @@ struct tda7419_vol_control {
 static inline bool tda7419_vol_is_stereo(struct tda7419_vol_control *tvc)
 {
 	if (tvc->reg == tvc->rreg)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 static int tda7419_vol_info(struct snd_kcontrol *kcontrol,
-- 
2.7.4
