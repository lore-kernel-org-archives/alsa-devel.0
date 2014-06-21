From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/11] ASoC: Use component DAPM context
	for platforms
Date: Sat, 21 Jun 2014 21:34:53 +0100
Message-ID: <20140621203453.GC22657@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5394574737772568925=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 52E932625E3
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:35:08 +0200 (CEST)
In-Reply-To: <1402935191-18398-8-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5394574737772568925==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:07PM +0200, Lars-Peter Clausen wrote:
> The snd_soc_platform dapm field is not accessed outside of the ASoC core. Switch
> it over to using the snd_soc_component DAPM context.

Applied, thanks.

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpexqAAoJELSic+t+oim98gAP/18Cik4GzmktVA7RFkuAUq5M
pgphU2ffBfKnlcwWbIGhpJ3BLheNxm/xJ4sEEQB6zr/695i3bbTacIC3Q9xl9hDf
1JpZPBN1VLTKGggu2qcLyoBx+zHTu1Dw2wgm/Vo5ZA0X/2XwS+LJ7pn7HFO+Oazr
WA/gcSJnhdz9o+OaJqy8QN0d3pQTf69f2CUtQurCoY/oACYVR4OuNY+tN6Ro62/T
ciICiyxMi7+QWZSFFHRFQI8N5+G0vwqqAeHHct6fK6rymMWgVl7t1kco1GNFx877
dTPMFKlvqJM/WtSNmOBFXmeUFkUisKz79bKc9cLtZ1vnVGJDPsuGaLBK0k416rup
bnE91jX5rnXVY3qFte9VFY/89a0wAaiCnH96AqGOKWhNm+SKOTCYD3GFI/mbyKG5
kS8BcF10/BIYrhPGjkKVV9BTmOlgKCWQVYwyNUkAFNueIexekhwVBqeW6ZxrhIS2
eG0vtrWIODADWluMNouYT0ZTiystQifrpAmhfyaO6AkT8/tFcK/RzNXdqfEy7fr5
TwHFrCAJGnhoPwY+JvbKibLVItnq7+1SIh5jvvBdl7t8ByT4NGi/Ia2gSyhX+e0g
X5sAtwQ0QVVhQlWpkUDBPxaks4PMKZGwUDcyywbIKn8J+QGP44Bxpf61qOrDQmdq
Bb5NQB1o4/cKpZV5SB26
=li/x
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--

--===============5394574737772568925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5394574737772568925==--
