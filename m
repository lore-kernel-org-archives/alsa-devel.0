From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.36
Date: Wed, 23 Jun 2010 00:27:33 +0100
Message-ID: <20100622232733.GA17609@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4963724476
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 01:27:19 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 66517915e0954ee027b889f452511945f7a9f3ec:

  ASoC: Fix I2C dependency for SND_FSI_AK4642 and SND_FSI_DA7210 (2010-06-1=
6 16:34:17 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.36

Eric B=E9nard (1):
      ASoC: eukrea-tlv320: add support for our i.MX25 board

Lars-Peter Clausen (3):
      ASoC: Add JZ4740 ASoC support
      ASoC: Add JZ4740 codec driver
      ASoC: JZ4740: Add qi_lb60 board driver

Mark Brown (1):
      ASoC: Fix sorting of DA7210 entries in Kconfig

Stuart Longland (1):
      ASoC: Fix overflow bug in SOC_DOUBLE_R_SX_TLV

 sound/soc/Kconfig             |    1 +
 sound/soc/Makefile            |    1 +
 sound/soc/codecs/Kconfig      |   12 +-
 sound/soc/codecs/Makefile     |    2 +
 sound/soc/codecs/jz4740.c     |  511 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/jz4740.h     |   20 ++
 sound/soc/imx/Kconfig         |    2 +-
 sound/soc/imx/eukrea-tlv320.c |    3 +-
 sound/soc/jz4740/Kconfig      |   23 ++
 sound/soc/jz4740/Makefile     |   13 +
 sound/soc/jz4740/jz4740-i2s.c |  540 +++++++++++++++++++++++++++++++++++++=
++++
 sound/soc/jz4740/jz4740-i2s.h |   18 ++
 sound/soc/jz4740/jz4740-pcm.c |  373 ++++++++++++++++++++++++++++
 sound/soc/jz4740/jz4740-pcm.h |   22 ++
 sound/soc/jz4740/qi_lb60.c    |  166 +++++++++++++
 sound/soc/soc-core.c          |    4 +-
 16 files changed, 1703 insertions(+), 8 deletions(-)
 create mode 100644 sound/soc/codecs/jz4740.c
 create mode 100644 sound/soc/codecs/jz4740.h
 create mode 100644 sound/soc/jz4740/Kconfig
 create mode 100644 sound/soc/jz4740/Makefile
 create mode 100644 sound/soc/jz4740/jz4740-i2s.c
 create mode 100644 sound/soc/jz4740/jz4740-i2s.h
 create mode 100644 sound/soc/jz4740/jz4740-pcm.c
 create mode 100644 sound/soc/jz4740/jz4740-pcm.h
 create mode 100644 sound/soc/jz4740/qi_lb60.c
