From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Thu, 21 Oct 2010 13:45:32 -0700
Message-ID: <20101021204531.GA30466@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 30CFF1038C8
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 22:45:22 +0200 (CEST)
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

The following changes since commit f6765502f8daae3d237a394889276c8987f3e299:

  Revert "ASoC: Add max98088 CODEC driver" (2010-10-18 06:01:33 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-next

These have all been in -next for a few days, note that this isn't
for-2.6.37 - I may update with any extra fixes after sending this.

Jarkko Nikula (1):
      ASoC: Fix I2C component device id number creation

Jassi Brar (1):
      ASoC: WM8580: Remove useless assignment

Julia Lawall (1):
      ASoC: davinci-mcasp.c: Return error code in failure

Mark Brown (1):
      ASoC: Restore MAX98088 CODEC driver

 include/sound/max98088.h          |   50 +
 sound/soc/codecs/Kconfig          |    4 +
 sound/soc/codecs/Makefile         |    2 +
 sound/soc/codecs/max98088.c       | 2097 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/max98088.h       |  193 ++++
 sound/soc/codecs/wm8580.c         |    4 -
 sound/soc/davinci/davinci-mcasp.c |    2 +
 sound/soc/soc-core.c              |    2 +-
 8 files changed, 2349 insertions(+), 5 deletions(-)
 create mode 100644 include/sound/max98088.h
 create mode 100644 sound/soc/codecs/max98088.c
 create mode 100644 sound/soc/codecs/max98088.h
