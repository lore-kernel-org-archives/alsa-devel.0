From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/8] ASoC updates for next
Date: Thu, 30 Oct 2008 15:57:18 +0000
Message-ID: <20081030155718.GA1418@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6B1D32448A
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 16:57:20 +0100 (CET)
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

The following changes since commit 15ad9a531a64d46af54839ab13542a81ad4c82a5:
  Takashi Iwai (1):
        Merge branch 'topic/fix/asoc' into topic/asoc

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Mark Brown (6):
      ASoC: Fix handling of DAPM suspend work
      ASoC: Convert core to use standard debug print macros
      ASoC: Remove DAPM restriction on mixer control name lengths
      ASoC: Add PXA SSP support
      ASoC: Do a warm reset after cold when resetting the WM9713
      ASoC: Use finer grained dependencies in SND_SOC_ALL_CODECS

Timur Tabi (1):
      ASoC: Disable automatic volume control in the CS4270 sound driver

Troy Kisky (1):
      ASoC: Allow setting codec register with debugfs filesystem

 include/sound/soc.h       |    4 +
 sound/soc/codecs/Kconfig  |   44 ++-
 sound/soc/codecs/cs4270.c |   13 +
 sound/soc/codecs/wm9713.c |    2 +
 sound/soc/pxa/Kconfig     |   13 +
 sound/soc/pxa/Makefile    |    2 +
 sound/soc/pxa/pxa-ssp.c   |  929 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/pxa/pxa-ssp.h   |   47 +++
 sound/soc/soc-core.c      |  207 ++++++++---
 sound/soc/soc-dapm.c      |   44 +--
 10 files changed, 1200 insertions(+), 105 deletions(-)
 create mode 100644 sound/soc/pxa/pxa-ssp.c
 create mode 100644 sound/soc/pxa/pxa-ssp.h
