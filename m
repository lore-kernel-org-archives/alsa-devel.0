From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4] ASoC updates for 2.6.31
Date: Mon, 15 Jun 2009 10:32:23 +0100
Message-ID: <20090615093223.GA30743@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C6301037FD
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 11:32:24 +0200 (CEST)
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

The following changes since commit 236e6723bedb483b2ebf73ada01e2c853c5cac01:
  Mark Brown (1):
        ASoC: Fix lm4857 control

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Mark Brown (3):
      ASoC: Remove odd bit clock ratios for WM8903
      ASoC: Revert duplicated code in SSM2602 driver
      ASoC: Instantiate any forgotten DAPM widgets

Philipp Zabel (1):
      ASoC: magician: fix PXA SSP clock polarity

 sound/soc/codecs/ssm2602.c |    4 ----
 sound/soc/codecs/wm8903.c  |    4 ----
 sound/soc/pxa/magician.c   |    2 +-
 sound/soc/soc-core.c       |    3 +++
 4 files changed, 4 insertions(+), 9 deletions(-)
