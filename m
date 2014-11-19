From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/3] ASoC: rt5677: Follow the gpio naming rule
	to rename the irq function
Date: Wed, 19 Nov 2014 13:52:19 +0800
Message-ID: <1416376340-4789-2-git-send-email-oder_chiou@realtek.com>
References: <1416376340-4789-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D433265388
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 06:53:05 +0100 (CET)
In-Reply-To: <1416376340-4789-1-git-send-email-oder_chiou@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Follow the gpio naming rule to rename the irq function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index b2d88bb..dd080cd 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4552,7 +4552,7 @@ static struct regmap_irq_chip rt5677_irq_chip = {
 	.mask_invert = 1,
 };
 
-static int rt5677_irq_init(struct i2c_client *i2c)
+static int rt5677_init_irq(struct i2c_client *i2c)
 {
 	int ret;
 	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
@@ -4579,7 +4579,7 @@ static int rt5677_irq_init(struct i2c_client *i2c)
 	return 0;
 }
 
-static void rt5677_irq_exit(struct i2c_client *i2c)
+static void rt5677_free_irq(struct i2c_client *i2c)
 {
 	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
 
@@ -4693,7 +4693,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 	}
 
 	rt5677_init_gpio(i2c);
-	rt5677_irq_init(i2c);
+	rt5677_init_irq(i2c);
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5677,
 				      rt5677_dai, ARRAY_SIZE(rt5677_dai));
@@ -4701,9 +4701,8 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 
 static int rt5677_i2c_remove(struct i2c_client *i2c)
 {
-	rt5677_irq_exit(i2c);
-
 	snd_soc_unregister_codec(&i2c->dev);
+	rt5677_free_irq(i2c);
 	rt5677_free_gpio(i2c);
 
 	return 0;
-- 
1.8.1.1.439.g50a6b54
