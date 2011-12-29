From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 04/14] ASoC: Convert max98088 to devm_kzalloc()
Date: Thu, 29 Dec 2011 12:01:07 +0800
Message-ID: <1325131267.19977.7.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DA0C24641
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:01:13 +0100 (CET)
Received: by yenr11 with SMTP id r11so3917333yen.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:01:12 -0800 (PST)
In-Reply-To: <1325130983.19977.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Hsiang <peter.hsiang@maxim-ic.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/max98088.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index ba4f6f1..006efcf 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -2069,7 +2069,8 @@ static int max98088_i2c_probe(struct i2c_client *i2c,
        struct max98088_priv *max98088;
        int ret;
 
-       max98088 = kzalloc(sizeof(struct max98088_priv), GFP_KERNEL);
+       max98088 = devm_kzalloc(&i2c->dev, sizeof(struct max98088_priv),
+			       GFP_KERNEL);
        if (max98088 == NULL)
                return -ENOMEM;
 
@@ -2080,15 +2081,12 @@ static int max98088_i2c_probe(struct i2c_client *i2c,
 
        ret = snd_soc_register_codec(&i2c->dev,
                        &soc_codec_dev_max98088, &max98088_dai[0], 2);
-       if (ret < 0)
-               kfree(max98088);
        return ret;
 }
 
 static int __devexit max98088_i2c_remove(struct i2c_client *client)
 {
        snd_soc_unregister_codec(&client->dev);
-       kfree(i2c_get_clientdata(client));
        return 0;
 }
 
-- 
1.7.5.4
