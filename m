From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.0
Date: Fri, 24 Jun 2011 11:34:23 +0100
Message-ID: <20110624103422.GA9483@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2BAD52412E
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 12:34:26 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 33195500edf260e8c8809ab9dfc67f50e0ce031f:

  ASoC: SAMSUNG: Fix the incorrect referencing of I2SCON register (2011-06-10 10:54:46 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.0

Arnaud Patard (2):
      ASoC: imx: Remove unused Kconfig SND_MXC_SOC_SSI entry
      ASoC: imx: add missing module informations

Daniel Mack (1):
      ASoC: pxa-ssp: Correct check for stream presence

Mark Brown (1):
      ASoC: Remove unused and about to be broken SND_SOC_CUSTOM I/O bus

 include/sound/soc.h             |    3 +--
 sound/soc/imx/Kconfig           |    7 -------
 sound/soc/imx/imx-pcm-dma-mx2.c |    2 ++
 sound/soc/imx/imx-ssi.c         |    2 +-
 sound/soc/pxa/pxa2xx-pcm.c      |    4 ++--
 sound/soc/soc-cache.c           |    3 ---
 6 files changed, 6 insertions(+), 15 deletions(-)
