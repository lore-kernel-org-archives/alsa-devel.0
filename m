From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 5/7] ASoC: samsung: Drop usage of struct s3c_dma_params from
 spdif.c
Date: Thu, 04 Aug 2016 11:30:30 +0200
Message-ID: <1470303032-14582-6-git-send-email-s.nawrocki@samsung.com>
References: <1470303032-14582-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1470303032-14582-1-git-send-email-s.nawrocki@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, b.zolnierkie@samsung.com, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

struct s3c_dma_params already includes struct snd_dmaengine_dai_dma_data,
there is no need for such an indirection so switch to using struct
snd_dmaengine_dai_dma_data instead of struct s3c_dma_params.  This also
allows us to use snd_soc_dai_init_dma_data() function instead of the
platform specific samsung_asoc_init_dma_data helper.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/spdif.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 0cb9c85..26c1fbe 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -90,10 +90,10 @@ struct samsung_spdif_info {
 	u32		saved_clkcon;
 	u32		saved_con;
 	u32		saved_cstas;
-	struct s3c_dma_params	*dma_playback;
+	struct snd_dmaengine_dai_dma_data *dma_playback;
 };
 
-static struct s3c_dma_params spdif_stereo_out;
+static struct snd_dmaengine_dai_dma_data spdif_stereo_out;
 static struct samsung_spdif_info spdif_info;
 
 static inline struct samsung_spdif_info *to_info(struct snd_soc_dai *cpu_dai)
@@ -179,7 +179,7 @@ static int spdif_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct samsung_spdif_info *spdif = to_info(rtd->cpu_dai);
 	void __iomem *regs = spdif->regs;
-	struct s3c_dma_params *dma_data;
+	struct snd_dmaengine_dai_dma_data *dma_data;
 	u32 con, clkcon, cstas;
 	unsigned long flags;
 	int i, ratio;
@@ -425,11 +425,11 @@ static int spdif_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
-	spdif_stereo_out.dma_size = 2;
-	spdif_stereo_out.dma_addr = mem_res->start + DATA_OUTBUF;
+	spdif_stereo_out.addr_width = 2;
+	spdif_stereo_out.addr = mem_res->start + DATA_OUTBUF;
 	filter = NULL;
 	if (spdif_pdata) {
-		spdif_stereo_out.slave = spdif_pdata->dma_playback;
+		spdif_stereo_out.filter_data = spdif_pdata->dma_playback;
 		filter = spdif_pdata->dma_filter;
 	}
 
-- 
1.9.1
