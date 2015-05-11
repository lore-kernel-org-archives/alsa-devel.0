From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/11] ASoC: ml26124: Replace direct
	snd_soc_codec dapm field access
Date: Mon, 11 May 2015 09:42:32 +0200
Message-ID: <1431330156-16706-7-git-send-email-lars@metafoo.de>
References: <1431330156-16706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-107.synserver.de (smtp-out-107.synserver.de
 [212.40.185.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 594C32606BC
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 09:42:47 +0200 (CEST)
In-Reply-To: <1431330156-16706-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Rongjun Ying <rongjun.ying@csr.com>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ml26124.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index f1d5778..62dda24 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -523,7 +523,7 @@ static int ml26124_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* VMID ON */
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			snd_soc_update_bits(codec, ML26124_PW_REF_PW_MNG,
 					    ML26124_VMID, ML26124_VMID);
 			msleep(500);
-- 
1.8.0
