From: Jesse Chan <jc@linux.com>
Subject: [PATCH] ASoC: pcm512x-spi: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Sun, 19 Nov 2017 22:05:16 -0800
Message-ID: <20171120060517.7083-1-jc@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jesse Chan <jc@linux.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jesse Chan <jc@linux.com>
---
 sound/soc/codecs/pcm512x-spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/pcm512x-spi.c b/sound/soc/codecs/pcm512x-spi.c
index 25c63510ae15..7cdd2dc4fd79 100644
--- a/sound/soc/codecs/pcm512x-spi.c
+++ b/sound/soc/codecs/pcm512x-spi.c
@@ -70,3 +70,7 @@ static struct spi_driver pcm512x_spi_driver = {
 };
 
 module_spi_driver(pcm512x_spi_driver);
+
+MODULE_DESCRIPTION("ASoC PCM512x codec driver - SPI");
+MODULE_AUTHOR("Mark Brown <broonie@kernel.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1
