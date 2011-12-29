From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 13/14] ASoC: Convert tlv320dac33 to
	devm_kzalloc()
Date: Thu, 29 Dec 2011 12:11:00 +0800
Message-ID: <1325131860.19977.18.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CA4824657
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:11:06 +0100 (CET)
Received: by ghbz2 with SMTP id z2so2952906ghb.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:11:06 -0800 (PST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320dac33.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index c7a61fb..f0aad26 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1532,7 +1532,8 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	}
 	pdata = client->dev.platform_data;
 
-	dac33 = kzalloc(sizeof(struct tlv320dac33_priv), GFP_KERNEL);
+	dac33 = devm_kzalloc(&client->dev, sizeof(struct tlv320dac33_priv),
+			     GFP_KERNEL);
 	if (dac33 == NULL)
 		return -ENOMEM;
 
@@ -1587,7 +1588,6 @@ err_get:
 	if (dac33->power_gpio >= 0)
 		gpio_free(dac33->power_gpio);
 err_gpio:
-	kfree(dac33);
 	return ret;
 }
 
@@ -1604,8 +1604,6 @@ static int __devexit dac33_i2c_remove(struct i2c_client *client)
 	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
 
 	snd_soc_unregister_codec(&client->dev);
-	kfree(dac33);
-
 	return 0;
 }
 
-- 
1.7.5.4
