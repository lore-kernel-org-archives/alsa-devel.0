From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/8] Add ASoC support for AMD APUs [v6]
Date: Tue, 5 Jan 2016 19:04:45 +0000
Message-ID: <20160105190445.GP6588@sirena.org.uk>
References: <1450897275-17152-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0028222596=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1450897275-17152-1-git-send-email-alexander.deucher@amd.com>
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


--===============0028222596==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vzUQzca511KWT6Hk"
Content-Disposition: inline


--vzUQzca511KWT6Hk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 23, 2015 at 02:01:08PM -0500, Alex Deucher wrote:

> for the i2s codec.  Since the alsa changes depend on the drm changes,
> I'd like to take the alsa patches in via the drm tree.

If the ALSA changes depend on the DRM changes I'd expect to see
something in Kconfig otherwise I'd expect we'll see either build or link
failures?  Or is the dependency runtime only (in which case there's no
need to worry about it for applying the patches)?

--vzUQzca511KWT6Hk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWjBPMAAoJECTWi3JdVIfQbycIAIY9LhIu9MWGIAHx+qyW8fws
IzFP7po8lqrlmVOEasccD8wDcqTDn+AjNnLeuo96SB1p3tGyzfJXiazHIC7gRxM1
eu/mc19W4lAnkPulLftpXsJr7KTykqaplhpLG1ILUJe7Z+83ly0RmcfCbOWSxB1H
+2Xi7TydlCr4WbXQwBp/nYzx8toqLUn8+aPaz7Bb80udsoK/EKsHYE+QhaoLmhef
HeB8oFFwbi6zL7OWAu1Tcaxxa6eltiG+AxLwe67Xt9OG46wYbEwSfvS2un9X7SXh
gvHXvENszwR06Y/In7U/0jg1nr7nMeHpbLalqadR2Fjze8SVqS44lBTbSehwOR0=
=xrx8
-----END PGP SIGNATURE-----

--vzUQzca511KWT6Hk--

--===============0028222596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0028222596==--
