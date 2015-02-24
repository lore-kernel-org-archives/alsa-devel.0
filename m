From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: core: Add extra dapm properties for Device Tree
Date: Tue, 24 Feb 2015 23:47:17 +0900
Message-ID: <20150224144717.GN6236@finisterre.sirena.org.uk>
References: <15b0ecaefffcd48bb5f56fe76326d705c3467438.1423963314.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kM4gEFU/49KOGupy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <15b0ecaefffcd48bb5f56fe76326d705c3467438.1423963314.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--kM4gEFU/49KOGupy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 14, 2015 at 05:22:49PM -0800, Nicolin Chen wrote:
> The current helper functions, snd_soc_of_parse_audio_simple_widgets()
> and snd_soc_of_parse_audio_routing(), set dapm_widgets and dapm_routes
> without caring if they are already set by using build-in widgets and
> routes in the card driver. So there could be one of them, build-in one
> or Device Tree one, overrided by the other depending on which one was
> assigned later.

Applied both, thanks.  This doesn't feel terribly elegant (what happens
with ACPI and with whatever else?) but it does the job and we can always
refactor it to be neater later.  Or perhaps just rename the variable
which may actually be all that's needed.

--kM4gEFU/49KOGupy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7I70AAoJECTWi3JdVIfQ5XgH/jUv0xEvH+M67LcRSislOaa2
/DPfzmxHkEtOVEJzk2UhY2321HnWl34QnfUddR6kgmiByTeRzT5f6jKO6myzwwo2
DNwiN5caJEEcCOVDdZERAeXaz6oXspHnOjTWOto9pIBOAv5lEqwBNZLN7ka8uF/C
nJrBL9U45TKwCbbL9GG7fhOS0Y83Fd/t+7MtYhsPtBJuz1yqQEOZm7YRrHAXCZID
CZWd3WPg0rsVNdKK8F/PWeswhTWx9BUF8yxIDsQtaSHTXdx33ce0CoULlZyg57lz
LB2N59OMu4H/kmadrDH032AB/X6kaEiH/nPjMZ+JGwSVgOUJ+HI8Iv0hk5E+qek=
=2i4w
-----END PGP SIGNATURE-----

--kM4gEFU/49KOGupy--
