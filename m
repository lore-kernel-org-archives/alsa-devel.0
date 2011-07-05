From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 3/5] ASoC: twl6040: Do not use wrapper for irq request
Date: Wed, 6 Jul 2011 01:41:31 +0300
Message-ID: <20110705224130.GD8023@legolas.emea.dhcp.ti.com>
References: <1309895376-17446-1-git-send-email-peter.ujfalusi@ti.com>
 <1309895376-17446-4-git-send-email-peter.ujfalusi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309895376-17446-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: alsa-devel@alsa-project.org


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2011 at 10:49:34PM +0300, Peter Ujfalusi wrote:
> The twl6040_request_irq/free_irq inline functions are going
> to be removed, so replace them with direct calls.
> The irq number is provided by the core driver via resource.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

(forget the Acked-by on previous thread :-)

--=20
balbi

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOE5MaAAoJEAv8Txj19kN1OFkH/iNPLI+On/C7zLVBYgZ3VMIp
kqQeEXsEhn/RfvmC5E0f3PEehdTZfr36QZeaJJWkDeotn0yfJ8xBc1zeJwSxjziw
tRUOMEGd66LfKVaI3oBTYjvzZFTGLoUJXsHNtPAfyCDj1ns8hQGQ58rwG4vJKqWG
J8i6UczNcD9ezb0qK0v8hJtFubi2SUWmSjBfn/bCAYFvMiAYOf3r10KSDzorBq3A
aXJU999ZX+p8OZ/alVwQJ9lfhxwOacMHEzvIKARYQLk/DOP68MYoL1sZhRzpwkQV
Op1kfUXJICyEhVdtRSxjYI6upamZDVxrs8/EsrwCwEbAyEbveCi8Ihs77SZ387U=
=2ahy
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
