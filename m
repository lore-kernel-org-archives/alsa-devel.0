From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH v3 08/10] dmaengine: sun6i: allow build on
 ARM64 platforms (sun50i)
Date: Tue, 31 Jan 2017 02:23:55 +0800
Message-ID: <3729521485800635@web23g.yandex.ru>
References: <20170129023331.62106-1-icenowy@aosc.xyz>
	 <20170129023331.62106-9-icenowy@aosc.xyz> <20170130164210.GD19244@localhost>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBPMJX3CAKGQEBKTZOOQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170130164210.GD19244@localhost>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, "linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



31.01.2017, 00:41, "Vinod Koul" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:
> On Sun, Jan 29, 2017 at 10:33:29AM +0800, Icenowy Zheng wrote:
>> =C2=A0As 64-bit Allwinner H5 SoC has the same DMA engine with H3, the DM=
A
>> =C2=A0driver should be allowed to be built for ARM64, in order to make i=
t work on H5.
>>
>> =C2=A0Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
>> =C2=A0Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> =C2=A0Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> =C2=A0---
>> =C2=A0Patch introduced between v1 and v2, to satisfy the newly added H3/=
H5 audio
>> =C2=A0codec support.
>>
>> =C2=A0=C2=A0drivers/dma/Kconfig | 2 +-
>> =C2=A0=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> =C2=A0diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> =C2=A0index 0d6a96ee9fc7..d01d59812cf3 100644
>> =C2=A0--- a/drivers/dma/Kconfig
>> =C2=A0+++ b/drivers/dma/Kconfig
>> =C2=A0@@ -157,7 +157,7 @@ config DMA_SUN4I
>>
>> =C2=A0=C2=A0config DMA_SUN6I
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Al=
lwinner A31 SoCs DMA support"
>> =C2=A0- depends on MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
>> =C2=A0+ depends on MACH_SUN6I || MACH_SUN8I || (ARM64 && ARCH_SUNXI) || =
COMPILE_TEST
>
> Do we really need ARM64 here? also looking at others I wonder why isn't
> this MACH_SUNXI...?

You mean directly place "ARCH_SUNXI" here?

SUN4I/SUN5I/SUN7I do not use DMA_SUN6I, they have different DMA
controllers.

>
> --
> ~Vinod

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
