From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Wed, 18 Feb 2009 12:01:37 +0000
Message-ID: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D86D10388C
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:01:44 +0100 (CET)
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

The following changes since commit f1464ede550b8fda75086cb9bacf8d60fc9f6780:
  Takashi Iwai (1):
        Merge branch 'for-2.6.30' of git://git.kernel.org/.../broonie/sound-2.6 into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Kevin Hilman (1):
      ASoC: Fix DaVinci module unload error

Mark Brown (9):
      ASoC: Remove version display from the WM8731 driver
      ASoC: Clean up WM8731 bias level configuration
      ASoC: Improve diagnostics for AT91SAM9G20-EK probe
      ASoC: Check machine type before loading on AT91SAM9G20-EK
      ASoC: Actively manage MCLK for AT91SAM9G20-EK
      ASoC: Rename AT91SAMG20-EK for applications
      ASoC: Shuffle WM8731 SPI and I2C device registration
      ASoC: Refactor WM8731 device registration
      ASoC: Remove version display from the WM8753 driver

Paul Fertser (1):
      ASoC: Fix WM8753 DAIs unregistering

 sound/soc/atmel/sam9g20_wm8731.c   |  124 +++++++++++--
 sound/soc/codecs/wm8731.c          |  377 ++++++++++++++++--------------------
 sound/soc/codecs/wm8731.h          |    6 -
 sound/soc/codecs/wm8753.c          |    9 +-
 sound/soc/davinci/davinci-evm.c    |    3 +-
 sound/soc/davinci/davinci-sffsdr.c |    3 +-
 sound/soc/pxa/corgi.c              |   43 ++++-
 sound/soc/pxa/poodle.c             |   41 ++++-
 8 files changed, 361 insertions(+), 245 deletions(-)
