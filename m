From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: ssm2518: Convert to params_width()
Date: Thu, 31 Jul 2014 13:18:18 +0100
Message-ID: <1406809099-18597-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 486CB26562A
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:18:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The CODEC doesn't care how data is laid out in memory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ssm2518.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index 56adb3e2def9..e8680bea5f86 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -361,11 +361,11 @@ static int ssm2518_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	if (ssm2518->right_j) {
-		switch (params_format(params)) {
-		case SNDRV_PCM_FORMAT_S16_LE:
+		switch (params_width(params)) {
+		case 16:
 			ctrl1 |= SSM2518_SAI_CTRL1_FMT_RJ_16BIT;
 			break;
-		case SNDRV_PCM_FORMAT_S24_LE:
+		case 24:
 			ctrl1 |= SSM2518_SAI_CTRL1_FMT_RJ_24BIT;
 			break;
 		default:
-- 
2.0.1
