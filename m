From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/16] ASoC: fsl-ssi: Driver cleanup
Date: Fri, 4 Apr 2014 11:03:51 +0100
Message-ID: <20140404100351.GM14763@sirena.org.uk>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <20140403221406.GI14763@sirena.org.uk>
 <20140404064932.GC20621@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3084601436600196575=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 514762657A3
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 12:04:13 +0200 (CEST)
In-Reply-To: <20140404064932.GC20621@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3084601436600196575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xiGzRFbP+7h+smMw"
Content-Disposition: inline


--xiGzRFbP+7h+smMw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2014 at 08:49:32AM +0200, Markus Pargmann wrote:

> Thanks for applying this series, but could you please drop it for the
> moment? We found some issues with the baud clock setup for i2s master
> mode and have some fixed patches for the series. So it would be nice to
> get this in without fixups if that's still possible? I could send a v3
> next week.

I've dropped everything after "fsl-ssi: Move debugging to a separate
file" since that didn't compile anyway (though I'll add the binding
document update as a fix).  In future please don't wait until after your
patches have been applied before saying things like this, it's not good
to rebase branches normally.

--xiGzRFbP+7h+smMw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPoOEAAoJELSic+t+oim9eBEQAI+U/fAb4cswofUD8ZCrO/K6
Nq2KSC2zAcbIcZYp9MhVB36TWMXT2zpGNqblBVt8yvzUwnUKDde0a306IfZRT3Gd
n2vSYhXdSrgHOfL4YsHfzdtUkqSVtuXQraPGN9IZDRsydQlZzf72++UL75jacHKZ
UYSiP4Js/Ihh3GvWn7f3osucU0QF6etdO6Q+5a2zDcA8AJPln53gxV0vvVJuv40y
8IAiUu+tViziTjWxIQlJ3qlPnhiRgURQZERBYx+3mYcHVd2N0HZC7NWFLIhn0d3e
YI2EuT76JqB+iHLSCEgbIsJiBQECD/dmoPSxPy5lZL2W9FqY+JVHEjdkc50sKVi0
z0NDvZ10yFQVJ/xk6szbg8IIHheR3YQLZuHfBAWgn1/Mw9ZDNvnqM4lH7Ut6uMQR
57dFkuhq258YjwAUkofEu6qZ+txP9FpeYLWZd9rbIGJ6b5CQZhH0aP092dVYttSb
nLGCNDcEROugWKHmJgzc0ybACuHEJK+00vML0z/mH+unMf634ldUZxKLqvOeKcaZ
3hymbKbbZAYyeEup2OI0KvyGwVSWUFQmJc+4UzkJ2GTxZnczyCmzDoaL/kI5MNNw
DTqfbKN4wi5YkQdsPo9U/6SURM54DfuCplwUjDT7Wgcj1cakfzP0dBuDeo3a4Pw4
DVjeqVUGfrX9jiGyMD2F
=CwO6
-----END PGP SIGNATURE-----

--xiGzRFbP+7h+smMw--

--===============3084601436600196575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3084601436600196575==--
