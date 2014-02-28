From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 2/2] ASoC: io: Remove reduntant params of snd_soc_codec_set_cache_io()
Date: Fri, 28 Feb 2014 13:06:49 +0800
Message-ID: <1393564009-15968-3-git-send-email-Li.Xiubo@freescale.com>
References: <1393564009-15968-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393564009-15968-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: vinod.koul@intel.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, timur@tabi.org, mr.swami.reddy@ti.com, vishwas.a.deshpande@ti.com, fabio.estevam@freescale.com, kuninori.morimoto.gx@renesas.com, sachin.kamat@linaro.org, Adam.Thomson.Opensource@diasemi.com, dgreid@chromium.org, abrestic@chromium.org, swarren@nvidia.com, shc_work@mail.ru, s.trumtrar@pengutronix.de, bardliao@realtek.com, shawn.guo@linaro.org, LW@KARO-electronics.de, mpa@pengutronix.de, peter.ujfalusi@ti.com, Andreas.Irestal@axis.com, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com, viresh.kumar@linaro.org, axel.lin@ingics.com, alban.bedel@avionic-design.de, voice.shen@atmel.com, jic23@kernel.org, mahaijuns@gmail.com, mike.dyer@md-soft.co.uk, b42378@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.ker
List-Id: alsa-devel@alsa-project.org

Now that all users have been converted to regmap and the config.reg_bits
and config.val_bits can be setted by each user through regmap core API.
So these two params are redundant here.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 include/sound/soc.h       | 1 -
 sound/soc/codecs/wm5110.c | 2 +-
 sound/soc/codecs/wm8997.c | 2 +-
 sound/soc/soc-core.c      | 2 +-
 sound/soc/soc-io.c        | 4 ----
 5 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ecfb334..0a1d732 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -404,7 +404,6 @@ int snd_soc_codec_readable_register(struct snd_soc_codec *codec,
 int snd_soc_codec_writable_register(struct snd_soc_codec *codec,
 				    unsigned int reg);
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
-			       int addr_bits, int data_bits,
 			       enum snd_soc_control_type control);
 int snd_soc_cache_sync(struct snd_soc_codec *codec);
 int snd_soc_cache_init(struct snd_soc_codec *codec);
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 4de2bf1..9cb4257 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1590,7 +1590,7 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 	codec->control_data = priv->core.arizona->regmap;
 	priv->core.arizona->dapm = &codec->dapm;
 
-	ret = snd_soc_codec_set_cache_io(codec, 32, 16, SND_SOC_REGMAP);
+	ret = snd_soc_codec_set_cache_io(codec, SND_SOC_REGMAP);
 	if (ret != 0)
 		return ret;
 
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 4e6442c..4a36d1a 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1055,7 +1055,7 @@ static int wm8997_codec_probe(struct snd_soc_codec *codec)
 
 	codec->control_data = priv->core.arizona->regmap;
 
-	ret = snd_soc_codec_set_cache_io(codec, 32, 16, SND_SOC_REGMAP);
+	ret = snd_soc_codec_set_cache_io(codec, SND_SOC_REGMAP);
 	if (ret != 0)
 		return ret;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c159a34..e7aa681 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1139,7 +1139,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 
 	/* Set the default I/O up try regmap */
 	if (dev_get_regmap(codec->dev, NULL))
-		snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
+		snd_soc_codec_set_cache_io(codec, SND_SOC_REGMAP);
 
 	if (driver->probe) {
 		ret = driver->probe(codec);
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 18353f1..4b4f3d9 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -69,8 +69,6 @@ static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
  * snd_soc_codec_set_cache_io: Set up standard I/O functions.
  *
  * @codec: CODEC to configure.
- * @addr_bits: Number of bits of register address data.
- * @data_bits: Number of bits of data per register.
  * @control: Control bus used.
  *
  * Register formats are frequently shared between many I2C and SPI
@@ -85,7 +83,6 @@ static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
  * volatile registers.
  */
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
-			       int addr_bits, int data_bits,
 			       enum snd_soc_control_type control)
 {
 	int ret;
@@ -118,7 +115,6 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
 #else
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
-			       int addr_bits, int data_bits,
 			       enum snd_soc_control_type control)
 {
 	return -ENOTSUPP;
-- 
1.8.4
