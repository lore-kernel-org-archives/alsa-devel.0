From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v3.13
Date: Thu, 19 Dec 2013 11:19:53 +0000
Message-ID: <20131219111953.GW31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5619398053758023827=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D3D1A261A9F
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 12:19:55 +0100 (CET)
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


--===============5619398053758023827==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cxfMsoqvp1jUizWj"
Content-Disposition: inline


--cxfMsoqvp1jUizWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:

  Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.13-rc4

for you to fetch changes up to 96b7fe0119b932ad25451d2b6357e727bbe6a309:

  Merge remote-tracking branches 'asoc/fix/adsp', 'asoc/fix/arizona', 'asoc/fix/atmel', 'asoc/fix/fsl', 'asoc/fix/kirkwood', 'asoc/fix/tegra', 'asoc/fix/wm8904' and 'asoc/fix/wm8962' into asoc-linus (2013-12-19 10:25:27 +0000)

The diffstat is larger than the description since the pull request is
against Linus' tree due the scheduling of your pull request last week
compared to mine to you.

----------------------------------------------------------------

ASoC: Fixes for v3.13

The fixes here are all driver specific ones, none of which particularly
stand out but all of which are useful to users of those drivers.

----------------------------------------------------------------
Bo Shen (3):
      ASoC: atmel_ssc_dai: add dai trigger ops
      ASoC: sam9x5_wm8731: change to work in DSP A mode
      ASoC: wm8904: fix DSP mode B configuration

Charles Keepax (2):
      ASoC: wm5110: Correct HPOUT3 DAPM route typo
      ASoC: wm_adsp: Add small delay while polling DSP RAM start

Jean-Francois Moine (1):
      ASoC: kirkwood: Fix the CPU DAI rates

Mark Brown (3):
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dma' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/adsp', 'asoc/fix/arizona', 'asoc/fix/atmel', 'asoc/fix/fsl', 'asoc/fix/kirkwood', 'asoc/fix/tegra', 'asoc/fix/wm8904' and 'asoc/fix/wm8962' into asoc-linus

Nicolin Chen (3):
      ASoC: soc-pcm: Use valid condition for snd_soc_dai_digital_mute() in hw_free()
      ASoC: wm8962: Enable SYSCLK provisonally before fetching generated DSPCLK_DIV
      ASoC: fsl: imx-wm8962: Don't update bias_level in machine driver

Stephen Warren (2):
      ASoC: tegra: fix uninitialized variables in set_fmt
      ASoC: don't leak on error in snd_dmaengine_pcm_register

 sound/soc/atmel/atmel_ssc_dai.c       | 30 ++++++++++++++++++++++++++-
 sound/soc/atmel/sam9x5_wm8731.c       |  2 +-
 sound/soc/codecs/wm5110.c             |  2 +-
 sound/soc/codecs/wm8904.c             |  2 +-
 sound/soc/codecs/wm8962.c             | 13 ++++++++++++
 sound/soc/codecs/wm_adsp.c            | 10 ++++++---
 sound/soc/fsl/imx-wm8962.c            |  2 --
 sound/soc/kirkwood/kirkwood-i2s.c     | 24 +++++++++++-----------
 sound/soc/soc-generic-dmaengine-pcm.c | 38 +++++++++++++++++++++++++----------
 sound/soc/soc-pcm.c                   |  5 +++--
 sound/soc/tegra/tegra20_i2s.c         |  6 +++---
 sound/soc/tegra/tegra20_spdif.c       | 10 ++++-----
 sound/soc/tegra/tegra30_i2s.c         |  6 +++---
 13 files changed, 105 insertions(+), 45 deletions(-)

--cxfMsoqvp1jUizWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSstZVAAoJELSic+t+oim9A24P/iXNdmgQA8qKZ8ccqsKBu99b
B7FOTgks6Mk1hvIigljDpl7Snr5cvciSXxwSq4UefvtMIvk/jqIqXkrNedd5Vt0v
Rf8HPXuAZKgGRYAF1wcmR5IGzUV0QmyFVU+0Xj51xw+8UWtajzvHrXsagceQsy4T
sWdR9LFXUa20LwIRZGVQwpXRu3K+z5MHaZj80NcmfkjOWW1ojK27z3KNImftHMZy
mUf9Mgynh79ozDoXytZUwiRJ6fzD+TAYiDxdPtBMhZ93NLxg3D6qX39f5LWQpS3x
f+d3y1afYcsBlNnHRvT4pPW213TRM2EBRdO6Q49zAnK9xg0+dFJKFkeRje1J7ehA
w+JceSNOo5SNBxtc2djeUkORYR5mVnGz7cOGqIUrjS6Op5IrNYeSYcdB5QT9cEio
IQtaEddiDhvNvmkClur6b2WNkfubJPJssNuQxGwgkJiD5VFsMddShMxgqMe5kDY7
ZGjphRXLJTy8AMkf/FqNEVYXK3Gte06kR/YsxFnT161u5Zh3+mF2R9+vdyMTpUz1
jjZHE4t2RBPjHYJD/n+8Zikyd7KgjKDotMDsIH/svtqzAoZ664sWrUPWfRL6pfkS
nFKOxj8YO7m2zk9BNSO6bGbpbixrfuYQ7HECFH3IZaEIYhaGickhV4blk7NPoIcG
kiL0EK/4LrvUC6Aqm/hS
=kQe1
-----END PGP SIGNATURE-----

--cxfMsoqvp1jUizWj--

--===============5619398053758023827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5619398053758023827==--
