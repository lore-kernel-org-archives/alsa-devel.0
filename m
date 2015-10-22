From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC : dwc : add check for master/slave format
Date: Thu, 22 Oct 2015 15:56:14 +0100
Message-ID: <20151022145614.GQ8232@sirena.org.uk>
References: <1444320760-21936-1-git-send-email-alexander.deucher@amd.com>
 <1444320760-21936-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1568500067=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1444320760-21936-2-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1568500067==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l8yJEXo8J9fv7OFY"
Content-Disposition: inline


--l8yJEXo8J9fv7OFY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2015 at 12:12:34PM -0400, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
>=20
> DW i2s controller's master/slave config can be read from a
> read-only register. Machine driver can try to set a master/slave
> format on cpu-dai using 'set_fmt' of dai ops. A check is added to
> verify codec is master when dwc is slave and vice-versa.
>=20
> Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
> ---

I can't apply this, you've not added a Signed-off-by for code sent by
someone else as covered in SubmittingPatches.

Please also try to use subject lines matching the style for the
subsystem.

--l8yJEXo8J9fv7OFY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKPkNAAoJECTWi3JdVIfQL84H/R+YMTSRR7jfJ0ZwW5f6ZmFn
ROxebYS3mhQlYUASDQ8atrD0KyY9kDsaoGA4d/3Pjayj4FZKq86zVhzbMFPkH5w7
l3c5OsIux8lmAiHM7nctKK41weC2o29PtV4jTZxo+bsb1tW1tyNOOvJOB7RiUG6/
F10Z5AH8jVMwqSlcnVreur/3LIaLYIkRZpGWz7XsZhYiAqaNjOrd79fZIHWzj344
07lshwgaCFsbC+9+KMKnx6EVfOQA57XxtzZ0Rmh7ciQmWY9Q/sT+u3ms4h51BpKP
B5FAubnZP+FowXEWNR87efnkIpoKg3UQyEirC8kseM26WyyzZuqyEivs1zVrnkw=
=3C4c
-----END PGP SIGNATURE-----

--l8yJEXo8J9fv7OFY--

--===============1568500067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1568500067==--
