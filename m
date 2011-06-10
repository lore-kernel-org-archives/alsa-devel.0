From: Jinyoung Park <jinyoungp@nvidia.com>
Subject: Re: [PATCH 1/1] ASoC: codecs: max98088: Combined DAI
 operations for DAI1 and DAI2.
Date: Fri, 10 Jun 2011 18:13:45 +0900
Message-ID: <4DF1E049.3030301@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 778FD103819
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 11:13:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter.Hsiang@maxim-ic.com, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, jassisinghbrar@gmail.com, 'Liam Girdwood' <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Submitting again the patch what applied Peter's comments.

>> These added local variables and their initialization repeats.
>> It may be better to put them in struct max98088_cdata[].
> I got it. I will change register offset into struct max98088_cdata[].
>
>> DAI2 does not have an OSR bit in the _CLOCK register.
>> In the combined function, this should be conditionally for DAI1 only.
> I will fix it.

Thanks,
Jin.

Combined DAI operations for DAI1 and DAI2.
For this, added id into DAI runtime data to identify each DAI.

Signed-off-by: Jin Park <jinyoungp@nvidia.com>
---
 sound/soc/codecs/max98088.c |  278
+++++++++++--------------------------------
 1 files changed, 69 insertions(+), 209 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index ac65a2d..3c0e4f7 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -36,6 +36,14 @@ struct max98088_cdata {
        unsigned int rate;
        unsigned int fmt;
        int eq_sel;
+
+       unsigned short clkmode_reg;
+       unsigned short clk_reg;
+       unsigned short clkcfg_hi_reg;
+       unsigned short clkcfg_lo_reg;
+       unsigned short fmt_reg;
+       unsigned short play_lvl_reg;
+       unsigned short filters_reg;
 };

 struct max98088_priv {
@@ -1253,29 +1261,26 @@ static inline int rate_value(int rate, u8 *value)
        return -EINVAL;
 }

