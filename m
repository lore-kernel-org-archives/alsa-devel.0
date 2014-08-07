From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Intel: Fix to use byte control
	interface
Date: Thu, 7 Aug 2014 12:58:05 +0100
Message-ID: <20140807115805.GJ17528@sirena.org.uk>
References: <1407144861-30475-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407144861-30475-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1309865362726358588=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F03E32650E4
 for <alsa-devel@alsa-project.org>; Thu,  7 Aug 2014 13:58:17 +0200 (CEST)
In-Reply-To: <1407144861-30475-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1309865362726358588==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABWr0kgVubSmBqR2"
Content-Disposition: inline


--ABWr0kgVubSmBqR2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2014 at 03:04:19PM +0530, Subhransu S. Prusty wrote:
> From: Vinod Koul <vinod.koul@intel.com>
>=20
> Using a byte control interface instead of generic_params ioctl.

Applied all, thanks.  This is a bit confusing since it's called a fix
but it's not actually a bug fix.

>=20
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

The signoffs should really be in the other order - if you're passing on
someone else's code you need to add your signoff after theirs.

--ABWr0kgVubSmBqR2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT42nKAAoJELSic+t+oim9l34P/3iSEWCkasHVLAu3otNYjKlC
nisWngEfRSawWe3eDD1Xgxb7O61EfsP/8ztXIJVztMGeM1sYV0SnG8ZQaRkRW+5s
PZFV6jXvXmg9jRuEjD/ffC3m0+vXb9okcGXbFlVebnd77U3uYD9KB4xO1E4MX1qt
wuBtKaAv0g/ZmhpMs+0zQoC7/vbAWJbPLTz5KTVHXbhbLE9fRyvM66QoNTktJO6L
Kh3XDotZcRzYXmxMVWfERfur0eqR+NzUEU5VQ7uhfque72PeWqjLPy/B75BYV+eF
isbdMMryvu0m10g0UZEIqqZ8zvbyKOBo+iUJ3xQJxHteQj91AelkF0goRUr85aQq
0tpd1/vhu6/4840AdcfioPimP+tzKvRMpD0yG1ZI+8/yHy1xR8osM/n1oaefyx7z
BwVM8vkhtaqFtPNdrPlx5+SocPOsntFhuLgmLiQOodQghFKeZ7uFLdGWaV263Ths
7b6NCW4i8LtEh9QikB1MVdOjIPu8peaFF3Nmqu/eLPVpYxi99XrR+Gu+Cug23mh/
vHy91sxhZvEL0z6ng9L2G6QiuQS3r2RdDWBMVg8o2Qy0C7/w4TaquPLuH+o+pVEi
tf3G3XcuUZoi9P8s3998xMHkrEVBfdED7NI0fuaUh7+9Ih+lG+qwiAS+3hoLsGio
TlOMt8i44T/54OthOJVQ
=nbyF
-----END PGP SIGNATURE-----

--ABWr0kgVubSmBqR2--

--===============1309865362726358588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1309865362726358588==--
