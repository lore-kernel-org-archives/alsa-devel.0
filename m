From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.2
Date: Fri, 7 Aug 2015 12:49:58 +0100
Message-ID: <20150807114958.GP20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1081286608263684658=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 075BE26044D
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 13:50:16 +0200 (CEST)
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


--===============1081286608263684658==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tf/l6FweWSfB3ZNR"
Content-Disposition: inline


--Tf/l6FweWSfB3ZNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 74d33293e467df61de1b1d8b2fbe29e550dec33b:

  Linux 4.2-rc5 (2015-08-02 18:34:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.2-rc5

for you to fetch changes up to d00a9e02178401433fc386e69c936f2039f07b57:

  Merge remote-tracking branches 'asoc/fix/cs4265', 'asoc/fix/intel' and 'asoc/fix/topology' into asoc-linus (2015-08-06 12:39:07 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.2

There are a couple of small driver specific fixes here but the
overwhelming bulk of these changes are fixes to the topology ABI that
has been newly introduced in v4.2.  Once this makes it into a release we
will have to firm this up but for now getting enhancements in before
they've made it into a release is the most expedient thing.

----------------------------------------------------------------
Axel Lin (1):
      ASoC: cs4265: Fix setting dai format for Left/Right Justified

Bard Liao (1):
      ASoC: rt5645: Fix lost pin setting for DMIC1

Jie Yang (2):
      ASoC: Intel: haswell: fix initialize 'NULL device *' issue
      ASoC: Intel: sst_byt: fix initialize 'NULL device *' issue

Liam Girdwood (1):
      ASoC: topology: Add private data type and bump ABI version to 3

Mark Brown (3):
      Merge tag 'asoc-fix-v4.2-rc3' into asoc-fix-topology
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/cs4265', 'asoc/fix/intel' and 'asoc/fix/topology' into asoc-linus

Mengdong Lin (3):
      ASoC: topology: fix typo in soc_tplg_kcontrol_bind_io()
      ASoC: topology: Update TLV support so we can support more TLV types
      ASoC: topology: Add ops support to byte controls UAPI

Subhransu S. Prusty (1):
      ASoC: topology: Add subsequence in topology

Vinod Koul (1):
      ASoC: topology: add private data to manifest

 include/uapi/sound/asoc.h                   | 35 +++++++++++------
 sound/soc/codecs/cs4265.c                   | 10 ++---
 sound/soc/codecs/rt5645.c                   |  2 +
 sound/soc/codecs/rt5645.h                   |  4 ++
 sound/soc/intel/baytrail/sst-baytrail-ipc.c |  2 +
 sound/soc/intel/haswell/sst-haswell-ipc.c   |  2 +
 sound/soc/soc-topology.c                    | 61 ++++++++++++++++++++---------
 7 files changed, 82 insertions(+), 34 deletions(-)

--Tf/l6FweWSfB3ZNR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxJtlAAoJECTWi3JdVIfQpiIH/0CEdCA4LY0lsqJz+hOJGEK8
tSAYKvBRoy3qOvnOkTLYVCjMkRdeazF4v6jdVWy5BbbqW2+ncr0TX7CGuzmaQWwO
11EqQCsh4AN4NlizhLak5E3dDbC51c6z14MwTNhwewlgermnsxcCXMFsj2Xbs+QQ
VVHl6svblqpy+hlWgCTOFvs4Q+TBtnHwXAqjqjKidARb00QqoxBH0HcXe+0LdW2u
slAEVPOakpastPJUbePIs7ou8wYMbY2e7ksoaoaS8ng+Hgww+qmnGB7ZiWbyYWhU
FI+GsJOpbeFEM7tm1kZpIGF0Gf2mF/5/FJxV4X2lFk/GLG3vy5k+m4LKM5szxPU=
=zEBQ
-----END PGP SIGNATURE-----

--Tf/l6FweWSfB3ZNR--

--===============1081286608263684658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1081286608263684658==--
