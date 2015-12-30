From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5645: use polling to support HS
	button
Date: Wed, 30 Dec 2015 15:33:20 +0800
Message-ID: <1451460801-24252-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 57C0B2658FA
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2015 08:33:41 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The IRQ pin will keep high when the headset button is pressed. And
keep low when the headset button is released. So, we need irq trigger
at both edges. However, some platform can't support it. Therefore,
we polling the register to report the button release event once a
button presse event is received.
To support the headset button detection function for those can't
support both edges trigger platforms, we also need to invert the
polarity of jack detection irq since we need to keep the IRQ pin
low in normal case.

Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 3e8d666..57c8d9e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -405,6 +405,7 @@ struct rt5645_priv {
 	struct delayed_work jack_detect_work, rcclock_work;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(rt5645_supply_names)];
 	struct rt5645_eq_param_s *eq_param;
+	struct timer_list btn_check_timer;
 
 	int codec_type;
 	int sysclk;
@@ -3130,7 +3131,7 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		}
 		if (rt5645->pdata.jd_invert)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
-				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
+				RT5645_JD_1_1_MASK, RT5645_JD_1_1_NOR);
 	} else { /* jack out */
 		rt5645->jack_type = 0;
 
@@ -3151,7 +3152,7 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		snd_soc_dapm_sync(dapm);
 		if (rt5645->pdata.jd_invert)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
-				RT5645_JD_1_1_MASK, RT5645_JD_1_1_NOR);
+				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
 	}
 
 	return rt5645->jack_type;
@@ -3275,6 +3276,12 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 		}
 		if (btn_type == 0)/* button release */
 			report =  rt5645->jack_type;
+		else {
+			if (rt5645->pdata.jd_invert) {
+				mod_timer(&rt5645->btn_check_timer,
+					msecs_to_jiffies(100));
+			}
+		}
 
 		break;
 	/* jack out */
@@ -3317,6 +3324,14 @@ static irqreturn_t rt5645_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void rt5645_btn_check_callback(unsigned long data)
+{
+	struct rt5645_priv *rt5645 = (struct rt5645_priv *)data;
+
+	queue_delayed_work(system_power_efficient_wq,
+		   &rt5645->jack_detect_work, msecs_to_jiffies(5));
+}
+
 static int rt5645_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
@@ -3783,6 +3798,13 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
+	if (rt5645->pdata.jd_invert) {
+		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
+			RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
+		setup_timer(&rt5645->btn_check_timer,
+			rt5645_btn_check_callback, (unsigned long)rt5645);
+	}
+
 	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
 	INIT_DELAYED_WORK(&rt5645->rcclock_work, rt5645_rcclock_work);
 
-- 
1.8.1.1.439.g50a6b54
