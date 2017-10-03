From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] ASoC: codecs: msm8916-wcd-analog: configure micbias in
 mbhc setup
Date: Tue, 3 Oct 2017 21:49:01 +0100
Message-ID: <525ce7f4-7069-2a74-6493-616f2342710c@linaro.org>
References: <20171003132735.29401-1-damien.riegel@savoirfairelinux.com>
 <d832c3e0-8d39-5880-3210-9b06d2d6ceb8@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d832c3e0-8d39-5880-3210-9b06d2d6ceb8@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, kernel@savoirfairelinux.com
List-Id: alsa-devel@alsa-project.org



On 03/10/17 21:42, Srinivas Kandagatla wrote:
> 
> 
> On 03/10/17 14:27, Damien Riegel wrote:
>> The very first time a headset is plugged in, detection is unreliable
>> because bias hasn't been configured yet, it's done once a mechanical
>> insertion interrupt has been triggered, so following insertions (and
>> thus detections) are not affected.
>>
>> To fix the very first detection, the bias must also be configured in the
>> function that setup the MBHC. Move pm8916_wcd_setup_mbhc after
>> pm8916_mbhc_configure_bias to avoid a forward declaration.
>>
>> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
>> ---
>> Changes in v2:
>>   - squash the two patches in one patch only
> 
> I do not see the squashed patches here??
> It looks like its just the first patch.

