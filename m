From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 2/2] ASoC: qcom: add apq8016 sound card support
Date: Tue, 09 Jun 2015 18:51:59 +0100
Message-ID: <557727BF.8040807@linaro.org>
References: <1433854702-23654-1-git-send-email-srinivas.kandagatla@linaro.org> <1433854776-23852-1-git-send-email-srinivas.kandagatla@linaro.org> <20150609170738.GI14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150609170738.GI14071@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 09/06/15 18:07, Mark Brown wrote:
> On Tue, Jun 09, 2015 at 01:59:36PM +0100, Srinivas Kandagatla wrote:
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
>> +		writel(readl(pdata->spkr_iomux) |
>> +			SPKR_CTL_PRI_WS_SLAVE_SEL_11,
>> +			pdata->spkr_iomux);
>> +
>> +		return 0;
>> +	}
>
> Why not just do these one time at probe, we don't undo them when we shut
> the DAI down?
If I do that Am afraid that the driver would loose the flexibility of 
selecting different MI2S from DT level. Hardcoding which MI2S can got to 
external or internal codec is something that I wanted to avoid from the 
start.

I will add the shutdown code to reset the configuration.

>
>> +
>> +	dev_err(card->dev, "unsupported cpu dai configuration\n");
>> +
>> +	return -EINVAL;
>
> It'd be clearer if this were part of the above code (which should still
> be written as a switch statement) - I was just asking myself what
> happens if we fall off the end of the if/else chain.

I will change this to switch case.

>
>> +		/**
>> +		 * External codec is ADV7533
>> +		 * and internal codec digital part is inside apq8016
>> +		 * and analog part is in PMIC PM8916
>> +		 **/
>> +		if (of_property_read_bool(np, "external"))
>> +			name = "ADV7533";
>> +		else
>> +			name = "WCD";
>
> If this is all the property is doing why not just put a link name
> property in the DT rather than this?  That makes the driver a bit more
> general and is more idiomatic.
Yes, it makes it more clear with link-name property. I will fix this in 
next version.
>
>> +		dai_link->name = dai_link->stream_name = name;
>
> Write two assignment statements, it's clearer and more idiomatic.
I will fix this too.
>
--srini
