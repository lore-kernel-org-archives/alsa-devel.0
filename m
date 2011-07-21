From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V2 0/2] ALSA: ASoC for Au1000/1500/1100
Date: Thu, 21 Jul 2011 18:34:08 +0200
Message-ID: <1311266050-22199-1-git-send-email-manuel.lauss@googlemail.com>
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Manuel Lauss <manuel.lauss@googlemail.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

Hello,

These 2 patches implement ASoC drivers for the AC97 and I2S
controllers found on early Alchemy chips.  They are largely
based on the old mips/au1x00.c driver which they replace.

AC97 Tested on a Db1500 development board; I2S untested since none
of the testboards I have actually have an I2S codec (just testpoints).

Changes since V1:
- added untested I2S controller driver for completeness, removed the audio
  defines from the au1000 header.

Manuel Lauss (2):
  ALSA: Alchemy AC97C/I2SC audio support
  ALSA: delete MIPS au1x00 driver

 arch/mips/alchemy/devboards/db1x00/platform.c |   37 ++
 arch/mips/include/asm/mach-au1x00/au1000.h    |   61 ---
 sound/mips/Kconfig                            |    8 -
 sound/mips/Makefile                           |    2 -
 sound/mips/au1x00.c                           |  695 -------------------------
 sound/soc/au1x/Kconfig                        |   28 +
 sound/soc/au1x/Makefile                       |   10 +
 sound/soc/au1x/ac97c.c                        |  398 ++++++++++++++
 sound/soc/au1x/db1000.c                       |   75 +++
 sound/soc/au1x/dma.c                          |  470 +++++++++++++++++
 sound/soc/au1x/i2sc.c                         |  353 +++++++++++++
 sound/soc/au1x/psc.h                          |   31 +-
 12 files changed, 1393 insertions(+), 775 deletions(-)
 delete mode 100644 sound/mips/au1x00.c
 create mode 100644 sound/soc/au1x/ac97c.c
 create mode 100644 sound/soc/au1x/db1000.c
 create mode 100644 sound/soc/au1x/dma.c
 create mode 100644 sound/soc/au1x/i2sc.c

-- 
1.7.6

