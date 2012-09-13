From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [RFC 0/7] mpc5200 ASoC and pcm030 board fixes
Date: Thu, 13 Sep 2012 17:43:09 -0400
Message-ID: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 26316262608
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 23:43:27 +0200 (CEST)
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

This series is a respin of "mpc5200 ASoC fixups"

The mpc5200 ASoC and pcm030 board code compiled, but did not run after the
multi-codec patches.  This series add the missing pieces into the mpc5200 ASoC
drivers and updates the pcm030 board to the current api.

Eric Millbrandt (7):
  powerpc/52xx: define FSL_SOC
  ASoC: fsl: mpc5200 combine psc_dma platform data
  ASoC: fsl: mpc5200 add missing information to snd_soc_dai_driver
  ASoC: fsl: cleanup headers in pcm030-audio-fabric
  ASoC: fsl: convert pcm030-audio-fabric to a platform-driver
  ASoC: fsl: convert pcm030-audio-fabric to use snd_soc_register_card
  ASoC: fsl: register the wm9712-codec

 arch/powerpc/platforms/52xx/Kconfig |    1 +
 sound/soc/fsl/mpc5200_dma.c         |   24 ++-------
 sound/soc/fsl/mpc5200_dma.h         |    3 +
 sound/soc/fsl/mpc5200_psc_ac97.c    |   10 ++++
 sound/soc/fsl/mpc5200_psc_i2s.c     |    8 +++
 sound/soc/fsl/pcm030-audio-fabric.c |  100 +++++++++++++++++++++++++---------
 6 files changed, 99 insertions(+), 47 deletions(-)

-- 
1.7.2.5
