From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: msm8916-wcd-digital: Add sidetone
 support
Date: Thu, 6 Jun 2019 14:29:45 +0100
Message-ID: <446dd43c-c47e-c7a3-bcef-33241f41e4b0@linaro.org>
References: <20190606124242.12941-1-srinivas.kandagatla@linaro.org>
 <20190606152402.2d310b7d@xxx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190606152402.2d310b7d@xxx>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org



On 06/06/2019 14:24, Amadeusz Sławiński wrote:
>> +	SOC_SINGLE_SX_TLV("IIR1 INP1 Volume",
>> LPASS_CDC_IIR1_GAIN_B1_CTL,
>> +			0,  -84, 40, digital_gain),
>> +	SOC_SINGLE_SX_TLV("IIR1 INP2 Volume",
>> LPASS_CDC_IIR1_GAIN_B2_CTL,
>> +			0,  -84, 40, digital_gain),
>> +	SOC_SINGLE_SX_TLV("IIR1 INP3 Volume",
>> LPASS_CDC_IIR1_GAIN_B3_CTL,
>> +			0,  -84, 40, digital_gain),
>> +	SOC_SINGLE_SX_TLV("IIR1 INP4 Volume",
>> LPASS_CDC_IIR1_GAIN_B4_CTL,
>> +			0,  -84,	40, digital_gain),
> There seems to be some alignment issue in above line.
> And while I'm commenting this place, there is only 4 Volume controls,
> while there is 5 switches for IIR1 and IIR2, is this right?
> 

Each IIR Filter is 5 Stage, and IIR block is feed with 4 inputs, these 
volumes above refers to each input path.


Thanks,
srini
>> +	SOC_SINGLE_SX_TLV("IIR2 INP1 Volume",
>> LPASS_CDC_IIR2_GAIN_B1_CTL,
