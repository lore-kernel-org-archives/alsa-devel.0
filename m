From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/4] ASoC: sgtl5000: Convert to params_width()
Date: Thu, 31 Jul 2014 13:25:09 +0100
Message-ID: <1406809509-21544-5-git-send-email-broonie@kernel.org>
References: <1406809509-21544-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B0FB265924
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
 sound/soc/codecs/sgtl5000.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d739f83380a8..e997d271728d 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -724,25 +724,25 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/* set i2s data format */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		if (sgtl5000->fmt == SND_SOC_DAIFMT_RIGHT_J)
 			return -EINVAL;
 		i2s_ctl |= SGTL5000_I2S_DLEN_16 << SGTL5000_I2S_DLEN_SHIFT;
 		i2s_ctl |= SGTL5000_I2S_SCLKFREQ_32FS <<
 		    SGTL5000_I2S_SCLKFREQ_SHIFT;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		i2s_ctl |= SGTL5000_I2S_DLEN_20 << SGTL5000_I2S_DLEN_SHIFT;
 		i2s_ctl |= SGTL5000_I2S_SCLKFREQ_64FS <<
 		    SGTL5000_I2S_SCLKFREQ_SHIFT;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		i2s_ctl |= SGTL5000_I2S_DLEN_24 << SGTL5000_I2S_DLEN_SHIFT;
 		i2s_ctl |= SGTL5000_I2S_SCLKFREQ_64FS <<
 		    SGTL5000_I2S_SCLKFREQ_SHIFT;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		if (sgtl5000->fmt == SND_SOC_DAIFMT_RIGHT_J)
 			return -EINVAL;
 		i2s_ctl |= SGTL5000_I2S_DLEN_32 << SGTL5000_I2S_DLEN_SHIFT;
-- 
2.0.1
