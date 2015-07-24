From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.2
Date: Fri, 24 Jul 2015 18:20:58 +0100
Message-ID: <20150724172058.GQ11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4741020518030878481=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8395D2605CB
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 19:21:05 +0200 (CEST)
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


--===============4741020518030878481==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="865pATNJ8WYJPPTx"
Content-Disposition: inline


--865pATNJ8WYJPPTx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 52721d9d3334c1cb1f76219a161084094ec634dc:

  Linux 4.2-rc3 (2015-07-19 14:45:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-fix-v4.2-rc3

for you to fetch changes up to 996034b117b467709dec7811ef134063934fa626:

  Merge remote-tracking branches 'asoc/fix/sgtl5000', 'asoc/fix/topology' and 'asoc/fix/zx' into asoc-linus (2015-07-24 16:18:22 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.2

A lot of small fixes here, a few to the core:

 - Fix for binding DAPM stream widgets on devices with prefixes assigned
   to them
 - Minor fixes for the newly added topology interfaces
 - Locking and memory leak fixes for DAPM
 - Driver specific fixes

----------------------------------------------------------------
Axel Lin (2):
      ASoC: sgtl5000: Fix up define for SGTL5000_SMALL_POP
      ASoC: pcm1681: Fix setting de-emphasis sampling rate selection

Ben Zhang (1):
      ASoC: ssm4567: Keep TDM_BCLKS in ssm4567_set_dai_fmt

Charles Keepax (1):
      ASoC: dapm: Fix deadlock on auto-disable mux controls

Fang, Yang A (1):
      ASoC: Intel: fix incorrect widget name

Jeeja KP (1):
      ASoC: topology: Fix to add dapm mixer info

Juergen Borleis (1):
      ASoC: fsl-ssi: Fix bitclock calculation for master mode

Koro Chen (2):
      ASoC: mediatek: Fix unbalanced calls to runtime suspend/resume
      ASoC: mediatek: Use platform_of_node for machine drivers

Krzysztof Kozlowski (2):
      ASoC: zx: i2s: Fix devm_ioremap_resource return value check
      ASoC: zx: spdif: Fix devm_ioremap_resource return value check

Lars-Peter Clausen (4):
      ASoC: dapm: Lock during userspace access
      ASoC: dapm: Fix kcontrol widget name memory management
      ASoC: Free card DAPM context on snd_soc_instantiate_card() error path
      ASoC: dapm: Don't add prefix to widget stream name

Liam Girdwood (1):
      ASoC: topology: Fix TLV size calculation.

Mark Brown (6):
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/pcm1681' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/ssm4567' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/fsl-ssi', 'asoc/fix/intel', 'asoc/fix/intel-kconfig' and 'asoc/fix/mediatek' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/sgtl5000', 'asoc/fix/topology' and 'asoc/fix/zx' into asoc-linus

Nicolas Boichat (1):
      ASoC: rt5645: Check if codec is initialized in workqueue handler

Shilpa Sreeramalu (1):
      ASoC: Intel: Get correct usage_count value to load firmware

Vinod Koul (2):
      ASoC: topology: fix typos in topology header
      ASoC: Intel: use CONFIG_SND_SOC for intel boards

 .../devicetree/bindings/sound/mt8173-max98090.txt  |  2 ++
 .../bindings/sound/mt8173-rt5650-rt5676.txt        |  2 ++
 include/uapi/sound/asoc.h                          |  4 +--
 sound/soc/codecs/pcm1681.c                         |  2 +-
 sound/soc/codecs/rt5645.c                          |  3 ++
 sound/soc/codecs/sgtl5000.h                        |  2 +-
 sound/soc/codecs/ssm4567.c                         |  8 ++++-
 sound/soc/fsl/fsl_ssi.c                            |  2 +-
 sound/soc/intel/Makefile                           |  2 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c       | 14 ++++-----
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |  4 +--
 sound/soc/mediatek/mt8173-max98090.c               | 17 ++++++++---
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          | 19 +++++++++---
 sound/soc/mediatek/mtk-afe-pcm.c                   |  2 ++
 sound/soc/soc-core.c                               |  1 +
 sound/soc/soc-dapm.c                               | 35 +++++++++++-----------
 sound/soc/soc-topology.c                           | 23 +++++++-------
 sound/soc/zte/zx296702-i2s.c                       |  4 +--
 sound/soc/zte/zx296702-spdif.c                     |  4 +--
 19 files changed, 93 insertions(+), 57 deletions(-)

--865pATNJ8WYJPPTx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVsnP6AAoJECTWi3JdVIfQ7+wH/j2MA79QGw1FeM7T9GfI5mSQ
7VxT3L397jdTxuPWehmey0SRm+detXh9TjGP0VT+pag58KNZq4wbaure1oC8NmSF
e6rS1eQ1GhydQmG5s+SL+zF/IjEl6i0/msyb4OUWH6JM/PExOyLJRmO9dI/saCvv
hsRM/4ZAhCrBzQBtfd4LNAjgOnIq5cl+DoQ3b7WedXquGHeW7ik/2FAU2fyqjusx
AX2uDSSlZ01ty1qYlvTjMVk0uFaKbvOC7fOVA9V6bljire7TjRVYW0cyBkotvAT0
7l+PI0aCSwtfyNWYGn2O+GANtjY1GQr+tdPpawZX/fT7Ve6NdIs8pZ86P1AwF+A=
=8Bpe
-----END PGP SIGNATURE-----

--865pATNJ8WYJPPTx--

--===============4741020518030878481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4741020518030878481==--
