From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V5 0/5] AC97 driver for mpc5200
Date: Tue, 26 May 2009 08:34:04 -0400
Message-ID: <20090526123235.17472.73912.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id C1CAC24790
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 14:34:08 +0200 (CEST)
Received: by gxk2 with SMTP id 2so7273405gxk.8
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 05:34:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

Version 5. Modified to use spin_event_timeout() as originally written.

---

Jon Smirl (5):
      Fabric bindings for STAC9766 on the Efika
      Support for AC97 on Phytec pmc030 base board.
      AC97 driver for mpc5200
      Main rewite of the mpc5200 audio DMA code
      powerpc: introduce macro spin_event_timeout()


 arch/powerpc/include/asm/delay.h    |   33 +++
 sound/soc/fsl/Kconfig               |   27 ++
 sound/soc/fsl/Makefile              |    5 
 sound/soc/fsl/efika-audio-fabric.c  |   90 +++++++
 sound/soc/fsl/mpc5200_dma.c         |  442 ++++++++++++++++++++++-------------
 sound/soc/fsl/mpc5200_dma.h         |   33 +--
 sound/soc/fsl/mpc5200_psc_ac97.c    |  331 ++++++++++++++++++++++++++
 sound/soc/fsl/mpc5200_psc_ac97.h    |   15 +
 sound/soc/fsl/mpc5200_psc_i2s.c     |  247 +++-----------------
 sound/soc/fsl/mpc5200_psc_i2s.h     |   12 +
 sound/soc/fsl/pcm030-audio-fabric.c |   90 +++++++
 11 files changed, 934 insertions(+), 391 deletions(-)
 create mode 100644 sound/soc/fsl/efika-audio-fabric.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h
 create mode 100644 sound/soc/fsl/mpc5200_psc_i2s.h
 create mode 100644 sound/soc/fsl/pcm030-audio-fabric.c

-- 
Jon Smirl
jonsmirl@gmail.com
