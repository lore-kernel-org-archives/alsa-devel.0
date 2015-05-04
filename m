From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/5] ASoC: Correct typo in
	SOC_VALUE_ENUM_SINGLE macro
Date: Mon, 4 May 2015 13:03:41 +0100
Message-ID: <20150504120341.GI15510@sirena.org.uk>
References: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3743668504688501738=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 11B33264EF3
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:16:15 +0200 (CEST)
In-Reply-To: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============3743668504688501738==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BghK6+krpKHjj+jk"
Content-Disposition: inline


--BghK6+krpKHjj+jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2015 at 12:37:23PM +0100, Charles Keepax wrote:

> Changes since v2:
>  - Use snd_soc_enum_item_to_val to get zero value from mux to account for
>    non-value enums
>  - Improve handling in snd_soc_dapm_put_enum_double of the situation
>    where the register and widget views of the control values don't match
>=20
> Thanks,
> Charles
>=20
>  include/sound/soc.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

This list of changes doesn't appear to have anything to do with this
patch?

--BghK6+krpKHjj+jk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR2AcAAoJECTWi3JdVIfQLJ8H/3k5rSkHsIrmPScvgiwHTfcA
trhLH+gdeQxVmvpshtFfubLe6vasg0YsW2K10bKyODVaBi028BiA8GFISISfVQ/B
TRznqEdlI3RlUVxcJjXn+GG+GnXjofOHis+2IEpoi0MfhwRN1I7YiAqSw+82g1qV
vATf+LePtnpK0MpCF7BZcEI/XxrcOo/bP7O3sDS7xU6xceas4VUlVlN44v19URsH
a4FNRS0C1Df5fUx+/wNC16frxoMZthHgep1/dtL1U62gEPEod2Iocrh3oC6rzxjW
vUYdCDbDgv1CendfNo/2PoXcvAGdv50TRTegpLmyVHNTOKTf4FUAhsCUBIsZ8bU=
=G27I
-----END PGP SIGNATURE-----

--BghK6+krpKHjj+jk--

--===============3743668504688501738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3743668504688501738==--
