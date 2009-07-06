From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Mon, 6 Jul 2009 21:49:01 +0100
Message-ID: <20090706204900.GC4348@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BF6E244E4
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 22:49:07 +0200 (CEST)
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

The following changes since commit da9ff1f796e81976935407251815838bef9868d4:
  Mark Brown (1):
        ASoC: Only disable pxa2xx-i2s clocks if we enabled them

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Grant Likely (2):
      ASoC: Fix mpc5200-psc-ac97 to ensure the data ready bit is cleared
      ASoC: add locking to mpc5200-psc-ac97 driver

Lars-Peter Clausen (1):
      ASoC: Fix wm8753 register cache size and initialization

Mark Brown (1):
      ASoC: Fix register cache initialisation for WM8753

 sound/soc/codecs/wm8753.c        |    6 +++---
 sound/soc/fsl/mpc5200_dma.c      |    1 +
 sound/soc/fsl/mpc5200_dma.h      |    1 +
 sound/soc/fsl/mpc5200_psc_ac97.c |   17 ++++++++++++++++-
 4 files changed, 21 insertions(+), 4 deletions(-)
