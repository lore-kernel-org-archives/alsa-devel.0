From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Tue, 8 Nov 2011 11:24:04 +0000
Message-ID: <20111108112404.GH25591@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7F092438C
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 12:24:10 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.3

Axel Lin (6):
      ASoC: wm8400: Fix setting Fout clock divider for FLL Control 4
      ASoC: wm8996: Avoid a redundant i2c_get_clientdata call in wm8996_i2c_remove
      ASoC: wm8940: Fix setting PLL Output clock division ratio
      ASoC: wm8940: Fix a typo for the mask of setting WM8940_BCLKDIV
      ASoC: tlv320aic3x: Use snd_soc_update_bits for read-modify-write
      ASoC: Avoid a redundant read in cs42l51_pdn_event

Kuninori Morimoto (3):
      ASoC: fsi: fixup compile warning
      ASoC: ak4642: ak4642 was tested
      ASoC: fsi: add valid data position control support

Mark Brown (29):
      ASoC: Convert wm8995 MICBIASes to supply widgets
      ASoC: Convert wm8991 MICBIAS to a supply widget
      ASoC: Convert wm8990 MICBIAS to a supply widget
      ASoC: Convert wm8988 MICBIAS to a supply widget
      ASoC: Convert wm8985 MICBIAS to a supply widget
      ASoC: Convert wm8983 MICBIAS to a supply widget
      ASoC: Convert wm8974 MICBIAS to a supply widget
      ASoC: Convert wm8961 MICBIAS to a supply widget
      ASoC: Convert wm8960 MICBIAS to a supply widget
      ASoC: Convert wm8904 MICBIAS to a supply widget
      ASoC: Convert wm8900 MICBIAS to a supply widget
      ASoC: Convert wm8400 MICBIAS to a supply widget
      ASoC: Start WM8962 FLL if SYSCLK is enabled
      ASoC: Enable SYSCLK last when enabling WM8962 mic detection
      ASoC: WM8962 accessory detection requires MICBIAS
      ASoC: Disable MICBIAS and SYSCLK when stopping WM8962 accessory detection
      ASoC: Sort LM4857 with the CODECs in the Makefile
      ASoC: Fix sort of jz4740 in Makefile
      ASoC: Update git repository URL
      ASoC: Remove needless unlikely()
      ASoC: Only enable thermal shutdown when required on WM9081
      ASoC: Manage thermal shutdown for WM8962
      ASoC: Disable thermal shutdown when not using speakers in wm_hubs
      ASoC: Don't use wm8994->control_data in wm8994_readable_register()
      ASoC: Don't use wm8994->control_data when requesting IRQs
      ASoC: Ensure we get an impedence reported for WM8958 jack detect
      Merge branch 'for-3.2' into for-3.3
      Merge branch 'for-3.2' of git://git.kernel.org/.../broonie/sound into for-3.2
      Merge branch 'for-3.2' into for-3.3

ramesh.babu@linux.intel.com (1):
      ASoC: Allow machines to ignore pmdown_time per-link

 MAINTAINERS                          |    2 +-
 include/linux/mfd/wm8994/registers.h |   15 ++++++++++++
 include/sound/soc.h                  |    3 ++
 sound/soc/codecs/Makefile            |    6 ++--
 sound/soc/codecs/ak4642.c            |    2 +-
 sound/soc/codecs/cs42l51.c           |   13 ++++------
 sound/soc/codecs/tlv320aic3x.c       |   41 +++++++++++---------------------
 sound/soc/codecs/wm8400.c            |    6 ++--
 sound/soc/codecs/wm8900.c            |    2 +-
 sound/soc/codecs/wm8904.c            |    2 +-
 sound/soc/codecs/wm8940.c            |    4 +-
 sound/soc/codecs/wm8960.c            |    2 +-
 sound/soc/codecs/wm8961.c            |    2 +-
 sound/soc/codecs/wm8962.c            |   20 +++++++++++++++
 sound/soc/codecs/wm8974.c            |    2 +-
 sound/soc/codecs/wm8983.c            |    3 +-
 sound/soc/codecs/wm8985.c            |    3 +-
 sound/soc/codecs/wm8988.c            |    2 +-
 sound/soc/codecs/wm8990.c            |    4 +-
 sound/soc/codecs/wm8991.c            |    4 +-
 sound/soc/codecs/wm8994.c            |   43 +++++++++++++++++++++++-----------
 sound/soc/codecs/wm8995.c            |    6 +++-
 sound/soc/codecs/wm8996.c            |    2 +-
 sound/soc/codecs/wm9081.c            |    2 +
 sound/soc/codecs/wm_hubs.c           |    3 ++
 sound/soc/sh/fsi.c                   |   21 ++++++++++++++--
 sound/soc/soc-pcm.c                  |    3 +-
 27 files changed, 140 insertions(+), 78 deletions(-)
