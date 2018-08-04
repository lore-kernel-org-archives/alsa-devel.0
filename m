From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 07/12] ASoC: da7219: use true and false for boolean values
Date: Sat, 4 Aug 2018 16:53:10 -0500
Message-ID: <aa152e8c761cf717f221fd04642efef48142f7f5.1533418275.git.gustavo@embeddedor.com>
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
 sound/soc/codecs/da7219.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 980a6a8..c0144f2 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2143,9 +2143,9 @@ static bool da7219_volatile_register(struct device *dev, unsigned int reg)
 	case DA7219_ACCDET_IRQ_EVENT_B:
 	case DA7219_ACCDET_CONFIG_8:
 	case DA7219_SYSTEM_STATUS:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
2.7.4
