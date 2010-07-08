From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.36
Date: Fri, 9 Jul 2010 08:56:19 +0900
Message-ID: <20100708235618.GA17755@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 476A41038E2
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jul 2010 01:56:43 +0200 (CEST)
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

The following changes since commit db059c0f6edec0b1deba665e5853f4ed829003b7:

  ASoC: Automatically manage ALC coefficients for WM8960 (2010-07-06 08:46:10 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.36

Mark Brown (2):
      ASoC: Include WM8994 GPIO and interrupt registers in codec_reg
      ASoC: Implement WM8994 OPCLK support

Maurus Cuelenaere (1):
      ASoC: Invert speaker enabling behaviour in SmartQ sound driver

Raffaele Recalcati (3):
      ASoC: DaVinci: Added two clocking possibilities to McBSP (I2S)
      ASoC: DaVinci: Added selection of clk input pin for McBSP
      ASoC: DaVinci: More accurate continuous serial clock for McBSP (I2S)

 arch/arm/mach-davinci/include/mach/asp.h |   48 +++++++++
 sound/soc/codecs/wm8994.c                |   43 +++++++++
 sound/soc/codecs/wm8994.h                |    3 +
 sound/soc/davinci/davinci-i2s.c          |  153 +++++++++++++++++++++++++++---
 sound/soc/davinci/davinci-i2s.h          |    5 +
 sound/soc/s3c24xx/smartq_wm8987.c        |    1 -
 6 files changed, 238 insertions(+), 15 deletions(-)
