From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: cs42xx8: Mark chip ID as
 volatile and remove cache bypass
Date: Mon, 24 Oct 2016 16:33:42 +0100
Message-ID: <20161024153342.GA17252@sirena.org.uk>
References: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4533299102343989140=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4191E266C86
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 17:33:53 +0200 (CEST)
In-Reply-To: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============4533299102343989140==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 24, 2016 at 10:55:44AM +0100, Charles Keepax wrote:
> Rather than manually enabling cache bypass when reading the ID registers
> simply mark them as volatile. The old code worked this is simply the
> more standard way to implement this. There is a comment included in the

Even better just remove the register default, with rbtree regmap will do
the read and then cache it - no need to mark as volatile.

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYDinVAAoJECTWi3JdVIfQwxgH+wXJDBXY/hsChku5YsonVNle
PAy68yPesR+EF7I2kkjl84nARi4HLEUVg3T9SAL59rFuW89vz4tH6ju08Zr3tmH4
Bth4zFHV0EJzJq+5EgbR9UGxrQuq5q3x0Qyj75seXpIy0NvpmsunzWRsQDcSTHO+
lMragRouVb5pAUR6LGmLfrjmVpYGSzVp2X8G1D5wOXH2TDKZXsxGuna3pWdb/nwO
RfCDhZ+meClyunigJiMb6lm1Y/7CdxEaiaFZ6xTtIaNk69SXd3QIFGvUtQuC7TJn
2sZX0iHROLeEUHHKS4LanN0JsUgvk2qgLHmW2ga3mnRipmxQ1Ti6apeI+9Zl3IQ=
=hiu7
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============4533299102343989140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4533299102343989140==--
