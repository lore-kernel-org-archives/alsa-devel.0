From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4] ASoC updates
Date: Thu, 18 Dec 2008 17:30:21 +0000
Message-ID: <20081218173021.GA25332@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CACA024473
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 18:30:22 +0100 (CET)
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

The following changes since commit 49d92c7d5bbd158734bc34ed578a68b214a48583:
  Stanley.Miao (1):
        ASoC: TWL4030: hands-free start-up sequence.

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-tiwai

Alexander Beregalov (1):
      ASoC: switch davinci DPRINTK to pr_debug()

Mark Brown (3):
      ASoC: Ease merge difficulties from new architectures
      ASoC: Complain if we fail to create DAPM controls
      ASoC: Add WM8350 AudioPlus codec driver

 include/linux/mfd/wm8350/audio.h |   38 +-
 sound/soc/Kconfig                |   10 +-
 sound/soc/Makefile               |   12 +-
 sound/soc/codecs/Kconfig         |    4 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/wm8350.c        | 1583 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8350.h        |   20 +
 sound/soc/davinci/davinci-pcm.c  |   18 +-
 sound/soc/soc-dapm.c             |    6 +-
 9 files changed, 1669 insertions(+), 24 deletions(-)
 create mode 100644 sound/soc/codecs/wm8350.c
 create mode 100644 sound/soc/codecs/wm8350.h
