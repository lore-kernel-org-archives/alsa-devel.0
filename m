From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V3 0/3] ASoC for Alchemy Au1000/1500/1100
Date: Fri, 22 Jul 2011 13:09:05 +0200
Message-ID: <1311332948-29406-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Manuel Lauss <manuel.lauss@googlemail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,

These 3 patches implement ASoC drivers for the AC97 and I2S
controllers found on early Alchemy chips.  They are largely
based on the old mips/au1x00.c driver which they replace.

AC97 Tested on a Db1500 development board; I2S untested since none
of the testboards I have actually have an I2S codec (just testpoints).

Changes since V2:
- implemented changes after feedback from Lars-Peter Clausen:
* split patch 1 in two, one for the ASoC drivers, and a separate for
  DB1000 machine code.
* get rid of automatic dma device registration
* tidied the I2S/AC97 sources
- mark sound/mips/au1x00.c as DEPRECATED instead of removing it outright.

Changes since V1:
- added untested I2S controller driver for completeness, removed the audio
  defines from the au1000 header.

Manuel Lauss (3):
  ASoC: Alchemy AC97C/I2SC audio support
  ASoC: Add a DB1x00 AC97 machine driver
  ALSA: deprecate MIPS AU1X00 AC97 driver

 arch/mips/alchemy/devboards/db1x00/platform.c |   48 +++
 arch/mips/include/asm/mach-au1x00/au1000.h    |   31 --
 sound/mips/Kconfig                            |    5 +-
 sound/soc/au1x/Kconfig                        |   28 ++
 sound/soc/au1x/Makefile                       |   10 +
 sound/soc/au1x/ac97c.c                        |  375 ++++++++++++++++++++++++
 sound/soc/au1x/db1000.c                       |   75 +++++
 sound/soc/au1x/dma.c                          |  381 +++++++++++++++++++++++++
 sound/soc/au1x/i2sc.c                         |  348 ++++++++++++++++++++++
 sound/soc/au1x/psc.h                          |   22 +-
 10 files changed, 1282 insertions(+), 41 deletions(-)
 create mode 100644 sound/soc/au1x/ac97c.c
 create mode 100644 sound/soc/au1x/db1000.c
 create mode 100644 sound/soc/au1x/dma.c
 create mode 100644 sound/soc/au1x/i2sc.c

-- 
1.7.6

