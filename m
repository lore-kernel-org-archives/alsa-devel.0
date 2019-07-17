From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_sai: mark regmap as fast_io
Date: Wed, 17 Jul 2019 12:06:32 +0100
Message-ID: <20190717110632.GA4459@sirena.org.uk>
References: <20190717105156.15721-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3539286412787647368=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B98FF800C4
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 13:06:35 +0200 (CEST)
In-Reply-To: <20190717105156.15721-1-l.stach@pengutronix.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Nicolin Chen <nicoleotsuka@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3539286412787647368==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2019 at 12:51:56PM +0200, Lucas Stach wrote:

> The regmap is only ever used to access MMIO registers, so it's fair
> to say that register access is fast.

Are you sure there's no caches that try to do allocations at
runtime?  The main thing fast_io does is change the locking to
spinlocks which means we shouldn't do any allocations under lock,
such as when updating the cache.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0vATUACgkQJNaLcl1U
h9CjZQf/dhUk5WYJfbbSdolGhGTGVxREvD34c+NDDsfaoHSLdEeVn5CEn/ordLf1
UUzmNXlCMqaMHJ5doeS1fF4jRixq/MHP4w4bEQYN9360Ij+eIbtlIQewBYCPuIyG
z5rEEf5YolcEboiJrIgC6rfGPMH7KSZciwwnKMHUrdTtP+dKbCLckdDwTHW8MOCT
wnSfTaZ2+C638kqjpLOBhicpVZ+GzZPdo4/kQlUMlGQdAPUuM9iKovrnoROB5A78
Gbre/hsBtEEU0X7Aa11G+BRvaBL5Wt7La6ZQMnfJV4yDWfk7TDh28wX6wlQ9ZIs6
BccrfqKRbozC6zJSit7TPRztnWDb5w==
=SCRH
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

--===============3539286412787647368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3539286412787647368==--
