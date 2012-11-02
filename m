From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: mxs-pcm: Fix fifo size
Date: Fri, 2 Nov 2012 15:06:27 +0000
Message-ID: <20121102150627.GE4413@opensource.wolfsonmicro.com>
References: <1351703171-27855-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3326022913949662818=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28AEB2650A1
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 16:06:29 +0100 (CET)
In-Reply-To: <1351703171-27855-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dong.aisheng@linaro.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3326022913949662818==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iEgkO1EH36X1eT6a"
Content-Disposition: inline


--iEgkO1EH36X1eT6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2012 at 03:06:11PM -0200, Fabio Estevam wrote:

> According to MX28 Reference Manual the SAIF FIFO contains four 32-bit entries.

> -	.fifo_size		= 32,
> +	.fifo_size		= 4,

fifo_size should be specified in bytes so the original code looks
correct?

--iEgkO1EH36X1eT6a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk+FgAAoJELSic+t+oim9hvsP+wflnkO7W0YseQNhMBgfOlFc
FWHjJglZ1Djp905fB9AoXoGMPTXoesZHyZJsScZJ5R3pZFU20km8RuLDFSKYdJRM
lR/2IDLdpePC8x5+9TpB0B+FwyAwTRXM9tFvR9iRhE4l+6EeSp5uWqtmm6J13fqG
utB96o0qQ3yV7othYmo5Bs07DG4ojp8bIKnC0DkaXmF5qqubpeogMQUwtG5/yUAZ
ihnvyASBgOo1Otoj4pUIlo1aDeq9yxqVy7ieYE0FErZTNLD+IGN8mlL+QDbFZSLP
R63ngXbcRg2OoVfBuZSq8R6o4COYbuT9y2uUvWwMBloPs+lOKRWqDCjuxgi/5b8f
e0aJR7Ie8Bzfisx0Nlo5TlyRnSEzC76KsSE5E1MmJ3lWBDw4JGMIRKrYItFb6K6W
hjks6iECpJq1pHHn0s1f0vZmYL+QF2/8jvIHiVNCjqgUDmot+pc87a3kY3g6h6qG
rjgfzOlqs8iexrwNYmLBUfrRjR/sgBvU8SD/HJhBCZIxYdZsF4M9/ybTncL+hW72
gDjN8l3v0lWDQ6ZshH5WxDoj1seVuC7/n1f8pdozWyNWllApuJm57jMvctjVi/6D
aBwKBdgFkMjMQubBd2RAtrEZU3hgTaR/WbAHuHOEcMNhN027z2UhJr6nmhfFewWr
xiD7BR3l7VALuE7JOe7O
=nDZ9
-----END PGP SIGNATURE-----

--iEgkO1EH36X1eT6a--

--===============3326022913949662818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3326022913949662818==--
