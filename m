From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/4] ASoC: max98090: Use params_width() rather
	than memory format
Date: Wed,  8 Jan 2014 20:40:42 +0000
Message-ID: <1389213644-11167-2-git-send-email-broonie@kernel.org>
References: <1389213644-11167-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 40DE1262607
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 21:40:58 +0100 (CET)
In-Reply-To: <1389213644-11167-1-git-send-email-broonie@kernel.org>
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
 sound/soc/codecs/max98090.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 0569a4c3ae00..51f9b3d16b41 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1840,8 +1840,8 @@ static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 
 	max98090->lrclk = params_rate(params);
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		snd_soc_update_bits(codec, M98090_REG_INTERFACE_FORMAT,
 			M98090_WS_MASK, 0);
 		break;
-- 
1.8.5.2
