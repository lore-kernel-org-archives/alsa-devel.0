From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Mon, 6 Jul 2009 22:42:31 +0100
Message-ID: <20090706214231.GD25548@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8341924533
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 23:42:37 +0200 (CEST)
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

The following changes since commit 2115d2c17369df4b70fd161623a40ce98c261989:
  Mark Brown (1):
        Merge branch 'for-2.6.31' into for-2.6.32

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Candelaria Villareal, Jorge (2):
      ASoC: TWL4030: Add EXTMUTE to reduce pop-noise effect
      ASoC: Zoom2: Update twl4030_setup_data parameters

Grant Likely (2):
      ASoC: Fix mpc5200-psc-ac97 to ensure the data ready bit is cleared
      ASoC: add locking to mpc5200-psc-ac97 driver

Lars-Peter Clausen (1):
      ASoC: Fix wm8753 register cache size and initialization

Lopez Cruz, Misael (1):
      ASoC: TWL4030: Add tristate callbacks for HiFi and Voice

Mark Brown (7):
      ASoC: Fix register cache initialisation for WM8753
      ASoC: Add CODEC volatile register operation
      ASoC: Fix leaks in WM8731 probe error handling
      ASoC: Fix WM8960 leaks on probe failure
      ASoC: Fix leaks in WM8988 registration error handling
      ASoC: Remove unused AK4535 hardware read functionality
      Merge branch 'for-2.6.31' into for-2.6.32

Troy Kisky (8):
      ASoC: DaVinci: i2s, remove MOD_REG_BIT macro
      ASoC: DaVinci: i2s toggle clock to complete reset
      ASoc: DaVinci: i2s, minor cleanup
      ASoC: DaVinci: i2s cleanup
      ASoC: DaVinci: i2s, only start sample generator if needed
      ASoC: DaVinci: i2s, minor cleanup of davinci_i2s_startup
      ASoC: DaVinci: i2s, fix mcbsp_word_length update
      ASoC: DaVinci: i2s, add davinci_i2s_prepare and shutdown

 include/sound/soc.h              |    2 +
 sound/soc/codecs/ak4535.c        |   16 ---
 sound/soc/codecs/twl4030.c       |   55 ++++++++++
 sound/soc/codecs/twl4030.h       |    2 +
 sound/soc/codecs/wm8731.c        |   17 ++-
 sound/soc/codecs/wm8753.c        |    6 +-
 sound/soc/codecs/wm8960.c        |   16 ++-
 sound/soc/codecs/wm8988.c        |    8 +-
 sound/soc/davinci/davinci-i2s.c  |  220 ++++++++++++++++++++++----------------
 sound/soc/fsl/mpc5200_dma.c      |    1 +
 sound/soc/fsl/mpc5200_dma.h      |    1 +
 sound/soc/fsl/mpc5200_psc_ac97.c |   17 +++-
 sound/soc/omap/zoom2.c           |   17 +++-
 sound/soc/soc-core.c             |   17 +++
 14 files changed, 268 insertions(+), 127 deletions(-)
