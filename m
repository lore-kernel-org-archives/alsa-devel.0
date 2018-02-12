From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: Add the support of Intel HDA
	Header" to the asoc tree
Date: Mon, 12 Feb 2018 12:53:27 +0000
Message-ID: <E1elDbr-0006eO-4B@debutante>
References: <1517826596-17864-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AEE42681D2
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:53:31 +0100 (CET)
In-Reply-To: <1517826596-17864-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, spujar@nvidia.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5659: Add the support of Intel HDA Header

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

>From 041e74b71491acadad74b275e8b05add165d92b4 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Mon, 5 Feb 2018 18:29:56 +0800
Subject: [PATCH] ASoC: rt5659: Add the support of Intel HDA Header

The patch adds the support of Intel HDA Header.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/rt5659.h    |   1 +
 sound/soc/codecs/rt5659.c | 118 ++++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt5659.h |   3 +-
 3 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/include/sound/rt5659.h b/include/sound/rt5659.h
index 656c4d58948d..9012e2b25360 100644
--- a/include/sound/rt5659.h
+++ b/include/sound/rt5659.h
@@ -30,6 +30,7 @@ enum rt5659_dmic2_data_pin {
 enum rt5659_jd_src {
 	RT5659_JD_NULL,
 	RT5659_JD3,
+	RT5659_JD_HDA_HEADER,
 };
 
 struct rt5659_platform_data {
diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 07e7757417bc..dbc7dbfe8c6f 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -1461,6 +1461,61 @@ static void rt5659_jack_detect_work(struct work_struct *work)
 			    SND_JACK_BTN_2 | SND_JACK_BTN_3);
 }
 
