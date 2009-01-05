From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates
Date: Mon, 5 Jan 2009 17:56:34 +0000
Message-ID: <20090105175633.GA24696@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EEF4E10380B
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 18:56:34 +0100 (CET)
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

The following changes since commit cad9d90ec3f6c497dce2b163046436b6ab5cf6b6:
  Takashi Iwai (1):
        Merge branch 'fixes' of git://git.kernel.org/.../broonie/sound-2.6 into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-tiwai

David Brownell (1):
      ASoC: Clocking fixes for davinci-evm.c

Dmitry Baryshkov (1):
      pxa2xx-ac97: switch AC unit to correct state before probing

Grazvydas Ignotas (1):
      ASoC: Mark non-connected TWL4030 pins for pandora

Jarkko Nikula (1):
      ASoC: OMAP: Select OMAP pin multiplexing when using Nokia N810 ASoC drivers

Peter Ujfalusi (2):
      ASoC: New enum type: value_enum
      ASoC: TWL4030: Convert the bitfield enums to VALUE_ENUM type

 include/sound/soc-dapm.h        |   15 +++
 include/sound/soc.h             |   30 ++++++
 sound/arm/pxa2xx-ac97-lib.c     |   25 +++--
 sound/soc/codecs/twl4030.c      |  118 +++++++++++-------------
 sound/soc/davinci/davinci-evm.c |   19 +++-
 sound/soc/omap/Kconfig          |    1 +
 sound/soc/omap/omap3pandora.c   |   13 +++
 sound/soc/soc-core.c            |  107 +++++++++++++++++++++
 sound/soc/soc-dapm.c            |  197 ++++++++++++++++++++++++++++++++++++++-
 9 files changed, 447 insertions(+), 78 deletions(-)
