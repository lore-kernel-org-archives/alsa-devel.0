From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.6
Date: Fri, 14 Sep 2012 18:41:31 +0100
Message-ID: <20120914174131.GA4478@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4178E265D9D
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 19:41:34 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:

  Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.6

for you to fetch changes up to 985b11fa8064d55d0d5a84e68667434598911bb2:

  ASoC: wm8904: correct the index (2012-09-14 18:02:38 +0100)

----------------------------------------------------------------
ASoC: Updates for 3.6

A bigger set of updates than I'm entirely comfortable with - things
backed up a bit due to travel.  As ever the majority of these are small,
focused updates for specific drivers though there are a couple of core
changes.  There's been good exposure in -next.

The AT91 patch fixes a build break.

----------------------------------------------------------------
Bo Shen (1):
      ASoC: wm8904: correct the index

Dylan Reid (1):
      ASoC: samsung dma - Don't indicate support for pause/resume.

Fabio Estevam (1):
      ASoC: mc13783: Remove mono support

Heather Lomond (1):
      ASoC: arizona: Fix typo in 44.1kHz rates

Joachim Eastwood (1):
      ASoC: atmel-ssc: include linux/io.h for raw io

Julia Lawall (3):
      ASoC: imx-sgtl5000: fix error return code
      ASoC: ux500_msp_i2s: better use devm functions and fix error return code
      ASoC: am3517evm: fix error return code

Mark Brown (2):
      ASoC: dapm: Make sure we update the bias level for CODECs with no op
      ASoC: dapm: Don't force card bias level to be updated

Prasad Joshi (1):
      ASoC: spear: correct the check for NULL dma_buffer pointer

Stephen Warren (2):
      sound: tegra_alc5632: remove HP detect GPIO inversion
      ASoC: tegra: fix maxburst settings in dmaengine code

 include/linux/atmel-ssc.h       |    1 +
 sound/soc/codecs/arizona.c      |    2 +-
 sound/soc/codecs/mc13783.c      |    8 ++++----
 sound/soc/codecs/wm8904.c       |    2 +-
 sound/soc/fsl/imx-sgtl5000.c    |    2 +-
 sound/soc/omap/am3517evm.c      |    2 +-
 sound/soc/samsung/dma.c         |    8 +-------
 sound/soc/soc-dapm.c            |    5 ++++-
 sound/soc/spear/spear_pcm.c     |    2 +-
 sound/soc/tegra/tegra_alc5632.c |    1 -
 sound/soc/tegra/tegra_pcm.c     |    4 ++--
 sound/soc/ux500/ux500_msp_i2s.c |   25 +++++--------------------
 12 files changed, 22 insertions(+), 40 deletions(-)
