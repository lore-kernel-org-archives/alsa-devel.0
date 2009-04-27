From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH v2 0/4] Mark mpc5200 i2s driver BROKEN
Date: Mon, 27 Apr 2009 12:44:39 -0400
Message-ID: <20090427164108.18211.44680.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E453245E0
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 18:44:44 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c3so12938ana.2
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 09:44:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark the mpc5200 i2s driver BROKEN and lay out a foundation for
fixing it. Separate out the mpc5200 core DMA routines from
mpc5200_psc_i2s.c into a standalone mpc5200_dma.c. No intention
to change how anything works, this is just a code reorg needed for
later patches to build on.

---

Jon Smirl (4):
      Rename exports in mpc5200_dma.c
      Rename the PSC functions to DMA
      Basic split of mpc5200 DMA code out from mpc5200_psc_i2s
      Set the MPC5200 i2s driver to BROKEN status.


 sound/soc/fsl/Kconfig           |    6 
 sound/soc/fsl/Makefile          |    2 
 sound/soc/fsl/mpc5200_dma.c     |  463 ++++++++++++++++++++++++++++
 sound/soc/fsl/mpc5200_dma.h     |   81 +++++
 sound/soc/fsl/mpc5200_psc_i2s.c |  644 +++++----------------------------------
 5 files changed, 633 insertions(+), 563 deletions(-)
 create mode 100644 sound/soc/fsl/mpc5200_dma.c
 create mode 100644 sound/soc/fsl/mpc5200_dma.h

-- 
Jon Smirl
jonsmirl@gmail.com
