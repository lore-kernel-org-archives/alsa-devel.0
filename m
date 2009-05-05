From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Tue, 5 May 2009 11:01:23 +0100
Message-ID: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8DC5224505
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:01:24 +0200 (CEST)
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

The following changes since commit 8560b9321f9050968f393ce1ec67e47c1a0bd5cf:
  Takashi Iwai (1):
        Merge branch 'fix/asoc' into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Jinyoung Park (1):
      ASoC: Fix errors in WM8990

Jonathan Cameron (1):
      ASoC: IMote2 ASoC Support

Lopez Cruz, Misael (2):
      ASoC: TWL4030: Add VDL analog bypass
      ASoC: TWL4030: Add voice digital loopback: sidetone

Mark Brown (15):
      ASoC: Fix error message formatting in s3c64xx-i2s driver
      ASoC: Check for supported CPUs when building s3c-i2s-v2
      ASoC: Make S3C64xx clock export function to return struct clk
      ASoC: Fix data format configuration for S3C64xx IISv2 and add 24 bit
      ASoC: Fix boot warnings from S3C IISv2
      ASoC: Allow use of resource from the platform device for S3C IISv2
      ASoC: Display the clock rate used as the basis for rate calculation
      ASoC: Display S3C IISv2 mode and MS errors by default
      ASoC: Staticise txctrl and rxctrl for S3C IISv2
      ASoC: Use platform device resource for S3C64xx IISv2
      ASoC: Use a shared define for AC97 CODEC data formats
      ASoC: Remove unused DAI format defines
      Merge commit 'takashi/topic/asoc' into for-2.6.31
      Merge branch 'for-2.6.30' into for-2.6.31
      ASoC: Remove redundant codec pointer from DAIs

Peter Ujfalusi (1):
      ASoC: TWL4030: Add VIBRA output

 include/sound/soc-dai.h         |   28 ++-------
 sound/soc/codecs/ac97.c         |    4 +-
 sound/soc/codecs/ad1980.c       |    4 +-
 sound/soc/codecs/twl4030.c      |  121 +++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/wm8990.c       |   40 +++++++-------
 sound/soc/codecs/wm9705.c       |    4 +-
 sound/soc/codecs/wm9712.c       |    6 +-
 sound/soc/codecs/wm9713.c       |    6 +-
 sound/soc/pxa/Kconfig           |    9 +++
 sound/soc/pxa/Makefile          |    2 +
 sound/soc/pxa/imote2.c          |  114 ++++++++++++++++++++++++++++++++++++
 sound/soc/s3c24xx/s3c-i2s-v2.c  |   87 ++++++++++++++++++++++++----
 sound/soc/s3c24xx/s3c64xx-i2s.c |   15 ++---
 sound/soc/s3c24xx/s3c64xx-i2s.h |    4 +-
 14 files changed, 362 insertions(+), 82 deletions(-)
 create mode 100644 sound/soc/pxa/imote2.c
