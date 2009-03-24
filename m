From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Tue, 24 Mar 2009 10:40:00 +0000
Message-ID: <20090324104000.GA29490@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E94681037F9
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 11:40:02 +0100 (CET)
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

The following changes since commit 1f2186951e02f2a5bcda9459f63136918932385a:
  Takashi Iwai (1):
        ALSA: Fix wrong pointer to dev_err() in arm/pxa2xx-ac97-lib.c

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Philipp Zabel (2):
      ASoC: pxa-ssp: Use 16-bit DMA for magician stereo
      ASoC: Add Magician machine support

 sound/soc/pxa/Kconfig    |   10 +
 sound/soc/pxa/Makefile   |    2 +
 sound/soc/pxa/magician.c |  560 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/pxa/pxa-ssp.c  |   12 +-
 4 files changed, 581 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/pxa/magician.c
