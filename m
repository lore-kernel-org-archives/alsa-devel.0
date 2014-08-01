From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Delete message when IPC
	timeout occurs
Date: Fri, 1 Aug 2014 19:12:17 +0100
Message-ID: <20140801181217.GF30458@sirena.org.uk>
References: <1406905718-31142-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7779594213633840888=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC083265692
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 20:12:49 +0200 (CEST)
In-Reply-To: <1406905718-31142-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7779594213633840888==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w47z9evyjOavafUr"
Content-Disposition: inline


--w47z9evyjOavafUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2014 at 11:08:38PM +0800, Jie Yang wrote:
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>=20
> This fixes a bug where we dont delete the current message when an
> IPC message timeout occurs.

Applied, thanks.

--w47z9evyjOavafUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT29h+AAoJELSic+t+oim9VLMP/2IrqmY7JwMg9JL069oQ1YDu
WLqLHtMY97kbITAPUy2Kj7EaXqjA/wIO/ACAsSuiKzKro8bdqXwX2gBf7vRCukIg
otModgzNdOQK9N0l7faW0xKrM/ZeUIACI3koVbL5Vh40sJzAbhkJpI2QVG1Vc6xL
QxkKUb9RwmPA/TTldg8cj8zwrxEhFO7I5dCxgljactQ13rgbUnmxbffBJ3/s/TkH
nCyUshHFHZQzs+md/v/ekWHr9HjfKrHP0m4Quf/wix3oAiThC+zydnN41nzfSrDT
OckxmjGEmY+hD7iTP0z/a6WtluZRjyScw1BguYaeY+cBWMLPw0rdkRo/H+pmE8KC
wyBIsbD8wK2TcbN2qVRJ0CAOTEQIH46lLoEBdHt3oUQjfhaHaJSOpFVBA3QutSQl
wpyaVcF0U0lT1dimjGL00pKNwxOMDWcHpgGX43U/sgYvFPPKOXMDqNbCt6RflQ/u
N3PvUeZAdCi5r0CuECXG23jRHwCRUHDLr662dDSRofMDSjy3JdEvxyr0Uu0x62k2
SSnq7VxPUx6yGgkQN5eyUYxFkAP+Eb6zJZskYyPiAv7Djp3XVy/l7GVOVpwJ+JaT
R5CcvltKib8Bz4NajiMZZQCd+AcGMYRvhoxu3SO16jpGzT0ZTEiDv0ArZd8nBwQg
bf4MQyEOjL0H741g60Eo
=k683
-----END PGP SIGNATURE-----

--w47z9evyjOavafUr--

--===============7779594213633840888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7779594213633840888==--
