From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/5] Refresh ak4104 driver
Date: Fri, 17 Feb 2012 12:22:41 -0800
Message-ID: <20120217202240.GA2784@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4842179994431978766=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 164A510392D
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 21:22:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4842179994431978766==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series updates the ak4104 driver to more modern idioms,
mainly converting to regmap.  I've absolutely no ability to test this so
there's a reasonable chance this will just explode but hopefully it
should work fine.  Since all the read modify write, I/O and cache code
was open coded in the driver we end up factoring out a reasonable
amount.

Mark Brown (5):
      ASoC: ak4104: Remove uninformative print on probe()
      ASoC: ak4104: Convert to module_spi_driver()
      ASoC: ak4104: Use snd_soc_update_bits() for read/modify/write
      ASoC: ak4104: Use snd_soc_write() rather than internal write function
      ASoC: ak4104: Convert to direct regmap API usage

 sound/soc/codecs/ak4104.c |  174 ++++++++++++++++-----------------------------
 1 files changed, 62 insertions(+), 112 deletions(-)

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPPrcJAAoJEBus8iNuMP3dNiYP/RZMdIhTJf89Lk7nbfK+IT3O
NGRaYQPja1S4mqkxiZRbnpBQgwf8eFSdMpJsKoDo4gNUSBuaLz6KtunLLB8SBgvZ
MEg6isvyPFAMkd+MGwZWkCbpCFS70HyqoV0veQEWjys6Gn7hPeVwfnJRRjXG0c4q
lavojc3Yg8qxO+HP3fEZqRz7tkYnIxiXSQkgm+z3d3XIPk7FOugWc0dvwEOBPm7w
KbZgXEoLVY4+Zp4Ja3of75sd8awvX8qOdOTRr5uqoGeuojQ9C3oqapWB7rWq3gSd
G7M6+8uFcx1s+MMmm4woXEk4Jx8kxw888OFq+rHyn093U8LN87H43lJihF5GyMVS
22eQmeTnOAw8oWGnlBHY6EzBObgbjigQm/rkkxO6dIRMnTo506wpKdvOpAdAzhTU
7A2C8jpCzkY0iPKInGcJ44/y4a+kQ3UHe2bh+Yib3dUaQQ41aFvubesCXPCQaeFt
ao0ZBg6Nt8DZIIJtYyn+vQpebXkz+MA2Y7wmZWXkXfnOW23r65jyN68n+XoL3dVj
48Dcc7qV18PmNlO3Fd6lSAM0ehsuWiEYJ2OcP4tZVeTYw2ntH5AzHdQpHjbabfRs
MEg1jLHX7o7RRdb/DS9hVSSZdzxukNBZdw5Qqk+JyTMJdBVbZEubREZEXqWtwokV
ePpEm4GFiCVztEhVgfmA
=nNnZ
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

--===============4842179994431978766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4842179994431978766==--
