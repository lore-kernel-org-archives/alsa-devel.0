From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 0/6] ASoC: Add audio for sti platforms round 2
Date: Thu, 16 Jul 2015 11:36:01 +0200
Message-ID: <1437039367-30842-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D7EE2661B0
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 11:36:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org

New set of patches after partial integration 
of [PATCH v3 0/9]  ASoC: Add audio for sti platforms

New patches:
  ASoC: sti: minor corrections for uniplayer

Patches rebased from [PATCH v3 0/9]  asoc: Add audio for sti platforms
  ASoC: sti: Add CPU DAI driver for capture
	( IRQ enable /disable cleaned)
  ASoC: sti: Add uniperipheral dai driver
  ASoC: Add ability to build sti drivers
  ASoC: sti: Add clock adjustement control
  ASoC: sti: Add IEC control

Arnaud Pouliquen (6):
  ASoC: sti: minor corrections for uniplayer
  ASoC: sti: Add CPU DAI driver for capture
  ASoC: sti: Add uniperipheral dai driver
  ASoC: Add ability to build sti drivers
  ASoC: sti: Add clock adjustement control
  ASoC: sti: Add IEC control

 sound/soc/Kconfig               |   1 +
 sound/soc/Makefile              |   1 +
 sound/soc/sti/Kconfig           |  11 ++
 sound/soc/sti/Makefile          |   4 +
 sound/soc/sti/sti_uniperif.c    | 253 ++++++++++++++++++++++++++++
 sound/soc/sti/uniperif.h        |  14 ++
 sound/soc/sti/uniperif_player.c | 226 ++++++++++++++++++++++++-
 sound/soc/sti/uniperif_reader.c | 362 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 869 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/sti/Kconfig
 create mode 100644 sound/soc/sti/Makefile
 create mode 100644 sound/soc/sti/sti_uniperif.c
 create mode 100644 sound/soc/sti/uniperif_reader.c

-- 
1.9.1
