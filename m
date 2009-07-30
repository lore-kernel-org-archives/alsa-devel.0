From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 17/20] ASoC: OMAP: Make DMA 64 aligned
Date: Thu, 30 Jul 2009 15:49:40 +0300
Message-ID: <1248958183-15015-18-git-send-email-eduardo.valentin__27648.8654934385$1248959182$gmane$org@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-14-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-15-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-16-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-17-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1248958183-15015-17-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 03cb420..a18b3bf 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -321,7 +321,7 @@ static struct snd_pcm_ops omap_pcm_ops = {
 	.mmap		= omap_pcm_mmap,
 };
 
-static u64 omap_pcm_dmamask = DMA_BIT_MASK(32);
+static u64 omap_pcm_dmamask = DMA_BIT_MASK(64);
 
 static int omap_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
 	int stream)
@@ -371,7 +371,7 @@ int omap_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 	if (!card->dev->dma_mask)
 		card->dev->dma_mask = &omap_pcm_dmamask;
 	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(64);
 
 	if (dai->playback.channels_min) {
 		ret = omap_pcm_preallocate_dma_buffer(pcm,
-- 
1.6.2.GIT

