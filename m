From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Thu, 25 Jun 2009 14:11:13 +0100
Message-ID: <20090625131113.GB17690@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D4F0103896
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 15:11:19 +0200 (CEST)
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

The following changes since commit 28d0325ce6e0a52f53d8af687e6427fee59004d3:
  Linus Torvalds (1):
        Linux 2.6.31-rc1

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Barry Song (1):
      ASoC: Blackfin: convert internal names from bf52x to bf5xx

Daniel Ribeiro (2):
      ASoC: Allow 32 bit registers for DAPM
      ASoC: remove duplicated code on pxa-ssp.c

Lopez Cruz, Misael (4):
      ASoC: Zoom2: Add machine driver for Zoom2 board
      ASoC: TWL4030: Fix voice interface clock masters
      ASoC: TWL4030: Add AVADC Clock Priority
      ASoC: TWL4030: Correct bypass event for voice sidetone

Mark Brown (21):
      ASoC: Sort DAPM power sequences while building lists
      ASoC: Factor out DAPM sequence execution
      ASoC: Coalesce register writes for DAPM sequences
      ASoC: Sort specialised mixers and muxes together
      ASoC: Coalesce power updates for DAPM widgets with events
      ASoC: Coalesce power updates for PGAs
      ASoC: Make DAPM power sequence lists local variables
      Merge branch 'dapm' into for-2.6.32
      ASoC: Add WM8961 driver
      ASoC: Automatically control WM8903 sloping stopband filter
      ASoC: Automatically manage WM8900 sloping stopband filter
      ASoC: Automatically manage WM8350 sloping stopband filter
      ASoC: Add stub suspend and resume calls for ASoC subdevices
      ASoC: Add suspend and resume callbacks to Wolfson CODEC drivers
      ASoC: Regulator support for WM8580
      ASoC: Fix shadowed variables in twl4030
      ASoC: Staticise put_twl4030_opmode_enum_double()
      Merge branch 'wm8961' into for-2.6.32
      ASoC: Add a shutdown callback
      ASoC: Add core suspend and resume callbacks to WM8961
      Merge branch 'for-2.6.31' into for-2.6.32

Peter Ujfalusi (1):
      MAINTAINERS: Add entry for twl4030 series soc codec driver

Philipp Zabel (1):
      ASoC: UDA1380: refactor device registration

 MAINTAINERS                        |    7 +
 include/sound/soc-dapm.h           |    1 +
 include/sound/soc.h                |   11 +-
 include/sound/uda1380.h            |   22 +
 sound/soc/blackfin/bf5xx-ad73311.c |   16 +-
 sound/soc/blackfin/bf5xx-ssm2602.c |   16 +-
 sound/soc/codecs/Kconfig           |    4 +
 sound/soc/codecs/Makefile          |    2 +
 sound/soc/codecs/twl4030.c         |   38 +-
 sound/soc/codecs/uda1380.c         |  313 +++++----
 sound/soc/codecs/uda1380.h         |    8 -
 sound/soc/codecs/wm8350.c          |   40 +-
 sound/soc/codecs/wm8400.c          |   17 +
 sound/soc/codecs/wm8580.c          |   55 ++-
 sound/soc/codecs/wm8731.c          |   39 ++
 sound/soc/codecs/wm8753.c          |   35 +
 sound/soc/codecs/wm8900.c          |   30 +-
 sound/soc/codecs/wm8903.c          |   27 +-
 sound/soc/codecs/wm8940.c          |   17 +
 sound/soc/codecs/wm8960.c          |   17 +
 sound/soc/codecs/wm8961.c          | 1326 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8961.h          |  866 +++++++++++++++++++++++
 sound/soc/codecs/wm8988.c          |   34 +
 sound/soc/codecs/wm9081.c          |   17 +
 sound/soc/omap/Kconfig             |    7 +
 sound/soc/omap/Makefile            |    2 +
 sound/soc/omap/sdp3430.c           |    2 +-
 sound/soc/omap/zoom2.c             |  301 ++++++++
 sound/soc/pxa/magician.c           |   54 +-
 sound/soc/pxa/pxa-ssp.c            |   50 +-
 sound/soc/soc-core.c               |   83 ++-
 sound/soc/soc-dapm.c               |  347 +++++++---
 32 files changed, 3452 insertions(+), 352 deletions(-)
 create mode 100644 include/sound/uda1380.h
 create mode 100644 sound/soc/codecs/wm8961.c
 create mode 100644 sound/soc/codecs/wm8961.h
 create mode 100644 sound/soc/omap/zoom2.c
