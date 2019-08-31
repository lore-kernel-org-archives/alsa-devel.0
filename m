From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: es8316: Add clock control of MCLK
Date: Sat, 31 Aug 2019 20:18:42 +0900
Message-ID: <ee38ca00-4146-49fe-21c0-af0578b1d65c@katsuster.net>
References: <20190829173205.11805-1-katsuhiro@katsuster.net>
 <20190829173205.11805-2-katsuhiro@katsuster.net>
 <20190830111817.GA5182@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190830111817.GA5182@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, David Yang <yangxiaohua@everest-semi.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 2019/08/30 20:18, Mark Brown wrote:
> On Fri, Aug 30, 2019 at 02:32:04AM +0900, Katsuhiro Suzuki wrote:
> 
>> +	es8316->mclk = devm_clk_get(component->dev, "mclk");
>> +	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
>> +		return -EPROBE_DEFER;
> 
> If we don't get a clock it'd be nice to at least log that in case
> there's something wrong with the clock driver so that people have more
> of a hint as to why things might be breaking.
> 

OK, to change more user friendly.


>> +
>> +	if (es8316->mclk) {
>> +		ret = clk_prepare_enable(es8316->mclk);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
> 
> There's nothing that disables the clock on remove.
> 
> Otherwise this looks good.
> 
Thank you for reviewing. I'll fix it and send V2 patch set.


> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

Best Regards,
Katsuhiro Suzuki
