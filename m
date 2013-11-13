From: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCHv3] dmaengine: Add support for BCM2835
Date: Wed, 13 Nov 2013 04:57:07 -0600
Message-ID: <2B888C9F-DA6A-472C-AF14-95FB9CF1D41A@codeaurora.org>
References: <528154A1.1050303@koalo.de>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <528154A1.1050303-oZ8rN/sblLk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


On Nov 11, 2013, at 4:05 PM, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org> wro=
te:

> Add support for DMA controller of BCM2835 as used in the Raspberry Pi=
=2E
> Currently it only supports cyclic DMA.
>=20
> Signed-off-by: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
> ---
>=20
> Thank you for your comments!
> I hope I have now removed all leftovers of the sg struct.
> Regarding the endian-ness: I have not found any hint about that in th=
e datasheet. Therefore, I chose uint32_t. If you think fixed le32 is mo=
re likely I will change it.
> The PAD fields do not seem to be used, but the datasheet states they =
should be set to 0.
>=20
>=20
> .../devicetree/bindings/dma/bcm2835-dma.txt        |   57 ++
> arch/arm/boot/dts/bcm2835.dtsi                     |   23 +
> drivers/dma/Kconfig                                |    6 +
> drivers/dma/Makefile                               |    1 +
> drivers/dma/bcm2835-dma.c                          |  810 +++++++++++=
+++++++++
> 5 files changed, 897 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/dma/bcm2835-dma.=
txt
> create mode 100644 drivers/dma/bcm2835-dma.c
>=20
> diff --git a/Documentation/devicetree/bindings/dma/bcm2835-dma.txt b/=
Documentation/devicetree/bindings/dma/bcm2835-dma.txt
> new file mode 100644
> index 0000000..9542ac8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/bcm2835-dma.txt
> @@ -0,0 +1,57 @@
> +* BCM2835 DMA controller
> +
> +Required properties:
> +- compatible: Should be "brcm,bcm2835-dma".
> +- reg: Should contain DMA registers location and length.
> +- interrupts: Should contain all DMA interrupts. First cell is the I=
RQ bank
> +		Second cell is the IRQ number.

Can you be more specific about what you mean by =91all DMA interrupts=92=
?

> +- #dma-cells: Must be <1>, used to represent the number of integer c=
ells in
> +the dmas property of client devices.
> +- dma-channels: Maximum number of DMA channels available
> +- dma-requests: Number of DMA Requests.=20
> +- dma-channel-mask: Bit mask representing the channels available.

Should be brcm,dma-channel-mask

> +
> +Example:
> +
> +dma: dma@7e007000 {
> +	compatible =3D "brcm,bcm2835-dma";
> +	reg =3D <0x7e007000 0xf00>;
> +	interrupts =3D <1 16
> +		      1 17
> +		      1 18
> +		      1 19
> +		      1 20
> +		      1 21
> +		      1 22
> +		      1 23
> +		      1 24
> +		      1 25
> +		      1 26
> +		      1 27
> +		      1 28>;
> +=09
> +	#dma-cells =3D <1>;
> +	dma-channels =3D <15>;
> +	dma-requests =3D <32>;
> +	dma-channel-mask =3D <0x7f35>;
> +};
> +
> +DMA clients connected to the BCM2835 DMA controller must use the for=
mat
> +described in the dma.txt file, using a two-cell specifier for each c=
hannel:
> +a phandle plus one integer cells.
> +The two cells in order are:
> +
> +1. A phandle pointing to the DMA controller.
> +2. The DREQ number.
> +
> +Example:
> +
> +bcm2835_i2s: i2s@7e203000 {
> +	compatible =3D "brcm,bcm2835-i2s";
> +	reg =3D <	0x7e203000 0x20
> +		0x7e101098 0x02>;
> +
> +	dmas =3D <&dma 2
> +		&dma 3>;
> +	dma-names =3D "tx", "rx";
> +};

- k

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
