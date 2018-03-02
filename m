From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: max9867: Drop probe function
Date: Fri, 2 Mar 2018 12:43:15 +0000
Message-ID: <20180302124315.GG6255@sirena.org.uk>
References: <20180301215701.GB4302@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0832459244517597331=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A6A532673A4
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 13:43:16 +0100 (CET)
In-Reply-To: <20180301215701.GB4302@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============0832459244517597331==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Content-Disposition: inline


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 10:57:01PM +0100, Ladislav Michl wrote:
> Driver probe function has no use and can be deleted.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  - v2: Rebased against Mark's current tree
> =20
>  Mark,
>=20
>  is this what you asked for? It does not make much sense to me
>  as you have to redo the work I wanted to save you...

No, this doesn't apply - please resend what you originally sent.

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqZRuIACgkQJNaLcl1U
h9BPeAf/cMxH74b1YMEvewec0my8XSgLq6+eXNFf1MMfc/o7j8UP9mHER4q3nqbq
fgvuCKSXGgl0UxCOaDxjsDRvLS9t89BtZfZJYlJPoFyMOcE2vadHSbr5DtekG2u2
oL0NjjO5gHiPbjbEi8DRk0+64MXNxEb+WwN4C4/xQeU4cQjhVCtQM7V4f9e+48QQ
AoSMWE+u67q9S88mmYha+XwkRSmiGK/3oXY+rmRQnqGL2jdZurpMfTFqGs5Gj2qS
mcw7CdnnDxH1mAxufNvDuTwCi466cT6PcK4rWlRBsGSJb07RI9PE1FqlbeBsMaAa
H3bPV3HwGTsWT1vxhxOiS4mxub3HfQ==
=KdhZ
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--

--===============0832459244517597331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0832459244517597331==--
