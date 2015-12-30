From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: use polling to support HS
	button" to the asoc tree
Date: Wed, 30 Dec 2015 18:05:20 +0000
Message-ID: <E1aEL7g-0007NI-OP@debutante>
References: <1451460801-24252-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BC17265A1B
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2015 19:05:27 +0100 (CET)
In-Reply-To: <1451460801-24252-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: use polling to support HS button

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

>From 7ff6319e7da5c09f0ce86d122d46040807262325 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 30 Dec 2015 15:33:20 +0800
Subject: [PATCH] ASoC: rt5645: use polling to support HS button

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 3e8d66661b7e..57c8d9ecfde1 100644
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
2.6.2
