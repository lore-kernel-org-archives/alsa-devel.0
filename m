From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: rockchip: i2s: add support for grabbing output
 clock to codec
Date: Tue, 2 Dec 2014 09:54:39 -0800
Message-ID: <CAD=FV=Uwb1NxxCoXHzHu6DJCpnG_HV2RhCr3JaJaXbJja8kd7A@mail.gmail.com>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
	<1417531977-30094-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417531977-30094-1-git-send-email-jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Jianqun,

This ought to be a "v3" patch and ideally ought to describe
differences from v2 (after the cut).  Please have Kever or Chris
review your next patch before sending it out since I think they are
familiar with the process.


On Tue, Dec 2, 2014 at 6:52 AM, Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> From: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> We need to claim the clock which is driving the codec so that when we enable
> clock gating, we continue to clock the codec when needed.  I make this an
> optional clock since there might be some applications where we don't need it
> but can still use the I2S block.
>
> Signed-off-by: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

You still forgot your own signed-off-by.  Please try again.  See
<https://patchwork.kernel.org/patch/5334991/>


> +       i2s->oclk = devm_clk_get(&pdev->dev, "i2s_clk_out");
> +       if (IS_ERR(i2s->oclk)) {
> +               dev_dbg(&pdev->dev, "Didn't find output clock\n");
> +               i2s->oclk = NULL;
> +       }

You still forgot the blank line here requested by Heiko.  Please try
again.  See <https://patchwork.kernel.org/patch/5334991/>


> +       if (i2s->oclk)
> +               ret = clk_prepare_enable(i2s->oclk);
> +
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
