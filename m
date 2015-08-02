From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 5/6] ASoC: fsl_ssi: instantiate AC'97 CODEC
Date: Sun, 2 Aug 2015 19:48:43 +0200
Message-ID: <20150802174843.GB19600@pengutronix.de>
References: <55BA362B.1010706@maciej.szmigiero.name>
 <20150731054617.GV30895@pengutronix.de>
 <55BB8898.7000909@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2336574340420579062=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 486FA2606CA
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 19:48:48 +0200 (CEST)
In-Reply-To: <55BB8898.7000909@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============2336574340420579062==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 04:39:20PM +0200, Maciej S. Szmigiero wrote:
> On 31.07.2015 07:46, Markus Pargmann wrote:
> > On Thu, Jul 30, 2015 at 04:35:23PM +0200, Maciej S. Szmigiero wrote:
> >> Instantiate AC'97 CODEC in fsl_ssi driver AC'97 mode.
> >>
> >> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> >> ---
> >>  sound/soc/fsl/fsl_ssi.c |   21 +++++++++++++++++++++
> >>  1 files changed, 21 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> >> index 154bcf6..8e5ff5e 100644
> >> --- a/sound/soc/fsl/fsl_ssi.c
> >> +++ b/sound/soc/fsl/fsl_ssi.c
> >> @@ -1460,6 +1460,27 @@ done:
> >>  		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi_private,
> >>  				     ssi_private->dai_fmt);
> >> =20
> >> +	if (fsl_ssi_is_ac97(ssi_private)) {
> >> +		u32 ssi_idx;
> >> +
> >> +		ret =3D of_property_read_u32(np, "cell-index", &ssi_idx);
> >=20
> > This property is not set anywhere in the imx* DTs.
>=20
> That's right, but it is documented as required property in sound/fsl,ssi.=
txt:
> > Required properties:
> > (..)
> > - cell-index:       The SSI, <0> =3D SSI1, <1> =3D SSI2, and so on.
>=20
> >=20
> >> +		if (ret) {
> >> +			dev_err(&pdev->dev, "cannot get SSI index property\n");
> >> +			goto error_sound_card;
> >> +		}
> >> +
> >> +		ssi_private->pdev =3D
> >> +			platform_device_register_data(NULL,
> >> +					"ac97-codec", ssi_idx, NULL, 0);
> >=20
> > If you really want to create a device at this point you should use
> > PLATFORM_DEVID_AUTO. I would prefer something where this is created in
> > DT. On the other side it is a discoverable bus..
>=20
> In the original implementation the codec was instantiated in DT but
> the feedback was that this is wrong since devices on discoverable
> buses shouldn't be in DT.
>=20
> The platform device index is based on SSI index since the sound
> card driver (fsl-asoc-card) has to know CODEC device name to identify
> it in DAI links - as the only identification options seem to be either
> DT node of CODEC or its device name.
>=20
> That's why the (platform) device name has to be deterministic
> if there is no mechanism to pass it from controller driver
> to sound card driver.

Thanks for clarification. I am not really happy with using this
cell-index as the whole information that should be necessary is already
contained in the memory address range given. The SSI units are otherwise
identical in hardware, so cell-index feels like some arbitrary
description that is used in the Reference Manual and for software.

However I don't have a better idea how to solve this at the moment and
as it is listed as required property and not a new DT binding it can be
used.

Best regards,

Markus

>=20
> > Regards,
> >=20
> > Markus
>=20
> Best regards,
> Maciej Szmigiero
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvlf6AAoJEEpcgKtcEGQQRJsP/1K/b0nsra/odz0He8LAVe5f
QJ4IWcIYW6c+OevuhouimLzKMJGUDDYtJmFP5a4I5iRtTFL7TMx2z9ZbLO0/mQgP
RFyudaojCpf9nhpVaBxqrWQR8i3JEnT4aEABwsahW8H7jEPRWakSF53rEYrx1pcy
Ks9R1HHIrnxPegl7h5i8eLx7lnnCjqbDVFSOYi9xRxicM0FPwb5yxKB82mAVr/Di
glGujtKB7BQyub/qczQXOT0wLkiQfS0ErF1BAiGCrwFQbLrWDiwTlkQXNVShxXu7
7m0LAY+wfJPWlTSYyKCKI2s4r5LjdZBTaC/sb71Kba5BMkmf9qEfVU31HvrOBIFk
QWAKx/lqOODqfCbDSWsRHSnwf0rpaG/bOzocRbcJxE6riAl0u80c7+OwSxg1Mmht
ahHx+Z882f0eO+2dPZSzsQGaI4Wo4HQ0D4u4XHKR4FdnFSMSmvoLW3K5NTAPMxmy
8DWCSrINJy0ZbFkz1GJQEZtEVM9+KkPKHDz08x/0MTCzEXTlOGg1wNgVtINI1Sbw
wwe2a53cXUHNHHm/LcKJMz8f7gN5Kg+4C64wOKf6IrCgVPrJVw5e8e1/YYHWbv76
hZKXNbQ7HlZ1g6zj2cGv6SCVqxZUT2Kf2kTZA4Jmzsu4JWcaBbHAM5lB5F8l0NEE
Z7QA8wzwjxIiVb3Uvd4w
=wwKF
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

--===============2336574340420579062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2336574340420579062==--
