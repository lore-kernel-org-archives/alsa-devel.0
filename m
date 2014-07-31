From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/5] ASoC: sn95031: Convert to params_width()
Date: Thu, 31 Jul 2014 13:02:19 +0100
Message-ID: <1406808143-8985-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A00632655BB
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:02:36 +0200 (CEST)
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
 sound/soc/codecs/sn95031.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 42dff26b3a2a..cf8fa40662f0 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -661,12 +661,12 @@ static int sn95031_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	unsigned int format, rate;
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		format = BIT(4)|BIT(5);
 		break;
 
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		format = 0;
 		break;
 	default:
-- 
2.0.1
