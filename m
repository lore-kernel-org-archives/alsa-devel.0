From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Mon, 9 Feb 2009 11:20:05 +0000
Message-ID: <20090209112004.GB14843@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B8A7F103800
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 12:20:18 +0100 (CET)
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

The following changes since commit 0664678a84c653bde844c7d91646259a25c6188b:
  Philipp Zabel (1):
        ASoC: pxa-ssp: fix SSP port request

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Eero Nurkkala (1):
      ASoC: TLV320AIC3X: Fix kcontrol's private value use in put callback

Jarkko Nikula (1):
      ASoC: WM8990: Fix kcontrol's private value use in put callback

Mark Brown (1):
      Merge branch 'for-2.6.29' into for-2.6.30

Mike Frysinger (2):
      ASoC: Blackfin: cleanup sport handling in ASoC Blackfin AC97 code
      ASoC: Blackfin: drop unnecessary dma casts

Philipp Zabel (3):
      pxa/h5000: Setup I2S pins for pxa2xx-i2s
      pxa/spitz: Setup I2S pins for pxa2xx-i2s
      ASoC: pxa2xx-i2s: remove I2S pin setup

Robert Jarzmik (1):
      ASoC: Add initial support of Mitac mioa701 device SoC.

Roel Kluin (1):
      ASoC: count reaches 10001, not 10000.

Timur Tabi (1):
      ASoC: optimize init sequence of Freescale MPC8610 sound drivers

 arch/arm/mach-pxa/h5000.c          |    7 +
 arch/arm/mach-pxa/spitz.c          |    6 +
 sound/soc/blackfin/bf5xx-ac97.c    |   92 +++++---------
 sound/soc/blackfin/bf5xx-ad73311.c |    4 +-
 sound/soc/blackfin/bf5xx-sport.c   |  104 ++++++---------
 sound/soc/codecs/tlv320aic3x.c     |   11 +-
 sound/soc/codecs/wm8990.c          |    4 +-
 sound/soc/fsl/fsl_dma.c            |  178 ++++++++++++-------------
 sound/soc/fsl/fsl_ssi.c            |   19 ++--
 sound/soc/pxa/Kconfig              |    9 ++
 sound/soc/pxa/Makefile             |    2 +
 sound/soc/pxa/mioa701_wm9713.c     |  250 ++++++++++++++++++++++++++++++++++++
 sound/soc/pxa/pxa2xx-i2s.c         |   36 -----
 13 files changed, 456 insertions(+), 266 deletions(-)
 create mode 100644 sound/soc/pxa/mioa701_wm9713.c
