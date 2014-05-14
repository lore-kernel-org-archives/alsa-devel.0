From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for Intel for v3.15
Date: Wed, 14 May 2014 12:44:56 +0100
Message-ID: <20140514114456.GX12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8790978996193645695=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CD83261A89
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 13:45:13 +0200 (CEST)
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


--===============8790978996193645695==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E6sl32Vb4/lwuBRu"
Content-Disposition: inline


--E6sl32Vb4/lwuBRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 95e9ee92e20162681e9f65c25962e0606db9d149:

  ASoC: Intel: Fix audio crash due to negative address offset (2014-04-22 19:22:53 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-v3.15-rc5-intel

for you to fetch changes up to cffd6665f57ed18f4be9185c4330c8c98c22e201:

  ASoC: Intel: Fix Baytrail SST DSP firmware loading (2014-05-13 18:21:02 +0100)

----------------------------------------------------------------
ASoC: Intel fixes for v3.15

This is a relatively large batch of fixes for the newly added
Haswell/Baytrail drivers from Intel.  It's a bit larger than is good for
this point in the cycle but it's all for a newly added driver so not so
worrying as it might otherwise be.  Some of it's integration problems,
some of it's the sort of problem usually turned up in stress tests.

----------------------------------------------------------------
Jarkko Nikula (2):
      ASoC: Intel: Cancel hsw_notification_work before freeing the stream
      ASoC: Intel: Fix Baytrail SST DSP firmware loading

Liam Girdwood (8):
      ASoC: Intel: Fix block allocation so we only allocate blocks once.
      ASoC: Intel: Fix allocated block list usage when adding blocks.
      ASoC: Intel: Fix Haswell/Broadwell DSP page table creation.
      ASoC: Intel: Fix Audio DSP usage when IOMMU is enabled.
      ASoC: Intel: Fix allow hw_params to be called more than once.
      ASoC: Intel: Fix stream position pointer.
      ASoC: Intel: Fix check for pdata usage before dereference.
      ASoC: Intel: Fix block offset calculations.

Wenkai Du (1):
      ASoC: Intel: Fix audio crash due to race condition in stream deletion

 sound/soc/intel/sst-acpi.c         |   1 +
 sound/soc/intel/sst-baytrail-dsp.c |   2 +-
 sound/soc/intel/sst-baytrail-ipc.c |   8 +++
 sound/soc/intel/sst-dsp-priv.h     |   1 +
 sound/soc/intel/sst-dsp.c          |   1 +
 sound/soc/intel/sst-dsp.h          |   1 +
 sound/soc/intel/sst-firmware.c     |  25 +++------
 sound/soc/intel/sst-haswell-dsp.c  |   4 +-
 sound/soc/intel/sst-haswell-ipc.c  |  31 ++++++++++-
 sound/soc/intel/sst-haswell-ipc.h  |   4 +-
 sound/soc/intel/sst-haswell-pcm.c  | 107 ++++++++++++++++++++++++-------------
 11 files changed, 126 insertions(+), 59 deletions(-)

--E6sl32Vb4/lwuBRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTc1c1AAoJELSic+t+oim9IR4P/0qSpP4EeQYx2Z4vVulQKP39
zRTEGQx5V54rY3EYTZQK3ncGjKacT9BFNiJ97hw7vo4Sxg+moD9+luc9h0eFZkaR
b5x0iKdJnHNWgbshF5MeauwGIv7Va2IdzVARDQLeZYZXnrUHH2iH3hu0lyccZ9Pc
H5DC6t0ED+vSF/UUCZc2ISiiN3FpmTvMgkAEOos3KfJYGnt45vYXP96I0/zJ5vTW
U/sMXyT68y7OQBOarY1fj35joMtwM3R0H+wra3/2LPWYRIT3Pxw/J3j42IBbC8y9
hjDvydSCvl19cpNVZcDJjWzP/WoapRbjfh74vNhB+JsMjZBUjBNywqGk3n4LGwUb
zsmmUnt17nZfR2R49D4LxR3CsVEvZxP9+HyIidyC6iT+JBVxOzeZ5+46CluPQds5
LUKX/1/zau8Li+Oa8EqsH3fcF+13nJxwsvZRoXeNXy6sNPPqBGS/dLF6RdLCrYMF
RqJklxEiThjEQ0WCM1QKiI5cJLGz8Wa3FIj5ER8cGmc5v/oHpZSKjXGO10AeGDi2
hUCcogxiTA/necUXdxK1WHjPSudquqghAreCUx/uLNJBUjWk5nBiD2bZOHkZnUIF
7n7t7PQTXsVsxsMqaUSukWt4H8dEKn3f98Zl+KcWeWCdoUU2paotRY44BXUWDB1S
Xnh1XDCv10NTUIokJGmn
=81PF
-----END PGP SIGNATURE-----

--E6sl32Vb4/lwuBRu--

--===============8790978996193645695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8790978996193645695==--
