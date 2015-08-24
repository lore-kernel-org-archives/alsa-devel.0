From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 3/5] ASoC: rt5645: Modify the jack detection
	function to prevent the pop sound while the jack plug in
Date: Mon, 24 Aug 2015 20:32:57 +0800
Message-ID: <1440419579-9970-3-git-send-email-oder_chiou@realtek.com>
References: <1440419579-9970-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 43E1A2606E8
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 14:33:10 +0200 (CEST)
In-Reply-To: <1440419579-9970-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch corrects the sequence of the jack detection. It will prevent the
pop sound while the jack plug in.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 828afa2..2c1b56b 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2805,14 +2805,15 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		}
 
 		regmap_write(rt5645->regmap, RT5645_JD_CTRL3, 0x00f0);
-		regmap_write(rt5645->regmap, RT5645_IN1_CTRL1, 0x0006);
 		regmap_update_bits(rt5645->regmap,
 				   RT5645_IN1_CTRL2, 0x1000, 0x1000);
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1, 0x0004,
+			0x0004);
 		msleep(100);
 		regmap_update_bits(rt5645->regmap,
 				   RT5645_IN1_CTRL2, 0x1000, 0x0000);
 
-		msleep(450);
+		msleep(600);
 		regmap_read(rt5645->regmap, RT5645_IN1_CTRL3, &val);
 		val &= 0x7;
 		dev_dbg(codec->dev, "val = %d\n", val);
@@ -2828,9 +2829,17 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			rt5645->jack_type = SND_JACK_HEADPHONE;
 		}
 
+		snd_soc_update_bits(codec, RT5645_CHARGE_PUMP, 0x0300, 0x0200);
+		snd_soc_write(codec, RT5645_DEPOP_M1, 0x001d);
+		snd_soc_write(codec, RT5645_DEPOP_M1, 0x0001);
 	} else { /* jack out */
 		rt5645->jack_type = 0;
 
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2, 0x1000,
+			0x1000);
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1, 0x0004,
+			0x0000);
+
 		if (rt5645->en_button_func)
 			rt5645_enable_push_button_irq(codec, false);
 
-- 
1.8.1.1.439.g50a6b54
