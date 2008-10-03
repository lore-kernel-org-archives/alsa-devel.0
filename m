From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: More ASoC updates
Date: Fri, 3 Oct 2008 09:53:38 +0100
Message-ID: <20081003085338.GA8173@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 87C37246B1
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 10:53:39 +0200 (CEST)
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

The following changes since commit ddaea5119fd2efde7b3936d4ccfa34c4201be0d3:
  Takashi Iwai (1):
        Merge branch 'asoc-fixes' into topic/asoc

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

There's more to come on the TLV320AIC23 but at this point it's all
cleanups and it's much easier to review incremental patches.

Arun KS (3):
      ASoC: Add TLV320AIC23 codec driver
      ASoC: Add support for osk5912
      ASoC: Add DSP DAI format support to the OMAP McBSP driver

 sound/soc/codecs/Kconfig       |    5 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/tlv320aic23.c |  670 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic23.h |  122 ++++++++
 sound/soc/omap/Kconfig         |    8 +
 sound/soc/omap/Makefile        |    2 +
 sound/soc/omap/omap-mcbsp.c    |    5 +
 sound/soc/omap/osk5912.c       |  232 ++++++++++++++
 8 files changed, 1046 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320aic23.c
 create mode 100644 sound/soc/codecs/tlv320aic23.h
 create mode 100644 sound/soc/omap/osk5912.c
