From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Mon, 10 Aug 2009 13:13:24 +0100
Message-ID: <20090810121324.GA27983@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC27010384E
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 14:13:30 +0200 (CEST)
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

The following changes since commit b7b8f9bf0cd73b90561e8123fd5ec28f4539c419:
  Janusz Krzysztofik (1):
        TTY/ASoC: Rename N_AMSDELTA line discipline to N_V253

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.32

Chaithrika U S (1):
      ASoC: DaVinci: Support Audio on DA830 EVM

Mark Brown (3):
      ASoC: Convert WM8776 to use factored out register cache code
      ASoC: Define more formats for the AC97 CODECs
      ASoC: Drop unneeded declaration of removed wm8731 SPI write function

Uwe Kleine-K=F6nig (1):
      ASoC: s3c2443-ac97: convert semaphore to mutex

 include/sound/soc-dai.h          |    8 ++++-
 sound/soc/codecs/wm8731.c        |    3 --
 sound/soc/codecs/wm8776.c        |   59 +++++++---------------------------=
---
 sound/soc/davinci/Kconfig        |   11 +++++++
 sound/soc/davinci/Makefile       |    1 +
 sound/soc/davinci/davinci-evm.c  |   33 +++++++++++++++++++++
 sound/soc/s3c24xx/s3c2443-ac97.c |   10 +++---
 7 files changed, 68 insertions(+), 57 deletions(-)
