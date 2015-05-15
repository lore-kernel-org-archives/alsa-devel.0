From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] ASoC: lm49453: Replace direct
	snd_soc_codec dapm field access
Date: Fri, 15 May 2015 12:32:54 +0200
Message-ID: <1431685980-6600-2-git-send-email-lars@metafoo.de>
References: <1431685980-6600-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-168.synserver.de (smtp-out-168.synserver.de
 [212.40.185.168])
 by alsa0.perex.cz (Postfix) with ESMTP id F10482661CD
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 12:33:05 +0200 (CEST)
In-Reply-To: <1431685980-6600-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/lm49453.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 166fd4c..6600aa0 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1271,7 +1271,7 @@ static int lm49453_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
 			regcache_sync(lm49453->regmap);
 
 		snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
-- 
1.8.0
