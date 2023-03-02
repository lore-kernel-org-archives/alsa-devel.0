Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D484C678D4
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Mar 2023 10:48:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EC581F9;
	Thu,  2 Mar 2023 11:47:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EC581F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677754084;
	bh=E+uZPJ5ImeEw4jKqHJOYmftD7/Hh5Lbi/smaLMrAhZI=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ReAQLhVWYyRS1niZJGOO/qzAFnasONXj9km6di81aNS1flMpHsok0i/1g5ToptFQh
	 8M6YtxKeHDPEuuqmW3Dux2q3AzcZ6djrHO7+EOs29/u7qpJ2EfrgmBw8+Vwr1qGWUg
	 gg93K/8nLG8boOfr4U2mztakDW8iP1sl9cY3FC3E=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 26366F8049C;
	Thu,  2 Mar 2023 11:46:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B11C1F8049C; Thu,  2 Mar 2023 11:46:46 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5E090F80236
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2023 11:46:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E090F80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=E6+g09by
Received: by mail-wm1-x333.google.com with SMTP id
 r19-20020a05600c459300b003eb3e2a5e7bso1245727wmo.0
        for <alsa-devel@alsa-project.org>;
 Thu, 02 Mar 2023 02:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677753993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GO6tJSKGhuKgdHNgP3IEYgtiqFiDG7WtsDPxWBs+xKc=;
        b=E6+g09byyy+IW3IG+Z9rsgrNe2X8rBBoRl7EopRxtys36mVnmVl5GRdCVC8JuNM10g
         GT3Zmpbo3cfkeicd92FRIGrMY4kLlwlRc+r0MLqTH//P1e0uI/ZOnYhkoUsr5csmBALM
         FI7a9REbNUHREnzPKLZWtmQBSSRLg/JCf+oAus7LGmxe21A002xt2d8X5o7Ph7P3TqlC
         TZhVS0Bqu6H1GBQiW+itYbN/QoNQ1p8jf+vOoAmbQAsjIDnkTyaWMz/5QniNcaSTnj/X
         beYJCZbaKW8ELycRSIW1cCBDA6EaNd48Hi6e4iF3F/qnkHCIEEPbt2WFPipyg/y9KC8k
         TwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677753993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GO6tJSKGhuKgdHNgP3IEYgtiqFiDG7WtsDPxWBs+xKc=;
        b=dqQktUbyXk2mBacZ3UfdbFtNFKsthlDcYyWezFfiS6IidcP3k6z/KieYESd1vNc5uw
         InyiCU6aPO/NNMkwZfo2YhnKfZYTcz+vfIVPNjq+d1dOAVTTAsrDEMESdSQT6GmuIzwd
         C2MhtVeG6JHtAVfKvoq25e1l+q71oYhF0oN5wD6AyIBdZR41zuKK/q7WuUT8g7i6UIBe
         tixzhT9etDOEJwfQrXNh3dqTscb3ntalwmljhhIAl5cfyWomxpPAZ8/jFv218p3pKG0V
         wIFinkcL9x3pMSk/1yoO7iS/MrrQeTrRmI1rtFqgZTjiIbpVAZWM6z4DVsvc2llizMqD
         LjFQ==
X-Gm-Message-State: AO0yUKXZ4B0ioqsIks2NFdD+LUHgFeLi6CSaEJOrM5B4zkosYjBS+HPy
	QdHA3R1hNQNXSAxWxv/9LvlyRw==
X-Google-Smtp-Source: 
 AK7set9Djd/6Vxw96gglKjfyYL7bSnZSB5gVDpn5iQoeb4+SPKAZKAF6cOCxFs2oRJeyQX9fIQIPeA==
X-Received: by 2002:a05:600c:1608:b0:3df:e41f:8396 with SMTP id
 m8-20020a05600c160800b003dfe41f8396mr7078567wmn.37.1677753993153;
        Thu, 02 Mar 2023 02:46:33 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 iz2-20020a05600c554200b003e11ad0750csm2522592wmb.47.2023.03.02.02.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:46:32 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH] ASoC: qcom: common: add kcontrol to jack pins
Date: Thu,  2 Mar 2023 10:46:16 +0000
Message-Id: <20230302104616.26318-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Y3EBMGN3C7TM4J6H224DJ77XDSQUX4N6
X-Message-ID-Hash: Y3EBMGN3C7TM4J6H224DJ77XDSQUX4N6
X-MailFrom: srinivas.kandagatla@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: lgirdwood@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, steev@kali.org, johan+linaro@kernel.org,
 quic_bjorande@quicinc.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y3EBMGN3C7TM4J6H224DJ77XDSQUX4N6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add Kcontrol to jack pins so that device switch in ucm can be done correctly.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/common.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 96fe80241fb4..c1f24af17506 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -180,6 +180,18 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 }
 EXPORT_SYMBOL_GPL(qcom_snd_parse_of);
 
+static struct snd_soc_jack_pin qcom_headset_jack_pins[] = {
+	/* Headset */
+	{
+		.pin = "Mic Jack",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+
 int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 			    struct snd_soc_jack *jack, bool *jack_setup)
 {
@@ -189,13 +201,14 @@ int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 	int rval, i;
 
 	if (!*jack_setup) {
-		rval = snd_soc_card_jack_new(card, "Headset Jack",
+		rval = snd_soc_card_jack_new_pins(card, "Headset Jack",
 					     SND_JACK_HEADSET | SND_JACK_LINEOUT |
 					     SND_JACK_MECHANICAL |
 					     SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 					     SND_JACK_BTN_2 | SND_JACK_BTN_3 |
 					     SND_JACK_BTN_4 | SND_JACK_BTN_5,
-					     jack);
+					     jack, qcom_headset_jack_pins,
+					     ARRAY_SIZE(qcom_headset_jack_pins));
 
 		if (rval < 0) {
 			dev_err(card->dev, "Unable to add Headphone Jack\n");
-- 
2.21.0

