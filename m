From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC:nau8825: automatic LRCK and BCLK divide
	in master mode
Date: Thu, 2 Feb 2017 15:36:50 +0800
Message-ID: <1486021010-32340-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E266026750E
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 08:37:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Provide the automatic configurable LRC and BCLK divide. The bit clock rate
can be chosen by userspace. The driver will make configurations of LRCK
and BCLK automatically when playback or capture in master mode.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8825.h |  1 +
 2 files changed, 57 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 4576f98..502443b 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1007,6 +1007,42 @@ static int nau8825_biq_coeff_put(struct snd_kcontrol *kcontrol,
        return 0;
 }

+int nau8825_bclk_rate_get_enum(struct snd_kcontrol *kcontrol,
+       struct snd_ctl_elem_value *ucontrol)
+{
+       struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+       struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+       unsigned int item;
+
+       item = snd_soc_enum_val_to_item(e, nau8825->bclk_rate);
+       ucontrol->value.enumerated.item[0] = item;
+
+       return 0;
+}
+
+int nau8825_bclk_rate_put_enum(struct snd_kcontrol *kcontrol,
+       struct snd_ctl_elem_value *ucontrol)
+{
+       struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+       struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+       unsigned int *item = ucontrol->value.enumerated.item;
+       unsigned int val;
+       bool change = false;
+
+       if (item[0] >= e->items)
+               return -EINVAL;
+
+       val = snd_soc_enum_item_to_val(e, item[0]);
+       if (val != nau8825->bclk_rate) {
+               nau8825->bclk_rate = val;
+               change = true;
+       }
+
+       return change;
+}
+
 static const char * const nau8825_biq_path[] = {
        "ADC", "DAC"
 };
@@ -1031,6 +1067,13 @@ static const struct soc_enum nau8825_dac_oversampl_enum =
        SOC_ENUM_SINGLE(NAU8825_REG_DAC_CTRL1, NAU8825_DAC_OVERSAMPLE_SFT,
                ARRAY_SIZE(nau8825_dac_oversampl), nau8825_dac_oversampl);

+static const char * const nau8825_bclk_rate[] = {
+       "128fs", "64fs", "32fs" };
+
+static const struct soc_enum nau8825_bclk_rate_enum =
+       SOC_ENUM_SINGLE(SND_SOC_NOPM, 0,
+               ARRAY_SIZE(nau8825_bclk_rate), nau8825_bclk_rate);
+
 static const DECLARE_TLV_DB_MINMAX_MUTE(adc_vol_tlv, -10300, 2400);
 static const DECLARE_TLV_DB_MINMAX_MUTE(sidetone_vol_tlv, -4200, 0);
 static const DECLARE_TLV_DB_MINMAX(dac_vol_tlv, -5400, 0);
@@ -1055,6 +1098,9 @@ static const struct snd_kcontrol_new nau8825_controls[] = {
        SOC_ENUM("BIQ Path Select", nau8825_biq_path_enum),
        SND_SOC_BYTES_EXT("BIQ Coefficients", 20,
                  nau8825_biq_coeff_get, nau8825_biq_coeff_put),
+
+       SOC_ENUM_EXT("BCLK rate", nau8825_bclk_rate_enum,
+               nau8825_bclk_rate_get_enum, nau8825_bclk_rate_put_enum),
 };

 /* DAC Mux 0x33[9] and 0x34[9] */
@@ -1343,6 +1389,14 @@ static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
        regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
                NAU8825_I2S_MS_MASK, ctrl2_val);

+       if (ctrl2_val & NAU8825_I2S_MS_MASTER) {
+               regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+                       NAU8825_I2S_BLK_DIV_MASK, nau8825->bclk_rate);
+               regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+                       NAU8825_I2S_LRC_DIV_MASK,
+                       (nau8825->bclk_rate + 1) << NAU8825_I2S_LRC_DIV_SFT);
+       }
+
        /* Release the semaphone. */
        nau8825_sema_release(nau8825);

@@ -2497,6 +2551,8 @@ static int nau8825_i2c_probe(struct i2c_client *i2c,
                return PTR_ERR(nau8825->regmap);
        nau8825->dev = dev;
        nau8825->irq = i2c->irq;
+       /* assign 32fs as default bit clock rate */
+       nau8825->bclk_rate = 2;
        /* Initiate parameters, semaphone and work queue which are needed in
         * cross talk suppression measurment function.
         */
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 514fd13..5f2ed8d 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -476,6 +476,7 @@ struct nau8825 {
        int xtalk_event_mask;
        bool xtalk_protect;
        int imp_rms[NAU8825_XTALK_IMM];
+       int bclk_rate;
 };

 int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
--
2.6.4



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
