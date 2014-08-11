From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Fix uninitialized variable in
 snd_soc_dapm_get_enum_double()
Date: Mon, 11 Aug 2014 20:00:57 +0100
Message-ID: <20140811190057.GM17528@sirena.org.uk>
References: <1407511775-26479-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1278156150927375915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D4C926172C
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 21:01:05 +0200 (CEST)
In-Reply-To: <1407511775-26479-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1278156150927375915==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1NsjvM78Wc2uYjy2"
Content-Disposition: inline


--1NsjvM78Wc2uYjy2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 08, 2014 at 05:29:35PM +0200, Geert Uytterhoeven wrote:

> ---
> Is this correct? Please review.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

BTW please remember to put the signoff *before* the --- otherwise it
gets discarded.

--1NsjvM78Wc2uYjy2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6RLmAAoJELSic+t+oim9WhEP/0VLO6NpCm9S3fWDvzoWCzcP
+C6ZKrWLHAD2ROuNn1OtZWanavx9/rBMsdmnp3x28/8j1ND5o27GpcEM2ZKIkqEV
0XTKrvkq9WcvzziH74bYFJxWkvP62aWzwupF5K9pLW0oPu2Fj9wGolCdb6fHAl8w
2PqXGOrngqDww7SfPFmOK6AJofa3H1KUSAlIB04n6Ak5WyeJGbBmvJIrxnUNVSEv
M0sSCGSlKdw+t1/3OC7ZGhRqLMzubB+CHXCGTI/uaMPu8RCcIN0qi7mAdDNRL/mJ
H2GbI+7q2ZEwWjZvdReFpOdXrGi2jN+fTKhQ13uwN20xfqJtL+hlejiQYllcOQ4N
rAzvDpJepuPs7pgnnqB3YAdvDlAuroqBoBFxperdJxFOAyab3UKVPDCthJ26/qdy
VTFTgjBU9Xk3knM2Il5RK8UMN1vXBWaz6wC8IRM3BL1s2c3mK92692bosA5ZEOGm
SpScvzQpiQGtYQA8g7mx71eQq5c8jeB8O2s1JQUXglSzwZFXKvtPbHOiQhQj0t+A
013cnjMVF91ryB+YSg98GwC3bnQNuPe8zUnHS2cig+DLSjhpAQ8wnldSrMcOzoof
Spvrux24WPcAIfshxZnDGd+YkqRUdmbL6S/B0ZN0YKr8Uiz7Q/GSpaYzYq4nmBMD
Hsdvzd14bPYKer7yNsFT
=ZZZb
-----END PGP SIGNATURE-----

--1NsjvM78Wc2uYjy2--

--===============1278156150927375915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1278156150927375915==--
