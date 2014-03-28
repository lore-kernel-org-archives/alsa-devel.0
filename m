From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/4] ASoC: davinci-mcasp: Correct
	start/stop sequences
Date: Fri, 28 Mar 2014 11:09:13 +0000
Message-ID: <20140328110913.GW30768@sirena.org.uk>
References: <1395998717-27067-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2522210967921256314=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D3D36261987
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 12:09:24 +0100 (CET)
In-Reply-To: <1395998717-27067-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2522210967921256314==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hSsVBZHIO2Q9XETc"
Content-Disposition: inline


--hSsVBZHIO2Q9XETc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 11:25:13AM +0200, Peter Ujfalusi wrote:

> The startup sequence for TX and RX was not correct, not following the
> programming sequence from the TRM.
> This could cause initial channel swap when starting TX.
> When stopping the stream the AFIFO should be stopped as the last step to avoid
> unpredictable behavior.

> The change has been tested on AM335x and AM437x but it should be valid for all
> devices.

Applied all, thanks.

--hSsVBZHIO2Q9XETc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNVhWAAoJELSic+t+oim9tWgQAIMA0uS1NBbEV+KC68Ke0N3G
jmx9I/peOe3w19wVKJsOHX2L6keYwg9kASXjUHWRoC3g70QJ+K0andWLkDN/W7qU
RCrMSSiT1hpTwsnf7nqK5vZR0OKZfwsGYzwUnREFOZqL0gbMTyKljIfbWh6jooHU
YXD1JN5a3HUueOrG/GeD4xuI49srx1oB1oeGF89/ZCP4VhruSFoTeZoKU25j8j9X
gZfa39YfNdfTCFNgT85oWtlfifIb6QaxuYDgxS1jHbTgJEea3YEYCSkKjY/F1x1B
ADcsaw64Imere2+H0CZF2KN9Db6YRpD8gRZX1TCVQ8eUKX77maw9qRzySLotTRNI
+wm1l5ZxdTE3dY993FfrTWkvQ0veOwLcGCp7tca20HWxWq7eVUsfL6+iQ7pUYVnZ
HHajZiosV4BCJw+jWp1sBofj4tG+/8PtW9HxbZzddwnpyc2ygPguhf28te64KaKX
uIJVZmDU7MuvGyCoMbO7hEQ8AwnmxZs2nnYwo5ZgSIt2z0HgW17YcdWnKzN+v5xs
D6XDTLamquxyVzDH9aP4vt/9hv3N07RbjD3ZU3xb/cJfbSSECsElc/Ox8FPUkIxb
XLCD11hBLkRQVQLzGTXAcJoNOp3kK2LPaNr5sBsFzFOUHxPMe7QOKhIw6dPIkm09
MDekWvvGOgLKfejhbn0Z
=I60S
-----END PGP SIGNATURE-----

--hSsVBZHIO2Q9XETc--

--===============2522210967921256314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2522210967921256314==--
