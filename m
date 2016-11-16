From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: rt5665: Use devm_gpio_request_one()
Date: Wed, 16 Nov 2016 21:08:42 +0800
Message-ID: <20161116130842.28182-2-axel.lin@ingics.com>
References: <20161116130842.28182-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 085602606F8
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 14:10:26 +0100 (CET)
Received: by mail-pg0-f68.google.com with SMTP id e9so14355509pgc.1
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 05:10:26 -0800 (PST)
In-Reply-To: <20161116130842.28182-1-axel.lin@ingics.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <julia.lawall@lip6.fr>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5665.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 7dfaaf1..324461e 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4677,11 +4677,9 @@ static int rt5665_i2c_probe(struct i2c_client *i2c,
 	}
 
 	if (gpio_is_valid(rt5665->pdata.ldo1_en)) {
-		if (devm_gpio_request(&i2c->dev, rt5665->pdata.ldo1_en,
-			"rt5665"))
+		if (devm_gpio_request_one(&i2c->dev, rt5665->pdata.ldo1_en,
+					  GPIOF_OUT_INIT_HIGH, "rt5665"))
 			dev_err(&i2c->dev, "Fail gpio_request gpio_ldo\n");
-		else if (gpio_direction_output(rt5665->pdata.ldo1_en, 1))
-			dev_err(&i2c->dev, "Fail gpio_direction gpio_ldo\n");
 	}
 
 	/* Sleep for 300 ms miniumum */
-- 
2.9.3
