From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: Re: [PATCH 2/2] ASoC: sunxi: compatibility for
 sun6i to SPDIF
Date: Mon, 1 Aug 2016 21:39:34 +0800
Message-ID: <CAGb2v65Hyp8U1OMrfy0Bo9-qC0eO5de+NjWQzch87_2Ty+fBqQ@mail.gmail.com>
References: <20160730142716.29377-1-codekipper@gmail.com> <20160730142716.29377-3-codekipper@gmail.com>
 <170941469890365@web9j.yandex.ru> <20160730152049.GU6215@lukather>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBLVC7W6AKGQEREFOONQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160730152049.GU6215@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, "codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, Jul 30, 2016 at 11:20 PM, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Sat, Jul 30, 2016 at 10:52:45PM +0800, Icenowy Zheng wrote:
>> > + if (of_device_is_compatible(pdev->dev.of_node,
>> > + "allwinner,sun6i-a31-spdif")) {
>> > + host->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
>> > + if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
>> > + ret = -EPROBE_DEFER;
>> > + dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
>> > + goto err_disable_apb_clk;
>> > + }
>> > + if (!IS_ERR(host->rst))
>> > + reset_control_deassert(host->rst);
>> > + }
>> > +
>> I think you do not need the compatible.
>> You can just detect whether the reset is present.
>
> That would weaken the error check. If we're running on the A31 and are
> missing our reset property, it would go unnoticed.

We've been doing it this way with the mmc controller and the usb hosts though.
IIRC you once said in the older SoCs, the reset control is tied to the clock
gate in the hardware.

The _optional variant is also funny, though I understand it is a design
of the reset controller framework.


Regards
ChenYu
