From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 6/6] ASoC: sgtl5000: Don't disable
 regulators in SND_SOC_BIAS_OFF
Date: Sat, 7 Mar 2015 10:41:52 +0000
Message-ID: <20150307104152.GO21293@sirena.org.uk>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-7-git-send-email-eric.nelson@boundarydevices.com>
 <20150306201646.GA21293@sirena.org.uk>
 <54FA2BB8.10203@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4287511417587829523=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB5F92605F3
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 11:41:59 +0100 (CET)
In-Reply-To: <54FA2BB8.10203@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============4287511417587829523==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="isFuM/k5xG11LieK"
Content-Disposition: inline


--isFuM/k5xG11LieK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2015 at 03:35:36PM -0700, Eric Nelson wrote:
> On 03/06/2015 01:16 PM, Mark Brown wrote:

> > Why not just fix the code, reinitializing the chip is usually
> > pretty trivial?

> Apparently not.

Well, I'm not sure if that's actually true or not - the current driver
code is pretty bad and there's been a history of worrying submissions
that people assure me are working well and address problems.  All of
this is indicating to me that the complexity here is largely due to code
quality issues and that if we address those then things might get a lot
easier.

Requiring a funny power on sequence shouldn't be hard and is needed for
suspend and resume anyway, all having the regulator support does is mean
we can potentially take advantage of that code path at runtime.

--isFuM/k5xG11LieK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+tXwAAoJECTWi3JdVIfQ0HEH+wbyXENcZpcGegjJuD3WYSU7
jYZs+fRR9/wrjfXYFQQ51rtV1TictbGE9KSOxwNxKDQgZ6Nl9Xuak1j5zi5RIhBc
VHtjyjsyukKUHrY6HAoLodUFYrmMp70esEpxYBa5XMP2iIlwHv5Xb7ZjKpvkgBr1
y5roHeHdO+nfoAej1cVuAlBDW9B1adrV9hG0qc7QdSsIW8Z7CZP9OoDVKLJvUEyj
6K5LDjRB2goJ7BcqMh/Bda8KFyXJxrB9GvBCA1Aps0lDb22xHjYHwfmHs+Zb6ZUh
UxQo+gcd9/Tk/U3ueAF+PFIcSAvtyl9Q0uC8X/MLQZXV7a+hzQ+StWe0oRFI9ro=
=bUkT
-----END PGP SIGNATURE-----

--isFuM/k5xG11LieK--

--===============4287511417587829523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4287511417587829523==--
