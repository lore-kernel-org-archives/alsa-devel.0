From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH -next] ASoC: sun4i-codec: Fix error return code in
 sun4i_codec_probe()
Date: Mon, 22 Aug 2016 07:54:50 +0200
Message-ID: <20160822055450.GA21741@lukather>
References: <1470836554-11569-1-git-send-email-weiyj.lk@gmail.com>
 <CAGb2v67cVXWtM=AzeFcftnajSs=+C6F12P_EvnXHB=oKsAm5Cw@mail.gmail.com>
 <d48eceb4-c26d-3b3c-8577-1ba19a04b040@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d48eceb4-c26d-3b3c-8577-1ba19a04b040@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Emilio Lopez <emilio@elopez.com.ar>, Hans De Goede <hdegoede@redhat.com>, ats@offog.org, fengguang.wu@intel.com, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 11, 2016 at 10:15:27PM +0800, Wei Yongjun wrote:
> Hi
>=20
> On 08/10/2016 10:04 PM, Chen-Yu Tsai wrote:
> > On Wed, Aug 10, 2016 at 9:42 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> >> Fix to return error code -ENOMEM instead of 0 when create card
> >> failed, as done elsewhere in this function.
> >>
> >> Fixes: 45fb6b6f2aa3 ("ASoC: sunxi: add support for the on-chip
> >> codec on early Allwinner SoCs")
> >> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> >> ---
> >>  sound/soc/sunxi/sun4i-codec.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-cod=
ec.c
> >> index 0e19c50..e741659 100644
> >> --- a/sound/soc/sunxi/sun4i-codec.c
> >> +++ b/sound/soc/sunxi/sun4i-codec.c
> >> @@ -846,6 +846,7 @@ static int sun4i_codec_probe(struct platform_devic=
e *pdev)
> >>         card =3D sun4i_codec_create_card(&pdev->dev);
> >>         if (!card) {
> >>                 dev_err(&pdev->dev, "Failed to create our card\n");
> >> +               ret =3D -ENOMEM;
> >>                 goto err_unregister_codec;
> >>         }
> >>
> > This works, though it might be better to fix the create_card function a=
nd
> > any custom functions called in there to pass back a proper error value.
> >
> Since sun4i_codec_create_card() can only failed when kmalloc() return NUL=
L, so
> still need to change sun4i_codec_create_card()?

Yes, please do. It's better to return whatever the function was
returning. That was, if we add a new error code, we don't have to
rework the code over and over again.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXupOqAAoJEBx+YmzsjxAgWFYP/1dN/INbrlsKDjEI5ObV5eWw
Ia/ZVSRPEIFp6Rtx2PHxdbyvTdvyi7xwDv4CeZXitnBZbYP2MuB+iezlpo/Kjmu7
HUMagXdz5ry2aV+d7XfSD/fpPHZa+A6vLQ4RxXj7Qifi8LdVlUctGCVYKYv6HIgQ
2nSajThU8js7fGbfENB1GpH2WV9K3QveRxLE2vpk4XjhvRsOX+ZhCyra0JbCCS1Z
qYa7lKlA56o61Pol3+s84s0iUGnwq5D6x3BrqS9wv6lxZcs1uOXd3Mx2AF775C92
v8FLDLBV0i9YVewnI72DPEPieugDbLKEMld4vPFiB7sUGOazslYvI8I8XGCjE4B8
OSCzQ3FyL2HIhaCRhD4yQvBINAip46uCgn5Ct/7CO+8u6+/abq9eKKfjg/nBI3RN
vYM+x2fH+sCEN8UxoaiQe9X8VF7dbf2miUmk5knzvo1HDTIFDxygfITr1uoPuRy7
qmhjdA8s1Ieyv80mKvKG0H+Zr462swmLTDzBz4HRwGcdIgIr3QlW5fNFU+eWlHmP
6lJNgJTOIB9KSqBhHMzeiQQyDLqOXBTxhb7nwi5UlMSdBROUXcLVjTNdvg2jW6+o
APwTsbg6heaIDO1SfzMYbFYgfXtDoMD3QP8PaWzU5gto708JEcpkXlK2y4A5xvUa
gyJ45ohcIkcmXKmwGfDC
=pdGg
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
