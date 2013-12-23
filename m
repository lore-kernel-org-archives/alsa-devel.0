From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ad1836: Reject unsupported bit sizes
Date: Mon, 23 Dec 2013 12:43:35 +0000
Message-ID: <1387802615-27753-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C9222608B7
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2013 13:43:51 +0100 (CET)
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

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ad1836.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 9a92b79..d7c9838 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -179,6 +179,8 @@ static int ad1836_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S32_LE:
 		word_len = AD1836_WORD_LEN_24;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	regmap_update_bits(ad1836->regmap, AD1836_DAC_CTRL1,
-- 
1.8.5.2
