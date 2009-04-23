From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 18/21] ASoC: change stereo/mono to
	32-bit/16-bit for pxa-ssp
Date: Thu, 23 Apr 2009 20:55:52 +0100
Message-ID: <1240516555-22249-18-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E1861038A6
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:04 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

From: Eric Miao <eric.miao@marvell.com>

The original idea came from pHilipp, and this makes the code looks
more consistent.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa-ssp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index fb8cacc..6fc7876 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -67,7 +67,7 @@ struct pxa2xx_pcm_dma_data {
 };
 
 static struct pxa2xx_pcm_dma_params *
-ssp_get_dma_params(struct ssp_device *ssp, int stereo, int out)
+ssp_get_dma_params(struct ssp_device *ssp, int width4, int out)
 {
 	struct pxa2xx_pcm_dma_data *dma;
 
@@ -76,13 +76,13 @@ ssp_get_dma_params(struct ssp_device *ssp, int stereo, int out)
 		return NULL;
 
 	snprintf(dma->name, 20, "SSP%d PCM %s %s", ssp->port_id,
-			stereo ? "Stereo" : "Mono", out ? "out" : "in");
+			width4 ? "32-bit" : "16-bit", out ? "out" : "in");
 
 	dma->params.name = dma->name;
 	dma->params.drcmr = &DRCMR(out ? ssp->drcmr_tx : ssp->drcmr_rx);
 	dma->params.dcmd = (out ? (DCMD_INCSRCADDR | DCMD_FLOWTRG) :
 				  (DCMD_INCTRGADDR | DCMD_FLOWSRC)) |
-			(stereo ? DCMD_WIDTH4 : DCMD_WIDTH2) | DCMD_BURST16;
+			(width4 ? DCMD_WIDTH4 : DCMD_WIDTH2) | DCMD_BURST16;
 	dma->params.dev_addr = ssp->phys_base + SSDR;
 
 	return &dma->params;
-- 
1.5.6.3
