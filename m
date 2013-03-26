From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.9
Date: Tue, 26 Mar 2013 14:30:05 +0000
Message-ID: <20130326143004.GC18316@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1242180858415881393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA2DD2650C6
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 15:30:06 +0100 (CET)
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


--===============1242180858415881393==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8Bkcj4NmnZ79d4W7"
Content-Disposition: inline


--8Bkcj4NmnZ79d4W7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:

  Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v3.9-rc4

for you to fetch changes up to 40bac28eb1e39f229a94ad72e2ca8cdeef3ba31a:

  Merge remote-tracking branch 'asoc/fix/spear' into asoc-next (2013-03-26 14:08:07 +0000)

----------------------------------------------------------------

ASoC: Fixes for v3.9

A few more fixes here and there, including quite a few nasty driver
specific ones, but nothing that has a major general impact.

----------------------------------------------------------------
Axel Lin (1):
      ASoC: si476x: Add missing break for SNDRV_PCM_FORMAT_S8 switch case

Joe Perches (1):
      ASoC:: max98090: Remove executable bit

Lars-Peter Clausen (2):
      ASoC: spear_pcm: Update to new pcm_new() API
      ASoC: dma-sh7760: Fix compile error

Mark Brown (9):
      ASoC: dapm: Fix handling of loops
      Merge remote-tracking branch 'asoc/fix/adsp' into asoc-next
      Merge remote-tracking branch 'asoc/fix/core' into asoc-next
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/fix/fsl' into asoc-next
      Merge remote-tracking branch 'asoc/fix/max98090' into asoc-next
      Merge remote-tracking branch 'asoc/fix/sh' into asoc-next
      Merge remote-tracking branch 'asoc/fix/si476x' into asoc-next
      Merge remote-tracking branch 'asoc/fix/spear' into asoc-next

Markus Pargmann (1):
      ASoC: pcm030 audio fabric: remove __init from probe

Peter Ujfalusi (1):
      ASoC: dapm: Fix pointer dereference in is_connected_output_ep()

Sascha Hauer (1):
      ASoC: imx-ssi: Fix occasional AC97 reset failure

Silviu-Mihai Popescu (1):
      ASoC: core: fix invalid free of devm_ allocated data

Wei Yongjun (2):
      ASoC: wm_adsp: fix possible memory leak in wm_adsp_load_coeff()
      ASoC: core: fix possible memory leak in snd_soc_bytes_put()

 include/sound/soc-dapm.h            |    1 +
 sound/soc/codecs/si476x.c           |    1 +
 sound/soc/codecs/wm_adsp.c          |    5 +++--
 sound/soc/fsl/imx-ssi.c             |    5 +++++
 sound/soc/fsl/pcm030-audio-fabric.c |    2 +-
 sound/soc/sh/dma-sh7760.c           |    4 ++--
 sound/soc/soc-core.c                |    8 ++++----
 sound/soc/soc-dapm.c                |   14 ++++++++++++++
 sound/soc/spear/spear_pcm.c         |   12 ++++++------
 9 files changed, 37 insertions(+), 15 deletions(-)
 mode change 100755 => 100644 include/sound/max98090.h
 mode change 100755 => 100644 sound/soc/codecs/max98090.c
 mode change 100755 => 100644 sound/soc/codecs/max98090.h

--8Bkcj4NmnZ79d4W7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUbDmAAoJELSic+t+oim9lnYP/inAtxU13/gLUh8vyOF+lcad
zrdCyIID/APigt3jRn5AbAbA60s10s6lTrURkOPFUhRgCPdp6GaD7CL0l8OokcAC
Vd0zX40QCjFR+6yxS5WAxGAJhvgtzhQhKrxMFpBFtzP2oFmVcq+W/JjO77oOiNDA
cRWja4R4vHOOb81V+jcBz7CTjp/3kpGUd72zsvBfg5gZmxUeu8ME6PZQTlLY7WHT
ZgmEp9YlCZxkdtrtc65A0OB+EzaZ/fUAwipijinP2/qTEyDp8YmmYOimqukYRCuu
wDOgy8oiigiGljMn5+ydsWBgRq0CTRNmRxPFZETdmlmGRz4HkeQqDVUY0YbxuPW8
QkZVCmx40EgYYIn/ULWzXb4yAHciqxXaJZx01iUXdkPG80lzQk+Jg9ovDnSeNZF1
24ZkgnY/yy4HHlGcydNXMlTq5PwBOKWI/C7A6ThBr1qThuYoEsmW9eKfHS32PrfS
Fjn0FHXCaLVGz1PYRAQYAmoHkNc/1ccnqryKLR1Niub0FKtL987a0gyEeHZpTe3/
QJKz5ZLK9jTe7T1dkmjpWXvfVatY6r40V/9D2UTeT2qtO1nYDXdQAi83rCtrrx4f
YU3gFh77VNrHTvvx1vXZtmI8yPE7TiLbiFLXinZtY6/xpVwF86yWE8R7cqY++Jt4
/694o7EyDx+2AH0bNVIP
=/59l
-----END PGP SIGNATURE-----

--8Bkcj4NmnZ79d4W7--

--===============1242180858415881393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1242180858415881393==--
