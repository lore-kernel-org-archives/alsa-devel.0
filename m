From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/5] ASoC: uda134x: Convert to params_width()
Date: Thu, 31 Jul 2014 13:02:22 +0100
Message-ID: <1406808143-8985-4-git-send-email-broonie@kernel.org>
References: <1406808143-8985-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 556472655C7
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:02:41 +0200 (CEST)
In-Reply-To: <1406808143-8985-1-git-send-email-broonie@kernel.org>
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

The CODEC doesn't care how data is laid out in memory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/uda134x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 12fc0aed7503..32b2f78aa62c 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -243,14 +243,14 @@ static int uda134x_hw_params(struct snd_pcm_substream *substream,
 	case SND_SOC_DAIFMT_I2S:
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
-		switch (params_format(params)) {
-		case SNDRV_PCM_FORMAT_S16_LE:
+		switch (params_width(params)) {
+		case 16:
 			hw_params |= (1<<1);
 			break;
-		case SNDRV_PCM_FORMAT_S18_3LE:
+		case 18:
 			hw_params |= (1<<2);
 			break;
-		case SNDRV_PCM_FORMAT_S20_3LE:
+		case 20:
 			hw_params |= ((1<<2) | (1<<1));
 			break;
 		default:
-- 
2.0.1
