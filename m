From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 11/13] ASoC: samsung: i2s: Change indentation in
 SAMSUNG_I2S_FMTS definition
Date: Thu, 14 Feb 2019 10:37:45 +0100
Message-ID: <20190214093747.2414-12-s.nawrocki@samsung.com>
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093853epcas2p2f48340585495bf0ba662ae42399d1cab@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

Change indentation so this macro definition spans 2 rows and looks
more consistent with surrounding code.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 4f15b6af8268..e0c151843f9e 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1150,9 +1150,8 @@ static const struct snd_soc_component_driver samsung_i2s_component = {
 	.num_dapm_routes = ARRAY_SIZE(samsung_i2s_dapm_routes),
 };
 
-#define SAMSUNG_I2S_FMTS	(SNDRV_PCM_FMTBIT_S8 | \
-					SNDRV_PCM_FMTBIT_S16_LE | \
-					SNDRV_PCM_FMTBIT_S24_LE)
+#define SAMSUNG_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
+			  SNDRV_PCM_FMTBIT_S24_LE)
 
 static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 			  const struct samsung_i2s_dai_data *i2s_dai_data,
-- 
2.17.1
