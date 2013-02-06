From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.8
Date: Wed, 6 Feb 2013 13:22:57 +0000
Message-ID: <20130206132257.GK4720@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2326573354147391337=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 39480264F8D
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 14:32:56 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam.R.Girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2326573354147391337==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSJGZE3ajDCqFLUt"
Content-Disposition: inline


--VSJGZE3ajDCqFLUt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.8-rc6

for you to fetch changes up to 5074e8eca643dd19e5397e638c7e9ca0ba9b4e24:

  Merge remote-tracking branch 'asoc/fix/wm2200' into tmp (2013-02-06 10:54=
:35 +0000)

----------------------------------------------------------------

ASoC: Updates for v3.8-rc7

I've been a bit slack sending the pull requests for this so there's
rather more driver specific updates here than is desirable but
everything here is nicely localised so hopefully we're OK.

----------------------------------------------------------------
Alexey Galakhov (1):
      ASoC: samsung: Fix compilation error on S3C2440

Beno=EEt Th=E9baudeau (1):
      ASoC: tlv320aic3x: Remove mono support

Charles Keepax (1):
      ASoC: wm_adsp: Release firmware on error

Chris Rattray (1):
      ASoC: wm2200: correct IN2L and IN3L digital mute

Dan Carpenter (1):
      ASoC: dwc: fix support for more than two channels

Lee Jones (1):
      ASoC: Ux500: Fix build error pertaining to missing include file

Mark Brown (13):
      ASoC: wm_adsp: Ensure ADSP2 DMAs are quiesced when DSP is halted
      ASoC: wm2000: Lock state machine updates
      Merge remote-tracking branch 'asoc/fix/arizona' into tmp
      Merge remote-tracking branch 'asoc/fix/core' into tmp
      Merge remote-tracking branch 'asoc/fix/davinci' into tmp
      Merge remote-tracking branch 'asoc/fix/dwc' into tmp
      Merge remote-tracking branch 'asoc/fix/fsl' into tmp
      Merge remote-tracking branch 'asoc/fix/lrg' into tmp
      Merge remote-tracking branch 'asoc/fix/samsung' into tmp
      Merge remote-tracking branch 'asoc/fix/tlv320aic3x' into tmp
      Merge remote-tracking branch 'asoc/fix/ux500' into tmp
      Merge remote-tracking branch 'asoc/fix/wm2000' into tmp
      Merge remote-tracking branch 'asoc/fix/wm2200' into tmp

Michal Bachraty (1):
      ASoC: McASP: Fix data rotation for playback. Enables 24bit audio play=
back

Ryo Tsutsui (1):
      ASoC: arizona: Fixed a bug in FLL fractional calculation

Shawn Guo (2):
      Revert "ASoC: fsl: fix multiple definition of init_module"
      ASoC: fsl: fix snd-soc-imx-pcm module build

 MAINTAINERS                       |    2 +-
 sound/soc/codecs/arizona.c        |   16 ++++++++++++++--
 sound/soc/codecs/tlv320aic3x.c    |    4 ++--
 sound/soc/codecs/wm2000.c         |   31 ++++++++++++++++++++++++++++---
 sound/soc/codecs/wm2200.c         |    7 ++-----
 sound/soc/codecs/wm5102.c         |    3 +--
 sound/soc/codecs/wm5110.c         |    3 +--
 sound/soc/codecs/wm_adsp.c        |   20 ++++++++++++++------
 sound/soc/davinci/davinci-mcasp.c |    2 +-
 sound/soc/dwc/designware_i2s.c    |    4 ++++
 sound/soc/fsl/imx-pcm-dma.c       |   21 +--------------------
 sound/soc/fsl/imx-pcm-fiq.c       |   22 +---------------------
 sound/soc/fsl/imx-pcm.c           |   32 ++++++++++++++++++++++++++++++++
 sound/soc/fsl/imx-pcm.h           |   18 ++++++++++++++++++
 sound/soc/samsung/s3c24xx-i2s.c   |    2 +-
 sound/soc/soc-dapm.c              |   12 ++++++++++--
 sound/soc/ux500/mop500.c          |    2 +-
 17 files changed, 132 insertions(+), 69 deletions(-)

--VSJGZE3ajDCqFLUt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRElNCAAoJELSic+t+oim9FA4P/iWRcTFk8MTBwSEegljvk64X
kGjHz1sY8leWQakaOe3+7YxsDMDrWiBzykGuFUcq/nwq7/6TGABfm/kDGLRcVnKb
b2xCpcbzBMeFwl0g7M8sXIvjQRNYI4pcNhHzlk4ahPkBYMY+Nrddh6eAjcu+zRS4
v7oo/4PRTt5UfILVhNSFq1fb4JWkvjsF8+QD2PGB24QsXF53VR6DYZBWxVkWhSmY
KHdXWqVJ+Z7huVTbCuICVZJpNM+2Ia7dj+miQqLNPWyGeWT2+XJBhHqll2ZaguL6
fSYO7JYNFTjrD1eEPvaOU+SRZhg8yHB7E3nSYmELpZoMKpEGjYlXvwgIU5w0P8UH
fwiO9gfe/y+yLPZALySYHJkJpoh7rXtxCu9bkfbPNANtA2RqdcZaDlPs+SWxV0E4
vAe6SsZ+VZQnQRzzx9WOfAKJPzgh6X/AnXgyZdFlbwj2M9xbqJJA8/dkCTQ8Q0rz
pgkS/sBw6uUt33kNlw93xUvcV8puyHOApkugBI8BONL4AN7eFxA1cPWV/R3a9BU8
FtE99sMRa7X9CtArdAaU8qG6hxYbhw4iYclJK1gvH+NZUwMTOmJtoHIamtLA+FkY
9LTPPQbI6eZ44jBlx/GGXB5pqfVH4E+CJpwh2YaId5i1zaw6s3o0s3CcDntwYkMQ
k7E4s4nZSLvX/2ukDWR7
=m0Li
-----END PGP SIGNATURE-----

--VSJGZE3ajDCqFLUt--

--===============2326573354147391337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2326573354147391337==--
