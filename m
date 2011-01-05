From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Wed, 5 Jan 2011 12:50:07 +0000
Message-ID: <20110105125007.GA3268@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21558103909
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 13:49:51 +0100 (CET)
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

The following changes since commit 644a98453d5764f467b73f2e02df0d2688da1873:

  fbdev: sh_mobile_hdmi: fixup compile error (2010-12-29 13:06:29 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Harsha Priya (1):
      ASoC: Fix the device references to codec and platform drivers

Jarkko Nikula (1):
      ASoC: Remove needless inclusion of tlv320aic3x.h from machine drivers

Kuninori Morimoto (1):
      ASoC: sh: fsi-da7210: remove unnecessary format settings

Mark Brown (2):
      ASoC: Change Samsung Kconfig from ASOC_ to SND_SOC_
      Merge branch 'for-2.6.37' into for-2.6.38

Maurus Cuelenaere (1):
      ASoC: Fix SmartQ compilation

 sound/soc/davinci/davinci-evm.c           |    1 -
 sound/soc/omap/n810.c                     |    1 -
 sound/soc/omap/rx51.c                     |    1 -
 sound/soc/s6000/s6105-ipcam.c             |    1 -
 sound/soc/samsung/Kconfig                 |   72 ++++++++++++++--------------
 sound/soc/samsung/Makefile                |   36 +++++++-------
 sound/soc/samsung/s3c24xx_simtec_hermes.c |    2 -
 sound/soc/sh/fsi-da7210.c                 |    2 +-
 sound/soc/soc-core.c                      |   14 +++---
 9 files changed, 62 insertions(+), 68 deletions(-)
