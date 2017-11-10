From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Check the JD status in the
	button pushing" to the asoc tree
Date: Fri, 10 Nov 2017 21:29:42 +0000
Message-ID: <E1eDGru-0004YE-1N@debutante>
References: <1510291004-10244-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D5462679E2
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 22:29:45 +0100 (CET)
In-Reply-To: <1510291004-10244-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Check the JD status in the button pushing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From de6ae8afb9c098a874c3e81e3cc63938cc9f5bbc Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Fri, 10 Nov 2017 13:16:44 +0800
Subject: [PATCH] ASoC: rt5663: Check the JD status in the button pushing

Check the JD status in the button pushing to prevent the IRQ that is locked
by button pushing event while the jack unpluging.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index eb3065a992ab..d7b163a9769c 100644
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
@@ -1940,8 +1940,15 @@ static void rt5663_jack_detect_work(struct work_struct *work)
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
@@ -1962,6 +1969,37 @@ static void rt5663_jack_detect_work(struct work_struct *work)
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
@@ -3556,6 +3594,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 	}
 
 	INIT_DELAYED_WORK(&rt5663->jack_detect_work, rt5663_jack_detect_work);
+	INIT_DELAYED_WORK(&rt5663->jd_unplug_work, rt5663_jd_unplug_work);
 
 	if (i2c->irq) {
 		ret = request_irq(i2c->irq, rt5663_irq,
-- 
2.15.0
