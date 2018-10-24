From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 02/14] mfd: wcd9335: add support to wcd9335 core
Date: Wed, 24 Oct 2018 11:50:45 +0100
Message-ID: <8ec691a9-d91c-752b-de21-a82a7e78ee05@linaro.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
 <20180917005727.32728-3-srinivas.kandagatla@linaro.org>
 <20181024070746.GZ4939@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024070746.GZ4939@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 24/10/18 08:07, Lee Jones wrote:
>> +#define WCD9335_SLIM_INTERFACE_DEVICE_INDEX	0
>> +
>> +static const struct mfd_cell wcd9335_devices[] = {
>> +	{ .name = "wcd9335-codec", },
>> +};
> Any news on other devices?
> 
We are totally limited with hardware to test other devices on this 
codec. Given the fact that no one is actively working on adding support 
to other devices ATM.
Also IRC discussions with you suggested that I should move this driver 
to codecs for now and when a new device support comes up we can move it 
back to mfd.

Regarding other comments, I will make sure that address them if the code 
is still there after moving to codecs.

thanks,
srini

>> +static const struct regmap_range_cfg wcd9335_ranges[] = {
>> +	{
>> +		.name = "WCD9335",
>> +		.range_min =  0x0,
>> +		.range_max =  WCD9335_MAX_REGISTER,
>> +		.selector_reg = WCD9335_REG(0x0, 0),
>> +		.selector_mask = 0xff,
>> +		.selector_shift = 0,
>> +		.window_start = 0x0,
>> +		.window_len = 0x1000,
>> +	},
>> +};
