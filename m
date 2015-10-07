From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/2] ASoC: da7219: Use of_match_ptr() when assigning match
 table
Date: Wed, 7 Oct 2015 11:57:12 +0100
Message-ID: <0ba5a5ba6765f9f9d520a604ffd06dcb61a68822.1444214947.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1444214947.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444214947.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Use of_match_ptr() to handle non-DT kernel scenario where match
table should be NULL.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index c86a833..adcc079 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1932,7 +1932,7 @@ MODULE_DEVICE_TABLE(i2c, da7219_i2c_id);
 static struct i2c_driver da7219_i2c_driver = {
 	.driver = {
 		.name = "da7219",
-		.of_match_table = da7219_of_match,
+		.of_match_table = of_match_ptr(da7219_of_match),
 	},
 	.probe		= da7219_i2c_probe,
 	.remove		= da7219_i2c_remove,
-- 
1.9.3
