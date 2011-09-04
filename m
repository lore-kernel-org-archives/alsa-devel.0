From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: codecs: Remove unused mutex
Date: Sun, 04 Sep 2011 20:52:31 +0800
Message-ID: <1315140751.8673.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/alc5623.c |    2 --
 sound/soc/codecs/wm9090.c  |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index eecffb5..0517315 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -41,7 +41,6 @@ MODULE_PARM_DESC(caps_charge, "ALC5623 cap charge time (msecs)");
 struct alc5623_priv {
 	enum snd_soc_control_type control_type;
 	void *control_data;
-	struct mutex mutex;
 	u8 id;
 	unsigned int sysclk;
 	u16 reg_cache[ALC5623_VENDOR_ID2+2];
@@ -1052,7 +1051,6 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, alc5623);
 	alc5623->control_data = client;
 	alc5623->control_type = SND_SOC_I2C;
-	mutex_init(&alc5623->mutex);
 
 	ret =  snd_soc_register_codec(&client->dev,
 		&soc_codec_device_alc5623, &alc5623_dai, 1);
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 4de1220..f2f3077 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -139,7 +139,6 @@ static const u16 wm9090_reg_defaults[] = {
 
 /* This struct is used to save the context */
 struct wm9090_priv {
-	struct mutex mutex;
 	struct wm9090_platform_data pdata;
 	void *control_data;
 };
@@ -663,7 +662,6 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm9090);
 	wm9090->control_data = i2c;
-	mutex_init(&wm9090->mutex);
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm9090,  NULL, 0);
-- 
1.7.4.1
