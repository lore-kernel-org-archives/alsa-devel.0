From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: zte: spdif: remove duplicate
	initialization of dma_data
Date: Mon, 18 Sep 2017 09:56:38 +0100
Message-ID: <20170918085638.27110-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 83CD02668F0
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 10:57:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

dma_data is being initialized twice, remove the unused first
initialization and use the latter one instead.  Fixed clang warning:

"warning: Value stored to 'dma_data' during its initialization is
never read"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/zte/zx-spdif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/zte/zx-spdif.c b/sound/soc/zte/zx-spdif.c
index b143f9f682d2..17b6ce35037a 100644
--- a/sound/soc/zte/zx-spdif.c
+++ b/sound/soc/zte/zx-spdif.c
@@ -139,11 +139,11 @@ static int zx_spdif_hw_params(struct snd_pcm_substream *substream,
 {
 	struct zx_spdif_info *zx_spdif = dev_get_drvdata(socdai->dev);
 	struct zx_spdif_info *spdif = snd_soc_dai_get_drvdata(socdai);
-	struct snd_dmaengine_dai_dma_data *dma_data = &zx_spdif->dma_data;
+	struct snd_dmaengine_dai_dma_data *dma_data =
+		snd_soc_dai_get_dma_data(socdai, substream);
 	u32 val, ch_num, rate;
 	int ret;
 
-	dma_data = snd_soc_dai_get_dma_data(socdai, substream);
 	dma_data->addr_width = params_width(params) >> 3;
 
 	val = readl_relaxed(zx_spdif->reg_base + ZX_CTRL);
-- 
2.14.1
