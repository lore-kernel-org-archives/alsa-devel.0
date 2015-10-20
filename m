From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/4] dmaengine: Add transfer termination synchronization support
Date: Tue, 20 Oct 2015 11:46:27 +0200
Message-ID: <1445334391-12272-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Laurent Pinchart <renesas@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Qiao Zhou <zhouqiao@marvell.com>, Shengjiu Wang <shengjiu.wang@freescale.com>, Matt Campbell <mcampbell@izotope.com>, Jonah Petri <jpetri@izotope.com>, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DMAengine API has a long standing issue that is inherent to the API
itself. For a client that calls dmaengine_terminate_all() it is not
possible to properly synchronize the completion of any currently running
complete callbacks to the current context. This means it is possible to end
up with a use-after-free race condition if client frees resources that are
accessed in a complete callback before the complete callback has finished
running.

This patch series introduces a new explicit synchronization primitive to
the DMAengine API which allows clients to ensure that all complete
callbacks have finished running. This allows them to safely free any
resources that might be accessed in a complete callback.

The series for now only implements synchronization support for a single
driver and only updates single client to make use of the new API. If there
is agreement on the general approach more will follow.

- Lars

Lars-Peter Clausen (4):
  dmaengine: Add transfer termination synchronization support
  dmaengine: virt-dma: Add synchronization helper function
  dmaengine: axi_dmac: Add synchronization support
  ALSA: pcm_dmaengine: Properly synchronize DMA on shutdown

 Documentation/dmaengine/client.txt   | 38 ++++++++++++++-
 Documentation/dmaengine/provider.txt | 20 +++++++-
 drivers/dma/dma-axi-dmac.c           |  8 ++++
 drivers/dma/dmaengine.c              |  5 +-
 drivers/dma/virt-dma.h               | 13 ++++++
 include/linux/dmaengine.h            | 90 ++++++++++++++++++++++++++++++++++++
 sound/core/pcm_dmaengine.c           |  9 ++--
 7 files changed, 175 insertions(+), 8 deletions(-)

-- 
2.1.4
