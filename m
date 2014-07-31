From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/4] ASoC: si476x: Convert to params_width()
Date: Thu, 31 Jul 2014 13:25:08 +0100
Message-ID: <1406809509-21544-4-git-send-email-broonie@kernel.org>
References: <1406809509-21544-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D2662656A0
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:25:24 +0200 (CEST)
In-Reply-To: <1406809509-21544-1-git-send-email-broonie@kernel.org>
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
 sound/soc/codecs/si476x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index f26befb0c297..cdf882fa7716 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -167,17 +167,17 @@ static int si476x_codec_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
+	switch (params_width(params)) {
+	case 8:
 		width = SI476X_PCM_FORMAT_S8;
 		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
+	case 16:
 		width = SI476X_PCM_FORMAT_S16_LE;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		width = SI476X_PCM_FORMAT_S20_3LE;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		width = SI476X_PCM_FORMAT_S24_LE;
 		break;
 	default:
-- 
2.0.1
