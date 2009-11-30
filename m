From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Mon, 30 Nov 2009 15:50:32 +0000
Message-ID: <20091130155032.GC18944@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D12824335
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 16:50:35 +0100 (CET)
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

The following changes since commit a22eaf4ce106404f6c5283da30b4d514ede964c1:
  Takashi Iwai (1):
        ASoC: Revert missing reset_err in wm97*.c

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Anuj Aggarwal (1):
      ASoC: AIC23: Fixing infinite loop in resume path

Daniel Mack (2):
      ALSA: ARM: add Raumfeld audio support
      ASoC: pxa/raumfeld: adopt new snd_soc_dai_set_pll() API

Kuninori Morimoto (2):
      sh: ms7724se: Add runtime PM support for FSI
      ASoC: sh: fsi: Add runtime PM support

Mark Brown (1):
      Merge branch 'for-2.6.32' into for-2.6.33

 arch/sh/boards/mach-se/7724/setup.c |    3 +
 sound/soc/codecs/tlv320aic23.c      |    3 +-
 sound/soc/pxa/Kconfig               |    9 +
 sound/soc/pxa/Makefile              |    2 +
 sound/soc/pxa/raumfeld.c            |  335 +++++++++++++++++++++++++++++++++++
 sound/soc/sh/fsi.c                  |   39 +++--
 6 files changed, 375 insertions(+), 16 deletions(-)
 create mode 100644 sound/soc/pxa/raumfeld.c
