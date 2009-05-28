From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Thu, 28 May 2009 19:04:30 +0100
Message-ID: <20090528180430.GB4574@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CFAF1037F1
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 20:04:37 +0200 (CEST)
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

The following changes since commit 08d15f034e94251606479d7ca9070994c2e2fcf0:
  Mark Brown (1):
        ASoC: Switch FSL SSI DAI over to symmetric_rates

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Chaithrika U S (1):
      ASoC: Add dummy S/PDIF codec support

Jon Smirl (1):
      ASoC: Modify mpc5200 AC97 driver to use V9 of spin_event_timeout()

Mark Brown (1):
      ASoC: Initialise dev for the dummy S/PDIF DAI

Roel Kluin (1):
      ASoC: correct print specifiers for unsigneds

 sound/soc/atmel/playpaq_wm8510.c     |    2 +-
 sound/soc/codecs/Kconfig             |    4 ++
 sound/soc/codecs/Makefile            |    2 +
 sound/soc/codecs/spdif_transciever.c |   71 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/spdif_transciever.h |   17 ++++++++
 sound/soc/codecs/tlv320aic23.c       |    4 +-
 sound/soc/codecs/uda134x.c           |    4 +-
 sound/soc/codecs/wm8350.c            |    2 +-
 sound/soc/codecs/wm8400.c            |    4 +-
 sound/soc/codecs/wm8510.c            |    2 +-
 sound/soc/codecs/wm8580.c            |    4 +-
 sound/soc/codecs/wm8753.c            |    2 +-
 sound/soc/codecs/wm8900.c            |    6 +-
 sound/soc/codecs/wm8990.c            |    2 +-
 sound/soc/codecs/wm9713.c            |    2 +-
 sound/soc/fsl/mpc5200_psc_ac97.c     |   30 +++++++--------
 sound/soc/pxa/pxa-ssp.c              |    4 +-
 sound/soc/s3c24xx/s3c-i2s-v2.c       |    4 +-
 sound/soc/sh/ssi.c                   |    2 +-
 19 files changed, 130 insertions(+), 38 deletions(-)
 create mode 100644 sound/soc/codecs/spdif_transciever.c
 create mode 100644 sound/soc/codecs/spdif_transciever.h
