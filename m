From: Mark Brown <broonie@sirena.org.uk>
Subject: ASoC updates for 2.6.31
Date: Thu, 23 Apr 2009 20:54:20 +0100
Message-ID: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 56973103805
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:54:27 +0200 (CEST)
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

The following changes since commit 9b5b0c01598f9782690b09ce6c49f4ba116dde44:
  Mark Brown (1):
        Merge branch 'for-2.6.30' into for-2.6.31

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Eric Miao (2):
      ASoC: simplify the SSP DMA parameters settings by run-time generation
      ASoC: change stereo/mono to 32-bit/16-bit for pxa-ssp

Joonyoung Shim (2):
      ASoC: OMAP: Add checking to detect bufferless pcms
      ASoC: TWL4030: Add VDL path support

Mark Brown (16):
      ASoC: Factor out generic widget power checks
      ASoC: Factor out DAPM power checks for DACs and ADCs
      ASoC: Make the DAPM power check an operation on the widget
      ASoC: Fix offset of freqmode in WM8580 PLL configuration
      ASoC: Fix WM8580 volume update handling for large register changes
      ASoC: Add power supply widget to DAPM
      ASoC: Use DAPM supply widget for WM8903 charge pump
      ASoC: Support CLK_DSP in WM8903
      ASoC: Optimise configuration of WM8903 DC servo
      ASoC: Actively manage the DC servo for WM8903
      ASoC: Remove redundant rate constraint for WM8903
      ASoC: Implement WM8903 digital sidetone support
      Merge commit 'takashi/fix/asoc' into for-2.6.30
      Merge branch 'for-2.6.30' into for-2.6.31
      ASoC: s3c-i2s-v2 needs to declare a license for modular builds
      Merge branch 'for-2.6.30' into for-2.6.31

Peter Ujfalusi (2):
      ASoC: OMAP: Add 4 channel support to mcbsp
      ASoC: TWL4030: Add 4 channel TDM support

Russell King - ARM Linux (1):
      ASoC: Fix warning in wm9705

Takashi Iwai (1):
      ASoC: remove non-existing referece to CONFIG_SND_SOC_CODEC_WM8991

 Documentation/sound/alsa/soc/dapm.txt |    1 +
 include/sound/soc-dapm.h              |    9 +-
 sound/soc/codecs/Makefile             |    1 -
 sound/soc/codecs/twl4030.c            |  308 +++++++++++++++++++--------------
 sound/soc/codecs/twl4030.h            |   11 ++
 sound/soc/codecs/wm8580.c             |   16 +-
 sound/soc/codecs/wm8903.c             |  118 ++++++++-----
 sound/soc/codecs/wm9705.c             |    2 +-
 sound/soc/omap/omap-mcbsp.c           |    5 +-
 sound/soc/omap/omap-pcm.c             |    9 +-
 sound/soc/pxa/pxa-ssp.c               |  203 +++++-----------------
 sound/soc/s3c24xx/s3c-i2s-v2.c        |    3 +-
 sound/soc/soc-dapm.c                  |  139 +++++++++++-----
 13 files changed, 438 insertions(+), 387 deletions(-)
