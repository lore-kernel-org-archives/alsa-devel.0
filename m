From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Wed, 19 Aug 2009 16:20:38 +0100
Message-ID: <20090819152038.GC3323@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC7D124484
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 17:20:39 +0200 (CEST)
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

The following changes since commit d3c9e9a1390f8a34da8b69e09fa1afa90f5067f4:
  Mark Brown (1):
        ASoC: Implement TDM configuration for WM8993

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Joonyoung Shim (1):
      ASoC: Fix data format configuration for S3C64XX IISv2

Mark Brown (3):
      ASoC: Reenable S3C64xx I2S support
      ASoC: Remove duplicate ADC/DAC widgets from wm_hubs.c
      ASoC: Provide default set_bias_level() implementation

 arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h |    5 +++++
 sound/soc/codecs/wm_hubs.c                        |    6 ------
 sound/soc/s3c24xx/Kconfig                         |    2 +-
 sound/soc/s3c24xx/s3c-i2s-v2.c                    |    6 +++---
 sound/soc/soc-dapm.c                              |    8 ++++++--
 5 files changed, 15 insertions(+), 12 deletions(-)
