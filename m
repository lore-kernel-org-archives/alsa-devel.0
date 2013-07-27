From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 2/7] ASoC: codec: wm9712 simple DT bindings
Date: Sat, 27 Jul 2013 12:59:50 +0100
Message-ID: <20130727115950.GF9858@sirena.org.uk>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0288759095491653159=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374924716-23475-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0288759095491653159==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9TayrSCGl6Stf3M8"
Content-Disposition: inline


--9TayrSCGl6Stf3M8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2013 at 01:31:51PM +0200, Markus Pargmann wrote:

> +static const struct of_device_id wm9712_codec_of_dev_id[] =3D {
> +	{
> +		.compatible =3D "wlf,wm9712",
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
>  static struct platform_driver wm9712_codec_driver =3D {
>  	.driver =3D {
>  		.name =3D "wm9712-codec",
>  		.owner =3D THIS_MODULE,
> +		.of_match_table =3D wm9712_codec_of_dev_id,
>  	},
> =20
>  	.probe =3D wm9712_probe,

AC'97 is an enumerable bus, we shouldn't need this...

--9TayrSCGl6Stf3M8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR87YzAAoJELSic+t+oim9/EAP/2EVuDDr1ao50mKua2irOEW8
V0MJFv6N2o17rBJ8lGadPjRKrRocKnY9QcOHh9z1l5Pkq5CmbGGsym/DO/TAOAf8
nSZV7MtB4NY2xVyrBbAuzjPUVyv8KlK3A8vK+y1Ff5UHwwk6vqk8Uh/o9nNtnjO6
aRA/xfVv2voHMvmfQvSFrDIFbUnSDicsDGG7Lgj3K40HH9PiqI64PZWy4E+950Ei
v6LDf7gg8uyDhwJ5MO0bzHdQKZhQISSPip1DYnLtoNlRtUV8q2m+TTGmY0xfAajR
3/I+P30Gs/NJMfTEKHis7vwS34tR/Yn/m1n7b7XZ1KmWYo4Ekq60rf6D8Ix5KfbY
UyykLdhNowTZm0wrHi6KSihgLoFRaNvWw0ouTC2v6LCbaml/2OL49mYexRTuIWx0
tI39PRGrtvYeZB7tRUrYO1O6jXKCpw6Tky5UphPjHAjmbiV2ZO+WGKaW9r8/4ntD
xzJu6jdhDE+l20z+B1KgjQ9W8V5SQg9kXEgMn2DUXtRdfMoLYL/A6RdR9IYXJp0A
gMRDWNc69Wkq32KdPUrcnBG76r2OaeRvBn6FX/BaVoyKBrrdLA849EIkj/LQ+orC
JnApnXSPreh2LJ/TNEHujem2JB8R2wa4mnCHca4vVt6CCM/9LP7GpVODBQNLHbIg
6aqStMxynRu6O3OyfUyj
=Y9hf
-----END PGP SIGNATURE-----

--9TayrSCGl6Stf3M8--


--===============0288759095491653159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0288759095491653159==--
