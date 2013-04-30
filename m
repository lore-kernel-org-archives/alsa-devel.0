From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: ux500: register controls to card
 instead of codec
Date: Tue, 30 Apr 2013 19:33:01 +0100
Message-ID: <20130430183301.GE26160@sirena.org.uk>
References: <1367330994-7259-1-git-send-email-fabio.baltieri@linaro.org>
 <1367330994-7259-4-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7232624116348049767=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 302E72650A4
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2013 20:33:04 +0200 (CEST)
In-Reply-To: <1367330994-7259-4-git-send-email-fabio.baltieri@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7232624116348049767==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2013 at 04:09:54PM +0200, Fabio Baltieri wrote:
> Update mop500_ab8500_machine_init to register mop500_ab8500_ctrls as
> card control instead of codec control, as it only contains
> SOC_DAPM_PIN_SWITCH definitions.

Applied, thanks.

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRgA5ZAAoJELSic+t+oim9488P/R2T8qEjyfk4yEaJnu2Gp49r
NrmxsLCitnkLxtgz38NHk0sqPSicb/N2rh68MoLZzCIOVubY28vUgLZMUuE8z9xY
DgXc3m0BwCwm5NsLFsfGKExwY4vplB6uw2cx/26sW3p7u2GQ1nzIrGNNccANeatA
IZVpQEUGf9XEo1r/YWID+lx+XQ/RVQDz562Z+IalXx+3+uQhV9bpcpIZ8mLlLgzo
fpeCeAEjUz+KdeMFsdXM7xrq+O8WNS5cY9/r4FamBGgUT/8loaQoZZqF6+x03RCi
tfOLCu9aJmOMb0NS0i/m+qTP6Uh3JB9+uzi0796CG4KFMI+c1oobO9UxpzCDGijP
VCsDNHuGxNvZo4zJl+BcF90WLIXDzwpEENX7daKkLQdxt6N4T9P5/hz1adi+f5jZ
JQHYmZGrIX181N8DOfoMIY2bMU7ayx1IXu2Qq1wnQXjjmm9di8k00nmI4CNU6V8C
QTEL0HnHaBZ248RNAtjdXRHCV2mgS571EMMg6sSnhehesu6Zxor1dVVxTR5tgtU4
DZfCEWlr52j4RNQA3Qz3U/7JDkIJX8x5UDdohjJS3FBvkzIXByZckszHOBA7Ggsz
9y+CEuk3Q0C4xngg6PGZWirF023Ku+37UMoPRSur/BPGqWvPkq28MSy3rYeBkvtP
4uLEqFOU/dYTifz0t8am
=bE8J
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--

--===============7232624116348049767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7232624116348049767==--
