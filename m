Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0C6C04A6A
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Aug 2023 06:37:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53FFEDEE;
	Thu, 10 Aug 2023 08:36:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53FFEDEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691649441;
	bh=w9MDG2PIM2l+0VigNM1gBOHusv4bWzePxyDJCWMZnMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=edmn3DovhHcSAaJuq+XXuKhhthOa3GdLQbrB582W7VTMYAP6G+UGcrBjWYln0pibb
	 b146oOsEf53w53KybjbQbT/Hq/SsZ0iGOCxkclgYZDjg+j8XM9zp6vEWdVusBrQ4XA
	 VjQL3lcl65E1IHN1RK4Cra5GCEjFj2VHA5wRBZaA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B63B2F805B0; Thu, 10 Aug 2023 08:35:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 50FF5F805B0;
	Thu, 10 Aug 2023 08:35:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88A1DF80508; Thu, 10 Aug 2023 08:35:18 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57E27F8056F
	for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2023 08:33:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57E27F8056F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mZi34Ufd
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b9aa1d3029so8773931fa.2
        for <alsa-devel@alsa-project.org>;
 Wed, 09 Aug 2023 23:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691649206; x=1692254006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMM3/oOp03VQdiM5UtFP36bUtHvT73/cLwCpo+QdiIw=;
        b=mZi34UfdwwcDjlmRaN1sPV1Che6maw8DFhkpB5rlbV0q8J/t0iDdS/XpmNucnylJ3O
         vyE0k7yv6OQFCEw9vAiWkjStNiV4ON3E3/xElpQ7NEq0kSZ1ViuYVDnrkY8Scyj/jCmb
         jMOEwrRNdGsT2TIXKhvOODWDSAvMvm54g8VBCVAnvSeidAP/qalWZRgxGeNBuPJ92nw9
         OAweLoETqOOEX40mYzOkfOWLZce93VOvyJteawZl7vUCJVilbW5cz/YIXuaEECihqyoU
         sFSj748PEHeleeu7icxX4GlevJXwiCncCPSznc59NSRYeOwUMNOAXHaAgPqVO9/sqGF7
         pR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649206; x=1692254006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMM3/oOp03VQdiM5UtFP36bUtHvT73/cLwCpo+QdiIw=;
        b=gNx2Ic3Jw0fA0oq2uC7bpapHuEDE4y/e2v6mV/fa/dhaALcico+JamEVvmeXzZhyZa
         5T6WrRarn00E1tU0HlBe5/eoeWcVH4P3IxYEcAcxn9U1oAw/UKFEJwodH95Rg17+YBVz
         a9We5bM9IDfTktCJ6RiFuLFTbhbh5x78dKPzNL1xV4QaRF8Ku5OgCX9QAkUUTbMb1So/
         fM830XOqvi3mlskSmavgcznMaJjzTy9s5QOiKy4LfQ8hYf2ywmB/zjthKeN8WEPCh4E0
         PYyI3apgOcjGJZYid1/P1wK3+FRXcK3kjPCjvVAO4XBaDQW9A92gWqe8N/PNYpOQLtZv
         PfgA==
X-Gm-Message-State: AOJu0YxHMAUUw4/SImiHsyB0c2UlCB23SbV2PZ7rj8C3+aaqyAhob+l0
	YQ7DInRFfm4JYl2AW0aphw493w==
X-Google-Smtp-Source: 
 AGHT+IHJTabwknAAKRbDkyzBHhTtyG9imru5J2ltmZDPIQ9zQT0DI6lytWnPcjQ+HDIYznE8ecpa4w==
X-Received: by 2002:a2e:3203:0:b0:2b6:e3d5:76a7 with SMTP id
 y3-20020a2e3203000000b002b6e3d576a7mr974468ljy.24.1691649206283;
        Wed, 09 Aug 2023 23:33:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fe2b6d64c8sm4020018wmc.21.2023.08.09.23.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:33:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Rohit kumar <quic_rohkumar@quicinc.com>,
	Cheng-Yi Chiang <cychiang@chromium.org>,
	Rao Mandadapu <srivasam@codeaurora.org>,
	Judy Hsiao <judyhsiao@chromium.org>,
	Trevor Wu <trevor.wu@mediatek.com>,
	Jonathan Bakker <xc-racer2@live.ca>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 10/11] ASoC: samsung: odroid: parse audio-routing
Date: Thu, 10 Aug 2023 08:32:58 +0200
Message-Id: <20230810063300.20151-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
References: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NBWT4LWUXDOHHUFE46LZQDB2CB4L7ST6
X-Message-ID-Hash: NBWT4LWUXDOHHUFE46LZQDB2CB4L7ST6
X-MailFrom: krzysztof.kozlowski@linaro.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NBWT4LWUXDOHHUFE46LZQDB2CB4L7ST6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Parse generic sound card "audio-routing" property and fallback to
"samsung,audio-routing" if it is missing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/samsung/odroid.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 1743bd55ba1a..c93cb5a86426 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -230,12 +230,13 @@ static int odroid_audio_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	if (of_property_present(dev->of_node, "samsung,audio-routing")) {
-		ret = snd_soc_of_parse_audio_routing(card,
-						"samsung,audio-routing");
-		if (ret < 0)
-			return ret;
-	}
+	ret = 0;
+	if (of_property_present(dev->of_node, "audio-routing"))
+		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
+	else if (of_property_present(dev->of_node, "samsung,audio-routing"))
+		ret = snd_soc_of_parse_audio_routing(card, "samsung,audio-routing");
+	if (ret < 0)
+		return ret;
 
 	card->dai_link = odroid_card_dais;
 	card->num_links = ARRAY_SIZE(odroid_card_dais);
-- 
2.34.1

