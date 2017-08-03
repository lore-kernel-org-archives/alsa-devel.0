From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 4/6] ASoC: codecs: msm8916-wcd-analog:
	add MBHC support
Date: Thu, 3 Aug 2017 12:11:04 +0100
Message-ID: <56b54da2-0e87-a466-6184-ffbd85f631c4@linaro.org>
References: <20170802170930.26083-1-srinivas.kandagatla@linaro.org>
 <20170802170930.26083-5-srinivas.kandagatla@linaro.org>
 <20170802233323.blx36uutaytdexvb@workotop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 86027266847
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 13:11:10 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id m85so12261339wma.0
 for <alsa-devel@alsa-project.org>; Thu, 03 Aug 2017 04:11:10 -0700 (PDT)
In-Reply-To: <20170802233323.blx36uutaytdexvb@workotop.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 03/08/17 00:33, Damien Riegel wrote:
> Hi Srinivas,
> 
> 
> On Wed, Aug 02, 2017 at 07:09:28PM +0200, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> MBHC (MultiButton Headset Control) support is available in pm8921 in two
>> blocks, one to detect mechanical headset insertion and removal and other
>> block to support headset type detection and 5 button detection and othe
>> features like impedance calculation.
>>
>> This patch adds support to:
>> 1> Support to NC and NO type of headset Jacks.
>> 2> Mechanical insertion and detection of headset jack.
>> 3> Detect a 3 pole Headphone and a 4 pole Headset.
>> 4> Detect 5 buttons.
>>
>> Tested it on DB410c with Audio Mezz board with 4 pole and 3 pole
>> headset/headphones.
> 

> Good news! This version has better results. I still have an issue where
> a headphone is reported as a headset when I do this sequence:

Hi Damien,

Thanks for testing..


> 	1. connect headset
> 	2. disconnect headset
> 	3. connect headphone

> Following headphone connections/disconnections are reported correctly.
> Note that I don't press the media key, it's wrongly detected when I pull
> off the cable.

If you do step 3 slowly there is a chance that we get KEY_MEDIA events, 
as headphone is a 3 pole, during hp inserting we would end up shorting 
the MIC and GND lines on the connector, as 3-pole connectors have longer 
GND pole/connector length, this action is same as pressing MEDIA KEY.

The logic in the driver uses this MEDIA KEY press release as advantage 
to detect the accessory type before hs insertion, but this logic could 
break if we are inserting headphone slowly, which is not a normal usecase.

Any solution to this issue can be always break if we are doing slow 
insertion of hs or we endup making the driver complex. I will think 
about this once again and see how other drivers handle this usecase.

> 
> evtest logs:
> 
> 	Plugging headset:
> Event: time 10181.936746, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 1
> Event: time 10181.936746, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 1
> Event: time 10181.936746, -------------- SYN_REPORT ------------
> 	Unplugging headset:
> Event: time 10183.432797, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 1
> Event: time 10183.432797, -------------- SYN_REPORT ------------
> Event: time 10183.871029, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 0
> Event: time 10183.871029, -------------- SYN_REPORT ------------
> Event: time 10183.971521, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 1
> Event: time 10183.971521, -------------- SYN_REPORT ------------
> Event: time 10184.249429, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 0
> Event: time 10184.249429, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 0
> Event: time 10184.249429, -------------- SYN_REPORT ------------
> 	Plugin headphone:
> Event: time 10190.033748, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 1
> Event: time 10190.033748, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 1
> Event: time 10190.033748, -------------- SYN_REPORT ------------
> 	Unplugging headphone:
> Event: time 10191.267473, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 0
> Event: time 10191.267473, -------------- SYN_REPORT ------------
> Event: time 10191.548238, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 0
> Event: time 10191.548238, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 0
> Event: time 10191.548238, -------------- SYN_REPORT ------------
> 	Plugging headphone:
> Event: time 10194.342217, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 1
> Event: time 10194.342217, -------------- SYN_REPORT ------------
> 	Unplugging headphone:
> Event: time 10195.446049, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 0
> Event: time 10195.446049, -------------- SYN_REPORT -----------
> 
> 
> Also, the microphone is not reported when cable is connected and a
> button is pressed down. That might be a bit of a corner case, so I don't
> think it's worth complexifying the driver to handle that.
> 
> A few additional comments inline.
> 
> =
>     ^
>     git am complains about the leading space
> 
>> +			      by internal current source, this is a low power.
>> + - qcom,mbhc-vthreshold-high: Array of 5 thresold voltages in mV for 5 buttons
>> + 			       detection on headset when mbhc is powered up
>     ^
>     same here

