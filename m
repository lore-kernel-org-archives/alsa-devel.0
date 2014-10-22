From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/12] ASoC: dapm: Remove path 'walked' flag
Date: Wed, 22 Oct 2014 12:10:49 +0100
Message-ID: <20141022111049.GU2344@sirena.org.uk>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
 <1413826604-3212-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5210488132297790055=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 231BA26512F
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 13:11:14 +0200 (CEST)
In-Reply-To: <1413826604-3212-8-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5210488132297790055==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9AazSAFPVKSPmRXK"
Content-Disposition: inline


--9AazSAFPVKSPmRXK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2014 at 07:36:39PM +0200, Lars-Peter Clausen wrote:
> The 'walked' flag was used to avoid walking paths that have already been
> walked. But since we started caching the number of inputs and outputs of a
> path we never actually get into a situation where we try to walk a path that
> has the 'walked' flag set.

Applied, thanks.

--9AazSAFPVKSPmRXK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR5C4AAoJECTWi3JdVIfQ7aIH/R5+wujQrqC72Hn2NYp0BE1q
3LqhsYtLAVpS2+Ut2v1mrCrCPe9tUHzx2RwjriB12A5O4xy1HPzBU5r5ud25E0le
yCC6zavkoryw9Lo/eT8oHqR7feVj3kuU+I+hT3VKj0Xml/RsuE8M3gDHUPslK+nr
pJQvAbljGsjzSix3RjDQ1cacJWHnglshpHwJJ9lrh4IFuR7C1DqfH0n2Vfmzjn3m
CyYQDka7izkqXvZr9US6U+YwS1xRicIo9RDzGQQEuP5WRL616sl/RMHhzJQVQZJo
AmOQwyvLN1nWSjfi4+BhLafKkM11wiYt51ZT19uAqKvV9clNzBmZYkO+RSkA9Ng=
=M6yQ
-----END PGP SIGNATURE-----

--9AazSAFPVKSPmRXK--

--===============5210488132297790055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5210488132297790055==--
