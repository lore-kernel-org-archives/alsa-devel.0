From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Mon, 26 Apr 2010 16:16:53 +0100
Message-ID: <20100426151653.GA366@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 37553245A4
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 17:16:56 +0200 (CEST)
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

The following changes since commit 7add84aa779b4f7ca39484a82a11e01d7acd4dca:
  Mark Brown (1):
        ASoC: Allow unspecified source when stopping WM8994 FLLs

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Barry Song (2):
      ASoC: ad193x: fix wrong register setting in ad193x_set_dai_fmt
      ASoC: ad193x: fix typo, delete redundant space

Mark Brown (3):
      ASoC: Allow reporting of NULL jacks
      ASoC: Correct inversion of speaker mixer PCM switch
      ASoC: Warn on low WM8994 AIFCLK

Vladimir Zapolskiy (1):
      ASoC: UDA134X: Add UDA1345 CODEC support

 include/sound/uda134x.h    |    1 +
 sound/soc/codecs/ad193x.c  |   56 ++++++++++++++++++++++---------------------
 sound/soc/codecs/uda134x.c |   13 ++++++++++
 sound/soc/codecs/wm8974.c  |    2 +-
 sound/soc/codecs/wm8994.c  |    5 ++++
 sound/soc/soc-jack.c       |    5 +--
 6 files changed, 51 insertions(+), 31 deletions(-)
