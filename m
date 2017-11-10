From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Check the JD status in the
	button pushing
Date: Fri, 10 Nov 2017 13:16:44 +0800
Message-ID: <1510291004-10244-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F30A2678A9
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 06:22:01 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

Check the JD status in the button pushing to prevent the IRQ that is locked
by button pushing event while the jack unpluging.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 18dc1ec..b036c9d 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -52,7 +52,7 @@ struct rt5663_priv {
 	struct snd_soc_codec *codec;
 	struct rt5663_platform_data pdata;
 	struct regmap *regmap;
-	struct delayed_work jack_detect_work;
+	struct delayed_work jack_detect_work, jd_unplug_work;
 	struct snd_soc_jack *hs_jack;
 	struct timer_list btn_check_timer;
 	struct impedance_mapping_table *imp_table;
@@ -1941,8 +1941,15 @@ static void rt5663_jack_detect_work(struct work_struct *work)
 				break;
 			}
 			/* button release or spurious interrput*/
-			if (btn_type == 0)
+			if (btn_type == 0) {
 				report =  rt5663->jack_type;
+				cancel_delayed_work_sync(
+					&rt5663->jd_unplug_work);
+			} else {
+				queue_delayed_work(system_wq,
+					&rt5663->jd_unplug_work,
+					msecs_to_jiffies(500));
+			}
 		}
 	} else {
 		/* jack out */
@@ -1963,6 +1970,37 @@ static void rt5663_jack_detect_work(struct work_struct *work)
 			    SND_JACK_BTN_2 | SND_JACK_BTN_3);
 }
 
+static void rt5663_jd_unplug_work(struct work_struct *work)
+{
+	struct rt5663_priv *rt5663 =
+		container_of(work, struct rt5663_priv, jd_unplug_work.work);
+	struct snd_soc_codec *codec = rt5663->codec;
+
+	if (!codec)
+		return;
+
+	if (!rt5663_check_jd_status(codec)) {
+		/* jack out */
+		switch (rt5663->codec_ver) {
+		case CODEC_VER_1:
+			rt5663_v2_jack_detect(rt5663->codec, 0);
+			break;
+		case CODEC_VER_0:
+			rt5663_jack_detect(rt5663->codec, 0);
+			break;
+		default:
+			dev_err(codec->dev, "Unknown CODEC Version\n");
+		}
+
+		snd_soc_jack_report(rt5663->hs_jack, 0, SND_JACK_HEADSET |
+				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				    SND_JACK_BTN_2 | SND_JACK_BTN_3);
+	} else {
+		queue_delayed_work(system_wq, &rt5663->jd_unplug_work,
+			msecs_to_jiffies(500));
+	}
+}
+
 static const struct snd_kcontrol_new rt5663_snd_controls[] = {
 	/* DAC Digital Volume */
 	SOC_DOUBLE_TLV("DAC Playback Volume", RT5663_STO1_DAC_DIG_VOL,
@@ -3557,6 +3595,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 	}
 
 	INIT_DELAYED_WORK(&rt5663->jack_detect_work, rt5663_jack_detect_work);
+	INIT_DELAYED_WORK(&rt5663->jd_unplug_work, rt5663_jd_unplug_work);
 
 	if (i2c->irq) {
 		ret = request_irq(i2c->irq, rt5663_irq,
-- 
2.7.4
