From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] ASoC: AMD: add AMD ASoC ACP 2.x DMA driver
Date: Sat, 9 Jan 2016 19:41:38 +0000
Message-ID: <20160109194138.GU6588@sirena.org.uk>
References: <1450897275-17152-1-git-send-email-alexander.deucher@amd.com>
 <1450897275-17152-6-git-send-email-alexander.deucher@amd.com>
 <20160105184343.GL6588@sirena.org.uk>
 <CADnq5_NE4BBYMfLNfFM=eonNy2Lny-5R_dV24UCS5Htioiqz5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0619652073=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_NE4BBYMfLNfFM=eonNy2Lny-5R_dV24UCS5Htioiqz5Q@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============0619652073==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TgCXP+xznsSrEyty"
Content-Disposition: inline


--TgCXP+xznsSrEyty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 08, 2016 at 06:03:19PM -0500, Alex Deucher wrote:
> On Tue, Jan 5, 2016 at 1:43 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Dec 23, 2015 at 02:01:13PM -0500, Alex Deucher wrote:

> >> --- /dev/null
> >> +++ b/sound/soc/amd/Kconfig
> >> @@ -0,0 +1,4 @@
> >> +config SND_SOC_AMD_ACP
> >> +     tristate "AMD Audio Coprocessor support"
> >> +     help
> >> +      This option enables ACP DMA support on AMD platform.

> > This has no dependencies?

> No dependencies.  The ACP device discovery is triggered from GPU
> driver, but the ACP driver has no direct dependencies on it.
> Theoretically it could act as a standalone driver.

In that case there's no need to merge everything through the DRM tree,
each bit can go in separately.  That makes life a bit easier process
wise, people will need to merge the two to run things but that's fine.

--TgCXP+xznsSrEyty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWkWJxAAoJECTWi3JdVIfQ46YH/RhMMDoUm3+n6YAVLQ622o0D
tt5J6ThbIuRkeBrtTHrhwH4kJcJr19mmNwqGYE1ccTnkE3y0aMSfF5GS46wMAbQV
/xsQOqq9o+qKitDCrylIvWrEpFZjFpnBakQgu36PD6i35ddPN1j1V2CBmEEUnnfG
uih2tuV7YLrD7j2IkVdpPidjtz7m1Q6AU8VhX9LW6ZAvhVL1KlAoRR+ho+/Gopjs
CVoU1vt9KZ8Lyk7ByCrT3bvR5sg1Td2BscutsgkM8aH3O76sJV5Ci8a1UW52lbtw
G0pnOMCTKgB5PhTCmGVKCEoRdNO81YNb78pupRHBNztQlrX8LSXlFDQcdtbfO7s=
=5kot
-----END PGP SIGNATURE-----

--TgCXP+xznsSrEyty--

--===============0619652073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0619652073==--