-static int max98088_dai1_hw_params(struct snd_pcm_substream *substream,
+static int max98088_dai_hw_params(struct snd_pcm_substream *substream,
                                   struct snd_pcm_hw_params *params,
                                   struct snd_soc_dai *dai)
 {
        struct snd_soc_codec *codec = dai->codec;
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
-       struct max98088_cdata *cdata;
+       struct max98088_cdata *cdata = &max98088->dai[dai->id - 1];
        unsigned long long ni;
        unsigned int rate;
-       u8 regval;
-
-       cdata = &max98088->dai[0];
+       u8 val;

        rate = params_rate(params);

        switch (params_format(params)) {
        case SNDRV_PCM_FORMAT_S16_LE:
-               snd_soc_update_bits(codec, M98088_REG_14_DAI1_FORMAT,
-                       M98088_DAI_WS, 0);
+               snd_soc_update_bits(codec, cdata->fmt_reg,
M98088_DAI_WS, 0);
                break;
        case SNDRV_PCM_FORMAT_S24_LE:
-               snd_soc_update_bits(codec, M98088_REG_14_DAI1_FORMAT,
-                       M98088_DAI_WS, M98088_DAI_WS);
+               snd_soc_update_bits(codec, cdata->fmt_reg, M98088_DAI_WS,
+                                   M98088_DAI_WS);
                break;
        default:
                return -EINVAL;
@@ -1283,16 +1288,14 @@ static int max98088_dai1_hw_params(struct
snd_pcm_substream *substream,

        snd_soc_update_bits(codec, M98088_REG_51_PWR_SYS,
M98088_SHDNRUN, 0);

-       if (rate_value(rate, &regval))
+       if (rate_value(rate, &val))
                return -EINVAL;

-       snd_soc_update_bits(codec, M98088_REG_11_DAI1_CLKMODE,
-               M98088_CLKMODE_MASK, regval);
+       snd_soc_update_bits(codec, cdata->clkmode_reg,
M98088_CLKMODE_MASK, val);
        cdata->rate = rate;

        /* Configure NI when operating as master */
-       if (snd_soc_read(codec, M98088_REG_14_DAI1_FORMAT)
-               & M98088_DAI_MAS) {
+       if (snd_soc_read(codec, cdata->fmt_reg) & M98088_DAI_MAS) {
                if (max98088->sysclk == 0) {
                        dev_err(codec->dev, "Invalid system clock
frequency\n");
                        return -EINVAL;
@@ -1300,86 +1303,16 @@ static int max98088_dai1_hw_params(struct
snd_pcm_substream *substream,
                ni = 65536ULL * (rate < 50000 ? 96ULL : 48ULL)
                                * (unsigned long long int)rate;
                do_div(ni, (unsigned long long int)max98088->sysclk);
-               snd_soc_write(codec, M98088_REG_12_DAI1_CLKCFG_HI,
-                       (ni >> 8) & 0x7F);
-               snd_soc_write(codec, M98088_REG_13_DAI1_CLKCFG_LO,
-                       ni & 0xFF);
+               snd_soc_write(codec, cdata->clkcfg_hi_reg, (ni >> 8) &
0x7F);
+               snd_soc_write(codec, cdata->clkcfg_lo_reg, ni & 0xFF);
        }

        /* Update sample rate mode */
        if (rate < 50000)
-               snd_soc_update_bits(codec, M98088_REG_18_DAI1_FILTERS,
-                       M98088_DAI_DHF, 0);
+               snd_soc_update_bits(codec, cdata->filters_reg,
M98088_DAI_DHF, 0);
        else
-               snd_soc_update_bits(codec, M98088_REG_18_DAI1_FILTERS,
-                       M98088_DAI_DHF, M98088_DAI_DHF);
-
-       snd_soc_update_bits(codec, M98088_REG_51_PWR_SYS, M98088_SHDNRUN,
-               M98088_SHDNRUN);
-
-       return 0;
-}
-
-static int max98088_dai2_hw_params(struct snd_pcm_substream *substream,
-                                  struct snd_pcm_hw_params *params,
-                                  struct snd_soc_dai *dai)
-{
-       struct snd_soc_codec *codec = dai->codec;
-       struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
-       struct max98088_cdata *cdata;
-       unsigned long long ni;
-       unsigned int rate;
-       u8 regval;
-
-       cdata = &max98088->dai[1];
-
-       rate = params_rate(params);
-
-       switch (params_format(params)) {
-       case SNDRV_PCM_FORMAT_S16_LE:
-               snd_soc_update_bits(codec, M98088_REG_1C_DAI2_FORMAT,
-                       M98088_DAI_WS, 0);
-               break;
-       case SNDRV_PCM_FORMAT_S24_LE:
-               snd_soc_update_bits(codec, M98088_REG_1C_DAI2_FORMAT,
-                       M98088_DAI_WS, M98088_DAI_WS);
-               break;
-       default:
-               return -EINVAL;
-       }
-
-       snd_soc_update_bits(codec, M98088_REG_51_PWR_SYS,
M98088_SHDNRUN, 0);
-
-       if (rate_value(rate, &regval))
-               return -EINVAL;
-
-       snd_soc_update_bits(codec, M98088_REG_19_DAI2_CLKMODE,
-               M98088_CLKMODE_MASK, regval);
-       cdata->rate = rate;
-
-       /* Configure NI when operating as master */
-       if (snd_soc_read(codec, M98088_REG_1C_DAI2_FORMAT)
-               & M98088_DAI_MAS) {
-               if (max98088->sysclk == 0) {
-                       dev_err(codec->dev, "Invalid system clock
frequency\n");
-                       return -EINVAL;
-               }
-               ni = 65536ULL * (rate < 50000 ? 96ULL : 48ULL)
-                               * (unsigned long long int)rate;
-               do_div(ni, (unsigned long long int)max98088->sysclk);
-               snd_soc_write(codec, M98088_REG_1A_DAI2_CLKCFG_HI,
-                       (ni >> 8) & 0x7F);
-               snd_soc_write(codec, M98088_REG_1B_DAI2_CLKCFG_LO,
-                       ni & 0xFF);
-       }
-
-       /* Update sample rate mode */
-       if (rate < 50000)
-               snd_soc_update_bits(codec, M98088_REG_20_DAI2_FILTERS,
-                       M98088_DAI_DHF, 0);
-       else
-               snd_soc_update_bits(codec, M98088_REG_20_DAI2_FILTERS,
-                       M98088_DAI_DHF, M98088_DAI_DHF);
+               snd_soc_update_bits(codec, cdata->filters_reg,
M98088_DAI_DHF,
+                                   M98088_DAI_DHF);

        snd_soc_update_bits(codec, M98088_REG_51_PWR_SYS, M98088_SHDNRUN,
                M98088_SHDNRUN);
@@ -1423,16 +1356,13 @@ static int max98088_dai_set_sysclk(struct
snd_soc_dai *dai,
        return 0;
 }

-static int max98088_dai1_set_fmt(struct snd_soc_dai *codec_dai,
-                                unsigned int fmt)
+static int max98088_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-       struct snd_soc_codec *codec = codec_dai->codec;
+       struct snd_soc_codec *codec = dai->codec;
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
-       struct max98088_cdata *cdata;
-       u8 reg15val;
-       u8 reg14val = 0;
-
-       cdata = &max98088->dai[0];
+       struct max98088_cdata *cdata = &max98088->dai[dai->id - 1];
+       u8 clk_val;
+       u8 fmt_val = 0;

        if (fmt != cdata->fmt) {
                cdata->fmt = fmt;
@@ -1440,14 +1370,12 @@ static int max98088_dai1_set_fmt(struct
snd_soc_dai *codec_dai,
                switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
                case SND_SOC_DAIFMT_CBS_CFS:
                        /* Slave mode PLL */
-                       snd_soc_write(codec, M98088_REG_12_DAI1_CLKCFG_HI,
-                               0x80);
-                       snd_soc_write(codec, M98088_REG_13_DAI1_CLKCFG_LO,
-                               0x00);
+                       snd_soc_write(codec, cdata->clkcfg_hi_reg, 0x80);
+                       snd_soc_write(codec, cdata->clkcfg_lo_reg, 0x00);
                        break;
                case SND_SOC_DAIFMT_CBM_CFM:
                        /* Set to master mode */
-                       reg14val |= M98088_DAI_MAS;
+                       fmt_val |= M98088_DAI_MAS;
                        break;
                case SND_SOC_DAIFMT_CBS_CFM:
                case SND_SOC_DAIFMT_CBM_CFS:
@@ -1458,7 +1386,7 @@ static int max98088_dai1_set_fmt(struct
snd_soc_dai *codec_dai,

                switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
                case SND_SOC_DAIFMT_I2S:
-                       reg14val |= M98088_DAI_DLY;
+                       fmt_val |= M98088_DAI_DLY;
                        break;
                case SND_SOC_DAIFMT_LEFT_J:
                        break;
@@ -1470,127 +1398,43 @@ static int max98088_dai1_set_fmt(struct
snd_soc_dai *codec_dai,
                case SND_SOC_DAIFMT_NB_NF:
                        break;
                case SND_SOC_DAIFMT_NB_IF:
-                       reg14val |= M98088_DAI_WCI;
+                       fmt_val |= M98088_DAI_WCI;
                        break;
                case SND_SOC_DAIFMT_IB_NF:
-                       reg14val |= M98088_DAI_BCI;
+                       fmt_val |= M98088_DAI_BCI;
                        break;
                case SND_SOC_DAIFMT_IB_IF:
-                       reg14val |= M98088_DAI_BCI|M98088_DAI_WCI;
+                       fmt_val |= M98088_DAI_BCI|M98088_DAI_WCI;
                        break;
                default:
                        return -EINVAL;
                }

-               snd_soc_update_bits(codec, M98088_REG_14_DAI1_FORMAT,
+               snd_soc_update_bits(codec, cdata->fmt_reg,
                        M98088_DAI_MAS | M98088_DAI_DLY | M98088_DAI_BCI |
-                       M98088_DAI_WCI, reg14val);
+                       M98088_DAI_WCI, fmt_val);

-               reg15val = M98088_DAI_BSEL64;
-               if (max98088->digmic)
-                       reg15val |= M98088_DAI_OSR64;
-               snd_soc_write(codec, M98088_REG_15_DAI1_CLOCK, reg15val);
+               clk_val = M98088_DAI_BSEL64;
+               if ((dai->id == 1) && max98088->digmic)
+                       clk_val |= M98088_DAI_OSR64;
+               snd_soc_write(codec, cdata->clk_reg, clk_val);
        }

        return 0;
 }

-static int max98088_dai2_set_fmt(struct snd_soc_dai *codec_dai,
-                                unsigned int fmt)
+static int max98088_dai_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-       struct snd_soc_codec *codec = codec_dai->codec;
+       struct snd_soc_codec *codec = dai->codec;
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
-       struct max98088_cdata *cdata;
-       u8 reg1Cval = 0;
-
-       cdata = &max98088->dai[1];
-
-       if (fmt != cdata->fmt) {
-               cdata->fmt = fmt;
-
-               switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-               case SND_SOC_DAIFMT_CBS_CFS:
-                       /* Slave mode PLL */
-                       snd_soc_write(codec, M98088_REG_1A_DAI2_CLKCFG_HI,
-                               0x80);
-                       snd_soc_write(codec, M98088_REG_1B_DAI2_CLKCFG_LO,
-                               0x00);
-                       break;
-               case SND_SOC_DAIFMT_CBM_CFM:
-                       /* Set to master mode */
-                       reg1Cval |= M98088_DAI_MAS;
-                       break;
-               case SND_SOC_DAIFMT_CBS_CFM:
-               case SND_SOC_DAIFMT_CBM_CFS:
-               default:
-                       dev_err(codec->dev, "Clock mode unsupported");
-                       return -EINVAL;
-               }
-
-               switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-               case SND_SOC_DAIFMT_I2S:
-                       reg1Cval |= M98088_DAI_DLY;
-                       break;
-               case SND_SOC_DAIFMT_LEFT_J:
-                       break;
-               default:
-                       return -EINVAL;
-               }
-
-               switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-               case SND_SOC_DAIFMT_NB_NF:
-                       break;
-               case SND_SOC_DAIFMT_NB_IF:
-                       reg1Cval |= M98088_DAI_WCI;
-                       break;
-               case SND_SOC_DAIFMT_IB_NF:
-                       reg1Cval |= M98088_DAI_BCI;
-                       break;
-               case SND_SOC_DAIFMT_IB_IF:
-                       reg1Cval |= M98088_DAI_BCI|M98088_DAI_WCI;
-                       break;
-               default:
-                       return -EINVAL;
-               }
-
-               snd_soc_update_bits(codec, M98088_REG_1C_DAI2_FORMAT,
-                       M98088_DAI_MAS | M98088_DAI_DLY | M98088_DAI_BCI |
-                       M98088_DAI_WCI, reg1Cval);
-
-               snd_soc_write(codec, M98088_REG_1D_DAI2_CLOCK,
-                       M98088_DAI_BSEL64);
-       }
-
-       return 0;
-}
-
-static int max98088_dai1_digital_mute(struct snd_soc_dai *codec_dai,
int mute)
-{
-       struct snd_soc_codec *codec = codec_dai->codec;
-       int reg;
-
-       if (mute)
-               reg = M98088_DAI_MUTE;
-       else
-               reg = 0;
-
-       snd_soc_update_bits(codec, M98088_REG_2F_LVL_DAI1_PLAY,
-                           M98088_DAI_MUTE_MASK, reg);
-       return 0;
-}
-
-static int max98088_dai2_digital_mute(struct snd_soc_dai *codec_dai,
int mute)
-{
-       struct snd_soc_codec *codec = codec_dai->codec;
-       int reg;
+       struct max98088_cdata *cdata = &max98088->dai[dai->id - 1];
+       int val = 0;

        if (mute)
-               reg = M98088_DAI_MUTE;
-       else
-               reg = 0;
+               val = M98088_DAI_MUTE;

-       snd_soc_update_bits(codec, M98088_REG_31_LVL_DAI2_PLAY,
-                           M98088_DAI_MUTE_MASK, reg);
+       snd_soc_update_bits(codec, cdata->play_lvl_reg,
M98088_DAI_MUTE_MASK,
+                                  val);
        return 0;
 }

@@ -1653,21 +1497,22 @@ static int max98088_set_bias_level(struct
snd_soc_codec *codec,

 static struct snd_soc_dai_ops max98088_dai1_ops = {
        .set_sysclk = max98088_dai_set_sysclk,
-       .set_fmt = max98088_dai1_set_fmt,
-       .hw_params = max98088_dai1_hw_params,
-       .digital_mute = max98088_dai1_digital_mute,
+       .set_fmt = max98088_dai_set_fmt,
+       .hw_params = max98088_dai_hw_params,
+       .digital_mute = max98088_dai_digital_mute,
 };

 static struct snd_soc_dai_ops max98088_dai2_ops = {
        .set_sysclk = max98088_dai_set_sysclk,
-       .set_fmt = max98088_dai2_set_fmt,
-       .hw_params = max98088_dai2_hw_params,
-       .digital_mute = max98088_dai2_digital_mute,
+       .set_fmt = max98088_dai_set_fmt,
+       .hw_params = max98088_dai_hw_params,
+       .digital_mute = max98088_dai_digital_mute,
 };

 static struct snd_soc_dai_driver max98088_dai[] = {
 {
        .name = "HiFi",
+       .id = 1,
        .playback = {
                .stream_name = "HiFi Playback",
                .channels_min = 1,
@@ -1686,6 +1531,7 @@ static struct snd_soc_dai_driver max98088_dai[] = {
 },
 {
        .name = "Aux",
+       .id = 2,
        .playback = {
                .stream_name = "Aux Playback",
                .channels_min = 1,
@@ -1977,11 +1823,25 @@ static int max98088_probe(struct snd_soc_codec
*codec)
        cdata->rate = (unsigned)-1;
        cdata->fmt  = (unsigned)-1;
        cdata->eq_sel = 0;
+       cdata->clkmode_reg = M98088_REG_11_DAI1_CLKMODE;
+       cdata->clk_reg = M98088_REG_15_DAI1_CLOCK;
+       cdata->clkcfg_hi_reg = M98088_REG_12_DAI1_CLKCFG_HI;
+       cdata->clkcfg_lo_reg = M98088_REG_13_DAI1_CLKCFG_LO;
+       cdata->fmt_reg = M98088_REG_14_DAI1_FORMAT;
+       cdata->play_lvl_reg = M98088_REG_2F_LVL_DAI1_PLAY;
+       cdata->filters_reg = M98088_REG_18_DAI1_FILTERS;

        cdata = &max98088->dai[1];
        cdata->rate = (unsigned)-1;
        cdata->fmt  = (unsigned)-1;
        cdata->eq_sel = 0;
+       cdata->clkmode_reg = M98088_REG_19_DAI2_CLKMODE;
+       cdata->clk_reg = M98088_REG_1D_DAI2_CLOCK;
+       cdata->clkcfg_hi_reg = M98088_REG_1A_DAI2_CLKCFG_HI;
+       cdata->clkcfg_lo_reg = M98088_REG_1B_DAI2_CLKCFG_LO;
+       cdata->fmt_reg = M98088_REG_1C_DAI2_FORMAT;
+       cdata->play_lvl_reg = M98088_REG_31_LVL_DAI2_PLAY;
+       cdata->filters_reg = M98088_REG_20_DAI2_FILTERS;

        max98088->ina_state = 0;
        max98088->inb_state = 0;
--
1.7.1
