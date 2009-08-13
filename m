From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 16/20] ASoC: OMAP: Enable DMA burst mode
Date: Thu, 13 Aug 2009 17:35:29 +0300
Message-ID: <1250174133-451-17-git-send-email-eduardo.valentin__32153.7052667283$1250175150$gmane$org@nokia.com>
References: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-2-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-3-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-4-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-5-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-6-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-7-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-8-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-9-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-10-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-11-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-12-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-13-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-14-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-15-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-16-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1250174133-451-16-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 2422a42..5d41371 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -176,6 +176,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 
 	omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
 
+	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+
 	return 0;
 }
 
-- 
1.6.2.GIT

