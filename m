From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 05/10] ASoC: wcd9335: add CLASS-H Controller support
Date: Wed, 1 Aug 2018 09:57:31 +0100
Message-ID: <9f2ae979-1af1-2d80-f403-9220ec5c89a2@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-6-srinivas.kandagatla@linaro.org>
 <20180731170557.GK5719@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731170557.GK5719@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 31/07/18 18:05, Mark Brown wrote:
> On Fri, Jul 27, 2018 at 01:18:01PM +0100, Srinivas Kandagatla wrote:
> 
>> +	res_val = WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_0KOHM;
>> +	switch (mode) {
>> +	case CLS_H_NORMAL:
>> +		res_val = WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_50KOHM;
>> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_NORMAL;
>> +		gain = DAC_GAIN_0DB;
>> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
>> +		break;
>> +	case CLS_AB:
>> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_NORMAL;
>> +		gain = DAC_GAIN_0DB;
>> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
>> +		break;
>> +	case CLS_H_HIFI:
>> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_UHQA;
>> +		gain = DAC_GAIN_M0P2DB;
>> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
>> +		break;
>> +	case CLS_H_LP:
>> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_LP;
>> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_30MA;
>> +		break;
>> +	};
> 
> This is missing a default case for error checking, and you don't need
> the semicolon at the end either.
These states are validated before any calls are made to these functions.

However I agree without on default case for error checking and ;
I will fix this in next version.

thanks,
srini

> 
