From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: kirkwood-i2s: Inline
	KIRKWOOD_I2S_RATES
Date: Tue, 16 Jul 2013 10:55:06 +0100
Message-ID: <1373968506-22375-2-git-send-email-broonie@kernel.org>
References: <1373968506-22375-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 80707261B1C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 11:55:12 +0200 (CEST)
In-Reply-To: <1373968506-22375-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The addition of extclk support makes this misleading as it's only the
rates used when there is no extclk so put it in the specific DAI it
applies to.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index becc082..e6027fd 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -26,9 +26,6 @@
 
 #define DRV_NAME	"kirkwood-i2s"
 
-#define KIRKWOOD_I2S_RATES \
-	(SNDRV_PCM_RATE_44100 | \
-	 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
 #define KIRKWOOD_I2S_FORMATS \
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE | \
@@ -411,13 +408,15 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = KIRKWOOD_I2S_RATES,
+		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+				SNDRV_PCM_RATE_96000,
 		.formats = KIRKWOOD_I2S_FORMATS,
 	},
 	.capture = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = KIRKWOOD_I2S_RATES,
+		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+				SNDRV_PCM_RATE_96000,
 		.formats = KIRKWOOD_I2S_FORMATS,
 	},
 	.ops = &kirkwood_i2s_dai_ops,
-- 
1.8.3.2
