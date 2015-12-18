From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/13] ASoC: AMD: add ACP 2.x IP DMA abstraction layer
Date: Fri, 18 Dec 2015 11:22:33 +0000
Message-ID: <20151218112233.GY5727@sirena.org.uk>
References: <1449272440-8735-1-git-send-email-alexander.deucher@amd.com>
 <1449272440-8735-10-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0329328139=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1449272440-8735-10-git-send-email-alexander.deucher@amd.com>
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


--===============0329328139==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y9MYNmSb6ticsAhO"
Content-Disposition: inline


--Y9MYNmSb6ticsAhO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 04, 2015 at 06:40:37PM -0500, Alex Deucher wrote:

> ACP IP has internal DMA controller with multiple channels which
> can be programmed in cyclic/non cyclic manner. ACP can generate
> interrupt upon completion of DMA transfer, if required.

Why is this separate to the actual driver - what's the abstraction here?

--Y9MYNmSb6ticsAhO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWc+x4AAoJECTWi3JdVIfQkzoH/3TKsAzYtWockmWAGa7Fux6o
bXoCQJeXvae8WaY94Fywef/OZv90JPxik4hGr+SQ/5jDejlp1WpteNKkIB1NFDSO
jksWFdR+ovce2UGZEd5d7qkXZ5bmFyw8TS3iAUZTcpu5hYAoVCtSlxxC5gzbfk0f
zhEdKGmV+jlVFAcRiU7pnhBoYNODccqg8mMTOvzoVbeloF7QsAXG+LoQ7T/ygcRK
ZSmhjKm8brFhiX1CQiVIH1qgiNOgAkiNdYt3s4ALUMLtudHXE0YAl6UX8ilmhWx7
6dHrOqxeB4lTyp3/LqBTJzKNb88hbCsuBdNewJIJi5mS6kHeorIrBZ3ZRT2Z8CI=
=xIGo
-----END PGP SIGNATURE-----

--Y9MYNmSb6ticsAhO--

--===============0329328139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0329328139==--
