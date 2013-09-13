From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 3/8] ASoC: davinci-mcasp: Get DMA
 related properties from DT
Date: Fri, 13 Sep 2013 11:34:31 +0100
Message-ID: <20130913103431.GG29403@sirena.org.uk>
References: <cover.1378738436.git.jsarha@ti.com>
 <35b6dc24d8a803b97c683d4d2c51db7e3518f7ff.1378738436.git.jsarha@ti.com>
 <20130909152559.GM29403@sirena.org.uk>
 <d56ff517b8d6e29af7639665bb17c1bb@kapsi.fi>
 <20130912110800.GI29403@sirena.org.uk>
 <62c9342f91e99fa5d421a7ad29fbf354@kapsi.fi>
 <20130912115626.GO29403@sirena.org.uk>
 <49bf24974af0ff34d2be7db97e04f2a9@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7259691706908052802=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 22DF52608ED
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:34:34 +0200 (CEST)
In-Reply-To: <49bf24974af0ff34d2be7db97e04f2a9@kapsi.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <oku@iki.fi>
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, Joel Fernandes <joelf@ti.com>, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============7259691706908052802==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yeCL+mIsZLk3aPZ2"
Content-Disposition: inline


--yeCL+mIsZLk3aPZ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2013 at 03:10:12PM +0300, Jyri Sarha wrote:
> On 2013-09-12 14:56, Mark Brown wrote:

> >What exactly is the dma register location here - what hardware is being
> >controlled?

> They is the McASP-bus receive/transmit buffer data port addresses.
> So those
> are McASP entity specific properties that need to be passed to
> DMA-engine.

OK, and presumably this is just part of the main McASP register block
and doesn't need to go into DT?

--yeCL+mIsZLk3aPZ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMuo0AAoJELSic+t+oim92NsP/1698aNsco5uPXA+/9T0C5la
btbsbEl8J2xMsBgFbQ/svMhYHsphB9KbfMYgkbkGjpfRi6xWn08A4qWW+DSTcE0/
a+zQgimdCtc2SX9RvrPizKa3XTSLbqco+1FWx7a/TSHEatwD56OHOsbCVNkmS2Rj
uU1IzDINogmxCn5LguutpeBiD4qP4s8xLbXFB4xtZ9iXNHqJVYJlVhZcf0MqhR+v
q9o3kZKXPnTdx6N7ipe/vqVVfHNrzNdV+tMrvZhWQEESmq+9z1z0iAPcKVZ9q2g4
iQY7yr61b6Bbx/wZE9oCe7j24WhHbr9/r5UbNesQlOCps2D52eA+40nB988Li7V2
SMDgyAre7jFfOSz7isYFkn1Qooq1RS3P5NlsTNfo7MIYoeauiA36pj2RzXG/swlo
WrOwJRPlYfCU6j/wIcXPalKixfgJDAI8duZLKIOaLUKUGhKdz7vNFX5ays9Qt4pW
AE/dKlClxWpks5t+tX1XUjW7LY5c8hmHv7VJEk1q3RpcNcNbSOqtps5Ax7hOxD0I
dEcf2XAE8qFPefl+AJcEiiXsofYEmX9ZFo2fR3kG3o7WrY7D1s3eMbBAWZWuG4cZ
aFpl6FPExj/W0CIMovVrQJKFVmAoKa6RYb2ppwuh8/b66TW1hZ2Ppw6ZnSZAQvK7
rFe4uQ9TXJ3zrZZRzGlk
=gyzS
-----END PGP SIGNATURE-----

--yeCL+mIsZLk3aPZ2--

--===============7259691706908052802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7259691706908052802==--