+static void rt5659_jack_detect_intel_hd_header(struct work_struct *work)
+{
+	struct rt5659_priv *rt5659 =
+		container_of(work, struct rt5659_priv, jack_detect_work.work);
+	unsigned int value;
+	bool hp_flag, mic_flag;
+
+	if (!rt5659->hs_jack)
+		return;
+
+	/* headphone jack */
+	regmap_read(rt5659->regmap, RT5659_GPIO_STA, &value);
+	hp_flag = (!(value & 0x8)) ? true : false;
+
+	if (hp_flag != rt5659->hda_hp_plugged) {
+		rt5659->hda_hp_plugged = hp_flag;
+
+		if (hp_flag) {
+			regmap_update_bits(rt5659->regmap, RT5659_IRQ_CTRL_1,
+				0x10, 0x0);
+			rt5659->jack_type |= SND_JACK_HEADPHONE;
+		} else {
+			regmap_update_bits(rt5659->regmap, RT5659_IRQ_CTRL_1,
+				0x10, 0x10);
+			rt5659->jack_type = rt5659->jack_type &
+				(~SND_JACK_HEADPHONE);
+		}
+
+		snd_soc_jack_report(rt5659->hs_jack, rt5659->jack_type,
+			SND_JACK_HEADPHONE);
+	}
+
+	/* mic jack */
+	regmap_read(rt5659->regmap, RT5659_4BTN_IL_CMD_1, &value);
+	regmap_write(rt5659->regmap, RT5659_4BTN_IL_CMD_1, value);
+	mic_flag = (value & 0x2000) ? true : false;
+
+	if (mic_flag != rt5659->hda_mic_plugged) {
+		rt5659->hda_mic_plugged = mic_flag;
+		if (mic_flag) {
+			regmap_update_bits(rt5659->regmap, RT5659_IRQ_CTRL_2,
+				0x2, 0x2);
+			rt5659->jack_type |= SND_JACK_MICROPHONE;
+		} else {
+			regmap_update_bits(rt5659->regmap, RT5659_IRQ_CTRL_2,
+				0x2, 0x0);
+			rt5659->jack_type = rt5659->jack_type
+				& (~SND_JACK_MICROPHONE);
+		}
+
+		snd_soc_jack_report(rt5659->hs_jack, rt5659->jack_type,
+			SND_JACK_MICROPHONE);
+	}
+}
+
 static const struct snd_kcontrol_new rt5659_snd_controls[] = {
 	/* Speaker Output Volume */
 	SOC_DOUBLE_TLV("Speaker Playback Volume", RT5659_SPO_VOL,
@@ -3990,6 +4045,54 @@ static void rt5659_calibrate(struct rt5659_priv *rt5659)
 	regmap_write(rt5659->regmap, RT5659_HP_CHARGE_PUMP_1, 0x0c16);
 }
 
+void rt5659_intel_hd_header_probe_setup(struct rt5659_priv *rt5659)
+{
+	int value;
+
+	regmap_read(rt5659->regmap, RT5659_GPIO_STA, &value);
+	if (!(value & 0x8)) {
+		rt5659->hda_hp_plugged = true;
+		regmap_update_bits(rt5659->regmap, RT5659_IRQ_CTRL_1,
+			0x10, 0x0);
+	} else {
+		regmap_update_bits(rt5659->regmap, RT5659_IRQ_CTRL_1,
+			0x10, 0x10);
+	}
+
+	regmap_update_bits(rt5659->regmap, RT5659_PWR_ANLG_1,
+		RT5659_PWR_VREF2 | RT5659_PWR_MB,
+		RT5659_PWR_VREF2 | RT5659_PWR_MB);
+	msleep(20);
+	regmap_update_bits(rt5659->regmap, RT5659_PWR_ANLG_1,
+		RT5659_PWR_FV2, RT5659_PWR_FV2);
+
+	regmap_update_bits(rt5659->regmap, RT5659_PWR_ANLG_3, RT5659_PWR_LDO2,
+		RT5659_PWR_LDO2);
+	regmap_update_bits(rt5659->regmap, RT5659_PWR_ANLG_2, RT5659_PWR_MB1,
+		RT5659_PWR_MB1);
+	regmap_update_bits(rt5659->regmap, RT5659_PWR_VOL, RT5659_PWR_MIC_DET,
+		RT5659_PWR_MIC_DET);
+	msleep(20);
+
+	regmap_update_bits(rt5659->regmap, RT5659_4BTN_IL_CMD_2,
+		RT5659_4BTN_IL_MASK, RT5659_4BTN_IL_EN);
+	regmap_read(rt5659->regmap, RT5659_4BTN_IL_CMD_1, &value);
+	regmap_write(rt5659->regmap, RT5659_4BTN_IL_CMD_1, value);
+	regmap_read(rt5659->regmap, RT5659_4BTN_IL_CMD_1, &value);
+
+	if (value & 0x2000) {
+		rt5659->hda_mic_plugged = true;
+		regmap_update_bits(rt5659->regmap, RT5659_IRQ_CTRL_2,
+			0x2, 0x2);
+	} else {
+		regmap_update_bits(rt5659->regmap, RT5659_IRQ_CTRL_2,
+			0x2, 0x0);
+	}
+
+	regmap_update_bits(rt5659->regmap, RT5659_IRQ_CTRL_2,
+		RT5659_IL_IRQ_MASK, RT5659_IL_IRQ_EN);
+}
+
 static int rt5659_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -4174,16 +4277,23 @@ static int rt5659_i2c_probe(struct i2c_client *i2c,
 				RT5659_PWR_MB, RT5659_PWR_MB);
 		regmap_write(rt5659->regmap, RT5659_PWR_ANLG_2, 0x0001);
 		regmap_write(rt5659->regmap, RT5659_IRQ_CTRL_2, 0x0040);
+		INIT_DELAYED_WORK(&rt5659->jack_detect_work,
+			rt5659_jack_detect_work);
 		break;
-	case RT5659_JD_NULL:
+	case RT5659_JD_HDA_HEADER:
+		regmap_write(rt5659->regmap, RT5659_GPIO_CTRL_3, 0x8000);
+		regmap_write(rt5659->regmap, RT5659_RC_CLK_CTRL, 0x0900);
+		regmap_write(rt5659->regmap, RT5659_EJD_CTRL_1,  0x70c0);
+		regmap_write(rt5659->regmap, RT5659_JD_CTRL_1,   0x2000);
+		regmap_write(rt5659->regmap, RT5659_IRQ_CTRL_1,  0x0040);
+		INIT_DELAYED_WORK(&rt5659->jack_detect_work,
+			rt5659_jack_detect_intel_hd_header);
+		rt5659_intel_hd_header_probe_setup(rt5659);
 		break;
 	default:
-		dev_warn(&i2c->dev, "Currently, support JD3 only\n");
 		break;
 	}
 
-	INIT_DELAYED_WORK(&rt5659->jack_detect_work, rt5659_jack_detect_work);
-
 	if (i2c->irq) {
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
 			rt5659_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index 8f1aeef08489..bea0433c164c 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -1810,7 +1810,8 @@ struct rt5659_priv {
 	int pll_out;
 
 	int jack_type;
-
+	bool hda_hp_plugged;
+	bool hda_mic_plugged;
 };
 
 int rt5659_set_jack_detect(struct snd_soc_codec *codec,
-- 
2.16.1
