From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.40
Date: Thu, 26 May 2011 23:43:31 +0800
Message-ID: <20110526154330.GB19721@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F27A4103AD6
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 17:43:34 +0200 (CEST)
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

The following changes since commit de0853c000aa3b5c9983d066c137e5dc9c8355a0:

  Merge branch 'topic/asoc' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6 into for-2.6.40 (2011-05-22 10:31:51 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.40

These are all small, targetted fixes or just plain trivial.

Axel Lin (1):
      ASoC: wm1250-ev1: Define "WM1250 Output" with SND_SOC_DAPM_OUTPUT

Daniel Mack (1):
      ASoC: fix raumfeld platform

Jarkko Nikula (1):
      ASoC: Fix power down for widgetless per-card DAPM context case

Jesper Juhl (1):
      ASoC: Remove duplicate linux/delay.h inclusion.

Liam Girdwood (2):
      ASoC: core - fix module reference counting for CPU DAIs
      ASoC: core - remove superfluous new line.

Nicolas Ferre (2):
      ASoC: wm8731: fix wm8731_check_osc() connected condition
      ASoC: sam9g20_wm8731: use the proper SYSCKL value

 sound/soc/atmel/sam9g20_wm8731.c |    2 +-
 sound/soc/codecs/wm1250-ev1.c    |    2 +-
 sound/soc/codecs/wm8731.c        |    2 +-
 sound/soc/codecs/wm8915.c        |    1 -
 sound/soc/pxa/raumfeld.c         |   92 ++++++++++++++++++++++++--------------
 sound/soc/soc-core.c             |    8 ++--
 sound/soc/soc-dapm.c             |    2 +-
 7 files changed, 66 insertions(+), 43 deletions(-)
