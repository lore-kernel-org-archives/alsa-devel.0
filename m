From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v3.18
Date: Thu, 9 Oct 2014 00:58:42 +0100
Message-ID: <20141008235842.GR4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4439202190876223340=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50F472604CF
 for <alsa-devel@alsa-project.org>; Thu,  9 Oct 2014 01:59:06 +0200 (CEST)
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


--===============4439202190876223340==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qeGiC+TUQd3u8fcS"
Content-Disposition: inline


--qeGiC+TUQd3u8fcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a5448c88b812390a3622e76d774e10c0da1fb970:

  Merge remote-tracking branches 'asoc/topic/txx9', 'asoc/topic/wm8978' and 'asoc/topic/wm8994' into asoc-next (2014-10-06 12:49:09 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.18-2

for you to fetch changes up to bdf20b4291eaa3b327398b8dd330065ad8e6d3ce:

  Merge remote-tracking branches 'asoc/fix/88pm860x', 'asoc/fix/fsl', 'asoc/fix/imx', 'asoc/fix/mc13783', 'asoc/fix/rockchip' and 'asoc/fix/simple' into asoc-linus (2014-10-08 16:44:50 +0100)

----------------------------------------------------------------
ASoC: Fixes for v3.18

A few small fixes, mostly small although a few really nasty ones like
the interaction between GPIO 0 and simple-card.

----------------------------------------------------------------
Daniel Mack (4):
      ASoC: soc-dapm: fix use after free
      ASoC: core: fix use after free in snd_soc_remove_platform()
      ASoC: 88pm860x-codec: Fix possibly missing string termination
      ASoC: soc-pcm: fix sig_bits determination in soc_pcm_apply_msb()

Geert Uytterhoeven (1):
      ASoC: simple-card: Initialize headphone and mic GPIO numbers

Mark Brown (6):
      ASoC: mc13783: Ensure we only try to dereference valid of_nodes
      Merge tag 'asoc-v3.17-rc4' into asoc-linus
      Merge tag 'asoc-v3.18' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/88pm860x', 'asoc/fix/fsl', 'asoc/fix/imx', 'asoc/fix/mc13783', 'asoc/fix/rockchip' and 'asoc/fix/simple' into asoc-linus

Sonny Rao (1):
      ASoC: rockchip-i2s: fix infinite loop in rockchip_snd_txctrl

Takashi Iwai (2):
      ASoC: imx-es8328: Fix missing return code in imx_es8328_probe()
      ASoC: imx-es8328: Fix of_node_put() call with uninitialized object

 sound/soc/codecs/88pm860x-codec.c |  2 +-
 sound/soc/codecs/mc13783.c        | 16 ++++++++++------
 sound/soc/fsl/imx-es8328.c        |  3 ++-
 sound/soc/generic/simple-card.c   |  3 +++
 sound/soc/rockchip/rockchip_i2s.c |  4 +++-
 sound/soc/soc-core.c              |  4 ++--
 sound/soc/soc-dapm.c              | 25 ++++++++++++++-----------
 sound/soc/soc-pcm.c               |  2 +-
 8 files changed, 36 insertions(+), 23 deletions(-)

--qeGiC+TUQd3u8fcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNc+xAAoJECTWi3JdVIfQjfsH/2Tnh3nUmrpuuzuZIJBWf6Cq
JqMLmwJZHeIIviaiMbxDmPfIuS7pa6w3yk4TQLg3nBPp/kuHCpoccft+mnk8rEe5
CPx+OMKv0LGsZk1Jbza8iaXZLGP3o3C099RovzlpMAy6UZ0e3OMsdJqlKGiXoNsw
kDmt0yI8/XlpLXOUVLLXvbPe4ohwXa8CED0ezCsQVFFSzu8tZlmkgMHJVIMIK1QU
dEOGtjNanP/9tnY5MzXCXMyfn5k1mfjsjCgrLE6olJ+6YOQhBr8CcyaQ0QKZxAWd
oEJB59QOsMt4uwa04ad7bs/1I/0rA6zHSlhxd/yIg8FqQYcybNldQRE6mknAFZg=
=4l7K
-----END PGP SIGNATURE-----

--qeGiC+TUQd3u8fcS--

--===============4439202190876223340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4439202190876223340==--
