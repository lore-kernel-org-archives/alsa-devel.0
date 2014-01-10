From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] ASoC: fsl: Don't mix
	SNDRV_PCM_RATE_CONTINUOUS with specific rates
Date: Fri, 10 Jan 2014 16:06:33 +0100
Message-ID: <1389366396-16884-2-git-send-email-lars@metafoo.de>
References: <1389366396-16884-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-105.synserver.de
 [212.40.185.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A56126088F
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:06:35 +0100 (CET)
In-Reply-To: <1389366396-16884-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

SNDRV_PCM_RATE_CONTINUOUS means that all rates (possibly limited to a certain
interval) are supported. There is no need to manually set other rate bits.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/fsl/fsl_ssi.c         | 3 +--
 sound/soc/fsl/mpc5200_psc_i2s.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f662ddd..33a4738 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -81,8 +81,7 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
  * ALSA that we support all rates and let the codec driver decide what rates
  * are really supported.
  */
-#define FSLSSI_I2S_RATES (SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000 | \
-			  SNDRV_PCM_RATE_CONTINUOUS)
+#define FSLSSI_I2S_RATES SNDRV_PCM_RATE_CONTINUOUS
 
 /**
  * FSLSSI_I2S_FORMATS: audio formats supported by the SSI
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index f4efaad..5d07e8a 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -26,8 +26,7 @@
  * ALSA that we support all rates and let the codec driver decide what rates
  * are really supported.
  */
-#define PSC_I2S_RATES (SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000 | \
-			SNDRV_PCM_RATE_CONTINUOUS)
+#define PSC_I2S_RATES SNDRV_PCM_RATE_CONTINUOUS
 
 /**
  * PSC_I2S_FORMATS: audio formats supported by the PSC I2S mode
-- 
1.8.0
