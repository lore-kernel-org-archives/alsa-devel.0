From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Wed, 8 Jul 2009 17:38:42 +0100
Message-ID: <20090708163842.GA2424@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8FF5724367
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 18:38:43 +0200 (CEST)
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

The following changes since commit 4ec5c9693b46ab34976511cd43bf75c3a0fc704d:
  Mark Brown (1):
        Merge branch 'for-2.6.31' into for-2.6.32

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Chaithrika U S (4):
      ASoC: Introduce platform driver model for dm644x, dm355
      ASoC: Add mcasp support for DM646x
      ASoC: Add machine driver support for DM646x
      ASoC: Minor fixes to DaVinci I2S probe function

Mark Brown (5):
      Merge branch 'davinci' into for-2.6.32
      ASoC: Add TLV information for WM8731
      ASoC: Correct WM8731 Mic Capture Switch control name
      ASoC: DaVinci I2S needs mach/asp.h
      ASoC: Add WM8993 CODEC driver

Troy Kisky (1):
      ASoC: DaVinci: pcm, don't play 1st sound period twice

 include/sound/wm8993.h            |   44 +
 sound/soc/codecs/Kconfig          |    4 +
 sound/soc/codecs/Makefile         |    2 +
 sound/soc/codecs/wm8731.c         |   17 +-
 sound/soc/codecs/wm8993.c         | 2203 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8993.h         | 2132 +++++++++++++++++++++++++++++++++++
 sound/soc/davinci/Kconfig         |   13 +
 sound/soc/davinci/Makefile        |    3 +
 sound/soc/davinci/davinci-evm.c   |  102 +-
 sound/soc/davinci/davinci-i2s.c   |  123 ++-
 sound/soc/davinci/davinci-mcasp.c |  874 +++++++++++++++
 sound/soc/davinci/davinci-mcasp.h |   55 +
 sound/soc/davinci/davinci-pcm.c   |    1 +
 sound/soc/davinci/davinci-pcm.h   |   18 +-
 14 files changed, 5473 insertions(+), 118 deletions(-)
 create mode 100644 include/sound/wm8993.h
 create mode 100644 sound/soc/codecs/wm8993.c
 create mode 100644 sound/soc/codecs/wm8993.h
 create mode 100644 sound/soc/davinci/davinci-mcasp.c
 create mode 100644 sound/soc/davinci/davinci-mcasp.h
