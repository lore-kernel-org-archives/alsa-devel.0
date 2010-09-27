From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Sun, 26 Sep 2010 17:24:30 -0700
Message-ID: <20100927002429.GB10992@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E48F2460D
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 02:24:11 +0200 (CEST)
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
To: Takshi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 3e13f65e3aa51fc7009afc554683a0b182c057f5:

  ASoC: adapt multi-componentism again (2010-09-23 07:41:37 +0200)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Dimitris Papastamos (3):
      ASoC: Delegate to hw specific read for volatile registers
      ASoC: Fix incorrect parameter to snd_soc_codec_volatile_register
      ASoC: WM8985: Remove unneeded declaration.

Mark Brown (8):
      ASoC: Remove unneeded WM9713 header include from SMDK WM9713 driver
      ASoC: Clarify naming for SMDK WM9713 driver
      ASoC: Clean up the CODEC device as well as the board for SMDK WM9713
      ASoC: Convert s3c-ac97 to pr_() macros
      ASoC: Add debug logging for s3c-ac97 resets
      ASoC: Clean up AC'97 glue driver
      ASoC: Add Jassi Brar as Samsung maintainer
      Merge branch 'for-2.6.36' into for-2.6.37

 MAINTAINERS                     |    6 +++
 sound/soc/codecs/ac97.c         |   14 +++-----
 sound/soc/codecs/wm8985.c       |    2 -
 sound/soc/s3c24xx/s3c-ac97.c    |   14 +++++---
 sound/soc/s3c24xx/smdk_wm9713.c |    4 +-
 sound/soc/soc-cache.c           |   76 +++++++++++++++++++++++++-------------
 6 files changed, 72 insertions(+), 44 deletions(-)
