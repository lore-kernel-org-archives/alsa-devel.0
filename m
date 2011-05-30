From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Mon, 30 May 2011 11:20:52 +0800
Message-ID: <20110530032051.GC4130@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C39481037E3
	for <alsa-devel@alsa-project.org>;
	Mon, 30 May 2011 05:20:57 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit 55922c9d1b84b89cb946c777fddccb3247e7df2c:

  Linux 3.0-rc1 (2011-05-29 17:43:36 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.41

Axel Lin (1):
      ASoC: Remove redundant freq assignment for max98095->sysclk/max98088->sysclk

Ben Gardiner (7):
      ASoC: davinci-pcm: trivial: make ping-pong params setup symmetrical
      ASoC: davinci-pcm: expand the .formats
      ASoC: davinci-pcm: increase the maximum channels
      ASoC: davinci-pcm: fix audible glitch on 2nd ping-pong playback
      ASoC: davinci-pcm: extract period elapsed functions
      ASoC: davinci-pcm: convert to BATCH mode
      ASoC: davinci-pcm: comments for the conversion to BATCH mode

Daniel Mack (1):
      ASoC: Fix comment in cs4270 codec driver

Dimitris Papastamos (2):
      ASoC: soc-cache: Block based rbtree compression
      ASoC: soc-cache: Cache a pointer to the last accessed rbnode

Kuninori Morimoto (9):
      ASoC: sh: fsi: tidyup parameter of fsi_stream_push
      ASoC: sh: fsi: add fsi_set_master_clk
      ASoC: sh: fsi: irq control moves to fsi_port_start/stop
      ASoC: sh: fsi: tidyup unclear variable naming
      ASoC: sh: fsi: remove pm_runtime from fsi_dai_set_fmt.
      ASoC: sh: fsi: make sure fsi_stream_push/pop access by spin lock
      ASoC: sh: fsi: remove fsi_module_init/kill
      ASoC: sh: fsi: cleanup suspend/resume
      ASoC: sh: fsi: add fsi_hw_startup/shutdown

Mark Brown (6):
      ASoC: Convert 16x16 write to use cpu_to_be16()
      ASoC: Convert 7x9 write to use cpu_to_be16()
      ASoC: Use cpu_to_be16() in 8x16 write
      ASoC: Use explicit endianness conversion in snd_soc_16_8_write()
      ASoC: Fix wm_hubs input PGA ZC bits
      Merge branch 'for-2.6.40' into for-2.6.41

Nicolas Ferre (3):
      ASoC: trivial: typo in debug comment
      ASoC: trivial: typo in atmel_pcm_dma_params strucutre comment
      ASoC: atmel_ssc_dai: fix ssc error path

Stephen Warren (3):
      ASoC: core: Don't schedule deferred_resume_work twice
      ASoC: Fix dapm_is_shared_kcontrol so everything isn't shared
      ASoC: Tegra: Enable Kaen HP_MUTE at boot

 sound/soc/atmel/atmel-pcm.c     |    2 +-
 sound/soc/atmel/atmel-pcm.h     |    2 +-
 sound/soc/atmel/atmel_ssc_dai.c |    4 +-
 sound/soc/codecs/cs4270.c       |    5 +-
 sound/soc/codecs/max98088.c     |    2 -
 sound/soc/codecs/max98095.c     |    2 -
 sound/soc/codecs/wm_hubs.c      |    8 +-
 sound/soc/davinci/davinci-pcm.c |  148 ++++++-----
 sound/soc/sh/fsi.c              |  576 ++++++++++++++++++++-------------------
 sound/soc/soc-cache.c           |  294 +++++++++++++++-----
 sound/soc/soc-core.c            |   19 +-
 sound/soc/soc-dapm.c            |    5 +-
 sound/soc/tegra/tegra_wm8903.c  |    2 +-
 13 files changed, 629 insertions(+), 440 deletions(-)
