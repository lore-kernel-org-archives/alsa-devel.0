From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v2 7/12] wm8940: fix a memory leak if wm8940_register
	return error
Date: Thu, 15 Jul 2010 15:48:48 +0800
Message-ID: <1279180128.8410.5.camel@mola>
References: <1279162147.29294.2.camel@mola> <1279162893.29294.20.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279162893.29294.20.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch adds checking for wm8940_register return value,
and does kfree(wm8940) if wm8940_register() fail.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8940.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index e3c4bbf..f0c1113 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -845,6 +845,7 @@ static void wm8940_unregister(struct wm8940_priv *wm8940)
 static int wm8940_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
+	int ret;
 	struct wm8940_priv *wm8940;
 	struct snd_soc_codec *codec;
 
@@ -858,7 +859,11 @@ static int wm8940_i2c_probe(struct i2c_client *i2c,
 	codec->control_data = i2c;
 	codec->dev = &i2c->dev;
 
-	return wm8940_register(wm8940, SND_SOC_I2C);
+	ret = wm8940_register(wm8940, SND_SOC_I2C);
+	if (ret < 0)
+		kfree(wm8940);
+
+	return ret;
 }
 
 static int __devexit wm8940_i2c_remove(struct i2c_client *client)
-- 
1.5.4.3
