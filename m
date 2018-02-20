From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 03/11] ASoC: rt5651: Fix bias_level confusion /
	overcurrent detection deps
Date: Tue, 20 Feb 2018 23:15:03 +0100
Message-ID: <20180220221511.22861-3-hdegoede@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 891A52671A9
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 23:15:22 +0100 (CET)
In-Reply-To: <20180220221511.22861-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Overcurrent detection (ovcd) requires the following to be on:
1) The LDO supply
2) The micbias1 supply
3) General analog voltages such as vref aka a bias_level of standby

Before this commit deps 2. and 3. were not met (unless a stream recording
from the mic was active).

3. Is not met because rt5651_set_bias_level() was only enabling this when
reaching a bias level of prepared instead of doing this in the normal
standby bias level, which the dapm core will select as soon as any pins /
supplies are on. This commit fixes by making rt5651_set_bias_level() behave
as a normal set_bias function for other codecs and already enabling these
things at standby level.

This change to rt5651_set_bias_level() causes a problem because when jack-
detect is used the bias-level was always set to standby because of the
"JD Power" supply being force-enabled.

As the set_bias_level code already leaves the RT5651_PWR_JD_M bit on when
entering standby (now off) when jd is in use, we can simply drop the
"JD Power" supply so that the bias-level properly becomes off when nothing
is happening. For the same reason we should also not enable the LDO supply
until we actually want to do ovcd detection.

2. is fixed by simply force-enabling "micbias1" when doing ovcd, this
commit also adds code to turn both the micbias1 and the LDO supplies of
again when we're done, note they will only really get turned off if the
ovcd was the only user.

The snd_soc_codec_force_bias_level(BIAS_OFF) call done in rt5651_probe()
will now turn off PWR_ANLG1, so the programming of PWR_ANLG1 before the
snd_soc_codec_force_bias_level() now is a no-op and can be removed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index a48278f6205d..52fb835ea584 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -864,10 +864,6 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY_S("ADC ASRC", 1, RT5651_PLL_MODE_2,
 			      11, 0, NULL, 0),
 
-	/* Input Side */
-	SND_SOC_DAPM_SUPPLY("JD Power", RT5651_PWR_ANLG2,
-		RT5651_PWM_JD_M_BIT, 0, NULL, 0),
-
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("LDO", RT5651_PWR_ANLG1,
 			RT5651_PWR_LDO_BIT, 0, NULL, 0),
@@ -1520,8 +1516,8 @@ static int rt5651_set_bias_level(struct snd_soc_codec *codec,
 	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
 
 	switch (level) {
-	case SND_SOC_BIAS_PREPARE:
-		if (SND_SOC_BIAS_STANDBY == snd_soc_codec_get_bias_level(codec)) {
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			snd_soc_update_bits(codec, RT5651_PWR_ANLG1,
 				RT5651_PWR_VREF1 | RT5651_PWR_MB |
 				RT5651_PWR_BG | RT5651_PWR_VREF2,
@@ -1541,7 +1537,7 @@ static int rt5651_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 
-	case SND_SOC_BIAS_STANDBY:
+	case SND_SOC_BIAS_OFF:
 		snd_soc_write(codec, RT5651_D_MISC, 0x0010);
 		snd_soc_write(codec, RT5651_PWR_DIG1, 0x0000);
 		snd_soc_write(codec, RT5651_PWR_DIG2, 0x0000);
@@ -1576,7 +1572,6 @@ static irqreturn_t rt5651_irq(int irq, void *data)
 static int rt5651_set_jack(struct snd_soc_codec *codec,
 			   struct snd_soc_jack *hp_jack, void *data)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
@@ -1619,9 +1614,8 @@ static int rt5651_set_jack(struct snd_soc_codec *codec,
 		break;
 	}
 
-	snd_soc_dapm_force_enable_pin(dapm, "JD Power");
-	snd_soc_dapm_force_enable_pin(dapm, "LDO");
-	snd_soc_dapm_sync(dapm);
+	regmap_update_bits(rt5651->regmap, RT5651_PWR_ANLG2, RT5651_PWR_JD_M,
+			   RT5651_PWR_JD_M);
 
 	regmap_update_bits(rt5651->regmap, RT5651_MICBIAS,
 			   0x38, 0x38);
@@ -1648,16 +1642,6 @@ static int rt5651_probe(struct snd_soc_codec *codec)
 
 	rt5651->codec = codec;
 
-	snd_soc_update_bits(codec, RT5651_PWR_ANLG1,
-		RT5651_PWR_VREF1 | RT5651_PWR_MB |
-		RT5651_PWR_BG | RT5651_PWR_VREF2,
-		RT5651_PWR_VREF1 | RT5651_PWR_MB |
-		RT5651_PWR_BG | RT5651_PWR_VREF2);
-	usleep_range(10000, 15000);
-	snd_soc_update_bits(codec, RT5651_PWR_ANLG1,
-		RT5651_PWR_FV1 | RT5651_PWR_FV2,
-		RT5651_PWR_FV1 | RT5651_PWR_FV2);
-
 	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
@@ -1811,8 +1795,11 @@ static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	int jack_type;
 
 	if (jack_insert) {
-		snd_soc_dapm_force_enable_pin(dapm, "LDO");
-		snd_soc_dapm_sync(dapm);
+		snd_soc_dapm_mutex_lock(dapm);
+		snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO");
+		snd_soc_dapm_force_enable_pin_unlocked(dapm, "micbias1");
+		snd_soc_dapm_sync_unlocked(dapm);
+		snd_soc_dapm_mutex_unlock(dapm);
 
 		snd_soc_update_bits(codec, RT5651_MICBIAS,
 				    RT5651_MIC1_OVCD_MASK |
@@ -1830,6 +1817,12 @@ static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			jack_type = SND_JACK_HEADSET;
 		snd_soc_update_bits(codec, RT5651_IRQ_CTRL2,
 				    RT5651_MB1_OC_CLR, 0);
+
+		snd_soc_dapm_mutex_lock(dapm);
+		snd_soc_dapm_disable_pin_unlocked(dapm, "micbias1");
+		snd_soc_dapm_disable_pin_unlocked(dapm, "LDO");
+		snd_soc_dapm_sync_unlocked(dapm);
+		snd_soc_dapm_mutex_unlock(dapm);
 	} else { /* jack out */
 		jack_type = 0;
 
-- 
2.14.3
