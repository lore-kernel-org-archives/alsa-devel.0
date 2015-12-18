From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/13] Add ASoC support for AMD APUs [v5]
Date: Fri, 18 Dec 2015 12:09:20 +0000
Message-ID: <20151218120920.GC5727@sirena.org.uk>
References: <1449272440-8735-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0142803448=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1449272440-8735-1-git-send-email-alexander.deucher@amd.com>
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


--===============0142803448==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cmojth4sdaU3VRJa"
Content-Disposition: inline


--cmojth4sdaU3VRJa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 04, 2015 at 06:40:28PM -0500, Alex Deucher wrote:
> This patch set implements support for i2s audio and new AMD GPUs.
> The i2s codec is fed by a DMA engine on the GPU.  To handle this
> we create mfd cells which we hang the i2s codec and DMA engine on.
> Because of this, this patch set covers two subsystems: drm and alsa.
> The drm patches add support for the ACP hw block which provides the
> DMA engine for the i2s codec.  The alsa patches add the ASoC driver
> for the i2s codec.  Since the alsa changes depend on the drm changes,
> I'd like to take the alsa patches in via the drm tree.

I'm not seeing any review at all of the DRM side code...  other than a
few minor issues the audio bits seem mostly OK.

--cmojth4sdaU3VRJa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWc/dvAAoJECTWi3JdVIfQcyQH/1A7UgOqTOGxdrwYD2hnnhNE
v6ask9SNUVDDrtgxrMNZgatDhl9iosbx5TYwVuns1qOQP8eEIJWwNVRjJ1NiL6g6
RMg5WgmTerABZIpzngNqtUA5HKcINcDfJAlXEdgHFlm4xFy7mMRfrTB/OyN/moXR
8BQ+McD23uA3AuSIBskOBfSeGwbw7eyOPJHnBli3lXGPm4p/BQotHIL9aFEDubqU
/Rt1A8gv9x2TEoQTUvPpMaCQZzngcmYPQei1ulqzFW0vZD9qFHMzkoczYjZypH41
5WCB+J7q0sgNJo4ZVIEahZUJugD0dg8mB/p6v+Rt4jikmVpbzM4C1QehslPRH1U=
=yqmP
-----END PGP SIGNATURE-----

--cmojth4sdaU3VRJa--

--===============0142803448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0142803448==--
