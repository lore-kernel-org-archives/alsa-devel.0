From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Mon, 25 Jul 2011 08:05:34 +0100
Message-ID: <20110725070534.GA10566@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D15E624353
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jul 2011 09:05:36 +0200 (CEST)
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

The following changes since commit 440085598672c0e3fde8a48495f61fea418b06d1:

  Merge branch 'for-3.0' into for-3.1 (2011-07-17 18:25:58 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.1

Sorry, I thought I'd sent this out and then the release caught me on the
hop a bit.  Apart from Liam's changes and the new driver these are all
bug fixes of one form or another - the sgtl5000 driver apparently just
didn't work most of the time.

Liam Girdwood (2):
      ASoC: dapm - add DAPM macro for external enum widgets
      ASoC: dapm - Add methods to retrieve snd_card and soc_card from dapm context.

Mark Brown (3):
      ASoC: Mark cache as dirty when suspending
      ASoC: Acknowledge WM8962 interrupts before acting on them
      ASoC: Revert "ASoC: SAMSUNG: Add I2S0 internal dma driver"

Rajashekhara, Sudhakar (2):
      ASoC: davinci: fix codec start and stop functions
      ASoC: davinci: add missing break statement

Sangbeom Kim (2):
      ASoC: SAMSUNG: Modify I2S driver to support idma
      ASoC: SAMSUNG: Add I2S0 internal dma driver

Wolfram Sang (3):
      ASoC: core: make comments fit the code
      ASoC: sgtl5000: refactor registering internal ldo
      ASoC: sgtl5000: guide user when regulator support is needed

 include/sound/soc-dapm.h         |    6 +++
 sound/soc/codecs/sgtl5000.c      |   70 +++++++++++++++++--------------------
 sound/soc/codecs/wm8962.c        |    6 ++--
 sound/soc/davinci/davinci-vcif.c |    9 +++--
 sound/soc/samsung/i2s.c          |    7 ++++
 sound/soc/soc-core.c             |    5 ++-
 sound/soc/soc-dapm.c             |   30 ++++++++++++++++
 7 files changed, 86 insertions(+), 47 deletions(-)
