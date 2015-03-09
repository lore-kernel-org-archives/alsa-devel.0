From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm8996: match wait_for_completion_timeout
 return type
Date: Mon, 9 Mar 2015 18:16:12 +0000
Message-ID: <20150309181612.GQ28806@sirena.org.uk>
References: <1425808935-17070-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="utew04vv9FCWZJ01"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425808935-17070-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Xiubo Li <Li.Xiubo@freescale.com>, Sachin Kamat <sachin.kamat@samsung.com>, Axel Lin <axel.lin@ingics.com>, abdoulaye berthe <berthe.ab@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--utew04vv9FCWZJ01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 08, 2015 at 06:02:15AM -0400, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. An
> appropriately named unsigned long is added and the assignment fixed up
> in case of completion occurring the remaining time is >=1 so ret is set to
> 1 if no timeout occurred.

Applied both, thanks.

--utew04vv9FCWZJ01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/eNsAAoJECTWi3JdVIfQQWEH/3qBO+lXhQlI+EFjkdFLGxYn
S1J4Dg/ihLsu59Bmicy2l5md7R3WUnuKTFVpNcgpgVBUp+43e/hMJomOzOny6uVz
f9qNY8JfNPbSNyJS57D1iywwH4PCE1HCztF2xqTi2vhqxQRiPWfQuYjk48chVFaO
COjkJz4ZPQ9aEcmrl49AGpVQkNZbRiUSRv0/OBfsa9HSSA0yhcBo/daECXhciHVY
ByiSgIhGyrmLNp5+lXao4vx3s6hDV5vbCC8++2z0w5WGtWqCohpUZlFwjRqXaFHR
ub5uUDIelpi8xwvTD53kkbtnYgjLL+Bpv4pGIXqLz7JEgvVFFlhOAWUkkZrjTP8=
=EFbY
-----END PGP SIGNATURE-----

--utew04vv9FCWZJ01--
