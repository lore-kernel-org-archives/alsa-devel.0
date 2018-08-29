From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH v2 2/3] ASoC: cs4265: Add native 32bit I2S
	transport
Date: Thu, 30 Aug 2018 09:38:01 +1000
Message-ID: <20180829233802.22032-2-flatmax@flatmax.org>
References: <20180829233802.22032-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E385267830
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2018 01:39:31 +0200 (CEST)
In-Reply-To: <20180829233802.22032-1-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, ckeepax@opensource.cirrus.com
Cc: Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

The cs4265 uses 32 bit transport on the I2S bus. This patch enables native
32 bit mode for machine drivers which use this sound card driver.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---

No changes from v1, however have tested the intended functionality and
list discussion had firmed up its purpose.
---
 sound/soc/codecs/cs4265.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 15b4ae04..17d7e6f0 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -495,7 +495,8 @@ static int cs4265_set_bias_level(struct snd_soc_component *component,
 			SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000)
 
 #define CS4265_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U16_LE | \
-			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_U24_LE)
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_U24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE)
 
 static const struct snd_soc_dai_ops cs4265_ops = {
 	.hw_params	= cs4265_pcm_hw_params,
-- 
2.17.1
