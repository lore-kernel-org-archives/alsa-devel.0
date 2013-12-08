From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/3] dma: Indicate residue granularity in
	dma_slave_caps
Date: Sun,  8 Dec 2013 17:18:06 +0100
Message-ID: <1386519489-1935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-151.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id B0553261B16
 for <alsa-devel@alsa-project.org>; Sun,  8 Dec 2013 17:17:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi,

This patch series introduces a new field to the dma_slave_caps struct which
exposes the granularity with which the reported residue is updated, updates the
pl330 DMA driver to set this field and lets the generic dmaengine PCM audio
driver check that field.

The reason for introducing the field is that for audio we need to know the
granularity with which the reported residue is updated. The uncertainty of the
ALSA period pointer depends on the granularity of the reported residue. E.g. if
residue is only updated once every period this means that the position in the
buffer from/to which the hardware is currently reading/writing could be
anywhere between the reported PCM pointer and the reported PCM pointer plus one
period size (plus some extra margin for interrupt latency, etc). Certain
algorithms (e.g. pulseaudio's timer based scheduling) only work correctly if the
uncertainty of the PCM pointer is low enough. Exposing this information from the
DMA driver makes it possible for applications to switch to alternative modes of
operation which also work with a high granularity.

The patch series introduces four levels of granularity, which I think will cover
most DMA cores. I'd like some feedback though if anybody can think of a DMA
controller for which none of the levels would be correct. The four levels are:
	* DESCRIPTOR: The DMA channel is only able to tell whether a descriptor has
	  been completed or not, which means residue reporting is not supported by
	  this channel. The residue field of the dma_tx_state field will always be
	  0.
	* SEGMENT: The DMA channel updates the residue field after each successfully
	  completed segment of the transfer (For cyclic transfers this is after each
	  period). This is typically implemented by having the hardware generate an
	  interrupt after each transferred segment and then the driver updates the
	  outstanding residue by the size of the segment. Another possibility is if
	  the hardware supports SG and the segment descriptor has a field which gets
	  set by the hardware after the segment has been completed. The driver then
	  counts the number of segments which do not have the flag set to compute
	  the residue.
	* BURST: The DMA channel updates the residue field after each transferred
	  burst. This is typically only supported if the hardware has a progress
	  register of some sort (E.g. a register with the current read/write address
	  or a register with the amount of bursts/beats/bytes that have been
	  transferred or still need to be transferred).
	* BYTE: Same as BURST but with a byte level granularity.

I've only included the last one for completeness and I'm not sure if we really
need it. Even if the hardware is able to report the amount of transferred data
with a byte level granularity the lower bits will not carry too much
meaning. When using burst transfers the lower bits will remain the same for
longer periods and then rapidly increment during the burst transfer. The upper
bits though will increment with the actual frequency with which the data is
consumed. And that's what applications are typically interested in.

- Lars

Lars-Peter Clausen (3):
  dma: Indicate residue granularity in dma_slave_caps
  dma: pl330: Set residue_granularity
  ASoC: generic-dmaengine-pcm: Check DMA residue granularity

 drivers/dma/pl330.c                   |  1 +
 include/linux/dmaengine.h             | 17 ++++++++++++++++
 sound/soc/soc-generic-dmaengine-pcm.c | 37 +++++++++++++++++++++++++++++++++--
 3 files changed, 53 insertions(+), 2 deletions(-)

-- 
1.8.0
