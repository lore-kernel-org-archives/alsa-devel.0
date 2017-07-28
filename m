From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 5/6] ASoC: codecs: msm8916-wcd-analog:
	add MBHC support
Date: Fri, 28 Jul 2017 15:12:06 +0100
Message-ID: <4f5d7239-5591-68db-5d1f-9fcc7cf45f6b@linaro.org>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
 <20170726003512.18965-6-srinivas.kandagatla@linaro.org>
 <20170728135156.ifdo2ev44eldrw4r@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com
 [209.85.128.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FFBE2676F1
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 16:12:10 +0200 (CEST)
Received: by mail-wr0-f172.google.com with SMTP id y43so155601358wrd.3
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 07:12:10 -0700 (PDT)
In-Reply-To: <20170728135156.ifdo2ev44eldrw4r@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org



On 28/07/17 14:51, Mark Brown wrote:
> On Wed, Jul 26, 2017 at 02:35:11AM +0200, srinivas.kandagatla@linaro.org wrote:
> 
>> +	if (wcd->hphl_jack_type_normally_open)
>> +		plug_type = CDC_A_HPHL_PLUG_TYPE_NO;
>> +
>> +	if (wcd->gnd_jack_type_normally_open)
>> +		plug_type |= CDC_A_GND_PLUG_TYPE_NO;
> 
> It'd be clearer to use |= consistently, this is just confusing as it
> makes it look like there's a path where things aren't initialized.

Yep, I will fix this in next version.
> 
>> +	btn_result = snd_soc_read(codec, CDC_A_MBHC_RESULT_1) &
>> +				  CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK;
>> +
>> +	if (!btn_result)
>> +		priv->mbhc_btn0_pressed = false;
>> +
>> +	snd_jack_report(priv->jack->jack, 0);
> 
> This checks to see if the read worked, uses it to decide if it should
> clear the button pressed flag but unconditionally reports that the
> button is not pressed.  It also discards the read error if there was one
> without reporting that.  This needs cleanup.
Okay, will clean this part in next version.
> 
>> +	btn_result = snd_soc_read(codec, CDC_A_MBHC_RESULT_1) &
>> +				  CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK;
>> +
>> +	switch (btn_result) {
>> +	case 0xf:
>> +		snd_jack_report(priv->jack->jack, SND_JACK_BTN_4);
>> +		break;
>> +	case 0x7:
>> +		snd_jack_report(priv->jack->jack, SND_JACK_BTN_3);
>> +		break;
>> +	case 0x3:
>> +		snd_jack_report(priv->jack->jack, SND_JACK_BTN_2);
>> +		break;
>> +	case 0x1:
>> +		snd_jack_report(priv->jack->jack, SND_JACK_BTN_1);
>> +		break;
>> +	case 0:
>> +		priv->mbhc_btn0_pressed = true;
>> +		snd_jack_report(priv->jack->jack, SND_JACK_BTN_0);
>> +		break;
>> +	}
> 
> Here we silently ignore any value we get back from the chip that we
> didn't expect and all read errors.

I would not expect anyother values if the vrefs are programmed 
correctly, however i will add a error message in default case to notify 
this to user.

> 
>> +struct msm8916_wcd_mbhc_data {
>> +	/* Voltage threshold when internal current source of 100uA is used */
>> +	int vref_btn_cs[MBHC_MAX_BUTTONS];
>> +	/* Voltage threshold when microphone bias is ON */
>> +	int vref_btn_micb[MBHC_MAX_BUTTONS];
>> +};
> 
> I'd expect to see some mechanism for configuring the threasholds via DT,
> not all vendors use the same specs for resistive buttons.

Yep makes sense, I will do this in next version.



> 
