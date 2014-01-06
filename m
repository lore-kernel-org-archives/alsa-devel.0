From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 0/6] dma: Indicate residue granularity in
	dma_slave_caps
Date: Mon,  6 Jan 2014 11:45:56 +0100
Message-ID: <1389005162-5223-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-079.synserver.de (smtp-out-023.synserver.de
 [212.40.185.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 44208261691
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 11:45:46 +0100 (CET)
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

Here is an updated version of the DMA residue granularity patchset. As
discuessed last time it would be best if this could go through ASoC tree. It
needs some feedback from the DMA folks first though.

New in v2:
	* Dropped byte level granularity as discussed during v1 review
	* Added support for auto-detecting the NO_RESIDUE flag on the compat path in
      the generic ASoC dmaengine PCM driver
	* Updated a few ASoC drivers to take advantage of the new API

Updated original cover text from v1 below:

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

 - Lars

Lars-Peter Clausen (6):
  dma: Indicate residue granularity in dma_slave_caps
  dma: pl330: Set residue_granularity
  ASoC: generic-dmaengine-pcm: Check NO_RESIDUE flag at runtime
  ASoC: generic-dmaengine-pcm: Check DMA residue granularity
  ASoC: axi-{spdif,i2s}: Drop NO_RESIDUE flag
  ASoC: samsung: Remove NO_RESIDUE flag

 drivers/dma/pl330.c                   |  1 +
 include/linux/dmaengine.h             | 15 ++++++++
 sound/soc/adi/axi-i2s.c               |  3 +-
 sound/soc/adi/axi-spdif.c             |  3 +-
 sound/soc/samsung/dmaengine.c         |  1 -
 sound/soc/soc-generic-dmaengine-pcm.c | 66 ++++++++++++++++++++++-------------
 6 files changed, 60 insertions(+), 29 deletions(-)

-- 
1.8.0
