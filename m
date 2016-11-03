From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 04/14] ASoC: sun4i-codec: Increase DMA max burst to 8
Date: Thu, 3 Nov 2016 09:26:08 +0100
Message-ID: <20161103082608.4e27avywl5fmozt2@lukather>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-5-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pivqiv7xd34p5yoj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161103075556.29018-5-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


--pivqiv7xd34p5yoj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2016 at 03:55:46PM +0800, Chen-Yu Tsai wrote:
> According to the DMA engine API documentation, maxburst denotes the
> largest possible size of a single transfer, so as not to overflow
> destination FIFOs as explained in this excerpt from dmaengine.h
>=20
>  * @src_maxburst: the maximum number of words (note: words, as in
>  * units of the src_addr_width member, not bytes) that can be sent
>  * in one burst to the device. Typically something like half the
>  * FIFO depth on I/O peripherals so you don't overflow it. This
>  * may or may not be applicable on memory sources.
>  * @dst_maxburst: same as src_maxburst but for destination target
>  * mutatis mutandis.
>=20
> The TX FIFO is 64 samples deep for stereo, and the RX FIFO is 16
> samples deep. So maxburst could be 32 and 8 for TX and RX respectively.
>=20
> Unfortunately the sunxi DMA controller driver takes maxburst as
> the requested burst size, rather than a limit, and returns an error
> for unsupported values. The original value was 4, but some later
> SoCs do not officially support this burst size.
>=20
> This patch increases maxburst on the TX side to 8, which is supported
> by all variants of the sunxi DMA controller.
>=20
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--pivqiv7xd34p5yoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYGvSgAAoJEBx+YmzsjxAg/gYP/24c/bpYq74OmJLKJ0QKAO47
gVJ/SMX2Z3epM4dai9g/Xpv8YtUkvHu7Oe7NWuYxLSa8MQH+XvQduC4n937Ks329
4FArj8mCygedv3pIQi3eDCli7B64RgoVb8h7XPqVdJ7fIki/8xr2IA6bDd9ZAT1x
r9V+fXrjHNNYMPWWlu1WVY49lGZysDzg3htJEQ3kTsMvNoRhV7Wd4n8F8fIlkZZS
uLQ7MLi5nEouDBPMwdw2uKzhySvvxXKNvxQkK8Cz2xUfbQ5/RoRSdmhA3PJI//Ae
C2TTXuvAKWKLlSaXRj/u/r2v37EkiaMvAq+vrCT/1TOWSWguCDgNIDr23SPpFfWX
vktjeVl+crg+LC6d40jIx8p3VWOdl8aO5Xil9hksuDQX3abVi675+Wo9/t5t1N4/
n5IWZGw12VFwX1cOJSQJ0J2p604RYcB8sNq9jEo66VOV6SCyohSYgcwFtRDNQkuU
7n1/lvQ9HJTsnbX0m6XVzfXErrvsUvt/CwBsSJzvf6eeYj0RkbpBQ6dPqIrbaiZf
TnYXOKl2x+ZQLsiO0Tanw+1RKWi0gvA/2FfbTMACYHsTG+cV1iOYK2asGtGMZdtU
pqkcyqlCZ94I3GlgkzVvsglmJXYi8KdKsgCFPIlr4etHRgGGdZBRU6sYIZ4tYeiD
Dq6BcDtO1oWudabQLPI5
=PqIS
-----END PGP SIGNATURE-----

--pivqiv7xd34p5yoj--