Please Ignore this comment!!
Opps!! should have looked at it carefully!!


Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> 
> Thanks,
> srini
>>
>>   sound/soc/codecs/msm8916-wcd-analog.c | 94 
>> +++++++++++++++++++----------------
>>   1 file changed, 50 insertions(+), 44 deletions(-)
>>
>> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c 
>> b/sound/soc/codecs/msm8916-wcd-analog.c
>> index f562f2d86907..71494e9dbdcb 100644
>> --- a/sound/soc/codecs/msm8916-wcd-analog.c
>> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
>> @@ -443,50 +443,6 @@ static int 
>> pm8916_wcd_analog_enable_micbias_int1(struct
>>                                wcd->micbias1_cap_mode);
>>   }
>> -static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
>> -{
>> -    struct snd_soc_codec *codec = wcd->codec;
>> -    u32 plug_type = 0;
>> -    u32 int_en_mask;
>> -
>> -    snd_soc_write(codec, CDC_A_MBHC_DET_CTL_1,
>> -              CDC_A_MBHC_DET_CTL_L_DET_EN |
>> -              CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_INSERTION |
>> -              CDC_A_MBHC_DET_CTL_MIC_CLAMP_CTL_AUTO |
>> -              CDC_A_MBHC_DET_CTL_MBHC_BIAS_EN);
>> -
>> -    if (wcd->hphl_jack_type_normally_open)
>> -        plug_type |= CDC_A_HPHL_PLUG_TYPE_NO;
>> -
>> -    if (wcd->gnd_jack_type_normally_open)
>> -        plug_type |= CDC_A_GND_PLUG_TYPE_NO;
>> -
>> -    snd_soc_write(codec, CDC_A_MBHC_DET_CTL_2,
>> -              CDC_A_MBHC_DET_CTL_HS_L_DET_PULL_UP_CTRL_I_3P0 |
>> -              CDC_A_MBHC_DET_CTL_HS_L_DET_COMPA_CTRL_V0P9_VDD |
>> -              plug_type |
>> -              CDC_A_MBHC_DET_CTL_HPHL_100K_TO_GND_EN);
>> -
>> -
>> -    snd_soc_write(codec, CDC_A_MBHC_DBNC_TIMER,
>> -              CDC_A_MBHC_DBNC_TIMER_INSREM_DBNC_T_256_MS |
>> -              CDC_A_MBHC_DBNC_TIMER_BTN_DBNC_T_16MS);
>> -
>> -    /* enable MBHC clock */
>> -    snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
>> -                DIG_CLK_CTL_D_MBHC_CLK_EN_MASK,
>> -                DIG_CLK_CTL_D_MBHC_CLK_EN);
>> -
>> -    int_en_mask = MBHC_SWITCH_INT;
>> -    if (wcd->mbhc_btn_enabled)
>> -        int_en_mask |= MBHC_BUTTON_PRESS_DET | MBHC_BUTTON_RELEASE_DET;
>> -
>> -    snd_soc_update_bits(codec, CDC_D_INT_EN_CLR, int_en_mask, 0);
>> -    snd_soc_update_bits(codec, CDC_D_INT_EN_SET, int_en_mask, 
>> int_en_mask);
>> -    wcd->mbhc_btn0_released = false;
>> -    wcd->detect_accessory_type = true;
>> -}
>> -
>>   static int pm8916_mbhc_configure_bias(struct pm8916_wcd_analog_priv 
>> *priv,
>>                         bool micbias2_enabled)
>>   {
>> @@ -534,6 +490,56 @@ static int pm8916_mbhc_configure_bias(struct 
>> pm8916_wcd_analog_priv *priv,
>>       return 0;
>>   }
>> +static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
>> +{
>> +    struct snd_soc_codec *codec = wcd->codec;
>> +    bool micbias_enabled = false;
>> +    u32 plug_type = 0;
>> +    u32 int_en_mask;
>> +
>> +    snd_soc_write(codec, CDC_A_MBHC_DET_CTL_1,
>> +              CDC_A_MBHC_DET_CTL_L_DET_EN |
>> +              CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_INSERTION |
>> +              CDC_A_MBHC_DET_CTL_MIC_CLAMP_CTL_AUTO |
>> +              CDC_A_MBHC_DET_CTL_MBHC_BIAS_EN);
>> +
>> +    if (wcd->hphl_jack_type_normally_open)
>> +        plug_type |= CDC_A_HPHL_PLUG_TYPE_NO;
>> +
>> +    if (wcd->gnd_jack_type_normally_open)
>> +        plug_type |= CDC_A_GND_PLUG_TYPE_NO;
>> +
>> +    snd_soc_write(codec, CDC_A_MBHC_DET_CTL_2,
>> +              CDC_A_MBHC_DET_CTL_HS_L_DET_PULL_UP_CTRL_I_3P0 |
>> +              CDC_A_MBHC_DET_CTL_HS_L_DET_COMPA_CTRL_V0P9_VDD |
>> +              plug_type |
>> +              CDC_A_MBHC_DET_CTL_HPHL_100K_TO_GND_EN);
>> +
>> +
>> +    snd_soc_write(codec, CDC_A_MBHC_DBNC_TIMER,
>> +              CDC_A_MBHC_DBNC_TIMER_INSREM_DBNC_T_256_MS |
>> +              CDC_A_MBHC_DBNC_TIMER_BTN_DBNC_T_16MS);
>> +
>> +    /* enable MBHC clock */
>> +    snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
>> +                DIG_CLK_CTL_D_MBHC_CLK_EN_MASK,
>> +                DIG_CLK_CTL_D_MBHC_CLK_EN);
>> +
>> +    if (snd_soc_read(codec, CDC_A_MICB_2_EN) & CDC_A_MICB_2_EN_ENABLE)
>> +        micbias_enabled = true;
>> +
>> +    pm8916_mbhc_configure_bias(wcd, micbias_enabled);
>> +
>> +    int_en_mask = MBHC_SWITCH_INT;
>> +    if (wcd->mbhc_btn_enabled)
>> +        int_en_mask |= MBHC_BUTTON_PRESS_DET | MBHC_BUTTON_RELEASE_DET;
>> +
>> +    snd_soc_update_bits(codec, CDC_D_INT_EN_CLR, int_en_mask, 0);
>> +    snd_soc_update_bits(codec, CDC_D_INT_EN_SET, int_en_mask, 
>> int_en_mask);
>> +    wcd->mbhc_btn0_released = false;
>> +    wcd->detect_accessory_type = true;
>> +}
>> +
>>   static int pm8916_wcd_analog_enable_micbias_int2(struct
>>                             snd_soc_dapm_widget
>>                             *w, struct snd_kcontrol
>>
