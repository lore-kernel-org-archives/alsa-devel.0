From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/4 v2] ASoC: wm8711: Use snd_soc_update_bits for
 read-modify-write
Date: Tue, 04 Oct 2011 11:15:30 +0800
Message-ID: <1317698130.2688.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mike Arthur <linux@wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
v2: also remove unused variable 'reg'.

 sound/soc/codecs/wm8711.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 8457d3c..47c7fd5 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -364,7 +364,7 @@ static int wm8711_resume(struct snd_soc_codec *codec)
 static int wm8711_probe(struct snd_soc_codec *codec)
 {
 	struct wm8711_priv *wm8711 = snd_soc_codec_get_drvdata(codec);
-	int ret, reg;
+	int ret;
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8711->bus_type);
 	if (ret < 0) {
@@ -381,10 +381,8 @@ static int wm8711_probe(struct snd_soc_codec *codec)
 	wm8711_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the update bits */
-	reg = snd_soc_read(codec, WM8711_LOUT1V);
-	snd_soc_write(codec, WM8711_LOUT1V, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8711_ROUT1V);
-	snd_soc_write(codec, WM8711_ROUT1V, reg | 0x0100);
+	snd_soc_update_bits(codec, WM8711_LOUT1V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8711_ROUT1V, 0x0100, 0x0100);
 
 	snd_soc_add_controls(codec, wm8711_snd_controls,
 			     ARRAY_SIZE(wm8711_snd_controls));
-- 
1.7.4.1
