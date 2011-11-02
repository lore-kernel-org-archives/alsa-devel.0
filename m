From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.2
Date: Wed, 2 Nov 2011 11:50:43 +0000
Message-ID: <20111102115043.GB2678@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BF2CB24368
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 12:50:45 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 5927f94700e860ae27ff24e7f3bc9e4f7b9922eb:

  ASoC: wm8940: Properly set codec->dapm.bias_level (2011-10-27 09:17:08 +0200)

are available in the git repository at:
  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.2

The usual connection of small, local fixes to specific drivers.

Axel Lin (5):
      ASoC: wm8940: Fix mask for setting BCLKDIV
      ASoC: tlv320aic23: Clear TLV320AIC23_MS_MASTER bit for slave mode
      ASoC: tlv320aic3x: Clear BIT_CLK_MASTER and WORD_CLK_MASTER bits for for slave mode
      ASoC: wm8711: Fix wrong mask for setting input audio data bit length select
      ASoC: Leave input audio data bit length settings untouched in wm8711_set_dai_fmt

Hong Xu (1):
      ASoC: WM8904: Set `invert' bit for Capture Switch

Mark Brown (4):
      ASoC: Fix return value of wm5100_gpio_direction_out()
      ASoC: Ensure WM8962 PLL registers are reset
      ASoC: Ensure the WM8962 oscillator and PLLs start up disabled
      ASoC: Ensure we always delay for WM8962 FLL when starting from SYSCLK

 sound/soc/codecs/tlv320aic23.c |    1 +
 sound/soc/codecs/tlv320aic3x.c |    1 +
 sound/soc/codecs/wm5100.c      |   12 ++++++++----
 sound/soc/codecs/wm8711.c      |    4 ++--
 sound/soc/codecs/wm8904.c      |    2 +-
 sound/soc/codecs/wm8940.c      |    2 +-
 sound/soc/codecs/wm8962.c      |   30 ++++++++++++++++++++----------
 7 files changed, 34 insertions(+), 18 deletions(-)
