From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 00/21] ASoC: davinci: Code cleanups and support
	for DRA7xx
Date: Thu, 14 Nov 2013 11:35:16 +0200
Message-ID: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 2760E2616E1
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:35:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

In this series:
Small cleanup of Kconfig/Makefile
McASP support for AM43xx SoCs
McASP support for DRA7xx SoCs
Fix for synchronous master mode operation of McASP
Code simplification (FIFO handling, etc)
Data port selection support (dat or config address space)
General code cleanup regarding to:
- relocating register definition to header file
- renaming of the private mcasp structure
- IO functions parameters has been changed

Regards,
Peter
---
Peter Ujfalusi (21):
  ASoC: davinci: Kconfig: Remove help section for SND_DAVINCI_SOC
  ASoC: davinci: Kconfig/Makefile: Generic EVM machine driver related
    cleanup
  ASoC: davinci: kconfig: Prepare for AM43xx support
  ASoC: davinci-evm: Do not include davinci-mcasp.h
  ASoC: davinci-evm: Switch to use .dai_fmt of snd_soc_dai_link(s)
  ASoC: davinci-mcasp: Move DAVINCI_MCASP_RATE from header to source
    file
  ASoC: davinci-mcasp: Remove unused DAVINCI_MCASP_I2S/DIT_DAI defines
  ASoC: davinci-mcasp: Correct dai driver struct initialization for 2nd
    dai
  ASoC: davinci-mcasp: Move register definitions to header file
  ASoC: davinci-mcasp: Move private struct definition to source file
  ASoC: davinci-mcasp: Remove unused DAVINCI_MCASP_NUM_SERIALIZER define
  ASoC: davinci-mcasp: Do not inline the mcasp_set_ctl_reg function
  ASoC: davinci-mcasp: Rename private struct and it's users (dev ->
    mcasp)
  ASoC: davinci-mcasp: Be consistent with the use of base in
    davinci_mcasp_set_dai_fmt
  ASoC: davinci-mcasp: Simplify FIFO configuration code
  ASoC: davinci-mcasp: Data source (bus) selection support
  ASoC: davinci-mcasp: Fix synchronous master receive mode
  ASoC: davinci-mcasp: Support for McASP version found in DRA7xx
  ASoC: davinci-mcasp: Support for fck reparenting
  ASoC: davinci-mcasp: Change IO functions parameter list
  ASoC: davinci-mcasp: Correct am33xx snd_platform_data name

 .../bindings/sound/davinci-mcasp-audio.txt         |    6 +-
 include/linux/platform_data/davinci_asp.h          |    1 +
 sound/soc/davinci/Kconfig                          |   29 +-
 sound/soc/davinci/Makefile                         |    8 +-
 sound/soc/davinci/davinci-evm.c                    |   48 +-
 sound/soc/davinci/davinci-mcasp.c                  | 1016 +++++++++-----------
 sound/soc/davinci/davinci-mcasp.h                  |  304 +++++-
 7 files changed, 738 insertions(+), 674 deletions(-)

-- 
1.8.4.2
