From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V1 00/13] mpc5200 audio rework for AC97
Date: Wed, 13 May 2009 21:58:59 -0400
Message-ID: <20090514015729.28145.30483.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 81E1C24355
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 03:59:10 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so720053ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 18:59:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following series implements audio support for the
mpc5200. It adds an AC97 driver and STAC9766 codec
driver. Board support for the Efika and Phytec pcm030
are also included. I'm sure everyone will have some
edits on this first version.

---

Jon Smirl (13):
      Support for AC97 on Phytec pmc030 base board.
      Fabric bindings for STAC9766 on the Efika
      AC97 driver for mpc5200
      Codec for STAC9766 used on the Efika
      Main rewite of the mpc5200 audio DMA code
      Have the WM9712 driver self register itself
      Add SNDRV_PCM_FMTBIT_S32_BE as a valid AC97 format
      Allow a custom ASOC fabric driver with soc-of-simple
      Add a few more mpc5200 PSC defines
      redo 2008f137e92220b98120c4803499cdddb2b0fb06
      Rename the PSC functions to DMA
      Basic split of mpc5200 DMA code out from mpc5200_psc_i2s
      Temporarily undo 2008f137e92220b98120c4803499cdddb2b0fb06


 arch/powerpc/boot/dts/pcm030.dts       |    8 
 arch/powerpc/include/asm/mpc52xx_psc.h |   10 
 arch/powerpc/platforms/52xx/efika.c    |    8 
 include/sound/soc-dai.h                |    3 
 include/sound/soc-of-simple.h          |   16 +
 sound/last.c                           |    6 
 sound/soc/codecs/Kconfig               |    4 
 sound/soc/codecs/Makefile              |    2 
 sound/soc/codecs/stac9766.c            |  491 ++++++++++++++++++++++
 sound/soc/codecs/stac9766.h            |   21 +
 sound/soc/codecs/tlv320aic26.c         |    2 
 sound/soc/codecs/wm9712.c              |   34 ++
 sound/soc/fsl/Kconfig                  |   30 +
 sound/soc/fsl/Makefile                 |    6 
 sound/soc/fsl/efika-audio-fabric.c     |   95 ++++
 sound/soc/fsl/mpc5200_dma.c            |  693 +++++++++++++++++++++++++++++++
 sound/soc/fsl/mpc5200_dma.h            |   83 ++++
 sound/soc/fsl/mpc5200_psc_ac97.c       |  379 +++++++++++++++++
 sound/soc/fsl/mpc5200_psc_ac97.h       |   13 +
 sound/soc/fsl/mpc5200_psc_i2s.c        |  707 +-------------------------------
 sound/soc/fsl/soc-of-simple.c          |  160 ++++++-
 21 files changed, 2053 insertions(+), 718 deletions(-)
 create mode 100644 sound/soc/codecs/stac9766.c
 create mode 100644 sound/soc/codecs/stac9766.h
 create mode 100644 sound/soc/fsl/efika-audio-fabric.c
 create mode 100644 sound/soc/fsl/mpc5200_dma.c
 create mode 100644 sound/soc/fsl/mpc5200_dma.h
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h

-- 
Jon Smirl
jonsmirl@gmail.com
