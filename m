From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.39
Date: Fri, 18 Feb 2011 14:18:56 -0800
Message-ID: <20110218221856.GA10566@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1DAB24479
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 23:18:36 +0100 (CET)
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
To: Takashi Iwai <tiawi@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 46fdaa3bec1bcaa36759b1f5e5e27245ae465b8f:

  ASoC: soc-cache: dereferencing before checking (2011-02-08 11:27:45 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.39

Dimitris Papastamos (2):
      ASoC: WM8994: Improve robustness in some use cases
      ASoC: WM8994: Improve playback robustness

Janusz Krzysztofik (1):
      ASoC: CX20442: fix wrong reg_cache_default content

Jarkko Nikula (1):
      ASoC: Allow use sleeping gpio in soc-jack

Mark Brown (21):
      ASoC: Remove redundant -codec from WM8903 driver name
      ASoC: Display WM8903 chip revision alphabetically
      ASoC: Add support for AIF channel muxing on WM8903
      ASoC: Convert WM8903 to use PGA_S for output stage enables
      ASoC: Dynamically manage CLK_SYS in WM8903
      ASoC: Fix WM8903 DAC mute default
      ASoC: Sync initial widget state with hardware
      Merge branch 'for-2.6.38' into for-2.6.39
      ASoC: Actively manage WM8903 DC servo configuration
      ASoC: Convert WM8903 bias management to use snd_soc_update_bits()
      ASoC: Don't use write sequencer to power up WM8903
      ASoC: Use explicit sequence for WM8903 bias off
      Merge branch 'for-2.6.38' into for-2.6.39
      ASoC: Ensure supplies are maintained for force enabled widgets
      ASoC: Warn if WM8903 platform data is used to enable microphone IRQ
      Merge branch 'for-2.6.38' into for-2.6.39
      ASoC: Fix missing space in WM8994
      ASoC: Remove export of snd_soc_dapm_stream_event()
      ASoC: Log wm_hubs DC servo operation code when reporting a timeout
      ASoC: Allow GPIO jack detection to be configured as a wake source
      ASoC: Add kerneldoc for jack_status_check callback

Stephen Warren (8):
      ASoC: Tegra: Harmony: Add headphone jack detection
      ASoC: Tegra: Harmony: Add switch control for speaker
      ASoC: WM8903: Fix mic detection register definitions
      ASoC: WM8903: Fix mic detection enable logic
      ASoC: Tegra: Harmony: Implement mic detection
      ASoC: Harmony: Call snd_soc_dapm_nc_pin
      ASoC: Tegra: Harmony: Explicitly set mic enables
      ASoC: Tegra: Add MODULE_ALIAS

Vaibhav Bedia (3):
      ASoC: Davinci: Use resource_size() helper function
      ASoC: Davinci: Call clk_disable() and clk_put() in case of error
      ASoC: Davinci: Replace usage of IO_ADDRESS with ioremap()

Vinod Koul (10):
      ASoC: sn95031: Add jack support in the codec
      ASoC: mfld_machine: Add support for jack detection
      ASoC: sn95031: Add support for reading mic bias
      ASoC: add support for multiple jack types
      ASoC: mid-x86: Use the soc-jack apis for jack type detection
      ASoC: sn95031: make playback rails depend on actual pins they control
      ASoC: sn95031: fix the DMIC path routing
      ASoC: sn95031: fix the amic tlv scale
      ASoC: mfld_machine: make use of soc_register_card API
      ASoC: sst_platform: fix the pulseaudio error

 include/sound/soc.h               |   29 ++
 include/sound/wm8903.h            |   10 +-
 sound/soc/codecs/cx20442.c        |    2 +-
 sound/soc/codecs/sn95031.c        |  239 +++++++++++++++---
 sound/soc/codecs/sn95031.h        |   33 +++
 sound/soc/codecs/wm8903.c         |  514 ++++++++++++++++++++++++-------------
 sound/soc/codecs/wm8903.h         |    8 +
 sound/soc/codecs/wm8994.c         |  199 +++++++++++++-
 sound/soc/codecs/wm_hubs.c        |    3 +-
 sound/soc/davinci/davinci-i2s.c   |   28 ++-
 sound/soc/davinci/davinci-mcasp.c |   29 ++-
 sound/soc/mid-x86/mfld_machine.c  |  209 +++++++++++++--
 sound/soc/mid-x86/sst_platform.c  |    9 +
 sound/soc/soc-dapm.c              |   24 ++-
 sound/soc/soc-jack.c              |   56 ++++-
 sound/soc/tegra/harmony.c         |  103 +++++++-
 sound/soc/tegra/tegra_das.c       |    1 +
 sound/soc/tegra/tegra_i2s.c       |    1 +
 sound/soc/tegra/tegra_pcm.c       |    5 +-
 19 files changed, 1207 insertions(+), 295 deletions(-)
