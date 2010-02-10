From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Wed, 10 Feb 2010 11:35:26 +0000
Message-ID: <20100210113526.GA4901@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A48EC24453
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 12:35:24 +0100 (CET)
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
To: Takashi Iwai <tiawi@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit c50749de02f272be6e09b9016e13a17307d29066:
  Grazvydas Ignotas (1):
        ASoC: pandora: Add DAC regulator support

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Daniel Mack (1):
      ASoC: cs4270: enable regulators at probe time

Mark Brown (1):
      ASoC: add phycore-ac97 sound support

Paul Menzel (1):
      ASoC: Typo. s/Freecale/Freescale/

Peter Ujfalusi (1):
      ASoC: TWL4030: Add supply for audio serial interface control

 sound/soc/codecs/cs4270.c    |   10 +++++
 sound/soc/codecs/twl4030.c   |   14 ++++++-
 sound/soc/imx/Kconfig        |    2 +-
 sound/soc/imx/Makefile       |    2 +
 sound/soc/imx/phycore-ac97.c |   90 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/imx/phycore-ac97.c
