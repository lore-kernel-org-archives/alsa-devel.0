From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.32
Date: Mon, 13 Jul 2009 23:28:32 +0100
Message-ID: <20090713222832.GA30127@sirena.org.uk>
References: <20090710192542.GB5916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 73B242452C
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jul 2009 00:28:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090710192542.GB5916@sirena.org.uk>
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

The following changes since commit 942c435ba79fd263a922bb114d56eccab6250662:
  Mark Brown (1):
        ASoC: Add WM8993 CODEC driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Daniel Mack (1):
      ASoC: Fix NULL pointer dereference in __pxa2xx_pcm_hw_free

Kevin Hilman (2):
      ASoC: spdif codec: enable use by modules
      ASoC: spdif: set module licence to GPL

Mark Brown (7):
      ASoC: Limit WM8731 to symmetric rates
      ASoC: Use CODEC as clock master on AT91SAM9G20-EK
      ASoC: Disable microphone input for AT91SAM9G20-EK by default
      ASoC: Configure WM8731 SYSCLK at startup on AT91SAM9G20-EK
      ASoC: Add pop delay debug at end of DAPM sequencing
      ASoC: WM8510 has a single frame clock so needs symmetric rates
      Merge branch 'for-2.6.31' into for-2.6.32

Peter Meerwald (1):
      ASoC: fixes multiple typos in comments, no functional change

Roel Kluin (1):
      ASoC: Keep index within stac9766_reg[]

Rongrong Cao (1):
      ASoC: fix checking for external widgets bug

 include/sound/soc-dai.h              |   26 +++---
 sound/arm/pxa2xx-pcm-lib.c           |    2 +-
 sound/soc/atmel/sam9g20_wm8731.c     |  138 ++++++---------------------------
 sound/soc/codecs/spdif_transciever.c |    3 +
 sound/soc/codecs/stac9766.c          |    4 +-
 sound/soc/codecs/wm8510.c            |    1 +
 sound/soc/codecs/wm8731.c            |    1 +
 sound/soc/soc-dapm.c                 |    7 +-
 8 files changed, 51 insertions(+), 131 deletions(-)
