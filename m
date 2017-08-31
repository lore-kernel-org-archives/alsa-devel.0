From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6 v3] ASoC: AMD: disabling memory gating in stoney
 platform
Date: Thu, 31 Aug 2017 12:39:45 +0100
Message-ID: <20170831113945.6jadevfbvl5u2qux@sirena.org.uk>
References: <1503079830-16072-1-git-send-email-alexander.deucher@amd.com>
 <1503079830-16072-4-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1532667708=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1503079830-16072-4-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, amd-gfx@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1532667708==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6gc6yk3fqrn4yhvb"
Content-Disposition: inline


--6gc6yk3fqrn4yhvb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 02:10:27PM -0400, Alex Deucher wrote:
> From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>=20
> For Stoney platform, Memory gating is disabled.i.e SRAM Banks
> won't be turned off. By Default, SRAM Bank state set to ON.
> Added condition checks to skip SRAM Bank state set logic for
> Stoney platform.

Acked-by: Mark Brown <broonie@kernel.org>

--6gc6yk3fqrn4yhvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmn9YAACgkQJNaLcl1U
h9BA9wf+PD1lvkMnug1MS7msaaBRFxzmVKx4jYlsHFAMaKZIyafbt4M0X1uFV3Jt
1nXqwmEYD6q2nlFx1R2imXER6HWgwML23McFuPZ05LsNFf7rEhVEM0z2CtslGMCN
+B31wrwnZG1ydpxpjMnTtWZl83bEsEVA/EI3fs8t/dVRj5NLzkhCkKWK+90wPk0c
bxQ2a/SS6GJJmFV9REKAGhKF709V9xnUAxKWAZ6AOS1MmR6kpIxLpHWn1qI2ZBgU
jubZPKgxV1K2yATRvgyn3HijHCBQ55HfZMHU40q5xSxFut0W2l0JAavRSy29vFZ/
19NLF496fEdqWQ+VPOZOdvV+K9teNw==
=sWFP
-----END PGP SIGNATURE-----

--6gc6yk3fqrn4yhvb--

--===============1532667708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1532667708==--
