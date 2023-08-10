Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7CDC001DB
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Aug 2023 06:36:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F97483B;
	Thu, 10 Aug 2023 08:35:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F97483B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691649379;
	bh=4ysxaoQFB8nEupVjghFlT1AKWoz8nkJRatdN58BopKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QrZFzboCgE5lr9amhUwiJNdy1JaYMYDUzBdh+eFNzJHWqhwio/Z1exxXyOCqEhnJx
	 ROheKcf7Tye50zn4wJj7EYAmzib7ozytGuxDvCdN45ePXrNXhMd1CXU4PAtCPJYhb/
	 C8Q4VIVgv6BBlJkeDZ3j3nJJ672IfNgQkkXCq2ww=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1629AF805BB; Thu, 10 Aug 2023 08:34:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67208F805AF;
	Thu, 10 Aug 2023 08:34:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC83CF80564; Thu, 10 Aug 2023 08:33:36 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DE599F80551
	for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2023 08:33:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE599F80551
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nLzSxmdC
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso4988495e9.1
        for <alsa-devel@alsa-project.org>;
 Wed, 09 Aug 2023 23:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691649203; x=1692254003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNOB2kSBm/ZCjLUQLsGBk0BsOPSn2yUKgs+5rBFTqgc=;
        b=nLzSxmdCld1p6/GNXMg8hXGakyqAdX2VctistK9WujPaXg2PnipVH+tA2okLWW90UN
         YK/BFf8rIAf9y9/FGQ16JTl3nEBJ/MahEeOfpBlHh+TGbMxyT3EbfPpUk4Sm9grnzt2z
         gZp/ofk3kXabjgpR2yA9JR5MjMdRURursj822tzChJxLFRvP1VLsc0LlKXQT0c6d+ti9
         rSq3OGfAnGXEG0/5D0ATH2CgUFxhUIBl4ymOlV3u6DabbmQOrsaSODD0uljC0IGsD/tD
         OezEw1qzk81Eqwk/q90jugj+om1k4tatpOqQqvVcsUpFq19K3NW2VUO7WrhFuFTXTL0G
         vZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649203; x=1692254003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNOB2kSBm/ZCjLUQLsGBk0BsOPSn2yUKgs+5rBFTqgc=;
        b=TmyRs6ahEUhUPbBTgLj4I5NaNRxPNX2TU4l/IkCI1wFM99gh0lJ+SOu8s3a92VXYD7
         Y4E3xBe1Sa5FWvAT9Qn/jwABFpD/qBY0sN/webZy7Ju2yBCbDHnlhk1VidLV9usFrRSw
         VBCAV76cPsbaU8F0xbPT7qLjcg+RiKk/bF/T6ZCa0f9kZ2+puCgCzBnGetgnrySow/C+
         etD9X8WQYwQpQ5ZLpcPe8jJ7gk34p1RY53hjXOcgdRGMxMCqS9L/a8aw/IR1V3vwZAuW
         GQy4jRciZEdkkw0inD7yZcB+5AfOrkmHgW9Ugm9FDUjDqj+B9YBWv/z1s0bTuB4b8pXP
         yh5A==
X-Gm-Message-State: AOJu0Yw1z5VSOF4/Xn0Z+VGOBVx24WakkYu8WCZLdPUX4MsAUlWoxUa7
	r99CIeTkdVRYmXjBv5q8ebnOgA==
X-Google-Smtp-Source: 
 AGHT+IHTzWeiFzQtz6B61NWeYjn6qIfVxR+QqP5IsC0pkDiH1Mt6bYQC6K+5H8AdGVl3d82V9DJTJw==
X-Received: by 2002:a05:600c:d6:b0:3fe:1cac:37d7 with SMTP id
 u22-20020a05600c00d600b003fe1cac37d7mr1221145wmm.10.1691649203041;
        Wed, 09 Aug 2023 23:33:23 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fe2b6d64c8sm4020018wmc.21.2023.08.09.23.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:33:22 -0700 (PDT)
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
Subject: [PATCH v2 09/11] ASoC: samsung: midas_wm1811: parse audio-routing
Date: Thu, 10 Aug 2023 08:32:57 +0200
Message-Id: <20230810063300.20151-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
References: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Q57K4ZMARZEXWD4EDEF4GZORIVQXYAGG
X-Message-ID-Hash: Q57K4ZMARZEXWD4EDEF4GZORIVQXYAGG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q57K4ZMARZEXWD4EDEF4GZORIVQXYAGG/>
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
 sound/soc/samsung/midas_wm1811.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/midas_wm1811.c b/sound/soc/samsung/midas_wm1811.c
index 6931b9a45b3e..9e83ed071f39 100644
--- a/sound/soc/samsung/midas_wm1811.c
+++ b/sound/soc/samsung/midas_wm1811.c
@@ -462,10 +462,14 @@ static int midas_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = snd_soc_of_parse_audio_routing(card, "samsung,audio-routing");
+	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
 	if (ret < 0) {
-		dev_err(dev, "Audio routing invalid/unspecified\n");
-		return ret;
+		/* Backwards compatible way */
+		ret = snd_soc_of_parse_audio_routing(card, "samsung,audio-routing");
+		if (ret < 0) {
+			dev_err(dev, "Audio routing invalid/unspecified\n");
+			return ret;
+		}
 	}
 
 	cpu = of_get_child_by_name(dev->of_node, "cpu");
-- 
2.34.1

