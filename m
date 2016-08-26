From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: wm8962: fix spelling mistake "mesurement" -> "measurement"
Date: Fri, 26 Aug 2016 18:52:33 +0100
Message-ID: <20160826175233.30585-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jiada Wang <jiada_wang@mentor.com>, Fabio Estevam <fabio.estevam@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, Sachin Pandhare <sachinpandhare@gmail.com>, Zidan Wang <zidan.wang@freescale.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index f3109da..97b0228 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3713,7 +3713,7 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 					    ARRAY_SIZE(wm8962_dc_measure));
 		if (ret != 0)
 			dev_err(&i2c->dev,
-				"Failed to configure for DC mesurement: %d\n",
+				"Failed to configure for DC measurement: %d\n",
 				ret);
 	}
 
-- 
2.9.3
