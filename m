From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: AMD: Manage ACP 2.x SRAM banks power
Date: Tue, 5 Jan 2016 19:02:58 +0000
Message-ID: <20160105190258.GO6588@sirena.org.uk>
References: <1450897275-17152-1-git-send-email-alexander.deucher@amd.com>
 <1450897275-17152-8-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1496625370=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1450897275-17152-8-git-send-email-alexander.deucher@amd.com>
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
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1496625370==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RHdRtM27np9fZUoh"
Content-Disposition: inline


--RHdRtM27np9fZUoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2015 at 02:01:15PM -0500, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
>=20
> ACP SRAM banks gets turned on when ACP is powered on.
> Not all banks are used for playback/capture. So, power on
> required banks during audio device open and power off during
> audio device close.

This looks good.

--RHdRtM27np9fZUoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWjBNhAAoJECTWi3JdVIfQQBwH/RpJoTZ+9A6ntlC4ldYdVmq5
1aOEoMrqIWB5HRXW5hJD/FdZMps9NjG2XGgMABqRFNUw6Kig/bYDmqIJricL5kVP
DkNHAtYxZ+XfYe3Ji1+lQsvwazL7GvnEpjHgJyCs5fbNO6/LN7jEYfZQXNqGTTrg
JH7N59I0TDU/hygP9AHK/1o4gDHLTkhOPIHqYI51zndlBrPWrqugN3wjbO0bk35x
mtilsjpPNKsdcOhgyXThBfTa+IBCLD6brsb8VvGYWSRgAkyJUgWjDSu5MhxAsEiL
y7QpxuuIxVwFzWojY3qQgyDv/NQDXouVz+ifU4SsDsdz+QxKLrOGSa4UmAduyPc=
=kQDq
-----END PGP SIGNATURE-----

--RHdRtM27np9fZUoh--

--===============1496625370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1496625370==--
