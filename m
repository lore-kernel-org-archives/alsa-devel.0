From: Jinyoung Park <jinyoungp@nvidia.com>
Subject: FW: ASoC: codecs: max98088: bug fixes and changes
Date: Wed, 11 May 2011 14:22:06 +0800
Message-ID: <D9A2FA38A1E15B4E832469E5FE40C7ABFA0296357C@HKMAIL01.nvidia.com>
References: <D9A2FA38A1E15B4E832469E5FE40C7ABFA0296357B@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 71FF1103810
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 08:22:17 +0200 (CEST)
In-Reply-To: <D9A2FA38A1E15B4E832469E5FE40C7ABFA0296357B@HKMAIL01.nvidia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'Peter Hsiang' <Peter.Hsiang@maxim-ic.com>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, 'Liam Girdwood' <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Dear Mark,

Recently, I working on max98088 and changed something in max98088 asoc driver.

I included three changes for max98088 in this mail.
- 1/3 Fixed invalid register definitions in mixer controls
* This change was confirmed by Peter Hsiang who author of max98088 driver and maxim engineer.
- 2/3 Moved the EX Limiter Mode from dapm widget to control
- 3/3 Added digital mute function in DAI1 and DAI2

Please review below my changes.


------------------------------------------------------------------------------------------------------------------------------
>From d572385569d6af23d7b98948b9ff36f2e34f6c41 Mon Sep 17 00:00:00 2001
From: Jin Park <jinyoungp@nvidia.com>
Date: Wed, 11 May 2011 12:12:11 +0900
Subject: [PATCH 1/3] ASoC: codecs: max98088: Fixed invalid register definitions in mixer controls

Fixed invalid register definitions in mixer controls such as left
speaker mixer, left hp mixer and left rec mixer.

