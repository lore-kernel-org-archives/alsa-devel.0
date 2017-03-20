From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/5] ASoC: sun8i-codec: Remove analog
	"HP" widget
Date: Mon, 20 Mar 2017 17:39:03 +0000
Message-ID: <20170320173903.fc2m4euobea3npyq@sirena.org.uk>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0120400368732098553=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D823F266948
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 18:39:29 +0100 (CET)
In-Reply-To: <20170318075509.3836-2-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, wens@csie.org, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0120400368732098553==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hm32663gc5y5olbn"
Content-Disposition: inline


--hm32663gc5y5olbn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 18, 2017 at 08:55:05AM +0100, Myl=E8ne Josserand wrote:
> The "HP" widget is already present and take part to
> the analog part (sun8i-codec-analog).
>=20
> Remove it from the digital part as it is unnecessary.

I know I said to send against Linus' tree but it turns out this actually
conflicts with some of the existing fixes, please see my fixes/sunxi
branch and resend against that.  Sorry for the hassle here.

--hm32663gc5y5olbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljQE7cACgkQJNaLcl1U
h9DUIgf8DZoZ9+gTJA//SWv0Fl3ar65cLHQqW2OMNW6J+3w13DtRUN4mHpeEmE1z
Gzuw4zyFQ+2dUU8ijbw6Icnp3wCk9vnHIeff3PnF/0T9KnyzxdRUgslXbkACsRbo
fvKO4nvPL5M4rKVlFyXhVQnvTWHGzog0mdEuqInv3ZBmsR6hvh0AvvPa4f8cpXS2
UcjQUPERz6JVUkR7NiE+Dh6DN+3JQS7K6ECQ0jvi4GOjgwepybvJLJ+Yt6VQ3SL7
ovoB8mwHu4AzDgF4gsuim+VgtAExM23oTtFXWihifj5rrhv+eCOcxktkiBmFu7k8
k5p6iE0KolTNFhOY2gWsurdjL37Yvw==
=fvBj
-----END PGP SIGNATURE-----

--hm32663gc5y5olbn--

--===============0120400368732098553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0120400368732098553==--
