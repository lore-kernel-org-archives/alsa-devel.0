From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v2.6.29
Date: Tue, 6 Jan 2009 14:58:37 +0000
Message-ID: <20090106145837.GB12803@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00F6E1037F4
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2009 15:58:38 +0100 (CET)
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

The following changes since commit 2f42357722f7ddc1ec0236fa55ad49ea8a7ce4b0:
  Peter Ujfalusi (1):
        ASoC: TWL4030: Convert the bitfield enums to VALUE_ENUM type

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-tiwai

Mark Brown (2):
      ASoC: Use snd_soc_dapm_nc_pin() in at91sam9g20ek
      ASoC: Fix SND_SOC_ALL_CODECS handling of dual SPI and I2C control buses

 sound/soc/atmel/sam9g20_wm8731.c |    4 ++--
 sound/soc/codecs/Kconfig         |   20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 7 deletions(-)
