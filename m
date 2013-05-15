From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/11] ASoC: kirkwood-dma: Staticize non
	exported struct
Date: Wed, 15 May 2013 08:47:50 +0400
Message-ID: <20130515044750.GC24524@sirena.org.uk>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
 <1368562797-10440-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7942150362507819234=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 63A10265162
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 06:47:55 +0200 (CEST)
In-Reply-To: <1368562797-10440-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org


--===============7942150362507819234==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 10:19:48PM +0200, Lars-Peter Clausen wrote:
> The kirkwood_dma_ops struct is not used outside of kirkwood-dma.c, so make it
> static.

Applied, thanks.

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxNzAAoJELSic+t+oim9bC0QAJYrdNTKn8MSwmPESP/BChHq
2b/TbXbLokkT6h/9Q+uFRtrMYdaGHOvPi51oyYF/YLkT2i6Dar/lBBuo2rMBREtb
ojhaHFSOW0MonRL7PLAxbWRzTczcEHXVseDAjVE4ESz3Yb+2RGxIyWwmAPog7Fxu
3cNlKFBvhYxIoHuWSBKOLafOGaALOW5CgKq2n0Agy4QAI7KlTYGi6sFyDzXpE6rA
YHfxWbpOUvfqVjkxjheZqBiVG2ZaYYpmKxASm9V+xNwYaEn0YhRAsYct6OOJMdOw
LnjHg9g/x+VLeNRL6oijMt1sy9R96QtR+hKmoMx9QrOrZL1zTCL9Ib3XyuJGVTXD
MZy7GmrmEYsF5RrPWixvlNyEO8AN2VBlf8BBtE9t/owreC7H29rs4xNa1mDqQOx1
q0iULUIBsnGy6gZqaSDGlGgIoQF5TtR1JZnY2hpxM7zi7N1MlKEfNEqmj1PAluuM
Lr0rxuLOUQ/j4V4OHb2Cr1v0ep7jbp70T9gf+SuoXW36EhEXLBmPup6PBwhOPFW2
iCdUyp7TE8YuvGZFBZv8S0GUL2cuHTQwBwl7jQMCvvMoyz7NnxP3cTBZ+vHpwbtH
UfkiJnVFCCWXjUg+/IPaCBP0nc2T4x+4GqqA3KKK1jD/M8wg9bnSdWOvFzmjwzkr
A3+4gtaYqcSvNTCPR9pf
=KANJ
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--

--===============7942150362507819234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7942150362507819234==--
