From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/8] ASoC: Convert wm8993 to devm_kzalloc()
Date: Wed, 14 Dec 2011 17:00:51 +0800
Message-ID: <1323853254-9020-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323853254-9020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5463243A1
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 10:01:08 +0100 (CET)
In-Reply-To: <1323853254-9020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index f472ea6..b966f69 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1613,7 +1613,8 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 	struct wm8993_priv *wm8993;
 	int ret;
 
-	wm8993 = kzalloc(sizeof(struct wm8993_priv), GFP_KERNEL);
+	wm8993 = devm_kzalloc(&i2c-dev, sizeof(struct wm8993_priv),
+			      GFP_KERNEL);
 	if (wm8993 == NULL)
 		return -ENOMEM;
 
@@ -1621,8 +1622,6 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8993, &wm8993_dai, 1);
-	if (ret < 0)
-		kfree(wm8993);
 	return ret;
 }
 
-- 
1.7.7.3
