From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 4/5] [RFC] ALSA ASOC adds destination and
	source port for dma
Date: Mon, 29 Sep 2008 15:23:52 +0530
Message-ID: <dfeb90390809290253kdf153b6p9993882e495f5e5c__48665.9070862972$1222682973$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: felipe.balbi@nokia.com, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Adds destination and source ports for dma which is required for OMAP1

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/omap-pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 690bfea..9e670ef 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -97,6 +97,7 @@ static int omap_pcm_hw_params(struct
snd_pcm_substream *substream,
 	prtd->dma_data = dma_data;
 	err = omap_request_dma(dma_data->dma_req, dma_data->name,
 			       omap_pcm_dma_irq, substream, &prtd->dma_ch);
+
 	if (!cpu_is_omap1510()) {
 		/*
 		 * Link channel with itself so DMA doesn't need any
@@ -147,12 +148,14 @@ static int omap_pcm_prepare(struct
snd_pcm_substream *substream)
 		dma_params.src_or_dst_synch	= OMAP_DMA_DST_SYNC;
 		dma_params.src_start		= runtime->dma_addr;
 		dma_params.dst_start		= dma_data->port_addr;
+		dma_params.dst_port		= OMAP_DMA_PORT_MPUI;
 	} else {
 		dma_params.src_amode		= OMAP_DMA_AMODE_CONSTANT;
 		dma_params.dst_amode		= OMAP_DMA_AMODE_POST_INC;
 		dma_params.src_or_dst_synch	= OMAP_DMA_SRC_SYNC;
 		dma_params.src_start		= dma_data->port_addr;
 		dma_params.dst_start		= runtime->dma_addr;
+		dma_params.src_port		= OMAP_DMA_PORT_MPUI;
 	}
 	/*
 	 * Set DMA transfer frame size equal to ALSA period size and frame
-- 
1.5.3.4
