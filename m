From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Thu, 26 Jun 2014 08:06:55 +0300
Message-ID: <1403759216-14427-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 1214E262632
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 07:07:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Correct the hw_params callback to configure the codec correctly in case of
S24_3LE format since in case of S24_3LE the codec has been configured to
16bit format mode.
S24_LE is not defined as supported format for the codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index e12fafbb1e09..5360772bc1ad 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -879,7 +879,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S20_3LE:
 		data |= (0x01 << 4);
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
 		data |= (0x02 << 4);
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-- 
2.0.0
