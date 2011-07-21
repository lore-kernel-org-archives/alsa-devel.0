From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 0/2] ALSA: ASoC for Au1000/1500/1100
Date: Thu, 21 Jul 2011 08:52:12 +0200
Message-ID: <1311231134-16437-1-git-send-email-manuel.lauss@googlemail.com>
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

Hello,

These 2 patches implement ASoC drivers for the AC97 controller
found on early Alchemy chips.  They are largely based on the
old mips/au1x00.c driver which they replace.

Tested on a Db1500 development board.

Manuel Lauss (2):
  ALSA: Alchemy AC97C audio support
  ALSA: delete MIPS au1x00 driver

 arch/mips/alchemy/devboards/db1x00/platform.c |   37 ++
 sound/mips/Kconfig                            |    8 -
 sound/mips/Makefile                           |    2 -
 sound/mips/au1x00.c                           |  695 -------------------------
 sound/soc/au1x/Kconfig                        |   25 +
 sound/soc/au1x/Makefile                       |    9 +
 sound/soc/au1x/ac97c.c                        |  398 ++++++++++++++
 sound/soc/au1x/db1000.c                       |   75 +++
 sound/soc/au1x/dma.c                          |  470 +++++++++++++++++
 sound/soc/au1x/psc.h                          |   31 +-
 10 files changed, 1036 insertions(+), 714 deletions(-)
 delete mode 100644 sound/mips/au1x00.c
 create mode 100644 sound/soc/au1x/ac97c.c
 create mode 100644 sound/soc/au1x/db1000.c
 create mode 100644 sound/soc/au1x/dma.c

-- 
1.7.6

