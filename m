Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F00FC4167D
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 15:40:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CCEF1678;
	Wed, 23 Nov 2022 16:39:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CCEF1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669217999;
	bh=bfI8ZPep+XyaB2YgdIgbr9A8t005+5vXk/cPOTL24JM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f5ZBQMvI0RAI6S95gVXlQPBucli/WlbQBGHSjuhdeVQKKvLTNglxFqdn8oJ1i1Wj8
	 IYWx0xXMECT1pgSj3TmemC9Js0Hp7LRp7KmpQk5ILJiOSavcRRV1cZj2coyy86femm
	 t94XT0Zivfce9jc7YsrUv7Ka/VDjdde3nX9Uwydw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28292F80249;
	Wed, 23 Nov 2022 16:39:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52CC5F80149; Wed, 23 Nov 2022 16:39:08 +0100 (CET)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C5DAF80149
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 16:39:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C5DAF80149
From: Pavel Dobias <dobias@2n.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: max9867: Implement exact integer mode
Date: Wed, 23 Nov 2022 16:38:18 +0100
Message-ID: <20221123153818.24650-1-dobias@2n.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail03w.axis.com (10.20.40.9) To se-mail01w.axis.com
 (10.20.40.7)
Cc: dobias@2n.com, alsa-devel@alsa-project.org, kernel@axis.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

For 8kHz and 16kHz sample rates and certain PCLK values
the codec can be programmed to operate in exact integer
mode. If available, use it to achieve the exact sample rate.

Signed-off-by: Pavel Dobias <dobias@2n.com>
---
 sound/soc/codecs/max9867.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 6d2941a9dbd6..e161ab037bf7 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -323,7 +323,7 @@ static int max9867_startup(struct snd_pcm_substream *substream,
 static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	int value;
+	int value, freq = 0;
 	unsigned long int rate, ratio;
 	struct snd_soc_component *component = dai->component;
 	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
@@ -373,6 +373,35 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 		}
 		regmap_update_bits(max9867->regmap, MAX9867_IFC1B,
 			MAX9867_IFC1B_BCLK_MASK, value);
+
+		/* Exact integer mode available for 8kHz and 16kHz sample rates
+		 * and certain PCLK (prescaled MCLK) values.
+		 */
+		if (params_rate(params) == 8000 ||
+		    params_rate(params) == 16000) {
+			switch (max9867->pclk) {
+			case 12000000:
+				freq = 0x08;
+				break;
+			case 13000000:
+				freq = 0x0A;
+				break;
+			case 16000000:
+				freq = 0x0C;
+				break;
+			case 19200000:
+				freq = 0x0E;
+				break;
+			}
+		}
+		if (freq && params_rate(params) == 16000)
+			freq++;
+
+		/* If exact integer mode not available, the freq value
+		 * remains zero, i.e. normal mode is used.
+		 */
+		regmap_update_bits(max9867->regmap, MAX9867_SYSCLK,
+				   MAX9867_FREQ_MASK, freq);
 	} else {
 		/*
 		 * digital pll locks on to any externally supplied LRCLK signal
@@ -428,8 +457,6 @@ static int max9867_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 			 freq);
 	max9867->sysclk = freq;
 	value = value << MAX9867_PSCLK_SHIFT;
-	/* exact integer mode is not supported */
-	value &= ~MAX9867_FREQ_MASK;
 	regmap_update_bits(max9867->regmap, MAX9867_SYSCLK,
 			MAX9867_PSCLK_MASK, value);
 	return 0;
-- 
2.20.1

