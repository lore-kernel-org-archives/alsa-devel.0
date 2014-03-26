From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [alsa-devel] [RFC v2 PATCH] ASoC: wm8904: add CCF support
Date: Wed, 26 Mar 2014 09:32:25 +0800
Message-ID: <53322E29.3070000@atmel.com>
References: <1395741416-23981-1-git-send-email-voice.shen@atmel.com> <20140325112716.GS2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <20140325112716.GS2269@sirena.org.uk>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, b.brezillon.dev@gmail.com, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 03/25/2014 07:27 PM, Mark Brown wrote:
> On Tue, Mar 25, 2014 at 05:56:56PM +0800, Bo Shen wrote:
>
>>   	case SND_SOC_BIAS_ON:
>> +		if (IS_ENABLED(CONFIG_COMMON_CLK))
>> +			if (wm8904->mclk)
>> +				clk_prepare_enable(wm8904->mclk);
>
> No, this shouldn't depend on COMMON_CLK - there is no reason other clock
> API implementations shouldn't be able to use this.  Providing a clock is
> something you can only do with COMMON_CLK but using one doesn't need
> that, generally using a clock is done unconditionally.

Actually in probe function, it does this check, if not CCF support, the 
wm8904->mclk is NULL. So, we can remove the CCF check here.

Thanks.

Best Regards,
Bo Shen
