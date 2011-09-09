From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] ALSA: keywest: Remove obsolete cleanup
 for clientdata
Date: Fri, 9 Sep 2011 12:08:20 +0200
Message-ID: <20110909100820.GK1912@pengutronix.de>
References: <1315561784.2831.0.camel@phoenix> <1315561852.2831.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8912889858200413924=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B782310398E
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 12:08:23 +0200 (CEST)
In-Reply-To: <1315561852.2831.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8912889858200413924==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQ77YLfPrO/qF/pM"
Content-Disposition: inline


--LQ77YLfPrO/qF/pM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 09, 2011 at 05:50:52PM +0800, Axel Lin wrote:
> The i2c core will clear the clientdata pointer automatically.
> We don't have to set the `data' field to NULL in remove() or
> if probe() failed anymore.
>=20
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

There is (at least) one

if (ptr)
	kfree(ptr);

in this driver. Maybe you could fix this, too, while you are here.

And there is soc/codecs/tpa6130a2.c waiting to be fixed as well :)

> ---
>  sound/ppc/keywest.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
> index 8f064c7..4080bec 100644
> --- a/sound/ppc/keywest.c
> +++ b/sound/ppc/keywest.c
> @@ -82,7 +82,6 @@ static int keywest_attach_adapter(struct i2c_adapter *a=
dapter)
> =20
>  static int keywest_remove(struct i2c_client *client)
>  {
> -	i2c_set_clientdata(client, NULL);
>  	if (! keywest_ctx)
>  		return 0;
>  	if (client =3D=3D keywest_ctx->client)
> --=20
> 1.7.4.1
>=20
>=20
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--LQ77YLfPrO/qF/pM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5p5ZQACgkQD27XaX1/VRsncwCgrVZ+E79G/JlKXRSNn+YY8GGK
OvcAn37uV4SLIO1ck6yw7dv0dMeM74tP
=IOt0
-----END PGP SIGNATURE-----

--LQ77YLfPrO/qF/pM--

--===============8912889858200413924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8912889858200413924==--
