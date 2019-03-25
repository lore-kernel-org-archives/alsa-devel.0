From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: simple-card-utils: remove set but not used
 variable ''
Date: Mon, 25 Mar 2019 11:03:18 +0800
Message-ID: <c216f899-fdfc-6f99-3f76-5ee64680b2fe@huawei.com>
References: <20190323020838.107533-1-yuehaibing@huawei.com>
 <87a7hjitm0.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87a7hjitm0.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2019/3/25 10:31, Kuninori Morimoto wrote:
> 
> Hi
> 
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_parse_clk':
>> sound/soc/generic/simple-card-utils.c:164:18: warning:
>>  parameter 'dai_name' set but not used [-Wunused-but-set-parameter]
>>
>> It's not used since commit 0580dde59438 ("ASoC: simple-card-utils: add
>> asoc_simple_debug_info()"), so can be removed.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
> 
> I think dai_name parameter itself is no longer needed for this function,
> but, it will be removed if all driver switched to modern dai_link style.
> So, it is not a big deal.
> 
> 	Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, yes, this just a code cleanup.

> 
> Best regards
> ---
> Kuninori Morimoto
> 
> .
> 
