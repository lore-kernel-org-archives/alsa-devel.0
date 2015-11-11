From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5677: Avoid the pop sound that
	comes from the filter power
Date: Wed, 11 Nov 2015 02:25:55 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694FA4ED0@RTITMBSV03.realtek.com.tw>
References: <1447063264-19301-1-git-send-email-oder_chiou@realtek.com>
 <CALj_zD6FMWYAT5msvRnb=kzh2OPt0jR-BP8L5DkbedJeNxkvtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B2F0626526D
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 03:26:04 +0100 (CET)
In-Reply-To: <CALj_zD6FMWYAT5msvRnb=kzh2OPt0jR-BP8L5DkbedJeNxkvtw@mail.gmail.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomazau <anatol@google.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Albert Chen <albertchen@realtek.com>, "broonie@kernel.org" <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi Anatol,

What these AUTODISABLE above for? Are they needed?
They are needed for the power up sequence that make sure the un-mute should be done after the filter power up.

For those of us who does not have access to the internal structure of the chip, could you please add a comment why this delay is needed here? What the chip is doing these 50ms?
The delay is done before the mixer un-mute, and it should delay some time to prevent the pop sound.
The 50ms delay is decided by our internal discussion, and it just waits the pop sound going away

Thanks.
Oder

From: Anatol Pomazau [mailto:anatol@google.com]
Sent: Tuesday, November 10, 2015 2:05 AM
To: Oder Chiou
Cc: broonie@kernel.org; lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Bard Liao; John Lin; Jack Yu; Albert Chen
Subject: Re: [PATCH] ASoC: rt5677: Avoid the pop sound that comes from the filter power

Hi

Thanks Oder into looking this.

We've been working with awesome Realtek engineers on fixing pop in AIF1->AIF2 audio path and I confirm that this patch fixes the problem.


