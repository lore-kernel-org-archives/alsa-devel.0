From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Tue, 14 Dec 2010 18:38:22 +0000
Message-ID: <20101214183822.GE13644@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D6C62103838
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 19:38:23 +0100 (CET)
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

The following changes since commit fdea0571ddca8e3f22448f66d72a034575abea28:

  ASoC: Fix merge errors with flush_scheduled_work() removal (2010-12-13 12:58:59 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Dimitris Papastamos (1):
      ASoC: soc-cache: A few minor stylistic changes

Jarkko Nikula (2):
      ASoC: Fix bias power down of non-DAPM codec
      ASoC: Fix build error caused by merging a fix for 2.6.37 into 2.6.38

Mario Becroft (1):
      ASoC: Optimise WM9081 FLL performance

Mark Brown (11):
      ASoC: Implement WM8994/58 DAC and ADC oversampling control
      ASoC: Implement WM8903 high pass filter support
      ASoC: Implement WM8903 oversampling rate controls
      ASoC: Remove open coded symmetry implementation from WM8903
      ASoC: Automatically manage WM8903 deemphasis rate
      ASoC: Fix widgets for WM8994/58 AIF2 source control
      Merge branch 'topic/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-2.6.38
      Merge branch 'for-2.6.37' into for-2.6.38
      ASoC: Fix AC'97 registration unwind
      regulator: Update LDO2 for WM8958
      ASoC: Explicitly clear WM8993 ramp controls on power down

Olaya, Margarita (1):
      ASoC: dapm: Add output driver widget

Vasily Khoruzhick (1):
      ASoC: Add HP iPAQ H1940 support

 drivers/regulator/wm8994-regulator.c |   23 +++-
 include/sound/soc-dapm.h             |   10 ++
 sound/soc/codecs/wm8903.c            |  182 +++++++++++----------
 sound/soc/codecs/wm8993.c            |    6 +
 sound/soc/codecs/wm8994.c            |   21 ++-
 sound/soc/codecs/wm9081.c            |    4 +
 sound/soc/samsung/Kconfig            |    8 +
 sound/soc/samsung/Makefile           |    2 +
 sound/soc/samsung/h1940_uda1380.c    |  296 ++++++++++++++++++++++++++++++++++
 sound/soc/soc-cache.c                |   14 +-
 sound/soc/soc-core.c                 |    2 +-
 sound/soc/soc-dapm.c                 |    9 +
 12 files changed, 477 insertions(+), 100 deletions(-)
 create mode 100644 sound/soc/samsung/h1940_uda1380.c
