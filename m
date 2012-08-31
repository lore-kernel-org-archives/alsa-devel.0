From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: [PATCH 0/3] ASoC: Davinci: McASP: add support new
	McASP IP Variant
Date: Fri, 31 Aug 2012 18:20:56 +0530
Message-ID: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 65A53265B49
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 15:08:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org
Cc: sudhakar.raj@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, gururaja.hebbar@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

The OMAP2+ variant of McASP is different from Davinci variant w.r.to some
register offset and missing generic SRAM APIs support

Changes
- Add new MCASP_VERSION_3 to identify new variant. New DT compatible
  "ti,omap2-mcasp-audio" to identify version 3 controller.
- The register offsets are handled depending on the version.
- Provide a config option to indicate missing SRAM API support.

While here, fix a typo caused by recent commit (cf53756 - ASoC: davinci: 
davinci-pcm does not need to be a plaform_driver)

Note:
   DMA parameters (dma fifo offset) are not updated and will be done later.

Hebbar, Gururaja (3):
  ASoC: Davinci: McASP: add support new McASP IP Variant
  ASoC: Davinci: pcm: add support for sram-support-less platforms
  ASoC: Davinci: evm: Fix typo in cpu dai name

 .../bindings/sound/davinci-mcasp-audio.txt         |    1 +
 include/linux/platform_data/davinci_asp.h          |    1 +
 sound/soc/davinci/Kconfig                          |    5 ++
 sound/soc/davinci/davinci-evm.c                    |    2 +-
 sound/soc/davinci/davinci-mcasp.c                  |   71 ++++++++++++++++----
 sound/soc/davinci/davinci-pcm.c                    |    8 ++
 6 files changed, 74 insertions(+), 14 deletions(-)
