From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/4] ASoC: max98088: Use params_width() rather
	than memory format
Date: Wed,  8 Jan 2014 20:40:41 +0000
Message-ID: <1389213644-11167-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4547C265010
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 21:40:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwoog@dmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max98088.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 53d7dab4e054..ee660e2d3df3 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1233,12 +1233,12 @@ static int max98088_dai1_hw_params(struct snd_pcm_substream *substream,
 
        rate = params_rate(params);
 
-       switch (params_format(params)) {
-       case SNDRV_PCM_FORMAT_S16_LE:
+       switch (params_width(params)) {
+       case 16:
                snd_soc_update_bits(codec, M98088_REG_14_DAI1_FORMAT,
                        M98088_DAI_WS, 0);
                break;
-       case SNDRV_PCM_FORMAT_S24_LE:
+       case 24:
                snd_soc_update_bits(codec, M98088_REG_14_DAI1_FORMAT,
                        M98088_DAI_WS, M98088_DAI_WS);
                break;
-- 
1.8.5.2