Signed-off-by: Jin Park <jinyoungp@nvidia.com<mailto:jinyoungp@nvidia.com>>
---
sound/soc/codecs/max98088.c |   24 ++++++++++++------------
1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 89498f9..3bdaa04 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -808,10 +808,10 @@ static const struct snd_kcontrol_new max98088_snd_controls[] = {

 /* Left speaker mixer switch */
static const struct snd_kcontrol_new max98088_left_speaker_mixer_controls[] = {
-       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 0, 1, 0),
-       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_2B_MIX_SPK_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_2B_MIX_SPK_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 7, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_2B_MIX_SPK_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_2B_MIX_SPK_LEFT, 7, 1, 0),
        SOC_DAPM_SINGLE("MIC1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 5, 1, 0),
        SOC_DAPM_SINGLE("MIC2 Switch", M98088_REG_2B_MIX_SPK_LEFT, 6, 1, 0),
        SOC_DAPM_SINGLE("INA1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 1, 1, 0),
@@ -836,10 +836,10 @@ static const struct snd_kcontrol_new max98088_right_speaker_mixer_controls[] = {

 /* Left headphone mixer switch */
static const struct snd_kcontrol_new max98088_left_hp_mixer_controls[] = {
-       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_25_MIX_HP_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_25_MIX_HP_LEFT, 0, 1, 0),
-       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_25_MIX_HP_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_25_MIX_HP_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_25_MIX_HP_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_25_MIX_HP_LEFT, 7, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_25_MIX_HP_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_25_MIX_HP_LEFT, 7, 1, 0),
        SOC_DAPM_SINGLE("MIC1 Switch", M98088_REG_25_MIX_HP_LEFT, 5, 1, 0),
        SOC_DAPM_SINGLE("MIC2 Switch", M98088_REG_25_MIX_HP_LEFT, 6, 1, 0),
        SOC_DAPM_SINGLE("INA1 Switch", M98088_REG_25_MIX_HP_LEFT, 1, 1, 0),
@@ -864,10 +864,10 @@ static const struct snd_kcontrol_new max98088_right_hp_mixer_controls[] = {

 /* Left earpiece/receiver mixer switch */
static const struct snd_kcontrol_new max98088_left_rec_mixer_controls[] = {
-       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_28_MIX_REC_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_28_MIX_REC_LEFT, 0, 1, 0),
-       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_28_MIX_REC_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_28_MIX_REC_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_28_MIX_REC_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_28_MIX_REC_LEFT, 7, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_28_MIX_REC_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_28_MIX_REC_LEFT, 7, 1, 0),
        SOC_DAPM_SINGLE("MIC1 Switch", M98088_REG_28_MIX_REC_LEFT, 5, 1, 0),
        SOC_DAPM_SINGLE("MIC2 Switch", M98088_REG_28_MIX_REC_LEFT, 6, 1, 0),
        SOC_DAPM_SINGLE("INA1 Switch", M98088_REG_28_MIX_REC_LEFT, 1, 1, 0),
--
1.7.1


------------------------------------------------------------------------------------------------------------------------------
>From 2f42206e5e73af88e86158256c47659257a025b4 Mon Sep 17 00:00:00 2001
From: Jin Park <jinyoungp@nvidia.com>
Date: Wed, 11 May 2011 14:41:01 +0900
Subject: [PATCH 2/3] ASoC: codecs: max98088: Moved the EX Limiter Mode from dapm widget to control

Moved the EX Limiter Mode from dapm widget to control, because it was not
required DAPM route.

Signed-off-by: Jin Park <jinyoungp@nvidia.com<mailto:jinyoungp@nvidia.com>>
---
sound/soc/codecs/max98088.c |    6 +-----
1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 3bdaa04..c520093 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -656,8 +656,6 @@ static const struct soc_enum max98088_exmode_enum =
                              ARRAY_SIZE(max98088_exmode_texts),
                              max98088_exmode_texts,
                              max98088_exmode_values);
-static const struct snd_kcontrol_new max98088_exmode_controls =
-       SOC_DAPM_VALUE_ENUM("Route", max98088_exmode_enum);

 static const char *max98088_ex_thresh[] = { /* volts PP */
        "0.6", "1.2", "1.8", "2.4", "3.0", "3.6", "4.2", "4.8"};
@@ -783,6 +781,7 @@ static const struct snd_kcontrol_new max98088_snd_controls[] = {
        SOC_SINGLE("EQ1 Switch", M98088_REG_49_CFG_LEVEL, 0, 1, 0),
        SOC_SINGLE("EQ2 Switch", M98088_REG_49_CFG_LEVEL, 1, 1, 0),

+       SOC_ENUM("EX Limiter Mode", max98088_exmode_enum),
        SOC_ENUM("EX Limiter Threshold", max98088_ex_thresh_enum),

        SOC_ENUM("DAI1 Filter Mode", max98088_filter_mode_enum),
@@ -1094,9 +1093,6 @@ static const struct snd_soc_dapm_widget max98088_dapm_widgets[] = {

        SND_SOC_DAPM_MICBIAS("MICBIAS", M98088_REG_4C_PWR_EN_IN, 3, 0),

-       SND_SOC_DAPM_MUX("EX Limiter Mode", SND_SOC_NOPM, 0, 0,
-               &max98088_exmode_controls),
-
        SND_SOC_DAPM_OUTPUT("HPL"),
        SND_SOC_DAPM_OUTPUT("HPR"),
        SND_SOC_DAPM_OUTPUT("SPKL"),
--
1.7.1


------------------------------------------------------------------------------------------------------------------------------
>From 2ae658d455df52be2ac5691c13e0d8c8190a6cbd Mon Sep 17 00:00:00 2001
From: Jin Park <jinyoungp@nvidia.com>
Date: Wed, 11 May 2011 14:56:14 +0900
Subject: [PATCH 3/3] ASoC: codecs: max98088: Added digital mute function in DAI1 and DAI2

Added digital mute function in DAI1 and DAI2.

Signed-off-by: Jin Park <jinyoungp@nvidia.com<mailto:jinyoungp@nvidia.com>>
---
sound/soc/codecs/max98088.c |   32 ++++++++++++++++++++++++++++++++
sound/soc/codecs/max98088.h |   13 +++++++++++++
2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index c520093..b5ccf37 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1582,6 +1582,36 @@ static int max98088_dai2_set_fmt(struct snd_soc_dai *codec_dai,
        return 0;
}

+static int max98088_dai1_digital_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+       struct snd_soc_codec *codec = codec_dai->codec;
+       int reg;
+
+       if (mute)
+               reg = M98088_DAI_MUTE;
+       else
+               reg = 0;
+
+       snd_soc_update_bits(codec, M98088_REG_2F_LVL_DAI1_PLAY,
+                           M98088_DAI_MUTE_MASK, reg);
+       return 0;
+}
+
+static int max98088_dai2_digital_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+       struct snd_soc_codec *codec = codec_dai->codec;
+       int reg;
+
+       if (mute)
+               reg = M98088_DAI_MUTE;
+       else
+               reg = 0;
+
+       snd_soc_update_bits(codec, M98088_REG_31_LVL_DAI2_PLAY,
+                           M98088_DAI_MUTE_MASK, reg);
+       return 0;
+}
+
static void max98088_sync_cache(struct snd_soc_codec *codec)
{
        u16 *reg_cache = codec->reg_cache;
@@ -1643,12 +1673,14 @@ static struct snd_soc_dai_ops max98088_dai1_ops = {
        .set_sysclk = max98088_dai_set_sysclk,
        .set_fmt = max98088_dai1_set_fmt,
        .hw_params = max98088_dai1_hw_params,
+       .digital_mute = max98088_dai1_digital_mute,
};

 static struct snd_soc_dai_ops max98088_dai2_ops = {
        .set_sysclk = max98088_dai_set_sysclk,
        .set_fmt = max98088_dai2_set_fmt,
        .hw_params = max98088_dai2_hw_params,
+       .digital_mute = max98088_dai2_digital_mute,
};

 static struct snd_soc_dai_driver max98088_dai[] = {
diff --git a/sound/soc/codecs/max98088.h b/sound/soc/codecs/max98088.h
index 56554c7..be89a4f 100644
--- a/sound/soc/codecs/max98088.h
+++ b/sound/soc/codecs/max98088.h
@@ -133,6 +133,19 @@
        #define M98088_REC_LINEMODE             (1<<7)
        #define M98088_REC_LINEMODE_MASK        (1<<7)

+/* M98088_REG_2D_MIX_SPK_CNTL */
+       #define M98088_MIX_SPKR_GAIN_MASK       (3<<2)
+       #define M98088_MIX_SPKR_GAIN_SHIFT      2
+       #define M98088_MIX_SPKL_GAIN_MASK       (3<<0)
+       #define M98088_MIX_SPKL_GAIN_SHIFT      0
+
+/* M98088_REG_2F_LVL_DAI1_PLAY, M98088_REG_31_LVL_DAI2_PLAY */
+       #define M98088_DAI_MUTE                 (1<<7)
+       #define M98088_DAI_MUTE_MASK            (1<<7)
+       #define M98088_DAI_VOICE_GAIN_MASK      (3<<4)
+       #define M98088_DAI_ATTENUATION_MASK     (0xF<<0)
+       #define M98088_DAI_ATTENUATION_SHIFT    0
+
/* M98088_REG_35_LVL_MIC1, M98088_REG_36_LVL_MIC2 */
        #define M98088_MICPRE_MASK              (3<<5)
        #define M98088_MICPRE_SHIFT             5
--
1.7.1



Best regards,
Jinyoung.


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
