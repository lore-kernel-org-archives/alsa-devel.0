From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] regmap: cache: Fall back to register by register
 read for cache defaults
Date: Mon, 1 Feb 2016 21:41:39 +0000
Message-ID: <20160201214139.GI4455@sirena.org.uk>
References: <1454362695-10682-1-git-send-email-broonie@kernel.org>
 <1454362695-10682-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454362695-10682-2-git-send-email-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mail@maciej.szmigiero.name, Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, nicoleotsuka@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 09:38:15PM +0000, Mark Brown wrote:
> If we are unable to read the cache defaults for a regmap then fall back
> on attempting to read them word by word. This is going to be painfully
> slow for large regmaps but might be adequate for smaller ones.

Competely untested, hopefully it helps fix the issues with the SSI.

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWr9ESAAoJECTWi3JdVIfQuiYH/Ryi/SXMdNTKDXCwhaZ56WHT
loVQQ0Mv43oFCEcusjDaHCTv4B5j+H4Z7agRte936N1T6lcoHpcCt73jr5VpG9EG
LeJfM/IoOSnbO495SK6aHhZYAEsrhp5B2SOWBC77C1Ic7t+9iYRh3I1ZWNXhlYBe
UZ3P6Nt9RZXTGk2UBd1sCclg9PIiXyrRc99K6emOq3hN5xOIHQskpqNFJdQv4ckm
17UefwpJ6np9LVfNTqaI4cyqKKZcsXbSfNnGkWcp9op5FN577cOQelL5+RKdOujg
qRK+jNRlNKuqSKB6XdRk8Vjo8JT7whJ/QPMO65nhEIxlL7CGGd+P0QrSHqJwMrE=
=gWHW
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
