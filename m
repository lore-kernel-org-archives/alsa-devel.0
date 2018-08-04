From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 08/12] ASoC: twl6040: use true and false for boolean values
Date: Sat, 4 Aug 2018 16:53:38 -0500
Message-ID: <da84f3ed6cf3da4c5a5644df030e96d1f86af2e0.1533418275.git.gustavo@embeddedor.com>
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
 sound/soc/codecs/twl6040.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index bfd1abd..94675da 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -148,7 +148,7 @@ static bool twl6040_can_write_to_chip(struct snd_soc_component *component,
 	case TWL6040_REG_HFRCTL:
 		return priv->dl2_unmuted;
 	default:
-		return 1;
+		return true;
 	}
 }
 
-- 
2.7.4
