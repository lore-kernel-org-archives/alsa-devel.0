From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 4/4] ASoC: codecs: add wsa881x amplifier
 support
Date: Thu, 8 Aug 2019 11:29:20 -0500
Message-ID: <4e60b92f-a32e-671c-3b1b-9b1ccec4f9b5@linux.intel.com>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-5-srinivas.kandagatla@linaro.org>
 <3ad15652-9d6c-11e4-7cc3-0f076c6841bb@linux.intel.com>
 <32516aae-8a43-6a74-c564-92dea8ff6e53@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <32516aae-8a43-6a74-c564-92dea8ff6e53@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, plai@codeaurora.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org


>>> +/* 4 ports */
>>> +static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>>> +    {
>>> +        /* DAC */
>>> +        .num = 1,
>>> +        .type = SDW_DPN_SIMPLE,
>>
>> IIRC we added the REDUCED type in SoundWire 1.1 to cover the PDM case 
>> with channel packing (or was it grouping) used by Qualcomm. I am not 
>> sure the SIMPLE type works?
> grouping I guess.
> 
> This is a simplified data port as there is no DPn_OffsetCtrl2 register 
> implemented.

ok, for the REDUCED type it's required to have BlockPackingMode and 
OffsetCtrl2, so it does not apply here. Thanks for confirming.
