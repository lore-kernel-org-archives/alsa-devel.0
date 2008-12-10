From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/8] ASoC updates
Date: Wed, 10 Dec 2008 19:58:59 +0000
Message-ID: <20081210195858.GA4062@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEB39243BB
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 20:59:00 +0100 (CET)
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

The following changes since commit f73f2a6a23e34de9cca9672f727694e5af00e6c7:
  Takashi Iwai (1):
        ALSA: ASoC - Fix symbol conflicts in omac-mcbsp.c

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-tiwai

Mark Brown (5):
      ASoC: Work around warnings from some build environments
      ASoC: Add codec registration API
      ASoC: Convert WM8900 to do more work at I2C probe time
      ASoC: Convert WM8903 driver to register at I2C probe time
      ASoC: Stop WM8903 SYSCLK when suspending

Peter Ujfalusi (3):
      ASoC: TWL4030: Add missing Carkit output
      ASoC: TWL4030: Small cleanup
      ASoC: TWL4030: Change the name for the DACs

 include/sound/soc.h        |    5 +
 sound/soc/codecs/twl4030.c |   27 +++---
 sound/soc/codecs/wm8900.c  |  159 +++++++++++++++--------------
 sound/soc/codecs/wm8900.h  |    7 --
 sound/soc/codecs/wm8903.c  |  241 +++++++++++++++++++-------------------------
 sound/soc/codecs/wm8903.h  |    5 -
 sound/soc/soc-core.c       |   43 ++++++++
 7 files changed, 247 insertions(+), 240 deletions(-)
