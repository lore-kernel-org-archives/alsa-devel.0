From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rt5677: Return error if
 devm_gpiod_get_optional return ERR_PTR
Date: Sat, 25 Jul 2015 09:01:40 +0800
Message-ID: <1437786100.6813.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 04FAE260632
 for <alsa-devel@alsa-project.org>; Sat, 25 Jul 2015 03:01:46 +0200 (CEST)
Received: by pabkd10 with SMTP id kd10so21851843pab.2
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 18:01:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

If devm_gpiod_get_optional() return ERR_PTR, it means something wrong
so request gpio fails. We had better return error in such case.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5677.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 8d70911..3a074b6 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5133,14 +5133,14 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(rt5677->pow_ldo2)) {
 		ret = PTR_ERR(rt5677->pow_ldo2);
 		dev_err(&i2c->dev, "Failed to request POW_LDO2: %d\n", ret);
-		rt5677->pow_ldo2 = 0;
+		return PTR_ERR(rt5677->pow_ldo2);
 	}
 	rt5677->reset_pin = devm_gpiod_get_optional(&i2c->dev,
 			"realtek,reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(rt5677->reset_pin)) {
 		ret = PTR_ERR(rt5677->reset_pin);
 		dev_err(&i2c->dev, "Failed to request RESET: %d\n", ret);
-		rt5677->reset_pin = 0;
+		return PTR_ERR(rt5677->reset_pin);
 	}
 
 	if (rt5677->pow_ldo2 || rt5677->reset_pin) {
-- 
2.1.0
