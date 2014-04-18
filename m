From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l51: Fix mask for REVID
Date: Fri, 18 Apr 2014 15:59:19 +0100
Message-ID: <20140418145919.GU12304@sirena.org.uk>
References: <1397723743.601.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0052850084233332480=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 16EE22608CF
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 16:59:44 +0200 (CEST)
In-Reply-To: <1397723743.601.0.camel@phoenix>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0052850084233332480==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G2KkZ9Pjck/7DGR/"
Content-Disposition: inline


--G2KkZ9Pjck/7DGR/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 17, 2014 at 04:35:43PM +0800, Axel Lin wrote:
> The REVID mask was changed by commit a1253ef6d3fa
> "ASoC: cs42l51: split i2c from codec driver". Fix it.

Applied, thanks.

--G2KkZ9Pjck/7DGR/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUT3EAAoJELSic+t+oim9CZUQAJQQByMxeGJAbpZfr15IrltX
KQMVnmwsLP8BaakuT8/giUZs+8fCD9vPzTLMB70cNYK8TU3XYg4DBGodw4Qnu90l
0ZY5NJjUS4vupSsf50H2NrIdrnVlgu5KJOQb4VQJvYGbOruqhE3mBHvpKK0P0HWD
NpoU0AFtQ1niUtzFdsfQMpe3+DdSa0jl5ujFsVchClvqjHkGjXt9ZvwsMoZBHgIH
8kx+yg/OHFItWAnlFCp3rw7fa4WJouCCxuEgg6bGVBLqYRxzP072D+hr1BtGjS1U
jelPXG7+nWy1Uz1wlM5HP3Aflm/u+/jPW55dhV55PpcKCcRPmHJWc5OMYa1N6ecx
XJIzMeMu8bzQgBp5y5IcHTAUl274g165E6T5d/OACluCHxwZPvgVx4RsE4A8FRb2
pRBB8aRnTDrcUp3g5KUfdR7uQGlvQPDi8qWUwkDKFGeVTK7touJRZva+M0HGgqd2
Q0BY5JeE5ZBv2QeCpzMDNv9cnV0VVz+R5UQhEASr5vq0SAQwY0zUt8qsKRWxFBEe
r6X6E2tYrcaG7162oDkKX41xc459VtKb8QsrY84TTaqj9RoOOw4Ysju4XTBbhTNF
W0Xcv5vs5VUXIvcmHBJ8bRSlb5Vh2pUc1/L/cmOzhoJEdSKViKPcResB7/Ao41+a
yEc3GQgfewZLxDFdieRy
=2d3m
-----END PGP SIGNATURE-----

--G2KkZ9Pjck/7DGR/--

--===============0052850084233332480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0052850084233332480==--
