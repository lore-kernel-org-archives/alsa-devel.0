From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/5] ASoC: davinci: Use edma-pcm and remove
	davinci-pcm
Date: Tue, 3 Mar 2015 16:45:16 +0200
Message-ID: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 84E3926153F
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 15:45:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, khilman@deeprootsystems.com, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

This series will deprecate and removes the davinci-pcm platform driver and
converts the daVinci DAI drivers to use the edma-pcm.

The main feature of davinci-pcm has been the so called ping-pong mode, which
can help in situations when the McASP/McBSP/ASP/VCIF experiences underrun or
overrun in playback or capture. This was due to the fact the davinci-pcm w/o
ping-pong needed to reprogram the paRAM slot after each period, this could
cause delay in DMA operation, which leads to starvation.
The edm-pcm does not need reprogramming and it seams to be working as good as
the davinci-pcm with ping-pong.

I have tested this series on OMAP-L138 EVM with McASP and McBSP. VCIF has been
only compile tested since I do not have access to the HW. The edma-pcm is
already used by AM335x and AM437x and it has been tested on those platforms
extensively.

After this series we no longer have legacy eDMA users which clears the path for
the eDMA driver stack cleanup.

Regards,
Peter
---
Peter Ujfalusi (5):
  ASoC: davinci: Select SND_EDMA_SOC when SND_DAVINCI_SOC is enabled
  ASoC: davinci-i2s: Convert to use edma-pcm
  ASoC: davinci-vcif: Convert to use edma-pcm
  ASoC: davinci-mcasp: Deprecate the use of davinci-pcm in favor of
    edma-pcm
  ASoC: davinci: Remove unused davinci-pcm platform driver

 sound/soc/davinci/Kconfig         |  18 +-
 sound/soc/davinci/Makefile        |   2 -
 sound/soc/davinci/davinci-i2s.c   |  67 ++-
 sound/soc/davinci/davinci-mcasp.c |  87 +---
 sound/soc/davinci/davinci-pcm.c   | 861 --------------------------------------
 sound/soc/davinci/davinci-pcm.h   |  41 --
 sound/soc/davinci/davinci-vcif.c  |  55 ++-
 7 files changed, 79 insertions(+), 1052 deletions(-)
 delete mode 100644 sound/soc/davinci/davinci-pcm.c
 delete mode 100644 sound/soc/davinci/davinci-pcm.h

-- 
2.3.0
