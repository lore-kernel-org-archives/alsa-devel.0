From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates
Date: Fri, 10 Oct 2008 15:51:27 +0100
Message-ID: <20081010145127.GA15329@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 041C624767
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 16:51:46 +0200 (CEST)
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

The following changes since commit f79f27b5e79b9ae1e39d8376fd2ed956e3e02430:
  Takashi Iwai (1):
        ALSA: ASoC - clean up Kconfig for TLV320AIC2

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Jarkko Nikula (3):
      ASoC: OMAP: Add multilink support to McBSP DAI driver
      ASoC: OMAP: Add support for OMAP2430 and OMAP34xx in McBSP DAI driver
      ASoC: OMAP: Set DMA stream name at runtime in McBSP DAI driver

Mark Brown (1):
      ASoC: Make TLV320AIC26 user-visible

 sound/soc/codecs/Kconfig    |    2 +-
 sound/soc/omap/omap-mcbsp.c |  176 ++++++++++++++++++++++++++++++-------------
 sound/soc/omap/omap-mcbsp.h |   16 +++-
 3 files changed, 134 insertions(+), 60 deletions(-)
