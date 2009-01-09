From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.29
Date: Fri, 9 Jan 2009 11:33:36 +0000
Message-ID: <20090109113335.GA5170@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 849DF103814
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 12:33:37 +0100 (CET)
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

The following changes since commit 227b4dc6432d271eecd0ff0aefe6f0897ec47397:
  Mark Brown (1):
        ASoC: Fix SND_SOC_ALL_CODECS handling of dual SPI and I2C control buses

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.29

Peter Ujfalusi (3):
      ASoC: Merge the soc_value_enum to soc_enum struct
      ASoC: TWL4030: Change the soc_value_enum back to soc_enum
      ASoC: TWL4030: Module unloading fix

 include/sound/soc-dapm.h   |    2 +-
 include/sound/soc.h        |   15 +--------
 sound/soc/codecs/twl4030.c |   12 ++++---
 sound/soc/soc-core.c       |   37 +-------------------
 sound/soc/soc-dapm.c       |   80 +++-----------------------------------------
 5 files changed, 16 insertions(+), 130 deletions(-)
