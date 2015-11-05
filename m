From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Power up the RC clock to make
	sure the speaker volume adjust properly" to the asoc tree
Date: Thu, 05 Nov 2015 12:14:59 +0000
Message-ID: <E1ZuJRT-00063z-UM@finisterre>
References: <1446724551-27762-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 68212265B58
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:15:12 +0100 (CET)
In-Reply-To: <1446724551-27762-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Power up the RC clock to make sure the speaker volume adjust properly

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7099ee85e6af56828c46255f43adb15ed47e67df Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Thu, 5 Nov 2015 19:55:51 +0800
Subject: [PATCH] ASoC: rt5645: Power up the RC clock to make sure the speaker
 volume adjust properly

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.6.1
