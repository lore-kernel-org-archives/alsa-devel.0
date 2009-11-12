From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Thu, 12 Nov 2009 16:55:18 +0000
Message-ID: <20091112165518.GA28862@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 937C1103800
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 17:55:20 +0100 (CET)
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

The following changes since commit a68cc8daebdd8ba7fe457ab4b2a0ccdf3cedc9f8:
  Grant Likely (1):
        ASoC: mpc5200: remove duplicate identical IRQ handler

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Barry Song (1):
      ASoC: move setting ac97 platformdata earlier than ac97 read/write

Jassi Brar (1):
      ASoC: Fixed arguments passed to SMDK64xx set_pll

Joonyoung Shim (1):
      ASoC: Add jack_status_check callback function for GPIO jacks

Mark Brown (1):
      ASoC: Add bit clock rate calculator utility functions

 include/sound/soc.h                 |    7 ++++
 sound/soc/Makefile                  |    2 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c |    2 +-
 sound/soc/soc-core.c                |    9 +++--
 sound/soc/soc-jack.c                |    3 ++
 sound/soc/soc-utils.c               |   68 +++++++++++++++++++++++++++++++++++
 6 files changed, 85 insertions(+), 6 deletions(-)
 create mode 100644 sound/soc/soc-utils.c
