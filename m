From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Thu, 22 Apr 2010 09:16:14 +0900
Message-ID: <20100422001613.GA23286@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DAC09243AC
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 02:16:08 +0200 (CEST)
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

The following changes since commit d4a8ca246146099e9068fc87cd2bc565896bc186:
  Takashi Iwai (1):
        ASoC: missing conversions to snd_soc_codec_*_drvdata()

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Mark Brown (4):
      ASoC: Support FLL input clock selection on WM8994
      ASoC: Set full range of WM8994 FLL Fratio values
      ASoC: Tone down debugging for WM8994 class W
      ASoC: Allow unspecified source when stopping WM8994 FLLs

Phil Carmody (1):
      ASoC: da7210: Fencepost error in reg cache read

 sound/soc/codecs/da7210.c |    2 +-
 sound/soc/codecs/wm8994.c |   47 +++++++++++++++++++++++++++++++++++---------
 sound/soc/codecs/wm8994.h |    5 ++++
 3 files changed, 43 insertions(+), 11 deletions(-)
