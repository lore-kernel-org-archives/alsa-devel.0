From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl_spdif: Fix incorrect usage
	of regmap_read()
Date: Mon, 12 May 2014 23:11:29 +0100
Message-ID: <20140512221129.GC12304@sirena.org.uk>
References: <1399365699-21084-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7852933168540130601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A47A026524C
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 00:11:44 +0200 (CEST)
In-Reply-To: <1399365699-21084-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7852933168540130601==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWnt3BFTPGlcXUeu"
Content-Disposition: inline


--SWnt3BFTPGlcXUeu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 04:41:39PM +0800, Nicolin Chen wrote:
> We should not copy the return value into this val since it's supposed to
> get the value of the register not the success result of regmap_read().
> Thus fix it.

Applied, thanks.

--SWnt3BFTPGlcXUeu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcUcOAAoJELSic+t+oim97cYQAI27iVJPR1eC03sVfsH+0Uav
kjM3OTagy4g7kOkZ5fABMzTJhuKFWknw8Isj5KOFNpPN55IBgs9XAhmMps3XRFIn
5DFemGmED61mPo+MuJe4gn6zQVRUhbtZWUb4T0lhdxDw/PCTtUvEPoFaRO2XzoJo
e9q5JccjvTIpUhxcMHJ38QBJO5+oow9KE766r0uhqowhfOxg+KaURbL4Mifp4nmF
PbCfnoIla5oLGtJ6WjTojBxRwJ3jNbTxXTV1b/opl0j2FGwR6Z//RX+O1G67j3jP
yZU4/Lh2Eo111HL2mpDcmq4FCJkSlaJzOnBVHLZ4eZZSs7EtDaQzk6xYg81A1wi/
P2wv0dUvyJ1v6PYopRfY9ZaF2mEjluQvH+zV9+0BsHZPEofdEYc55rubqrHCwYdI
sQfsTq2e4KoAn6xAuESyiial9mT4o263DaZOcfVywTkRsUNnA54eBAFbNhs3Olzb
SaRJlk2yHf4khY3nq5E4K5e0IFd4/fsb3k1aCAXceaGG4vaa6DbA5Z7J6Tw3m6Kq
EFNGOdUWGwQRkj7PMd+XsvgrYEH6/WUM/WejF8RNAuXX1HO3iqQP/6RY5AioAbev
11Y5ddsoUK87EEFjo5cRBBzNrort0mPap7n3p6Km7+7D9oVGjmoWUlzMc9hCVku9
BwKQecXadjfvBEa29+Mn
=3uOZ
-----END PGP SIGNATURE-----

--SWnt3BFTPGlcXUeu--

--===============7852933168540130601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7852933168540130601==--