Yep, I will fix this in next version.
> 
>> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
>> index dec4978..04a2112 100644
>> --- a/sound/soc/codecs/msm8916-wcd-analog.c
>> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> 
> [...]
> 
>> +int btn_mask = SND_JACK_BTN_0 | SND_JACK_BTN_1 |
>> +	       SND_JACK_BTN_2 | SND_JACK_BTN_3 | SND_JACK_BTN_4;
>> +int hs_jack_mask = SND_JACK_HEADPHONE | SND_JACK_HEADSET;
>> +
> 
> I think they're missing a 'static' (or should they be macros?).
> 
Yep.
>> +#define MBHC_MAX_BUTTONS	(5)
>> +
>>   struct pm8916_wcd_analog_priv {
>>   	u16 pmic_rev;
>>   	u16 codec_version;
>> +	int	mbhc_sw_irq;
>> +	int	mbhc_btn_press_irq;
>> +	int	mbhc_btn_release_irq;
> 
> Is is worth storing these irqs as these values are not used outside of
> pm8916_wcd_analog_spmi_probe?
Will clean this up in next version.
> 
>> +	bool	mbhc_btn_enabled;
>> +	/* special event to detect accessory type */
>> +	bool	mbhc_btn0_pressed;
>> +	bool	detect_accessory_type;
>>   	struct clk *mclk;
>> +	struct snd_soc_codec *codec;
>>   	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
>> +	struct snd_soc_jack *jack;
>> +	bool hphl_jack_type_normally_open;
>> +	bool gnd_jack_type_normally_open;
>> +	/* Voltage threshold when internal current source of 100uA is used */
>> +	u32 vref_btn_cs[MBHC_MAX_BUTTONS];
>> +	/* Voltage threshold when microphone bias is ON */
>> +	u32 vref_btn_micb[MBHC_MAX_BUTTONS];
>>   	unsigned int micbias1_cap_mode;
>>   	unsigned int micbias2_cap_mode;
>>   	unsigned int micbias_mv;
> 
> [...]
> 
>> +static int pm8916_mbhc_configure_bias(struct pm8916_wcd_analog_priv *priv,
>> +				      bool micbias2_enabled)
>> +{
>> +	struct snd_soc_codec *codec = priv->codec;
>> +	u32 coarse, fine, reg_val, reg_addr;
>> +	int *vrefs, i;
>> +
>> +	if (!micbias2_enabled) { /* use internal 100uA Current source */
>> +		/* Enable internal 2.2k Internal Rbias Resistor */
>> +		snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
>> +				    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
>> +				    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
>> +		/* Remove pull down on MIC BIAS2 */
>> +		snd_soc_update_bits(codec, CDC_A_MICB_2_EN,
>> +				   CDC_A_MICB_2_PULL_DOWN_EN_MASK,
>> +				   0);
>> +		/* enable 100uA internal current source */
>> +		snd_soc_update_bits(codec, CDC_A_MBHC_FSM_CTL,
>> +				    CDC_A_MBHC_FSM_CTL_BTN_ISRC_CTRL_MASK,
>> +				    CDC_A_MBHC_FSM_CTL_BTN_ISRC_CTRL_I_100UA);
>> +	}
>> +	snd_soc_update_bits(codec, CDC_A_MBHC_FSM_CTL,
>> +			CDC_A_MBHC_FSM_CTL_MBHC_FSM_EN_MASK,
>> +			CDC_A_MBHC_FSM_CTL_MBHC_FSM_EN);
> 
> Maybe test the value of priv->mbhc_btn_enabled here, otherwise it will
> use erroneous values.
This should be harmless, as we are not handling any of those interrupts, 
but I will fix this in next version.
> 
>> +
>> +	if (micbias2_enabled)
>> +		vrefs = &priv->vref_btn_micb[0];
>> +	else
>> +		vrefs = &priv->vref_btn_cs[0];
>> +
>> +	/* program vref ranges for all the buttons */
>> +	reg_addr = CDC_A_MBHC_BTN0_ZDET_CTL_0;
>> +	for (i = 0; i <  MBHC_MAX_BUTTONS; i++) {
>> +		/* split mv in to coarse parts of 100mv & fine parts of 12mv */
>> +		coarse = (vrefs[i] / 100);
>> +		fine = ((vrefs[i] % 100) / 12);
>> +		reg_val = (coarse << CDC_A_MBHC_BTN_VREF_COARSE_SHIFT) |
>> +			 (fine << CDC_A_MBHC_BTN_VREF_FINE_SHIFT);
>> +		snd_soc_update_bits(codec, reg_addr,
>> +			       CDC_A_MBHC_BTN_VREF_MASK,
>> +			       reg_val);
>> +		reg_addr++;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> [...]
> 
>> +static irqreturn_t pm8916_mbhc_switch_irq_handler(int irq, void *arg)
>> +{
>> +	struct pm8916_wcd_analog_priv *priv = arg;
>> +	struct snd_soc_codec *codec = priv->codec;
>> +	bool micbias_enabled = false;
> 
> micbias_enabled can be moved to the ins case as it's only used there.
> 
okay..

>> +	bool ins = false;
>> +
>> +					  &priv->vref_btn_cs[0],
>> +					  MBHC_MAX_BUTTONS);
>> +	if (rval < 0)
>> +		priv->mbhc_btn_enabled = false;
> 
> You should add brackets and maybe move the error message here (see my
> comment at the end).

Yes, if it make it more readable.
> 
>> +	else {
>> +		rval = of_property_read_u32_array(dev->of_node,
>> +						  "qcom,mbhc-vthreshold-high",
>> +						  &priv->vref_btn_micb[0],
>> +						  MBHC_MAX_BUTTONS);
>> +		if (rval < 0)
>> +			priv->mbhc_btn_enabled = false;
>> +	}
>> +
>>   	return 0;
>>   }

>> +		dev_err(dev, "MBHC button detection disabled\n");
> 
> imho, if you want to print an error message if this feature is
> unavailable, you should do that when parsing properties and let the
> users know which missing property caused the error.
Okay will do that..
> 
> 
> Regards,
> 
