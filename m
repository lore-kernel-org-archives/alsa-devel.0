From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 00/14] ASoc: sunxi: Add Allwinner A33 codec driver
Date: Fri, 7 Oct 2016 16:35:30 +0800
Message-ID: <20161007163530.7b027091@aosc.xyz>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBB7543W7QKGQEZLA7E2A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <cover.1475569400.git.mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue,  4 Oct 2016 11:46:13 +0200
Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi everyone,
>=20
>=20
> This patchset add the audio codec for Allwinner A33 (sun8i) SoC.
>=20
> It adds different drivers:
>    - sun8i-codec-analog (patch 4): This driver implements the analog
> part of the audio codec. The analog part is handled in PRCM registers
> so this driver must be added as prcm's subnode (patch 5).
>    - sun8i-codec (patch 6): This driver implements the digital part
> of the A33 codec.
>    - sun8i (patch 7): This driver implements a sound card for A33.
>    It links the DAI and the audio codec. The analog codec driver is
> handled as an "aux_device".
>=20
> The DAI for this codec is the same than for A20: "sun4i-i2s".
> The digital codec code is coming from Allwinner's BSP (after some
> cleanup and DAPM conversion) [1]
> The analog codec driver is coming from Chen-Yu Tsai's driver [2]
> with some modifications (such as read/write regmap functions).
>=20
> Currently, all the drivers handle only the playback feature.
> The other ones (such as capture) and all other interfaces except
> headphone are not supported.
>=20
> These drivers are functional except for one issue. When playing a
> sound for the first time, a short delay can be noticed. On a second
> play (right after), the sound is played correctly. If we wait a short
> time (~5 sec), the delay is back.
> There is the same behavior for left/right channel. On the first
> time, a left sound is played on the left channel but in the second
> time, the sound will be played on wrong channel.
>=20
> These issues will be fixed in a second time. Is someone have
> suggestions about it?
>=20
> Examples of amixer commands:
> 	amixer set 'Headphone' 75%
> 	amixer set 'Headphone' on
> 	amixer set 'DAC' on
> 	amixer set 'Right DAC Mixer RSlot 0' on
> 	amixer set 'Left DAC Mixer LSlot 0' on
> 	amixer set 'DAC Reversed Right' on
> 	amixer set 'DAC Reversed Left' on
>=20
> It was tested on Parrot and Sinlinx board where device tree's
> modifications are added (patch 11 to 14).

I tested it on my iNet D978 Rev2 board (dts available in linux-next now)
Directly output audio from mpg123 to the audio codec failed, with
noises appear in the earphone. (And the mpg123 process terminated very
fast, seems that the bitrate become wrong)

However, paplay works well with the decoded wav file, and ```mpg123 -o
pulse``` works properly.

>=20
> Thank you in advance,
> Best regards,
>=20
> [1]:
> https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sun=
xi/audiocodec/sun8iw5_sndcodec.c
> [2]: https://github.com/wens/linux/tree/a31-audio
>=20
> Myl=C3=A8ne Josserand (14):
>   dma: sun6i-dma: Add burst case of 4
>   clk: ccu-sun8i-a33: Add CLK_SET_RATE_PARENT to ac-dig
>   ASoC: sun4i-i2s: Add apb reset
>   ASoC: Add sun8i analog codec driver
>   mfd: sun6i-prcm: Add sun8i analog codec as subnode
>   ASoC: Add sun8i digital audio codec
>   ASoC: Add sun8i audio card
>   dt-bindings: sound: Add sun8i analog codec documentation
>   dt-bindings: sound: Add sun8i codec documentation
>   dt-bindings: sound: Add sun8i audio card documentation
>   ARM: dts: sun8i: Add analog codec on prcm node
>   ARM: dts: sun8i: Add audio codec, dai and card for A33
>   ARM: dts: sun8i: parrot: Enable audio nodes
>   ARM: dts: sun8i: sinlinx: Enable audio nodes
>=20
>  .../devicetree/bindings/sound/sun8i-audio.txt      |  17 +
>  .../bindings/sound/sun8i-codec-analog.txt          |  20 +
>  .../devicetree/bindings/sound/sun8i-codec.txt      |  24 +
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   7 +
>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   8 +
>  arch/arm/boot/dts/sun8i-a33.dtsi                   |  33 ++
>  arch/arm/boot/dts/sun8i-r16-parrot.dts             |   8 +
>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |   2 +-
>  drivers/dma/sun6i-dma.c                            |   2 +
>  drivers/mfd/sun6i-prcm.c                           |  16 +
>  sound/soc/sunxi/Kconfig                            |  30 ++
>  sound/soc/sunxi/Makefile                           |   3 +
>  sound/soc/sunxi/sun4i-i2s.c                        |  16 +-
>  sound/soc/sunxi/sun8i-codec-analog.c               | 305
> +++++++++++++ sound/soc/sunxi/sun8i-codec.c                      |
> 492 +++++++++++++++++++++
> sound/soc/sunxi/sun8i.c                            | 101 +++++ 16
> files changed, 1082 insertions(+), 2 deletions(-) create mode 100644
> Documentation/devicetree/bindings/sound/sun8i-audio.txt create mode
> 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
> create mode 100644
> Documentation/devicetree/bindings/sound/sun8i-codec.txt create mode
> 100644 sound/soc/sunxi/sun8i-codec-analog.c create mode 100644
> sound/soc/sunxi/sun8i-codec.c create mode 100644
> sound/soc/sunxi/sun8i.c
>=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
