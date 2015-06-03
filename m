From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 2/3] ASoC: qcom: add apq8016 sound card support
Date: Wed, 03 Jun 2015 09:11:41 +0100
Message-ID: <556EB6BD.6090502@linaro.org>
References: <1432309956-5228-1-git-send-email-srinivas.kandagatla@linaro.org> <1432310047-5316-1-git-send-email-srinivas.kandagatla@linaro.org> <20150602195506.GJ14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150602195506.GJ14071@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Patrick Lai <plai@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 02/06/15 20:55, Mark Brown wrote:
> On Fri, May 22, 2015 at 04:54:07PM +0100, Srinivas Kandagatla wrote:
>
>> +	if (cpu_dai->id == MI2S_QUATERNARY) {
>> +		/* Configure the Quat MI2S to TLMM */
>> +		writel(readl(pdata->mic_iomux) |
>> +			MIC_CTRL_QUA_WS_SLAVE_SEL_10 |
>> +			MIC_CTRL_TLMM_SCLK_EN,
>> +			pdata->mic_iomux);
>> +
>> +		return 0;
>> +	} else if (cpu_dai->id == MI2S_PRIMARY) {
>
> This looks like you're trying to write a switch statement.  It's also
I started of with switch case but, as this card only uses 
MI2S_QUATERNARY and MI2S_PRIMARY I converted it to if else statements to 
save few lines.
> somewhat unclear to me that this should be in a machine driver and not
> in a CODEC/aux driver that gets pulled in by a machine driver, I can't
> be entirely sure what this is controlling.

This bit of code is writing to a mux control register, which would be 
very much specific to board wiring. Moving this to machine level could 
would introduce lot of un-necessary interface.
>
>> +		if (of_property_read_bool(np, "external"))
>> +			name = "HDMI";
>> +
>> +		else
>> +			name = "Headset";
>
> Coding style.  I'm also a bit concerned about the binding here -
> headsets sound external too?
I agree, its confusing. The term external in this case describes the 
placement of codec w.r.t to SOC rather then the audio sink. on APQ8016 
we have an internal codec within the SOC which is wiredup to the Headset 
and on this board we have external ADV7533 codec which is connected to HDMI.

>
>> +	card->dev = dev;
>> +	data = apq8016_sbc_parse_of(card);
>
> We parse the DT here and then...
>
>> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Error parsing card name: %d\n", ret);
>> +		return ret;
>> +	}
>
> ...this other bit of DT here.
I will put this code to the apq8016_sbc_parse_of function.
>
>> +	ret = devm_snd_soc_register_card(&pdev->dev, card);
>> +	if (ret == -EPROBE_DEFER) {
>> +		card->dev = NULL;
>> +		return ret;
>> +	} else if (ret) {
>> +		dev_err(&pdev->dev, "Error registering soundcard: %d\n", ret);
>> +		return ret;
>> +	}
>
> If setting card->dev does anything there something is broken, and in
> general it's just better form to not special case probe deferral.
>
Yes, you are right, setting card->dev = NULL is really unnecessary, I 
will fix it and also remove the special casing the EPROBE_DEFER.
There are 2 other drivers which need similar cleanup, I will fix them too.

--srini
