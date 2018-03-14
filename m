From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH v4 02/24] soc: qcom: Add APR bus driver
Date: Wed, 14 Mar 2018 14:15:21 +0000
Message-ID: <b2b24ce9-2923-2dd5-f569-fbad80f3f706@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-3-srinivas.kandagatla@linaro.org>
 <d9e92aeb-8d74-554e-4390-4117571806a9@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d9e92aeb-8d74-554e-4390-4117571806a9@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit Kumar <rohitkr@codeaurora.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 14/03/18 14:12, Rohit Kumar wrote:
> 
> 
> On 3/10/2018 7:54 AM, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
> [..]
>> +struct bus_type aprbus_type = {
>> +    .name        = "aprbus",
>> +    .match        = apr_device_match,
>> +    .probe        = apr_device_probe,
>> +    .remove        = apr_device_remove,
>> +    .force_dma    = true,
> 
> There is no need of force_dma now as machine driver is not child of apr. 
> Please remove it.

Thanks Rohit, Will remove it.


>> +};
>> +EXPORT_SYMBOL_GPL(aprbus_type);
>> +
>>
> 