On Mon, Nov 9, 2015 at 2:01 AM, Oder Chiou <oder_chiou@realtek.com<mailto:oder_chiou@realtek.com>> wrote:
The patch changes the type of DACs mixer to AUTODISABLE and add the delay
time after power up to avoid the pop sound that comes from the filter
power.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com<mailto:oder_chiou@realtek.com>>
---
 sound/soc/codecs/rt5677.c | 100 ++++++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index b4cd7e3..69d987a 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -1386,90 +1386,90 @@ static const struct snd_kcontrol_new rt5677_dac_r_mix[] = {
 };

 static const struct snd_kcontrol_new rt5677_sto1_dac_l_mix[] = {
-       SOC_DAPM_SINGLE("ST L Switch", RT5677_STO1_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("ST L Switch", RT5677_STO1_DAC_MIXER,
                        RT5677_M_ST_DAC1_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC1 L Switch", RT5677_STO1_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC1 L Switch", RT5677_STO1_DAC_MIXER,
                        RT5677_M_DAC1_L_STO_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC2 L Switch", RT5677_STO1_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC2 L Switch", RT5677_STO1_DAC_MIXER,
                        RT5677_M_DAC2_L_STO_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC1 R Switch", RT5677_STO1_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC1 R Switch", RT5677_STO1_DAC_MIXER,
                        RT5677_M_DAC1_R_STO_L_SFT, 1, 1),
 };

 static const struct snd_kcontrol_new rt5677_sto1_dac_r_mix[] = {
-       SOC_DAPM_SINGLE("ST R Switch", RT5677_STO1_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("ST R Switch", RT5677_STO1_DAC_MIXER,
                        RT5677_M_ST_DAC1_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC1 R Switch", RT5677_STO1_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC1 R Switch", RT5677_STO1_DAC_MIXER,
                        RT5677_M_DAC1_R_STO_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC2 R Switch", RT5677_STO1_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC2 R Switch", RT5677_STO1_DAC_MIXER,
                        RT5677_M_DAC2_R_STO_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC1 L Switch", RT5677_STO1_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC1 L Switch", RT5677_STO1_DAC_MIXER,
                        RT5677_M_DAC1_L_STO_R_SFT, 1, 1),
 };

 static const struct snd_kcontrol_new rt5677_mono_dac_l_mix[] = {
-       SOC_DAPM_SINGLE("ST L Switch", RT5677_MONO_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("ST L Switch", RT5677_MONO_DAC_MIXER,
                        RT5677_M_ST_DAC2_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC1 L Switch", RT5677_MONO_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC1 L Switch", RT5677_MONO_DAC_MIXER,
                        RT5677_M_DAC1_L_MONO_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC2 L Switch", RT5677_MONO_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC2 L Switch", RT5677_MONO_DAC_MIXER,
                        RT5677_M_DAC2_L_MONO_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC2 R Switch", RT5677_MONO_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC2 R Switch", RT5677_MONO_DAC_MIXER,
                        RT5677_M_DAC2_R_MONO_L_SFT, 1, 1),
 };

 static const struct snd_kcontrol_new rt5677_mono_dac_r_mix[] = {
-       SOC_DAPM_SINGLE("ST R Switch", RT5677_MONO_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("ST R Switch", RT5677_MONO_DAC_MIXER,
                        RT5677_M_ST_DAC2_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC1 R Switch", RT5677_MONO_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC1 R Switch", RT5677_MONO_DAC_MIXER,
                        RT5677_M_DAC1_R_MONO_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC2 R Switch", RT5677_MONO_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC2 R Switch", RT5677_MONO_DAC_MIXER,
                        RT5677_M_DAC2_R_MONO_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC2 L Switch", RT5677_MONO_DAC_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC2 L Switch", RT5677_MONO_DAC_MIXER,
                        RT5677_M_DAC2_L_MONO_R_SFT, 1, 1),
 };

 static const struct snd_kcontrol_new rt5677_dd1_l_mix[] = {
-       SOC_DAPM_SINGLE("Sto DAC Mix L Switch", RT5677_DD1_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("Sto DAC Mix L Switch", RT5677_DD1_MIXER,
                        RT5677_M_STO_L_DD1_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("Mono DAC Mix L Switch", RT5677_DD1_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("Mono DAC Mix L Switch", RT5677_DD1_MIXER,
                        RT5677_M_MONO_L_DD1_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC3 L Switch", RT5677_DD1_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC3 L Switch", RT5677_DD1_MIXER,
                        RT5677_M_DAC3_L_DD1_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC3 R Switch", RT5677_DD1_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC3 R Switch", RT5677_DD1_MIXER,
                        RT5677_M_DAC3_R_DD1_L_SFT, 1, 1),
 };

 static const struct snd_kcontrol_new rt5677_dd1_r_mix[] = {
-       SOC_DAPM_SINGLE("Sto DAC Mix R Switch", RT5677_DD1_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("Sto DAC Mix R Switch", RT5677_DD1_MIXER,
                        RT5677_M_STO_R_DD1_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("Mono DAC Mix R Switch", RT5677_DD1_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("Mono DAC Mix R Switch", RT5677_DD1_MIXER,
                        RT5677_M_MONO_R_DD1_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC3 R Switch", RT5677_DD1_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC3 R Switch", RT5677_DD1_MIXER,
                        RT5677_M_DAC3_R_DD1_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC3 L Switch", RT5677_DD1_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC3 L Switch", RT5677_DD1_MIXER,
                        RT5677_M_DAC3_L_DD1_R_SFT, 1, 1),
 };

 static const struct snd_kcontrol_new rt5677_dd2_l_mix[] = {
-       SOC_DAPM_SINGLE("Sto DAC Mix L Switch", RT5677_DD2_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("Sto DAC Mix L Switch", RT5677_DD2_MIXER,
                        RT5677_M_STO_L_DD2_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("Mono DAC Mix L Switch", RT5677_DD2_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("Mono DAC Mix L Switch", RT5677_DD2_MIXER,
                        RT5677_M_MONO_L_DD2_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC4 L Switch", RT5677_DD2_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC4 L Switch", RT5677_DD2_MIXER,
                        RT5677_M_DAC4_L_DD2_L_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC4 R Switch", RT5677_DD2_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC4 R Switch", RT5677_DD2_MIXER,
                        RT5677_M_DAC4_R_DD2_L_SFT, 1, 1),
 };

 static const struct snd_kcontrol_new rt5677_dd2_r_mix[] = {
-       SOC_DAPM_SINGLE("Sto DAC Mix R Switch", RT5677_DD2_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("Sto DAC Mix R Switch", RT5677_DD2_MIXER,
                        RT5677_M_STO_R_DD2_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("Mono DAC Mix R Switch", RT5677_DD2_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("Mono DAC Mix R Switch", RT5677_DD2_MIXER,
                        RT5677_M_MONO_R_DD2_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC4 R Switch", RT5677_DD2_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC4 R Switch", RT5677_DD2_MIXER,
                        RT5677_M_DAC4_R_DD2_R_SFT, 1, 1),
-       SOC_DAPM_SINGLE("DAC4 L Switch", RT5677_DD2_MIXER,
+       SOC_DAPM_SINGLE_AUTODISABLE("DAC4 L Switch", RT5677_DD2_MIXER,
                        RT5677_M_DAC4_L_DD2_R_SFT, 1, 1),
 };

I tested the kernel change with filter power delay only (the changes below) and it was enough for me to fix the pop sound.

What these AUTODISABLE above for? Are they needed?



@@ -2596,6 +2596,21 @@ static int rt5677_vref_event(struct snd_soc_dapm_widget *w,
        return 0;
 }

+static int rt5677_filter_power_event(struct snd_soc_dapm_widget *w,
+       struct snd_kcontrol *kcontrol, int event)
+{
+       switch (event) {
+       case SND_SOC_DAPM_POST_PMU:
+               msleep(50);

For those of us who does not have access to the internal structure of the chip, could you please add a comment why this delay is needed here? What the chip is doing these 50ms?


+               break;
+
+       default:
+               return 0;
+       }
+
+       return 0;
+}
+
 static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
        SND_SOC_DAPM_SUPPLY("PLL1", RT5677_PWR_ANLG2, RT5677_PWR_PLL1_BIT,
                0, rt5677_set_pll1_event, SND_SOC_DAPM_PRE_PMU |
@@ -3072,19 +3087,26 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {

        /* DAC Mixer */
        SND_SOC_DAPM_SUPPLY("dac stereo1 filter", RT5677_PWR_DIG2,
-               RT5677_PWR_DAC_S1F_BIT, 0, NULL, 0),
+               RT5677_PWR_DAC_S1F_BIT, 0, rt5677_filter_power_event,
+               SND_SOC_DAPM_POST_PMU),
        SND_SOC_DAPM_SUPPLY("dac mono2 left filter", RT5677_PWR_DIG2,
-               RT5677_PWR_DAC_M2F_L_BIT, 0, NULL, 0),
+               RT5677_PWR_DAC_M2F_L_BIT, 0, rt5677_filter_power_event,
+               SND_SOC_DAPM_POST_PMU),
        SND_SOC_DAPM_SUPPLY("dac mono2 right filter", RT5677_PWR_DIG2,
-               RT5677_PWR_DAC_M2F_R_BIT, 0, NULL, 0),
+               RT5677_PWR_DAC_M2F_R_BIT, 0, rt5677_filter_power_event,
+               SND_SOC_DAPM_POST_PMU),
        SND_SOC_DAPM_SUPPLY("dac mono3 left filter", RT5677_PWR_DIG2,
-               RT5677_PWR_DAC_M3F_L_BIT, 0, NULL, 0),
+               RT5677_PWR_DAC_M3F_L_BIT, 0, rt5677_filter_power_event,
+               SND_SOC_DAPM_POST_PMU),
        SND_SOC_DAPM_SUPPLY("dac mono3 right filter", RT5677_PWR_DIG2,
-               RT5677_PWR_DAC_M3F_R_BIT, 0, NULL, 0),
+               RT5677_PWR_DAC_M3F_R_BIT, 0, rt5677_filter_power_event,
+               SND_SOC_DAPM_POST_PMU),
        SND_SOC_DAPM_SUPPLY("dac mono4 left filter", RT5677_PWR_DIG2,
-               RT5677_PWR_DAC_M4F_L_BIT, 0, NULL, 0),
+               RT5677_PWR_DAC_M4F_L_BIT, 0, rt5677_filter_power_event,
+               SND_SOC_DAPM_POST_PMU),
        SND_SOC_DAPM_SUPPLY("dac mono4 right filter", RT5677_PWR_DIG2,
-               RT5677_PWR_DAC_M4F_R_BIT, 0, NULL, 0),
+               RT5677_PWR_DAC_M4F_R_BIT, 0, rt5677_filter_power_event,
+               SND_SOC_DAPM_POST_PMU),

        SND_SOC_DAPM_MIXER("Stereo DAC MIXL", SND_SOC_NOPM, 0, 0,
                rt5677_sto1_dac_l_mix, ARRAY_SIZE(rt5677_sto1_dac_l_mix)),
--
1.8.1.1.439.g50a6b54


------Please consider the environment before printing this e-mail.
