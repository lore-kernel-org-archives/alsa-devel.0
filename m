From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/8] ASoC: tlv320dac33: Replace direct
	snd_soc_codec dapm field access
Date: Fri, 15 May 2015 12:32:58 +0200
Message-ID: <1431685980-6600-6-git-send-email-lars@metafoo.de>
References: <1431685980-6600-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-168.synserver.de (smtp-out-168.synserver.de
 [212.40.185.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 3581E2664BF
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 12:33:09 +0200 (CEST)
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
 sound/soc/codecs/tlv320dac33.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 33e93f6..d67a311 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -633,7 +633,7 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			/* Coming from OFF, switch on the codec */
 			ret = dac33_hard_power(codec, 1);
 			if (ret != 0)
@@ -644,7 +644,7 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* Do not power off, when the codec is already off */
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
 			return 0;
 		ret = dac33_hard_power(codec, 0);
 		if (ret != 0)
-- 
1.8.0
