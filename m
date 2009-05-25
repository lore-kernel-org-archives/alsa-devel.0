From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V3 0/4] mpc5200 audio rework for AC97
Date: Sun, 24 May 2009 21:38:45 -0400
Message-ID: <20090525013606.3073.86753.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D37E24553
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 03:38:51 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c3so1919233ana.2
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 18:38:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

The following series implements audio support for the mpc5200. It adds an AC97 driver and STAC9766 codec driver. 
Board support for the Efika and Phytec pcm030 are also included.

I've tried to implement the feedback received on the previous two versions.

based on commit 0bc53a67ac831ec84f730a657dbcadd80a589ef5 on broonie/for-2.6.31 at
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

---

Jon Smirl (4):
      Fabric bindings for STAC9766 on the Efika
      Support for AC97 on Phytec pmc030 base board.
      AC97 driver for mpc5200
      Main rewite of the mpc5200 audio DMA code


 sound/soc/fsl/Kconfig               |   27 ++
 sound/soc/fsl/Makefile              |    5 
 sound/soc/fsl/efika-audio-fabric.c  |   95 +++++++
 sound/soc/fsl/mpc5200_dma.c         |  504 +++++++++++++++++++++++------------
 sound/soc/fsl/mpc5200_dma.h         |   33 +-
 sound/soc/fsl/mpc5200_psc_ac97.c    |  392 +++++++++++++++++++++++++++
 sound/soc/fsl/mpc5200_psc_ac97.h    |   15 +
 sound/soc/fsl/mpc5200_psc_i2s.c     |  247 +++--------------
 sound/soc/fsl/mpc5200_psc_i2s.h     |   12 +
 sound/soc/fsl/pcm030-audio-fabric.c |   95 +++++++
 10 files changed, 1036 insertions(+), 389 deletions(-)
 create mode 100644 sound/soc/fsl/efika-audio-fabric.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h
 create mode 100644 sound/soc/fsl/mpc5200_psc_i2s.h
 create mode 100644 sound/soc/fsl/pcm030-audio-fabric.c

-- 
Jon Smirl
jonsmirl@gmail.com
