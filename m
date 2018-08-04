From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 09/12] ASoC: da7213: use true and false for boolean values
Date: Sat, 4 Aug 2018 16:54:10 -0500
Message-ID: <054adeac54eba2831e2433d71f385841034faf52.1533418275.git.gustavo@embeddedor.com>
References: <cover.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533418275.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org
Cc: Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/da7213.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 54cb5f2..92d006a 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1140,9 +1140,9 @@ static bool da7213_volatile_register(struct device *dev, unsigned int reg)
 	case DA7213_ALC_OFFSET_AUTO_M_R:
 	case DA7213_ALC_OFFSET_AUTO_U_R:
 	case DA7213_ALC_CIC_OP_LVL_DATA:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
2.7.4
