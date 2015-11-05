From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5645: Power up the RC clock to make
	sure the speaker volume adjust properly
Date: Thu, 5 Nov 2015 19:55:51 +0800
Message-ID: <1446724551-27762-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B85A6265A01
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 12:55:59 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 2813237..672fafd 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -245,7 +245,7 @@ struct rt5645_priv {
 	struct snd_soc_jack *hp_jack;
 	struct snd_soc_jack *mic_jack;
 	struct snd_soc_jack *btn_jack;
-	struct delayed_work jack_detect_work;
+	struct delayed_work jack_detect_work, rcclock_work;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(rt5645_supply_names)];
 	struct rt5645_eq_param_s *eq_param;
 
@@ -565,12 +565,33 @@ static int rt5645_hweq_put(struct snd_kcontrol *kcontrol,
 	.put = rt5645_hweq_put \
 }
 
+static int rt5645_spk_put_volsw(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	cancel_delayed_work_sync(&rt5645->rcclock_work);
+
+	regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
+		RT5645_PWR_CLK25M_MASK, RT5645_PWR_CLK25M_PU);
+
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+
+	queue_delayed_work(system_power_efficient_wq, &rt5645->rcclock_work,
+		msecs_to_jiffies(200));
+
+	return ret;
+}
+
 static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* Speaker Output Volume */
 	SOC_DOUBLE("Speaker Channel Switch", RT5645_SPK_VOL,
 		RT5645_VOL_L_SFT, RT5645_VOL_R_SFT, 1, 1),
-	SOC_DOUBLE_TLV("Speaker Playback Volume", RT5645_SPK_VOL,
-		RT5645_L_VOL_SFT, RT5645_R_VOL_SFT, 39, 1, out_vol_tlv),
+	SOC_DOUBLE_EXT_TLV("Speaker Playback Volume", RT5645_SPK_VOL,
+		RT5645_L_VOL_SFT, RT5645_R_VOL_SFT, 39, 1, snd_soc_get_volsw,
+		rt5645_spk_put_volsw, out_vol_tlv),
 
 	/* ClassD modulator Speaker Gain Ratio */
 	SOC_SINGLE_TLV("Speaker ClassD Playback Volume", RT5645_SPO_CLSD_RATIO,
@@ -3122,6 +3143,15 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 				SND_JACK_BTN_2 | SND_JACK_BTN_3);
 }
 
+static void rt5645_rcclock_work(struct work_struct *work)
+{
+	struct rt5645_priv *rt5645 =
+		container_of(work, struct rt5645_priv, rcclock_work.work);
+
+	regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
+		RT5645_PWR_CLK25M_MASK, RT5645_PWR_CLK25M_PD);
+}
+
 static irqreturn_t rt5645_irq(int irq, void *data)
 {
 	struct rt5645_priv *rt5645 = data;
@@ -3587,6 +3617,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	}
 
 	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
+	INIT_DELAYED_WORK(&rt5645->rcclock_work, rt5645_rcclock_work);
 
 	if (rt5645->i2c->irq) {
 		ret = request_threaded_irq(rt5645->i2c->irq, NULL, rt5645_irq,
@@ -3621,6 +3652,7 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 		free_irq(i2c->irq, rt5645);
 
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
+	cancel_delayed_work_sync(&rt5645->rcclock_work);
 
 	snd_soc_unregister_codec(&i2c->dev);
 	regulator_bulk_disable(ARRAY_SIZE(rt5645->supplies), rt5645->supplies);
-- 
1.8.1.1.439.g50a6b54
