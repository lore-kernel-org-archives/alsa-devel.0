From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/2] ASoC updates
Date: Fri, 5 Dec 2008 16:53:42 +0000
Message-ID: <20081205165341.GA21294@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 924E424179
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 17:53:43 +0100 (CET)
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

The following changes since commit 32c8dabc97d436582298ebd0e33af041c69f5a4b:
  Mark Brown (1):
        ASoC: Remove obsolete declaration of struct snd_soc_clock_info

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Daniel Mack (1):
      ASoC: tlv320aic3x: control additions and cleanups

Grazvydas Ignotas (1):
      ASoC: Add support for OMAP3 Pandora

 sound/soc/codecs/tlv320aic3x.c |   18 ++-
 sound/soc/omap/Kconfig         |    8 +
 sound/soc/omap/Makefile        |    2 +
 sound/soc/omap/omap3pandora.c  |  311 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 334 insertions(+), 5 deletions(-)
 create mode 100644 sound/soc/omap/omap3pandora.c
