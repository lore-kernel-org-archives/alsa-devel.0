From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Thu, 23 Dec 2010 12:05:04 +0000
Message-ID: <20101223120502.GA14938@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B60D1038B9
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 13:04:53 +0100 (CET)
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

The following changes since commit 9d01df063e70260d6c0aabd58dd5507db151aa51:

  ASoC: don't pass the string as the format arguemtn for dev_info() (2010-12-22 14:08:40 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Dimitris Papastamos (1):
      ASoC: Add initial WM8995 driver

Mark Brown (4):
      ASoC: Use delayed work to debounce WM8350 jack IRQs
      ASoC: Trace Wolfson jack detection IRQs
      ASoC: Add jack IRQ trace to 88pm860x driver
      ASoC: ifdef out trace points from modules for x86

Seungwhan Youn (1):
      ASoC: SAMSUNG: Debug wrong parameter

 sound/soc/codecs/88pm860x-codec.c |    7 +
 sound/soc/codecs/Kconfig          |    4 +
 sound/soc/codecs/Makefile         |    2 +
 sound/soc/codecs/wm8350.c         |   71 +-
 sound/soc/codecs/wm8903.c         |    6 +
 sound/soc/codecs/wm8962.c         |    5 +
 sound/soc/codecs/wm8994.c         |    5 +
 sound/soc/codecs/wm8995.c         | 1818 ++++++++
 sound/soc/codecs/wm8995.h         | 8749 +++++++++++++++++++++++++++++++++++++
 sound/soc/samsung/goni_wm8994.c   |    2 +-
 10 files changed, 10649 insertions(+), 20 deletions(-)
 create mode 100644 sound/soc/codecs/wm8995.c
 create mode 100644 sound/soc/codecs/wm8995.h
