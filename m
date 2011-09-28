From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 6/6] ASoC: Remove unused "control_data" field of struct
 max98095_priv
Date: Wed, 28 Sep 2011 10:14:05 +0800
Message-ID: <1317176045.14102.9.camel@phoenix>
References: <1317175218.14102.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317175218.14102.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Peter Hsiang <peter.hsiang@maxim-ic.com>
List-Id: alsa-devel@alsa-project.org

The control_data field is used to initialize the codec's control_data field,
but since this is also done by the snd-soc-cache core, the redundant
assignment can be removed and the field can be dropped.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/max98095.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 668434d..8f8e255 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -40,7 +40,6 @@ struct max98095_cdata {
 
 struct max98095_priv {
 	enum max98095_type devtype;
-	void *control_data;
 	struct max98095_pdata *pdata;
 	unsigned int sysclk;
 	struct max98095_cdata dai[3];
@@ -2337,7 +2336,6 @@ static int max98095_i2c_probe(struct i2c_client *i2c,
 
 	max98095->devtype = id->driver_data;
 	i2c_set_clientdata(i2c, max98095);
-	max98095->control_data = i2c;
 	max98095->pdata = i2c->dev.platform_data;
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98095,
-- 
1.7.4.1
