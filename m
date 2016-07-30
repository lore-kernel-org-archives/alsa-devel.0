From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: sunxi: compatibility for sun6i to SPDIF
Date: Sat, 30 Jul 2016 23:23:06 +0800
Message-ID: <24431469892186@web18m.yandex.ru>
References: <20160730142716.29377-1-codekipper@gmail.com>
	 <20160730142716.29377-3-codekipper@gmail.com>
	 <170941469890365@web9j.yandex.ru> <20160730152049.GU6215@lukather>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBXUM6O6AKGQEC63DHZY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160730152049.GU6215@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: "codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



30.07.2016, 23:20, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard@free-e=
lectrons.com>:
> On Sat, Jul 30, 2016 at 10:52:45PM +0800, Icenowy Zheng wrote:
>> =C2=A0> + if (of_device_is_compatible(pdev->dev.of_node,
>> =C2=A0> + "allwinner,sun6i-a31-spdif")) {
>> =C2=A0> + host->rst =3D devm_reset_control_get_optional(&pdev->dev, NULL=
);
>> =C2=A0> + if (IS_ERR(host->rst) && PTR_ERR(host->rst) =3D=3D -EPROBE_DEF=
ER) {
>> =C2=A0> + ret =3D -EPROBE_DEFER;
>> =C2=A0> + dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
>> =C2=A0> + goto err_disable_apb_clk;
>> =C2=A0> + }
>> =C2=A0> + if (!IS_ERR(host->rst))
>> =C2=A0> + reset_control_deassert(host->rst);
>> =C2=A0> + }
>> =C2=A0> +
>> =C2=A0I think you do not need the compatible.
>> =C2=A0You can just detect whether the reset is present.
>
> That would weaken the error check. If we're running on the A31 and are
> missing our reset property, it would go unnoticed.
The reset property is in the SoC's dtsi file, so it won't be easily missing=
...

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
