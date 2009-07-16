From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Thu, 16 Jul 2009 13:06:32 +0100
Message-ID: <20090716120632.GC26350@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7EAA810385C
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 14:06:33 +0200 (CEST)
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

The following changes since commit 4b75e9476737dffef44a66818a4a481edd2512a1:
  Mark Brown (1):
        ASoC: Error out if we can't determine a suitable WM9081 sysclk

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Barry Song (1):
      ASoC: new ad1938 codec driver based on asoc

Joonyoung Shim (3):
      ASoC: add SOC_DOUBLE_EXT_TLV control type
      ASoC: add SOC_DOUBLE_R_EXT_TLV control type
      ASoC: MAX9877: add MAX9877 amp driver

Kevin Hilman (1):
      ASoC: davinci: don't use clock names

 include/sound/soc.h               |   22 ++
 sound/soc/codecs/Kconfig          |    9 +
 sound/soc/codecs/Makefile         |    8 +
 sound/soc/codecs/ad1938.c         |  652 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ad1938.h         |  100 ++++++
 sound/soc/codecs/max9877.c        |  270 +++++++++++++++
 sound/soc/codecs/max9877.h        |   37 ++
 sound/soc/davinci/davinci-i2s.c   |    2 +-
 sound/soc/davinci/davinci-mcasp.c |    2 +-
 9 files changed, 1100 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/codecs/ad1938.c
 create mode 100644 sound/soc/codecs/ad1938.h
 create mode 100644 sound/soc/codecs/max9877.c
 create mode 100644 sound/soc/codecs/max9877.h
