From: <bardliao@realtek.com>
Subject: [PATCH 2/3] ASoC: RT286: check ID in i2c level
Date: Mon, 7 Jul 2014 16:48:37 +0800
Message-ID: <1404722918-17466-2-git-send-email-bardliao@realtek.com>
References: <1404722918-17466-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 770CC265589
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 10:49:25 +0200 (CEST)
In-Reply-To: <1404722918-17466-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

Move ID check from asoc level to i2c level.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 7c5f9d0..53eb7f3 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -952,14 +952,6 @@ static int rt286_probe(struct snd_soc_codec *codec)
 	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
 	int i, ret;
 
-	ret = snd_soc_read(codec,
-		RT286_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID));
-	if (ret != RT286_VENDOR_ID) {
-		dev_err(codec->dev,
-			"Device with ID register %x is not rt286\n", ret);
-		return -ENODEV;
-	}
-
 	snd_soc_write(codec, RT286_SET_AUDIO_POWER, AC_PWRST_D3);
 
 	for (i = 0; i < RT286_POWER_REG_LEN; i++)
@@ -1164,6 +1156,14 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	regmap_read(rt286->regmap,
+		RT286_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &ret);
+	if (ret != RT286_VENDOR_ID) {
+		dev_err(&i2c->dev,
+			"Device with ID register %x is not rt286\n", ret);
+		return -ENODEV;
+	}
+
 	rt286->index_cache = rt286_index_def;
 	rt286->i2c = i2c;
 	i2c_set_clientdata(i2c, rt286);
-- 
1.8.1.1.439.g50a6b54
