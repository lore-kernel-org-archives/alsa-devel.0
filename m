Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ADAC47255
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 13:28:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB445206B7
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 13:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YGu2yn6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB445206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B7A686F;
	Mon, 11 May 2020 15:27:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B7A686F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589203711;
	bh=AU/wlzmZQnActhUV6QTQhpH5oZDiPwcVwgXCVVvKS9s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YGu2yn6XJC0NoOemH2IqLbS342KkaOxD5QI/AShv7omEoBK4sWF49Ez7FOUUJtkUo
	 9QQld3ghOBrz0zM/y03sat4MLgskvjpaic5QGHuX1qQjElAUj3o2IZZFOy7lo6I6b2
	 ceAXeiiSMKpm/WVDMMk71uNEDiyyZ5RAzuJbr/3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 243DBF800E3;
	Mon, 11 May 2020 15:26:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BF8AF80299; Mon, 11 May 2020 15:26:01 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4F0FF800E3
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 15:25:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4F0FF800E3
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id D49872A15C2
Received: by jupiter.universe (Postfix, from userid 1000)
 id E0EA6480103; Mon, 11 May 2020 15:25:45 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Support Opensource <support.opensource@diasemi.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCHv3 3/5] ASoC: da7213: move set_sysclk to codec level
Date: Mon, 11 May 2020 15:25:42 +0200
Message-Id: <20200511132544.82364-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511132544.82364-1-sebastian.reichel@collabora.com>
References: <20200511132544.82364-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, kernel@collabora.com,
 Sebastian Reichel <sebastian.reichel@collabora.com>
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

Move set_sysclk function to component level, so that it can be used at
both component and DAI level.

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 sound/soc/codecs/da7213.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 0359249118d0..9686948b16ea 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1343,10 +1343,10 @@ static int da7213_mute(struct snd_soc_dai *dai, int mute)
 #define DA7213_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-				 int clk_id, unsigned int freq, int dir)
+static int da7213_set_component_sysclk(struct snd_soc_component *component,
+				       int clk_id, int source,
+				       unsigned int freq, int dir)
 {
-	struct snd_soc_component *component = codec_dai->component;
 	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
@@ -1354,7 +1354,7 @@ static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		return 0;
 
 	if (((freq < 5000000) && (freq != 32768)) || (freq > 54000000)) {
-		dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
+		dev_err(component->dev, "Unsupported MCLK value %d\n",
 			freq);
 		return -EINVAL;
 	}
@@ -1370,7 +1370,7 @@ static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				    DA7213_PLL_MCLK_SQR_EN);
 		break;
 	default:
-		dev_err(codec_dai->dev, "Unknown clock source %d\n", clk_id);
+		dev_err(component->dev, "Unknown clock source %d\n", clk_id);
 		return -EINVAL;
 	}
 
@@ -1380,7 +1380,7 @@ static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		freq = clk_round_rate(da7213->mclk, freq);
 		ret = clk_set_rate(da7213->mclk, freq);
 		if (ret) {
-			dev_err(codec_dai->dev, "Failed to set clock rate %d\n",
+			dev_err(component->dev, "Failed to set clock rate %d\n",
 				freq);
 			return ret;
 		}
@@ -1507,7 +1507,6 @@ static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 static const struct snd_soc_dai_ops da7213_dai_ops = {
 	.hw_params	= da7213_hw_params,
 	.set_fmt	= da7213_set_dai_fmt,
-	.set_sysclk	= da7213_set_dai_sysclk,
 	.set_pll	= da7213_set_dai_pll,
 	.digital_mute	= da7213_mute,
 };
@@ -1845,6 +1844,7 @@ static const struct snd_soc_component_driver soc_component_dev_da7213 = {
 	.num_dapm_widgets	= ARRAY_SIZE(da7213_dapm_widgets),
 	.dapm_routes		= da7213_audio_map,
 	.num_dapm_routes	= ARRAY_SIZE(da7213_audio_map),
+	.set_sysclk		= da7213_set_component_sysclk,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-- 
2.26.2

