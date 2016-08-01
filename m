From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: Re: [PATCH 2/2] ASoC: sunxi: compatibility for
 sun6i to SPDIF
Date: Mon, 01 Aug 2016 23:02:22 +0800
Message-ID: <114771470063742@web16h.yandex.ru>
References: <20160730142716.29377-1-codekipper@gmail.com> <20160730142716.29377-3-codekipper@gmail.com>
	 <170941469890365@web9j.yandex.ru> <20160730152049.GU6215@lukather> <CAGb2v65Hyp8U1OMrfy0Bo9-qC0eO5de+NjWQzch87_2Ty+fBqQ@mail.gmail.com>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBAOJ7W6AKGQECMNYEAA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v65Hyp8U1OMrfy0Bo9-qC0eO5de+NjWQzch87_2Ty+fBqQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: "codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



01.08.2016, 21:40, "Chen-Yu Tsai" <wens-jdAy2FN1RRM@public.gmane.org>:
> Hi,
>
> On Sat, Jul 30, 2016 at 11:20 PM, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> =C2=A0On Sat, Jul 30, 2016 at 10:52:45PM +0800, Icenowy Zheng wrote:
>>> =C2=A0> + if (of_device_is_compatible(pdev->dev.of_node,
>>> =C2=A0> + "allwinner,sun6i-a31-spdif")) {
>>> =C2=A0> + host->rst =3D devm_reset_control_get_optional(&pdev->dev, NUL=
L);
>>> =C2=A0> + if (IS_ERR(host->rst) && PTR_ERR(host->rst) =3D=3D -EPROBE_DE=
FER) {
>>> =C2=A0> + ret =3D -EPROBE_DEFER;
>>> =C2=A0> + dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
>>> =C2=A0> + goto err_disable_apb_clk;
>>> =C2=A0> + }
>>> =C2=A0> + if (!IS_ERR(host->rst))
>>> =C2=A0> + reset_control_deassert(host->rst);
>>> =C2=A0> + }
>>> =C2=A0> +
>>> =C2=A0I think you do not need the compatible.
>>> =C2=A0You can just detect whether the reset is present.
>>
>> =C2=A0That would weaken the error check. If we're running on the A31 and=
 are
>> =C2=A0missing our reset property, it would go unnoticed.
>
> We've been doing it this way with the mmc controller and the usb hosts th=
ough.
I did the same thing on NAND controller.
> IIRC you once said in the older SoCs, the reset control is tied to the cl=
ock
> gate in the hardware.
>
> The _optional variant is also funny, though I understand it is a design
> of the reset controller framework.
>
> Regards
> ChenYu

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
