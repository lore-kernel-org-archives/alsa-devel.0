From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: blackfin: add bf6xx audio dma driver
Date: Wed, 24 Sep 2014 09:26:22 +0100
Message-ID: <20140924082622.GW4015@sirena.org.uk>
References: <1411552520-26090-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2522516197931367453=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B2B542608C9
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 10:26:32 +0200 (CEST)
In-Reply-To: <1411552520-26090-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2522516197931367453==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+tDoj9+U2XbkXuwv"
Content-Disposition: inline


--+tDoj9+U2XbkXuwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2014 at 05:55:20PM +0800, Scott Jiang wrote:
> Bf5xx and bf6xx reused bf5xx-i2s-pcm.c before. Recently tdm driver
> has been merged into bf5xx-i2s-pcm.c and it's not compatible with
> bf6xx audio. So create this dma driver and add tdm support later.

Can you go into a bit more detail on the differences - clearly there's
some similarlities since the drivers got merged, can we really not share
any code?

--+tDoj9+U2XbkXuwv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoAtAAoJECTWi3JdVIfQWb4H/2D3wP4+V6qeeqxnaMpfOn+t
R+C3zAyo8yS5lsydu+xXm3cqmDyG54feOw76jLBvR5OkmYeB6WYYYbJmyGu2sFLn
Njo2+FuI9PoVlinUTrOqIdJ6jcjDMYelWBylUDTo6O/63wKbuXgLOb9gghe7NGKv
CxJSZePbnAH/REMe2UcvrsRwlntKeUPJK4P04SUq4xn/l6GzZYGT1qlJCVR26prl
7LMy/Y9aq2DumTgvKRgUJ4IU/vJJq/5CFJxDBhcu6ugok9wFYs5jKxsM71xrRFLY
v02nDPSWuHH+HUVfUf8PU4gXW5nyEhF3eeRImJj9jSd/SAGu4n14HXW0P8cIBzo=
=he1h
-----END PGP SIGNATURE-----

--+tDoj9+U2XbkXuwv--

--===============2522516197931367453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2522516197931367453==--
