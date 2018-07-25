From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: zte: Fix incorrect PCM format bit usages
Date: Wed, 25 Jul 2018 22:40:49 +0200
Message-ID: <20180725204049.28859-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB96D26774B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 22:40:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Baoyou Xie <baoyou.xie@linaro.org>, Jun Nie <jun.nie@linaro.org>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>
List-Id: alsa-devel@alsa-project.org

zx-tdm driver sets the DAI driver definitions with the format bits
wrongly set with SNDRV_PCM_FORMAT_*, instead of SNDRV_PCM_FMTBIT_*.

This patch corrects the definitions.

Spotted by a sparse warning:
  sound/soc/zte/zx-tdm.c:363:35: warning: restricted snd_pcm_format_t degrades to integer

Fixes: 870e0ddc4345 ("ASoC: zx-tdm: add zte's tdm controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/zte/zx-tdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/zte/zx-tdm.c b/sound/soc/zte/zx-tdm.c
index dc955272f58b..389272eeba9a 100644
--- a/sound/soc/zte/zx-tdm.c
+++ b/sound/soc/zte/zx-tdm.c
@@ -144,8 +144,8 @@ static void zx_tdm_rx_dma_en(struct zx_tdm_info *tdm, bool on)
 #define ZX_TDM_RATES	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000)
 
 #define ZX_TDM_FMTBIT \
-	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_MU_LAW | \
-	SNDRV_PCM_FORMAT_A_LAW)
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_MU_LAW | \
+	SNDRV_PCM_FMTBIT_A_LAW)
 
 static int zx_tdm_dai_probe(struct snd_soc_dai *dai)
 {
-- 
2.18.0
