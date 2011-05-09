From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.40
Date: Mon, 9 May 2011 22:18:16 +0200
Message-ID: <20110509201815.GB21323@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 939841037EA
	for <alsa-devel@alsa-project.org>;
	Mon,  9 May 2011 22:18:10 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 87023ff74b2358b5e51d3c790704f786e89ff769:

  ASoC: Declare const properly for enum texts (2011-05-03 12:51:59 +0200)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.40

Dimitris Papastamos (1):
      ASoC: soc-cache: Allow codec->cache_bypass to be used with snd_soc_hw_bulk_write_raw()

Lars-Peter Clausen (18):
      ASoC: Free the card's DAPM context
      ASoC: Move DAPM debugfs directory creation to snd_soc_dapm_debugfs_init
      ASoC: Move DAPM widget debugfs entry creation to snd_soc_dapm_new_widgets
      ASoC: Remove DAPM debugfs entries before freeing widgets
      ASoC: JZ4740: Fix i2s shutdown
      ASoC: Create codec DAPM widgets before calling the codecs probe function
      ASoC: SSM2602: Properly annotate i2c probe and remove functions
      ASoC: SSM2602: Fix 'Mic Boost2' control
      ASoC: SSM2602: Fix reg_cache_size
      ASoC: SSM2602: Cleanup coeff handling
      ASoC: SSM2602: Remove duplicate control
      ASoC: SSM2602: Remove unused struct and define
      ASoC: SSM2602: Fix default register cache
      ASoC: SSM2602: Do not power the codec up in probe
      ASoC: SSM2602: Add SSM2604 support
      ASoC: SSM2602: Add entry for the ssm2603 to the device id table
      ASoC: SSM2602: Model power supply for the digital core as a DAPM widget
      ASoC: SSM2602: Provide dB ranges for the volume controls

Marek Belisko (1):
      ASoC: UDA134x: Remove POWER_OFF_ON_STANDBY define.

Mark Brown (8):
      Merge branch 'for-2.6.39' into for-2.6.40
      ASoC: Don't crash on PM operations
      Merge branch 'topic/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-2.6.40
      ASoC: Use shared controls for input signal path in WM8915
      ASoC: Remove outdated FIXME from WM8915
      Merge branch 'for-2.6.39' into for-2.6.40
      Merge branch 'for-2.6.39' into for-2.6.40
      Merge branch 'for-2.6.39' into for-2.6.40

Mike Rapoport (1):
      ASoC: tegra: TrimSlice machine support

Stephen Warren (4):
      ASoC: s/w->kcontrols/w->kcontrol_news/g
      ASoC: Add w->kcontrols, and populate it
      ASoC: Store a list of widgets in a DAPM mux/mixer kcontrol
      ASoC: Implement mux control sharing

xingchao (1):
      ASoC: sst_platform: add hw_free callback to fix resource leak

 include/sound/soc-dapm.h          |   78 +++++----
 sound/soc/codecs/88pm860x-codec.c |    2 +-
 sound/soc/codecs/ssm2602.c        |  302 ++++++++++++++++++-------------
 sound/soc/codecs/ssm2602.h        |    6 -
 sound/soc/codecs/uda134x.c        |    2 -
 sound/soc/codecs/wm8915.c         |   46 +++--
 sound/soc/jz4740/jz4740-i2s.c     |    2 +-
 sound/soc/mid-x86/sst_platform.c  |    6 +
 sound/soc/soc-cache.c             |   11 +-
 sound/soc/soc-core.c              |   38 ++---
 sound/soc/soc-dapm.c              |  373 ++++++++++++++++++++++++++-----------
 sound/soc/tegra/Kconfig           |    8 +
 sound/soc/tegra/Makefile          |    2 +
 sound/soc/tegra/trimslice.c       |  228 ++++++++++++++++++++++
 14 files changed, 780 insertions(+), 324 deletions(-)
 create mode 100644 sound/soc/tegra/trimslice.c
