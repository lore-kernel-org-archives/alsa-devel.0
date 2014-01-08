From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH -next] ASoC: ux500: Fix sparse non static symbol warning
Date: Wed, 08 Jan 2014 11:14:44 +0100
Message-ID: <3148126.Rai0JT7dud@wuerfel>
References: <CAPgLHd9fB+tA=uAfE2s5i2ygySUyqG=DNpe7RQFNOv-kBxjL2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPgLHd9fB+tA=uAfE2s5i2ygySUyqG=DNpe7RQFNOv-kBxjL2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, linus.walleij@linaro.org, fabio.baltieri@linaro.org, lee.jones@linaro.org, yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 08 January 2014 18:13:35 Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fixes the following sparse warning:
> 
> sound/soc/ux500/ux500_msp_i2s.c:649:5: warning:
>  symbol 'ux500_msp_i2s_of_init_msp' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Arnd Bergmann <arnd@arndb.de>
