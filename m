From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.10
Date: Wed, 11 Jan 2017 17:33:23 +0000
Message-ID: <20170111173323.uxk7vpgtmggpismp@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2848142095079440993=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB24326719D
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 18:33:32 +0100 (CET)
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


--===============2848142095079440993==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w2ejpdnwalyly3t5"
Content-Disposition: inline


--w2ejpdnwalyly3t5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.10-rc3

for you to fetch changes up to 42e0ebdef53d91891939a475c6ef23970829ff99:

  Merge remote-tracking branches 'asoc/fix/nau8825', 'asoc/fix/rt5645', 'asoc/fix/tlv320aic3x' and 'asoc/fix/topology' into asoc-linus (2017-01-10 10:47:54 +0000)

----------------------------------------------------------------
ASoC: Fixes for v4.10

As well as the usual smattering of driver specific fixes collected since
the merge window this has one particularly important fix to the core for
handling of aux_devs which was broken during the merge window by some of
the componentization refactoring.

----------------------------------------------------------------
Bard Liao (1):
      ASoC: rt5645: set sel_i2s_pre_div1 to 2

Caleb Crome (1):
      ASoC: fsl_ssi: set fifo watermark to more reliable value

Colin Ian King (2):
      ASoC: rsnd: don't double free kctrl
      ASoC: topology: kfree kcontrol->private_value before freeing kcontrol

G Kranthi (1):
      ASoC: Intel: Skylake: Fix to fail safely if module not available in path

Jeeja KP (1):
      ASoC: Intel: Skylake: Release FW ctx in cleanup

John Hsu (2):
      ASoC: nau8825: correct the function name of register
      ASoC: nau8825: fix invalid configuration in Pre-Scalar of FLL

Jose Abreu (1):
      ASoC: dwc: Fix PIO mode initialization

Mark Brown (5):
      Merge remote-tracking branch 'asoc/fix/component' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/arizona', 'asoc/fix/dpcm', 'asoc/fix/dwc', 'asoc/fix/fsl-ssi' and 'asoc/fix/hdmi-codec' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/nau8825', 'asoc/fix/rt5645', 'asoc/fix/tlv320aic3x' and 'asoc/fix/topology' into asoc-linus

Patrick Lai (1):
      ASoC: dpcm: Avoid putting stream state to STOP when FE stream is paused

Peter Ujfalusi (1):
      ASoC: tlv320aic3x: Mark the RESET register as volatile

Pierre-Louis Bossart (2):
      ASoC: Intel: bytcr_rt5640: fallback mechanism if MCLK is not enabled
      ASoC: Intel: bytcr-rt5640: fix settings in internal clock mode

Richard Fitzgerald (1):
      ASoC: wm_adsp: Don't overrun firmware file buffer when reading region data

Sylwester Nawrocki (1):
      ASoC: Fix binding and probing of auxiliary components

Takashi Sakamoto (1):
      ASoC: hdmi-codec: use unsigned type to structure members with bit-field

 include/sound/hdmi-codec.h            |  8 ++--
 include/sound/soc.h                   |  3 ++
 sound/soc/codecs/nau8825.c            |  9 +++--
 sound/soc/codecs/nau8825.h            |  7 ++--
 sound/soc/codecs/rt5645.c             |  3 ++
 sound/soc/codecs/tlv320aic3x.c        | 13 ++++++
 sound/soc/codecs/wm_adsp.c            | 25 +++++++++++-
 sound/soc/dwc/designware_i2s.c        | 25 ++++++------
 sound/soc/fsl/fsl_ssi.c               | 74 +++++++++++++++++++++++++----------
 sound/soc/intel/boards/bytcr_rt5640.c | 18 +++++++--
 sound/soc/intel/skylake/skl-pcm.c     |  3 ++
 sound/soc/intel/skylake/skl-sst.c     |  3 ++
 sound/soc/sh/rcar/core.c              |  4 +-
 sound/soc/soc-core.c                  | 10 ++---
 sound/soc/soc-pcm.c                   |  4 +-
 sound/soc/soc-topology.c              |  3 +-
 16 files changed, 150 insertions(+), 62 deletions(-)

--w2ejpdnwalyly3t5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh2bGIACgkQJNaLcl1U
h9CNRgf/Q20Hd45MTP/B9xvogwNPun/LM2FYR4F+0WvjwRvrTx+pxd+TDN/2gFcf
zI44hxpmcaQ1Fl+HhiJFlLOeJA9LEmL5T31A3GY3V1h0Iv1j2KCCC1mYft3DAIr/
0YdJtJzVwDJ38VG5CtGgMEseKAahjT9Ds/AosNmsjNrQxFzRKzz5UbaEO0ffU2PU
JSuLWPTzhtbXwub9uU8FRpOkLcGXAjFbBurxnauqHWBhvtmtNtsPFChersY1DHTS
EYC250YREfS+ycavURrudOuO6O37dq5xL5SFTCJU8T5qV8/CUU/CxtntdevSFYX0
0rm+ygyNZxkBCXalBVkLqqm9D5yA9g==
=plv/
-----END PGP SIGNATURE-----

--w2ejpdnwalyly3t5--

--===============2848142095079440993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2848142095079440993==--
