From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFT] ASoC: mc13783: Fix wrong mask value
 used in mc13xxx_reg_rmw() calls
Date: Fri, 1 May 2015 17:36:52 +0100
Message-ID: <20150501163652.GG22845@sirena.org.uk>
References: <1430117495.28082.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7204338588300079754=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 123B92605F5
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 18:37:08 +0200 (CEST)
In-Reply-To: <1430117495.28082.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, SaschaHauer <s.hauer@pengutronix.de>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============7204338588300079754==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mj1f7rlQIuao6W6r"
Content-Disposition: inline


--mj1f7rlQIuao6W6r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2015 at 02:51:35PM +0800, Axel Lin wrote:
> mc13xxx_reg_rmw() won't change any bit if passing 0 to the mask field.
> Pass AUDIO_SSI_SEL instead of 0 for the mask field to set AUDIO_SSI_SEL
> bit.

Applied, thanks.

--mj1f7rlQIuao6W6r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ6ujAAoJECTWi3JdVIfQrgcH+wZdfv/2S/QIk1fRwELnnKMM
0YmH6U0EvrArTJEpbuCXgEpCoBv/cXr3M3Qqui8n4SHRvih1dSJObRLNyBu+5ZXu
LsZy90Nlw2n4ix5K1gfq7yfQ8HTXubWze07NI6iz4V4vb6cWd1xJD+cgRd5MmFZF
tNYL0eVj3Z0ZLCiFZzSx/ioLn2mXhUWRLdnd5vlf/AyhqwrR6TSGUBCwPVYuA+7U
FZYWUZJJwjYMN9AlOrLlCGxzdhgaGGCbHr9hwcUBWWjH2ooZ850eqgvEk69YZimG
E3/ttPuHgG2woQXX2E75oJt8PyN6NeQ3qkVS2OfH6a4RXIAU7q2V3M+Qiv+r28c=
=lWZX
-----END PGP SIGNATURE-----

--mj1f7rlQIuao6W6r--

--===============7204338588300079754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7204338588300079754==--
