From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/6] ASoC: Remove unused "control_data" field of struct
 wm8978_priv
Date: Tue, 27 Sep 2011 20:43:24 +0800
Message-ID: <1317127404.7207.6.camel@phoenix>
References: <1317127128.7207.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317127128.7207.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The control_data field is used to initialize the codec's control_data field,
but since this is also done by the snd-soc-cache core, the redundant
assignment can be removed and the field can be dropped.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8978.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 85e3e63..41ca4d9 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -52,7 +52,6 @@ static const u16 wm8978_reg[WM8978_CACHEREGNUM] = {
 /* codec private data */
 struct wm8978_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	unsigned int f_pllout;
 	unsigned int f_mclk;
 	unsigned int f_256fs;
@@ -955,7 +954,6 @@ static int wm8978_probe(struct snd_soc_codec *codec)
 	 * default hardware setting
 	 */
 	wm8978->sysclk = WM8978_PLL;
-	codec->control_data = wm8978->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
@@ -1016,7 +1014,6 @@ static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8978);
-	wm8978->control_data = i2c;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8978, &wm8978_dai, 1);
-- 
1.7.4.1
