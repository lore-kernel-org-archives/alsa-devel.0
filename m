From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Tue, 25 Aug 2009 11:09:04 +0100
Message-ID: <20090825100904.GB30000@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D82C2443E
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 12:09:05 +0200 (CEST)
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

The following changes since commit c6ea2af76ab79b82a0bfed313e4c2b68b10c2bc1:
  Takashi Iwai (1):
        ASoC: Remove unneeded inclusion of linux/regulator/consumer.h

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Janusz Krzysztofik (1):
      ARM: OMAP: DMA: Add support for DMA channel self linking on OMAP1510

Jarkko Nikula (3):
      OMAP: McBSP: Use textual values in DMA operating mode sysfs files
      ASoC: OMAP: Fix setup of XCCR and RCCR registers in McBSP DAI
      ARM: OMAP: McBSP: Merge two functions into omap_mcbsp_start/_stop

Mark Brown (4):
      ASoC: Add input and output AIF widgets
      ASoC: WM8993 digital mixing support
      ASoC: Select core DMA when building for S3C64xx
      Merge branch 'topic/digital-mixing' into for-2.6.32

 arch/arm/plat-omap/dma.c                |   10 +++
 arch/arm/plat-omap/include/mach/mcbsp.h |    2 -
 arch/arm/plat-omap/mcbsp.c              |  132 ++++++++++++------------------
 include/sound/soc-dapm.h                |    8 ++
 sound/soc/codecs/wm8993.c               |   88 ++++++++++++++++++++-
 sound/soc/omap/omap-mcbsp.c             |   13 +---
 sound/soc/s3c24xx/Kconfig               |    1 +
 sound/soc/soc-dapm.c                    |   58 ++++++++++----
 8 files changed, 199 insertions(+), 113 deletions(-)
