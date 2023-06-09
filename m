Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C2DC7EE29
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jun 2023 14:55:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA72DA4D;
	Fri,  9 Jun 2023 16:54:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA72DA4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686322515;
	bh=rwkX+GrjqTA2Tm2gBMivuGVIrC0Zk5mpJ23KVX/5Mls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LRjkoMjbcaDqqSKbMILQ5xB+HY/thIGJmeX2JRzcWjrjxCiBL7dNpNt7fHVoL9pwf
	 SP3yUihuNQwdVv/ZKJkG0LPAa/tgIgx8p5IRZD9E7M9YqbxbEm4IuWR4OgVtwfE0hQ
	 4ocEIK5RL//VFo7O63LlrPnz3gr8wmShi8jGMQ38=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8780CF80552; Fri,  9 Jun 2023 16:54:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F2B09F80553;
	Fri,  9 Jun 2023 16:54:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C1E8F80199; Fri,  9 Jun 2023 16:54:20 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 27793F800C8
	for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2023 16:54:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27793F800C8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=pYx6AAYX
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f7fcdc7f7fso12652845e9.0
        for <alsa-devel@alsa-project.org>;
 Fri, 09 Jun 2023 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322456; x=1688914456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ViS6qF8cS4iDl2a+diQ/4R9Vhl6rQuGyv9+232yC8g=;
        b=pYx6AAYX31qs1F2OdJbIgSLF5yMv3UfFa3oRnRll8KhhrmjwB3eEme0y1/+w3+P5bg
         idMNOEjcnlLemtdf/DSiN/3bybugS+OpaCxhTS/w7CXjZ9OwnE6bm/G89LRJQFiV4yzD
         hEJYKN0j72BaoMJuD/kUZbWg+yXlp1pUO+mmU40Y3H3kugF/792D1SskLtB9BFtflClQ
         fesCobyMVy3iaixO7aJFfh7MzgsF2nVbuPn9CHQ+ZIRGcj8+fGjAvTvCZJypMro1e9sS
         6Umvo4fTd8nEamBKl8wWca8/pKDVdU3YlnN5Vo80gFlB5Av89qsqtjwaQGSVX1FhoYit
         mokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322456; x=1688914456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ViS6qF8cS4iDl2a+diQ/4R9Vhl6rQuGyv9+232yC8g=;
        b=ED7G6vNHSG7F7x7Uk699pV4xfc1K/FhpOdZoqNgODUD5Dx+L0gxD0+1sq5r9GVagX2
         8tenTdHtcZQ8Q0AmodzUWw08nClh7Hs/WrouTqK82VKiU2cC67knWABKCMt3rakcAHXi
         JQoV0HyG5Qh1jWL/zwKVMd9W1oSys9cPBlZSMrjXVMTJDOZtIDXAUHTSYAKJNxjxlnWJ
         kHdkdIf8+8Av94wol6vIgd2Yaw0dGiLe5pr76Zt+kxCTRwPQA/CHUUmJLM7wqWkOnHa/
         o42f6pGlyXKwGs7IpCFP0V8Ug7xmZH+s5AfkiLZX964rC6ISx1gWlnOpXsSKBxCJkhYR
         95cQ==
X-Gm-Message-State: AC+VfDwVlIBDGZ6s/bo4XPjp3nStWKBMWmK5aOFo6nF6D/P1VCSymduh
	HRTIfAA4il2N3nJmwcKF6WLSYA==
X-Google-Smtp-Source: 
 ACHHUZ6XJv+CElBwzddgkPF/3BDt6V+kN3w98q7v8ajDl+3UTsnaK0Y5g9kA2jnZsi6MOEamkqZNvQ==
X-Received: by 2002:a05:600c:3b29:b0:3f7:ec1d:21b3 with SMTP id
 m41-20020a05600c3b2900b003f7ec1d21b3mr4169683wms.5.1686322455438;
        Fri, 09 Jun 2023 07:54:15 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 c21-20020a05600c0ad500b003f7310a3ffasm2946632wmr.2.2023.06.09.07.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:54:14 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	ckeepax@opensource.cirrus.com,
	kuninori.morimoto.gx@renesas.com,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	alsa-devel@alsa-project.org,
	Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 01/11] ASoC: qcom: SC7280: audioreach: Add sc7280 hardware
 param fixup callback
Date: Fri,  9 Jun 2023 15:53:57 +0100
Message-Id: <20230609145407.18774-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
References: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TXVSUXXUOW2AJAZDSHCXKGVCXXVDYGXE
X-Message-ID-Hash: TXVSUXXUOW2AJAZDSHCXKGVCXXVDYGXE
X-MailFrom: srinivas.kandagatla@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TXVSUXXUOW2AJAZDSHCXKGVCXXVDYGXE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>

Add support to set backend params such as sampling rate and
number of channels using backend params fixup callback.
Also add no pcm check for hardware params constraints setting.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sc7280.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index da7469a6a267..787dd49e03f6 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -14,6 +14,7 @@
 #include <sound/soc.h>
 #include <sound/rt5682s.h>
 #include <linux/soundwire/sdw.h>
+#include <sound/pcm_params.h>
 
 #include "../codecs/rt5682.h"
 #include "../codecs/rt5682s.h"
@@ -196,8 +197,10 @@ static int sc7280_snd_hw_params(struct snd_pcm_substream *substream,
 	struct sdw_stream_runtime *sruntime;
 	int i;
 
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE, 48000, 48000);
+	if (!rtd->dai_link->no_pcm) {
+		snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
+		snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE, 48000, 48000);
+	}
 
 	switch (cpu_dai->id) {
 	case LPASS_CDC_DMA_TX3:
@@ -358,6 +361,20 @@ static const struct snd_soc_dapm_widget sc7280_snd_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 };
 
+static int sc7280_snd_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+					 struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
+
+	return 0;
+}
+
 static int sc7280_snd_platform_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
@@ -387,6 +404,8 @@ static int sc7280_snd_platform_probe(struct platform_device *pdev)
 	for_each_card_prelinks(card, i, link) {
 		link->init = sc7280_init;
 		link->ops = &sc7280_ops;
+		if (link->no_pcm == 1)
+			link->be_hw_params_fixup = sc7280_snd_be_hw_params_fixup;
 	}
 
 	return devm_snd_soc_register_card(dev, card);
-- 
2.21.0

