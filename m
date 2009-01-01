From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Fix pxa2xx-pcm checks for invalid
	DMA channels
Date: Thu,  1 Jan 2009 15:32:52 +0000
Message-ID: <1230823973-6557-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090101153113.GA5966@sirena.org.uk>
	<1230823973-6557-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1230823973-6557-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9422A2434B
	for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2009 16:33:03 +0100 (CET)
In-Reply-To: <1230823973-6557-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Stephen Ware <stephen.ware@eqware.net>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Ware <stephen.ware@eqware.net>

Set the invalid dma channel to -1 (and check properly for it) in
pxa2xx_pcm_hw_free().  Was assuming 0 is an invalid channel number but 0
is a valid pxa dma channel num.

Signed-off-by: stephen <stephen.ware@eqware.net>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index c670d08..53b9fb1 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -61,9 +61,9 @@ static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	__pxa2xx_pcm_hw_free(substream);
 
-	if (prtd->dma_ch) {
+	if (prtd->dma_ch >= 0) {
 		pxa_free_dma(prtd->dma_ch);
-		prtd->dma_ch = 0;
+		prtd->dma_ch = -1;
 	}
 
 	return 0;
-- 
1.5.6.3
