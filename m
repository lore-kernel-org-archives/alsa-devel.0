From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 14/14] ASoC: zte: constify snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 17:36:11 +0530
Message-ID: <1503057971-16033-15-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bardliao@realtek.com, oder_chiou@realtek.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_soc_dai_ops are not supposed to change at runtime. All functions
working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
const snd_soc_dai_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/zte/zx-i2s.c   | 2 +-
 sound/soc/zte/zx-spdif.c | 2 +-
 sound/soc/zte/zx-tdm.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index 8bbad1d..9a05659 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -357,7 +357,7 @@ static void zx_i2s_shutdown(struct snd_pcm_substream *substream,
 	clk_disable_unprepare(zx_i2s->dai_pclk);
 }
 
-static struct snd_soc_dai_ops zx_i2s_dai_ops = {
+static const struct snd_soc_dai_ops zx_i2s_dai_ops = {
 	.trigger	= zx_i2s_trigger,
 	.hw_params	= zx_i2s_hw_params,
 	.set_fmt	= zx_i2s_set_fmt,
diff --git a/sound/soc/zte/zx-spdif.c b/sound/soc/zte/zx-spdif.c
index 9fa6463..b143f9f 100644
--- a/sound/soc/zte/zx-spdif.c
+++ b/sound/soc/zte/zx-spdif.c
@@ -264,7 +264,7 @@ static void zx_spdif_shutdown(struct snd_pcm_substream *substream,
 	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE \
 	| SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE)
 
-static struct snd_soc_dai_ops zx_spdif_dai_ops = {
+static const struct snd_soc_dai_ops zx_spdif_dai_ops = {
 	.trigger	= zx_spdif_trigger,
 	.startup	= zx_spdif_startup,
 	.shutdown	= zx_spdif_shutdown,
diff --git a/sound/soc/zte/zx-tdm.c b/sound/soc/zte/zx-tdm.c
index bd632cc..dc95527 100644
--- a/sound/soc/zte/zx-tdm.c
+++ b/sound/soc/zte/zx-tdm.c
@@ -309,7 +309,7 @@ static void zx_tdm_shutdown(struct snd_pcm_substream *substream,
 	clk_disable_unprepare(zx_tdm->dai_wclk);
 }
 
-static struct snd_soc_dai_ops zx_tdm_dai_ops = {
+static const struct snd_soc_dai_ops zx_tdm_dai_ops = {
 	.trigger	= zx_tdm_trigger,
 	.hw_params	= zx_tdm_hw_params,
 	.set_fmt	= zx_tdm_set_fmt,
-- 
1.9.1
