From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 08/12] ASoC: wcd9335: add basic controls
Date: Fri, 27 Jul 2018 10:55:11 +0100
Message-ID: <01645941-995f-60ef-5bb1-27811547a555@linaro.org>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-9-srinivas.kandagatla@linaro.org>
 <20180725120407.GO3661@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725120407.GO3661@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Vinod for review comments,

On 25/07/18 13:04, Vinod wrote:
> On 23-07-18, 16:54, Srinivas Kandagatla wrote:
> 
>> +static int wcd9335_set_compander(struct snd_kcontrol *kc,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
>> +	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
>> +	int comp = ((struct soc_mixer_control *) kc->private_value)->shift;
>> +	int value = ucontrol->value.integer.value[0];
>> +	int sel;
>> +
>> +	wcd->comp_enabled[comp] = value;
>> +	sel = value ? WCD9335_HPH_GAIN_SRC_SEL_COMPANDER :
>> +		WCD9335_HPH_GAIN_SRC_SEL_REGISTER;
>> +
>> +	/* Any specific register configuration for compander */
>> +	switch (comp) {
>> +	case COMPANDER_1:
>> +		/* Set Gain Source Select based on compander enable/disable */
>> +		snd_soc_component_update_bits(component, WCD9335_HPH_L_EN,
>> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
>> +		break;
>> +	case COMPANDER_2:
>> +		snd_soc_component_update_bits(component, WCD9335_HPH_R_EN,
>> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
>> +		break;
>> +	case COMPANDER_3:
>> +		break;
>> +	case COMPANDER_4:
>> +		break;
>> +	case COMPANDER_5:
>> +		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO3_GAIN,
>> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
>> +		break;
>> +	case COMPANDER_6:
>> +		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO4_GAIN,
>> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
>> +		break;
>> +	case COMPANDER_7:
>> +		break;
>> +	case COMPANDER_8:
>> +		break;
> 
> why not do:
> 
>          case COMPANDER_3:
>          case COMPANDER_4:
>          case COMPANDER_7:
>          case COMPANDER_8:
>                  break;
> 
> thereby clubbing all the ones not handled together..
> 
I removed the un-handled ones in v2.

>> +static int wcd9335_rx_hph_mode_get(struct snd_kcontrol *kc,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
>> +	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
>> +
>> +	ucontrol->value.integer.value[0] = wcd->hph_mode;
> 
> i think this is an enum so shouldn't value.enumerated.item[0] be used?
> 
Yep, there are one more instances like this, i fixed this in v2.
>> +
>> +	return 0;
>> +}
>> +
>> +static int wcd9335_rx_hph_mode_put(struct snd_kcontrol *kc,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
>> +	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
>> +	u32 mode_val;
>> +
>> +	mode_val = ucontrol->value.enumerated.item[0];
> 
> yaaay

--srini
> 
