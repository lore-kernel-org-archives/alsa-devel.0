From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: core: Add card mutex locking
	subclasses
Date: Wed, 7 Mar 2012 19:44:12 +0000
Message-ID: <20120307194411.GG3107@opensource.wolfsonmicro.com>
References: <1331116707-10016-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0978290396666173958=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A82310411F
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 20:44:14 +0100 (CET)
In-Reply-To: <1331116707-10016-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0978290396666173958==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6ZcLte273om6Oiqd"
Content-Disposition: inline


--6ZcLte273om6Oiqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 10:38:25AM +0000, Liam Girdwood wrote:
> This is the first part of a change that is intended to improve
> ASoC locking protection for DAPM and PCM operations.

Applied, thanks.

--6ZcLte273om6Oiqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV7p/AAoJEBus8iNuMP3dKyMP/3OnQF2rjYRTftVvnztj4vfA
p1nsQm9NXE+5emDJMXMLh461UPc3TEY/MqyhKboJMgxjbvCDrPvtgI2b3g1795sM
kUmxBdFswOMETmyY0lEV2oSbR3/vbBnzhN+RfCuAijhYbm4Ss1vR8OlSFN66751k
uYcenYJW+RYXDS531ETWKr51AhanErSlxZOuEsQZligluNdzIqRWaTi0gpAfYHO7
cHWvMhNUHKEPy+8ezzn1CK+rF4HBILayo9JXHa5a8Okr99aExMb8O8D1ENbMDXM9
+6TubH3n+m4zDLwgpRb+8thJLbinfSsCfu+B53GqpIb/mDRP43/hZ77XdlkkRpBD
oOnT7BEIOybhKK2N5cM4MQt6XpxCZ65/eIVDLaimAcn4KxU4rXkQ9mro2MSxXNF8
xuVoNFNZPaFcSqNhVdka3tY8ddBhXWete4OcEwOgDzY24r0eDn6YYnI2tshiO0dL
7XAs5+kXusG+S5zfl636xct7lPcipH/4tEEkmEOGN9GYQzw6BpLSZxRY1bSOjEhz
nOY96Act36dfMXK7FdK/s4AHLSWg1bxTMRYQcjCaVp6/glbe7LrIi8RnWL5R7sWJ
LO1Dw4o5miQp5qmB0Gb260cFb4SbnrJeU7sunZciN3ZtCH3ooQcsDhPkx80uvH29
zOzAcmEVMBp4GNbvAHc/
=dJ9x
-----END PGP SIGNATURE-----

--6ZcLte273om6Oiqd--

--===============0978290396666173958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0978290396666173958==--
