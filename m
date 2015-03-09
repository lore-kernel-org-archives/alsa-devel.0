From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: match wait_for_completion_timeout return
 type
Date: Mon, 9 Mar 2015 18:18:03 +0000
Message-ID: <20150309181803.GS28806@sirena.org.uk>
References: <1425820609-28684-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8bIXokQePRfDuBGo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425820609-28684-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--8bIXokQePRfDuBGo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 08, 2015 at 09:16:49AM -0400, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. An
> appropriately named unsigned long is added and the assignment fixed up.

Applied, thanks.

--8bIXokQePRfDuBGo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/ePbAAoJECTWi3JdVIfQDhIH/jrI3qV0x77VD/OiTmv/KquI
D5odfDLLeBPFWRl0vchJ3nlEvJzsWw8P7GZ31IIcsaK+qLSQ7WRF6PG00rQeGcBA
5kpvzYDJQYpLuxF+feAZ8w1GDa8BhcxZ6tx6izSNnYmpWVzcu5dbYGN0lh7FBKGL
iq3n7TCyizi/C+ME9MSpJtaN/9f0fHGfkWko+AMRSnzLpEu7o1dYANgcr0CqvFi1
rUSdSkGGQ3xOoU0jA0EVhun02b0ra/TPQswbIIhimSpA1ojqwUjV/zbU3YnkVh8O
BPSRK2EOx5LsAnWflswBzquWvOiihn7+eWDybJXyvzCpX2H2wskfKVgbdaAnCZU=
=Symd
-----END PGP SIGNATURE-----

--8bIXokQePRfDuBGo--
