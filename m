From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/11] ASoC: cx20442: Replace direct
	snd_soc_codec dapm field access
Date: Mon, 11 May 2015 09:42:29 +0200
Message-ID: <1431330156-16706-4-git-send-email-lars@metafoo.de>
References: <1431330156-16706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-107.synserver.de (smtp-out-107.synserver.de
 [212.40.185.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 037C926067F
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 09:42:45 +0200 (CEST)
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
 sound/soc/codecs/cx20442.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 13041cc..d6f4abb 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -333,7 +333,7 @@ static int cx20442_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
-		if (codec->dapm.bias_level != SND_SOC_BIAS_STANDBY)
+		if (snd_soc_codec_get_bias_level(codec) != SND_SOC_BIAS_STANDBY)
 			break;
 		if (IS_ERR(cx20442->por))
 			err = PTR_ERR(cx20442->por);
@@ -341,7 +341,7 @@ static int cx20442_set_bias_level(struct snd_soc_codec *codec,
 			err = regulator_enable(cx20442->por);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level != SND_SOC_BIAS_PREPARE)
+		if (snd_soc_codec_get_bias_level(codec) != SND_SOC_BIAS_PREPARE)
 			break;
 		if (IS_ERR(cx20442->por))
 			err = PTR_ERR(cx20442->por);
-- 
1.8.0
