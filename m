From: jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [RESENT PATCH v9 1/2] ASoC: rt5514: Add devicetree bindings for
 rt5514-spi
Date: Mon, 18 Sep 2017 19:20:07 +0800
Message-ID: <59BFABE7.5050904@rock-chips.com>
References: <20170906025010.10750-1-jeffy.chen@rock-chips.com> <20170913172452.rqy2umufkuh26fzj@rob-hp-laptop> <59BF1FCD.3060501@rock-chips.com> <1972340.u0BEiYTrvM@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1972340.u0BEiYTrvM@phil>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Heiko,

Thanks for your reply.

On 09/18/2017 05:30 PM, Heiko Stuebner wrote:
>>>> > >>
>>>> > >>-- compatible : "realtek,rt5514".
>>>> > >>+- compatible : "realtek,rt5514" or "realtek,rt5514", "realtek,rt5514-i2c".
>>> > >
>>> > >There's no need for the -spi or -i2c compatibles. This is implied by
>>> > >being a child of those controllers.
>> >heiko mentioned i should add it in the binding in:
>> >https://patchwork.kernel.org/patch/9918987/
> If you add a new compatible you need to add it to the binding. I think what
> Rob means is, that both the i2c and spi side can have the_same_
> compatible without the -i2c or -spi, as you can check wether they are
> children of either a spi or i2c controller in the code itself.
>
ok, got it.

i sent a new patch to check the bus_type instead :)

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
