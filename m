From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: rcar: Fix dma direction type
Date: Sat, 21 Jun 2014 21:00:52 +0100
Message-ID: <20140621200052.GM5099@sirena.org.uk>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
 <1403163631-26215-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7985630051557774528=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA1E326262A
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:01:05 +0200 (CEST)
In-Reply-To: <1403163631-26215-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============7985630051557774528==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1cCDjWmMO1HuOC1Z"
Content-Disposition: inline


--1cCDjWmMO1HuOC1Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 19, 2014 at 09:40:30AM +0200, Lars-Peter Clausen wrote:
> dmaengine_prep_slave_single() expects a enum dma_transfer_direction and not a
> enum dma_data_direction. Since the integer representations of both DMA_TO_DEVICE
> and DMA_MEM_TO_DEV aswell as DMA_FROM_DEVICE and DMA_DEV_TO_MEM have the same
> value the code worked fine even though it was using the wrong type.

Applied, thanks.

--1cCDjWmMO1HuOC1Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpeRwAAoJELSic+t+oim9gJEP/RS7Qsyl0zNj5w1hZ5rYLqpZ
OLtvm36wBzjbl0fI/L22nh0Fkh919MbeBmaK3DyGRy2cze4FtNVLIKJzE8EJb1lS
d/55TJS68FRIe/ZOsr7O93jMAHUQdAr7Jf9hBooKSUvEMbQZmIyga+H8W2yIkOT0
LyHX7PGa8nWtrJUzQznyQsPFmO5avTu43O0xjQuWn9jvPZ23xfKVTGZzSefpEfdV
/PHBl/cYdFN01P/C8nBeoRysPN2zKHU4eFxMhtXhGA8bG9d2h29fq/uBbHi9WVFB
wSukYYTaV3e1vxG83Qgy/6/EoKQVPTgmNUWn1/R1eGrm2NEY1uplFhJi+nDe8fv8
xUNfNYFOVH9OTeJAU3ZMfhv5w/RVIh6t1OzpuHxDcTMqP5sO6MPqVBa/INCGFq8M
4YCIH0BzVy213TGJxdxSuXQAfoDueV0aFOoev701+X54uCbu49uiG6cpPUHeyCe5
Q32FxO8Qd3QDNAJfxnrpLiQJQJb1Zy4dxJ2Vaka8CJeW3NrMGFcX5wf9/DCj/V6Y
19oARIX1v+ZwEMO9xjDSkhxLJJ4Ghxpg79WXYzalsz2aLzhZqdMRUeGqUJfcliom
xvrjbd2+v7oArjyPBBuQfq/RJnyLGupAaaeeo40u116Gh4T1lAMyJmcQH6S0nalh
GSgmA33F/hLKQnnycDn5
=lyBG
-----END PGP SIGNATURE-----

--1cCDjWmMO1HuOC1Z--

--===============7985630051557774528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7985630051557774528==--
