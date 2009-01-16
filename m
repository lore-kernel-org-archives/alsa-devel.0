From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Fri, 16 Jan 2009 17:13:47 +0000
Message-ID: <20090116171347.GA1912@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 77CBF24395
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 18:13:48 +0100 (CET)
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

The following changes since commit c0106d72b8d71696dbe9dc80e2c77d4ac63f7531:
  Takashi Iwai (1):
        Merge branch 'topic/asoc' into next/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Ben Nizette (1):
      ASoC: atmel_pcm: Remove non-existant header

Hugo Villeneuve (1):
      ASoC: DaVinci: Fix SFFSDR compilation error.

Ian Molton (3):
      ASoC: Driver for the WM9705 AC97 codec.
      ASoC: machine driver for Toshiba e750
      ASoC: machine driver for Toshiba e800

Mark Brown (1):
      Merge branch 'for-2.6.29' into for-2.6.30

 arch/arm/mach-pxa/e750.c                      |    5 +
 arch/arm/mach-pxa/include/mach/eseries-gpio.h |   10 +
 sound/soc/atmel/atmel-pcm.c                   |    2 -
 sound/soc/codecs/Kconfig                      |    4 +
 sound/soc/codecs/Makefile                     |    3 +
 sound/soc/codecs/wm9705.c                     |  410 +++++++++++++++++++++++++
 sound/soc/codecs/wm9705.h                     |   14 +
 sound/soc/davinci/davinci-sffsdr.c            |   20 +-
 sound/soc/pxa/Kconfig                         |    9 +
 sound/soc/pxa/Makefile                        |    2 +
 sound/soc/pxa/e750_wm9705.c                   |  189 ++++++++++++
 sound/soc/pxa/e800_wm9712.c                   |  116 ++++++-
 12 files changed, 765 insertions(+), 19 deletions(-)
 create mode 100644 sound/soc/codecs/wm9705.c
 create mode 100644 sound/soc/codecs/wm9705.h
 create mode 100644 sound/soc/pxa/e750_wm9705.c
