From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [RFC PATCH 0/5] mpc5200 asoc fixups
Date: Tue, 11 Sep 2012 22:14:44 -0400
Message-ID: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id B23A92615E3
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 04:15:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anatolij Gustschin <agust@denx.de>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

The mpc5200 asoc code did not run after the multi-codec patches.  This series
fixes the existing code and adds a generic platform driver that allows the
audio layout to be described in the device tree.

Eric Millbrandt (5):
  ASoC: fsl: mpc5200 multi-codec fixups
  ASoC: fsl: mpc5200 combine psc_dma platform data
  ASoC: fsl: mpc5200-soc-audio driver
  arch/powerpc/boot/dts pcm030 add mpc5200-soc-audio node
  ASoC: fsl: mpc5200 remove pcm030 and efika audio fabric

 .../devicetree/bindings/powerpc/fsl/mpc5200.txt    |   17 ++
 arch/powerpc/boot/dts/pcm030.dts                   |   23 ++-
 arch/powerpc/platforms/52xx/Kconfig                |    1 +
 sound/soc/fsl/Kconfig                              |   20 +--
 sound/soc/fsl/Makefile                             |    3 +-
 sound/soc/fsl/efika-audio-fabric.c                 |   91 --------
 sound/soc/fsl/mpc5200_dma.c                        |   28 +--
 sound/soc/fsl/mpc5200_dma.h                        |    3 +
 sound/soc/fsl/mpc5200_psc_ac97.c                   |   13 +-
 sound/soc/fsl/mpc5200_psc_i2s.c                    |    8 +
 sound/soc/fsl/mpc5200_soc_audio.c                  |  232 ++++++++++++++++++++
 sound/soc/fsl/pcm030-audio-fabric.c                |   91 --------
 12 files changed, 306 insertions(+), 224 deletions(-)
 delete mode 100644 sound/soc/fsl/efika-audio-fabric.c
 create mode 100644 sound/soc/fsl/mpc5200_soc_audio.c
 delete mode 100644 sound/soc/fsl/pcm030-audio-fabric.c

-- 
1.7.2.5
