From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pxa: don't select SSP for
	COMPILE_TESTing
Date: Mon, 7 Aug 2017 12:20:30 +0100
Message-ID: <20170807112030.zvz3flujilsixdj4@sirena.org.uk>
References: <20170807104101.3540159-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6282161380731121261=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21B222669F6
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 13:21:20 +0200 (CEST)
In-Reply-To: <20170807104101.3540159-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============6282161380731121261==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iisnfwzg6ivy2fwq"
Content-Disposition: inline


--iisnfwzg6ivy2fwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2017 at 12:40:44PM +0200, Arnd Bergmann wrote:
> When the audio driver selects CONFIG_PXA_SSP to be a loadable
> module on a platform other than PXA, and the PXA SPI driver
> is built-in, we get a link error in the SPI driver:

Why doesn't this cause problems on PXA?

--iisnfwzg6ivy2fwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmITP0ACgkQJNaLcl1U
h9B1+gf/eQe5C+iktagYkeh094lJ3cOLvwVMV15cNuYvjYOx82wbGlx83yKlli8t
JWqRG8CtZq5cEHAvjbMVkmaN9bTGYMUMhyte9UKi+0FtEL7N4bof4guVh+Vw2BEX
c++0t4jW6UGtUn3JKbrxbz+bqzwTsN64SknNPJyRIBAK2e+Nu07tIoDOHe4kU0UY
rRXKv9ARXgcIczMprs3UOHuJOx4kHodYNFVdS+53YtleZSpowKZqOAmqFaf17S3F
+oEDnB49DE7xWc82igVae/mqXgv4W5PifAUJFONQIVRcXjWc7EYFDlwwVIxt5BZN
P6udf9CUGo/JyZrNuGw2/5WL9muVaw==
=lJ2O
-----END PGP SIGNATURE-----

--iisnfwzg6ivy2fwq--

--===============6282161380731121261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6282161380731121261==--
