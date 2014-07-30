From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Check ops before we
	derefference pointers.
Date: Wed, 30 Jul 2014 13:24:35 +0100
Message-ID: <20140730122435.GW17528@sirena.org.uk>
References: <1406722712-8323-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6458168351230272520=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 040262608EA
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 14:24:46 +0200 (CEST)
In-Reply-To: <1406722712-8323-1-git-send-email-yang.jie@intel.com>
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


--===============6458168351230272520==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JHuICPdih4kARifA"
Content-Disposition: inline


--JHuICPdih4kARifA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2014 at 08:18:32PM +0800, Jie Yang wrote:
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>=20
> Check ops pointer members before we can derefference them.

Applied, thanks.

--JHuICPdih4kARifA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2OQAAAoJELSic+t+oim9EigP/1DFn8tl3zQqBj1O+P2EbKKi
drSDJ47ZcawDJCQ7hZUFQiRHW9dvZBOdd0VwaNadW67pis3LT5eXWEQfK3SKWPdp
bPeaCTv91sccl4w/v9/RdKplbWNYE97g8Dx+0wBAMf0hvLRfTmbA4/YnGJ9uYcGh
Gx4pQbHNtVYtxzXJh3jqtbs8Yh8MrBAddYiz3W9kS8ecwuUREOJhlCkmc24Q0nrH
kbTJ1o+lHjlltSymN42m/noV2uvtVKVyeWHF4uoYxeB5iYWAvIugwHTGdrchqy3n
7auiCvnPNYkzvfqxsvhMboV/HfofrW9+PjCdsMPGwkn3Q3/B5+AvVzIShFPzsrOI
+I7Ay+1votBP0xj12OfnpQE/mc9Hhc7PvDP6iS0vp42KGATn3g3gSb4QYrHH5cST
12VDT7kEWFOxHiS6+I4e6JukVyAqZmcxl2mBU1Ea+z/MRdj7w0pkPFvuu1giip/i
YM4+9BmC2519FCawFJY8ATeXH/ZB8NbLteQtQufceeaY03a/wDgoX9webpCbTFNf
CZDd0aC7kIcvbJKNfRpPV/Nn//gHWYv9LBLfayCjptCEbDJpywylzPS2iZe5cKPD
n10SSHrNFQ7y6zfWR+c05dpT8yyZQ71rrazYy0FrF3iN/jrlvubh9vH6S+HA68y1
3ILQpabYLWoNkfWGTEhQ
=g70r
-----END PGP SIGNATURE-----

--JHuICPdih4kARifA--

--===============6458168351230272520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6458168351230272520==--
