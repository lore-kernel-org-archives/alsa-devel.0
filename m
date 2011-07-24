From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 0/2] ASoC: au1x: update PSC AC97/I2S code
Date: Sun, 24 Jul 2011 15:11:26 +0200
Message-ID: <1311513088-18802-1-git-send-email-manuel.lauss@googlemail.com>
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Manuel Lauss <manuel.lauss@googlemail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following two patches depend on patchset "ASoC for Alchemy Au1000/1500/1100"
to apply and work.
Patch #1 moves the DBDMA (PCM) device registration from the AC97/I2S drivers
  into the board code.
Patch #2 changes use of "soc-audio" platform device int db1200 machine code to
  the new way.

Run-tested on DB1200, DB1300 and DB1550 boards.

Manuel Lauss (2):
  ASoC: au1x: remove automatic DMA device registration from PSC drivers
  ASoC: au1x: update db1200 machine to the new way of things

 arch/mips/alchemy/devboards/db1200/platform.c |   16 +++++
 sound/soc/au1x/db1200.c                       |   64 +++++++++++++------
 sound/soc/au1x/dbdma2.c                       |   83 ++++---------------------
 sound/soc/au1x/psc-ac97.c                     |   34 +++++++---
 sound/soc/au1x/psc-i2s.c                      |   32 +++++++---
 sound/soc/au1x/psc.h                          |    5 --
 6 files changed, 117 insertions(+), 117 deletions(-)

-- 
1.7.6

