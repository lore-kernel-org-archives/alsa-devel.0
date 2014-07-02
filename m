From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/5] ALSA/ASoC/dmaengine: Fix 3 bytes
	physical sample support
Date: Wed, 2 Jul 2014 16:29:18 +0300
Message-ID: <1404307763-30557-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E2BE264F0F
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 15:29:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, dan.j.williams@intel.com, lars@metafoo.de, tiwai@suse.de, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, joelf@ti.com, nsekhar@ti.com
Cc: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

Changes since v1:
- the hw.formats mask preparation moved to dmaengine_pcm_set_runtime_hwparams()
- we prepare the mask for all supported sample formats based on the physical
  width of the sample and beased on the slave_caps information.

I have noticed while switching the daVinci audio to dmaengine_pcm that the _3LE
and _3BE support is not working correctly via dmaengine_pcm:
In case of _3LE/_3BE formats the samples are stored in 3 consecutive bytes
without padding it to 4 bytes. This means that the DMA needs to be able to
support 3 bytes word length in order to read/write the samples from memory
correctly. Originally the code treated 24 bits physical length samples as
they were 32 bits which leads to corruption when playing or recording audio.

To fix the support for 3 bytes physical samples the dma driver also need to have
support for such data arrangement. eDMA does have support for it in HW and the
legacy davinci-pcm platform driver w/o dmaengine was able to support such
formats.

First step is to add DMA_SLAVE_BUSWIDTH_3_BYTES to dma_slave_buswidth for
engines and users to select 3 bytes as bus width.

Followed by:
In dmaengine_pcm_set_runtime_hwparams() we should check the slave_caps of the
dma if it supports the give sample physical width of the sample. Based on this
information we initialize the hw.formats: masking out all non supported formats
based on the physical width.
In case the dma driver does not implement the slave_caps the default assumption
is that it supports 1, 2 and 4 bytes widths.

Regards,
Peter
---
Peter Ujfalusi (5):
  dma: Support for 3 bytes word size
  ALSA: pcm_dmaengine: Use the available wrapper to get physical width
  ASoC: generic-dmaengine-pcm: Prepare formats mask for valid physical
    sample sizes
  ALSA: pcm_dmaengine: Correct support for 24bits physical sample widths
  dma: edma: Declare DMA_SLAVE_BUSWIDTH_3_BYTES as supported buswidth

 drivers/dma/edma.c                    |  1 +
 include/linux/dmaengine.h             |  1 +
 sound/core/pcm_dmaengine.c            |  4 +++-
 sound/soc/soc-generic-dmaengine-pcm.c | 26 +++++++++++++++++++++++++-
 4 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.0.0
