From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: adau1701: Initialize codec->control_data before
 using it
Date: Wed, 28 Sep 2011 13:47:41 +0800
Message-ID: <1317188861.13692.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Cliff Cai <cliff.cai@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently codec->control_data is not initialized before calling
process_sigma_firmware(codec->control_data, ADAU1701_FIRMWARE).

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/adau1701.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 2758d5f..1354902 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -88,6 +88,7 @@
 
 struct adau1701 {
 	unsigned int dai_fmt;
+	void *control_data;
 };
 
 static const struct snd_kcontrol_new adau1701_controls[] = {
@@ -455,9 +456,11 @@ static struct snd_soc_dai_driver adau1701_dai = {
 
 static int adau1701_probe(struct snd_soc_codec *codec)
 {
+	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	codec->dapm.idle_bias_off = 1;
+	codec->control_data = adau1701->control_data;
 
 	ret = adau1701_load_firmware(codec);
 	if (ret)
@@ -500,6 +503,7 @@ static __devinit int adau1701_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, adau1701);
+	adau1701->control_data = client;
 	ret = snd_soc_register_codec(&client->dev, &adau1701_codec_drv,
 			&adau1701_dai, 1);
 	if (ret < 0)
-- 
1.7.4.1
