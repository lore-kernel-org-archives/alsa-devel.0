From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v3.18
Date: Mon, 27 Oct 2014 11:28:59 +0000
Message-ID: <20141027112859.GU18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6129340294165815149=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 589762608BC
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 12:29:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6129340294165815149==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fryGc0vzirnrYIcd"
Content-Disposition: inline


--fryGc0vzirnrYIcd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:

  Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.18-rc2

for you to fetch changes up to c0d018bd5b1aabad59dffdec568e189359d93a14:

  Merge remote-tracking branches 'asoc/fix/adau1761', 'asoc/fix/fsl', 'asoc=
/fix/intel', 'asoc/fix/s6000' and 'asoc/fix/sgtl5000' into asoc-linus (2014=
-10-27 11:17:41 +0000)

----------------------------------------------------------------
ASoC: Fixes for v3.18

A few small driver fixes for v3.18 plus the removal of the s6000 support
since the relevant chip is no longer supported in mainline.

----------------------------------------------------------------
Daniel Gl=F6ckner (1):
      ASoC: s6000: remove driver

Daniel Mack (1):
      ASoC: fsl: use strncpy() to prevent copying of over-long names

Fabio Estevam (1):
      ASoC: sgtl500: Document the required supplies

Lars-Peter Clausen (1):
      ASoC: adau1761: Fix input PGA volume

Liam Girdwood (1):
      ASoC: Intel: HSW/BDW only support S16 and S24 formats.

Mark Brown (1):
      Merge remote-tracking branches 'asoc/fix/adau1761', 'asoc/fix/fsl', '=
asoc/fix/intel', 'asoc/fix/s6000' and 'asoc/fix/sgtl5000' into asoc-linus

 .../devicetree/bindings/sound/sgtl5000.txt         |  10 +
 sound/soc/Kconfig                                  |   1 -
 sound/soc/Makefile                                 |   1 -
 sound/soc/codecs/adau1761.c                        |   4 +
 sound/soc/fsl/fsl_asrc.c                           |   2 +-
 sound/soc/fsl/fsl_esai.c                           |   2 +-
 sound/soc/intel/sst-haswell-pcm.c                  |   4 +-
 sound/soc/s6000/Kconfig                            |  26 -
 sound/soc/s6000/Makefile                           |  11 -
 sound/soc/s6000/s6000-i2s.c                        | 617 -----------------=
----
 sound/soc/s6000/s6000-i2s.h                        |  23 -
 sound/soc/s6000/s6000-pcm.c                        | 521 -----------------
 sound/soc/s6000/s6000-pcm.h                        |  33 --
 sound/soc/s6000/s6105-ipcam.c                      | 221 --------
 14 files changed, 17 insertions(+), 1459 deletions(-)
 delete mode 100644 sound/soc/s6000/Kconfig
 delete mode 100644 sound/soc/s6000/Makefile
 delete mode 100644 sound/soc/s6000/s6000-i2s.c
 delete mode 100644 sound/soc/s6000/s6000-i2s.h
 delete mode 100644 sound/soc/s6000/s6000-pcm.c
 delete mode 100644 sound/soc/s6000/s6000-pcm.h
 delete mode 100644 sound/soc/s6000/s6105-ipcam.c

--fryGc0vzirnrYIcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUTix7AAoJECTWi3JdVIfQfZ8H/iD7i+n5vA/l21skxw4RH4yx
O57AoT1kQQyoo0Ey0JcvjgGYb6X4+pwzBeRXnSgI+P5N74S2vOPswE/c3pDCABGc
YkGqVSpW8UR1HO648YjNw7kqaPYUtuaLj8FP3Nj4tnYY2U13x1UbaVwgaZuoh7ql
8z09LpckV7ubigsRndHho0IoyJp7biKhCH+ypK+u8u1xAdCmupy0Q0frtvvM2Mus
ugnaqHcS55aV09lVvh3Kr5NY160AJT4/13iOHNDgAH3vMEShxhH5gBu4pCDa8TtN
Cb6tGArWnS6CZk6cokXZXvu+RB7CT7e6BfPxB28bTIvLtZowtxmoCIfQm2W1jRA=
=2C6y
-----END PGP SIGNATURE-----

--fryGc0vzirnrYIcd--

--===============6129340294165815149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6129340294165815149==--
