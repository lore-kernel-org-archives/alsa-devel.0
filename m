From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Rework SOC_DOUBLE_R_SX_TLV add
 SOC_SINGLE_SX_TLV
Date: Tue, 3 Apr 2012 11:43:51 +0100
Message-ID: <20120403104351.GB3192@opensource.wolfsonmicro.com>
References: <1333122235-30774-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5515277405522444619=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F364E104223
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 12:38:07 +0200 (CEST)
In-Reply-To: <1333122235-30774-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: apatard@mandriva.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============5515277405522444619==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 30, 2012 at 10:43:55AM -0500, Brian Austin wrote:
> Some codecs namely Cirrus Logic Codecs have a way of wrapping the dB scale around 0dB without 0dB being in the middle.

Applied, thanks.

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPetRIAAoJEBus8iNuMP3dEfsP/24cgPIlbL8Fx80BmGF0EZ2u
lz9ak+glN6pp+dGQjJXD6tlC56gARKCeVDRmabyvAW1rGFe3nVJsbhSTN8Qq96i9
A+JANi2aOmXZ5OnhQdzhYaHfSnoJFp+xukRSyy+WYi5/LNPJNpy8C9cUmRfc3gRq
xQQPr2dCzqDoVIfTFYadTj1izHihK7V7pCY+lTg3DTIaMZqhAA50Dzja72GAs+qN
Gi+qezo+Kcj4Ed7ZU5kdGPxt0579xQLPoDDmEmkNeXjBuNHwXSlP5xvlWs+yPmr0
WTbauK+8enkPfmegKCgfYJP7cAaaLEL93gxS3VYnWbLG+dFzhPyWMFqnXNjb+51o
BePLq4a/upnv18Q5HsSxevHinqIp/X2avEsr+N9u3CcV6A3jxrNdztTlngwHJXYo
GgVJn/g/p5RhOWrcUE0xYRv4SvYzAAMkxqdTyT9ORdGNk7btu4c7m/YMykN+Uwln
lBKx3NO/sZOBqduUYttx5zXfOGe67rPOFEeXeXtWYpXj78FHBoIla164a154VA/d
NmsTAIG9TNLanvK4hEaQXyCSi1p68QqrO0NjMNaeORKLZJEnAU08+yZIUw+u3PBb
QTCirFiZwuyXekXnGOcToPiH7ub/oO9dXMo3e6EeseHaLiROCe3IVfC6JIWj0+Rp
MKzniIuQDv0FsmxzVzng
=vAWV
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

--===============5515277405522444619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5515277405522444619==--
