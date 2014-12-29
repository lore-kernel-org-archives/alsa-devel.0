From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.20
Date: Mon, 29 Dec 2014 16:17:14 +0000
Message-ID: <20141229161714.GV17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3649909307778328549=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D082B260699
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 17:17:35 +0100 (CET)
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


--===============3649909307778328549==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uirbBhP+oL+JcCcl"
Content-Disposition: inline


--uirbBhP+oL+JcCcl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.19-rc2

for you to fetch changes up to 1b9f1ae8907cb13d3d2538d98385b2744c9490d5:

  Merge remote-tracking branches 'asoc/topic/samsung' and 'asoc/topic/wm8750' into asoc-next (2014-12-24 12:56:48 +0000)

----------------------------------------------------------------
ASoC: Updates for v3.20

Nothing too exciting here yet, a small optimization for DAPM from
Lars-Peter and a few small bits and pieces for drivers but nothing
that really stands out.

----------------------------------------------------------------
Andrew Jackson (4):
      ASoC: dwc: Remove unnecessary debug messages and tests
      ASoC: dwc: Reorder code in preparation for DT support
      ASoC: dwc: Ensure FIFOs are flushed to prevent channel swap
      ASoC: dwc: Iterate over all channels

Bard Liao (3):
      ASoC: rt5670: set platform data by dmi
      ASoC: rt5670: Add runtime PM support
      ASoC: rt5670: Keep sysclk on if JD func is used

Fang, Yang A (1):
      ASoC: rt5677: fixed rt5677_dsp_vad_put rt5677_dsp_vad_get panic

Jarkko Nikula (4):
      ASoC: Intel: Add I2C dependency to two new machines
      ASoC: Intel: Fix BYTCR firmware name
      ASoC: Intel: Fix BYTCR machine driver MODULE_ALIAS
      ASoC: pcm: Fix vague codec and cpu DAI prepare error messages

Jianqun Xu (3):
      ASoC: rockchip: i2s: fix error defination of transmit data level
      ASoC: rockchip: i2s: fix maxburst of dma data to 4
      ASoC: rockchip: i2s: set TDL and RDL to 16 samples

Jie Yang (2):
      ASoC: Intel: correct the fixed free block allocation
      ASoC: Intel: Store the entry_point read from FW file

Lars-Peter Clausen (4):
      ASoC: wm8750: Make VREF a VMID instead of OUTPUT widget
      ASoC: wm8750: Cleanup manual bias level transitions
      ASoC: dapm: Don't mark MICBIAS widgets as auto non-connected
      ASoC: dapm: Simplify fully route card handling

Mark Brown (9):
      ASoC: dapm: Remove snd_soc_of_parse_audio_routing() due to deferred probe
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/dwc', 'asoc/fix/intel', 'asoc/fix/rockchip' and 'asoc/fix/rt5677' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm512x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/dwc', 'asoc/topic/intel' and 'asoc/topic/omap' into asoc-next
      Merge remote-tracking branches 'asoc/topic/pxa', 'asoc/topic/rockchip', 'asoc/topic/rt5670' and 'asoc/topic/rt5677' into asoc-next
      Merge remote-tracking branches 'asoc/topic/samsung' and 'asoc/topic/wm8750' into asoc-next

Oder Chiou (3):
      ASoC: rt5677: Revise the filter powers
      ASoC: rt5677: Add the ASRC support
      ASoC: rt5677: Adjust the routing of "PLL1"

Peter Rosin (1):
      ASoC: pcm512x: Also support PCM514x devices

Takashi Iwai (1):
      ASoC: intel: Remove superfluous backslash in Kconfig

Wei Yongjun (1):
      ASoC: Intel: fix sparse non static symbol warnings

Wolfram Sang (4):
      ASoC: intel: sst: drop owner assignment from platform_drivers
      ASoC: omap: drop owner assignment from platform_drivers
      ASoC: pxa: drop owner assignment from platform_drivers
      ASoC: samsung: drop owner assignment from platform_drivers

kbuild test robot (2):
      ASoC: Intel: fix platform_no_drv_owner.cocci warnings
      ASoC: Intel: fix platform_no_drv_owner.cocci warnings

 .../devicetree/bindings/sound/pcm512x.txt          |   3 +-
 include/sound/soc-dapm.h                           |   1 -
 sound/soc/codecs/pcm512x-i2c.c                     |   4 +
 sound/soc/codecs/pcm512x-spi.c                     |   4 +
 sound/soc/codecs/rt5670.c                          |  38 ++++
 sound/soc/codecs/rt5677.c                          | 204 ++++++++++++++++++---
 sound/soc/codecs/wm8750.c                          |   2 +-
 sound/soc/dwc/designware_i2s.c                     | 135 +++++++-------
 sound/soc/intel/Kconfig                            |   8 +-
 sound/soc/intel/bytcr_dpcm_rt5640.c                |   3 +-
 sound/soc/intel/cht_bsw_rt5672.c                   |   1 -
 sound/soc/intel/sst-firmware.c                     |   7 +-
 sound/soc/intel/sst/sst_acpi.c                     |   7 +-
 sound/soc/omap/omap-hdmi-audio.c                   |   1 -
 sound/soc/pxa/spitz.c                              |   1 -
 sound/soc/rockchip/rockchip_i2s.c                  |   8 +-
 sound/soc/rockchip/rockchip_i2s.h                  |   2 +-
 sound/soc/samsung/arndale_rt5631.c                 |   1 -
 sound/soc/soc-core.c                               |  17 +-
 sound/soc/soc-dapm.c                               | 105 ++---------
 sound/soc/soc-pcm.c                                |   7 +-
 21 files changed, 349 insertions(+), 210 deletions(-)

--uirbBhP+oL+JcCcl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoX6JAAoJECTWi3JdVIfQxLAH/AzXFH+Hy78IrHj+9Xgr9WUQ
xQJMyD1EHezty8cm7ungNeu6OQD0ApqcLi4kAl8jRW79FPUiV9lTYrvZMCqaCh69
D4Nxh/L/OP771lzeOqDnbaIbM0NM/D6dRSRcAqTtBHSL8x+PQcaX5PvABbFSw2oz
VgP9NTRTyaWhCfO1bn9M/NLPp8gzoJfnXVSwtt66gXmFhBgb1OT982+VcBT3K1UL
s/0lvziFVCqBvluMBfRw3PLNV86F0bBLERn1vraey7wAxUhDFHam+yWs7LoINgIg
Y9JUugL70XzibSiWi13F1bjzmk4oCP3I5yMwU9MQcoSr6+2ix2wTGFJeFvoq02s=
=ZkfO
-----END PGP SIGNATURE-----

--uirbBhP+oL+JcCcl--

--===============3649909307778328549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3649909307778328549==--
