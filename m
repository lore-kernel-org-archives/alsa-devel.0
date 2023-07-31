Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3310CC04FDF
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 09:47:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 496D893A;
	Mon, 31 Jul 2023 11:46:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 496D893A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690796846;
	bh=w9MDG2PIM2l+0VigNM1gBOHusv4bWzePxyDJCWMZnMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=C+aaDxRhR+xmlUpHDVuwlZUVy5PgrrGBw89Lf/G1FyrVzHtmk2hWda+dWl7C/4Xq0
	 TYZiAA+5J+ZFd9amdtl/AgkraODC3gguGFl62V4HOnhK10gM1VNGCj/w5A/uLuTcLf
	 gnOYDGtqCNtVabYE+p3AfHgN0fr8dpmjkCDmx0w0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29603F805F5; Mon, 31 Jul 2023 11:43:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5386AF805F4;
	Mon, 31 Jul 2023 11:43:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DCB59F805C7; Mon, 31 Jul 2023 11:43:46 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 86494F805C2
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 11:43:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86494F805C2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=p3V1KScm
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fb7589b187so7053545e87.1
        for <alsa-devel@alsa-project.org>;
 Mon, 31 Jul 2023 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796622; x=1691401422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMM3/oOp03VQdiM5UtFP36bUtHvT73/cLwCpo+QdiIw=;
        b=p3V1KScmdLPmgJC69GcijUepICL5AVIM3EAETvRj+mTvl8smXeR7y+qE5llrGg1RBc
         mtCFxnbJt3diMjUWIgc/V85kdWzKsoCJU27yfBoQsImZvU0egnXL9lWKmOlI5YKzjUtW
         nfAwpgyk/SK6HEu+TBByd3i2lZDDBKYF1hDU/u/0nZYo5csjYCe+d9Wn3UvuunBi+GAQ
         aIRDBhMF6xnlo7gg5JTsuJtWglDKN/l9ppYfnwGgtyn5P0MR1WANzCPEbFSxY1bQjyVp
         KHd07Et7akegVLox7KMF1SsjBVlB78QSjiikAX4pc+rrOlH5LQdfQs5YXRumr1gfRBBz
         D92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796622; x=1691401422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMM3/oOp03VQdiM5UtFP36bUtHvT73/cLwCpo+QdiIw=;
        b=JW5ZF3IbFwvO6W4pOSgO/TXcUBSnAOdPoLFzylMXB3m6Kt/F3Wkqd8B2O2nSXblu4B
         YTHXapBzJ77hLTcAhUbc9edk2aLJCE/gQFhi+zh21Tcp2ACvRyFSgYbBes17RlsRVb7A
         b2Aq9zLBfxV+2GZ3wdGzECG1JpGVdB0gO7gRZgRUpx6/815zK5xX2MgnbFhvevV6PTrd
         2R7p7fjmfQNY0GLJjwTyJ/Y6tWWC2bX3l7gl61TX/28n6EWZlrybZLFRAoiVC5Yjcye0
         ippcWmn6oobZm3JHTRdA4EooU/WE4gn6+9PjmfELsK7+rXlBwgj1fxC+L4gB7JMcBIAB
         szmg==
X-Gm-Message-State: ABy/qLZHzrx2w0lSv/abaDZJYg59FYiiwleDEmxA5TNzemF5Px6bVhH0
	LhO/BLWR2Nx2VN1uDiI9//tJ+g==
X-Google-Smtp-Source: 
 APBJJlEp0ZNK+HWD6CIv96Mutem+tcF9lSytD8+rqw83Zg83lTGZaiCv/X0Q6YA+P3HWOwl2ZbY4yg==
X-Received: by 2002:a05:6512:459:b0:4f8:75cf:fdd7 with SMTP id
 y25-20020a056512045900b004f875cffdd7mr5655698lfk.22.1690796622165;
        Mon, 31 Jul 2023 02:43:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id
 z17-20020a170906815100b0099bcdfff7cbsm5867547ejw.160.2023.07.31.02.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:41 -0700 (PDT)
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
Subject: [PATCH 11/12] ASoC: samsung: odroid: parse audio-routing
Date: Mon, 31 Jul 2023 11:43:02 +0200
Message-Id: <20230731094303.185067-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IKG3FY3WDGOO7XWGPBR343AX5FQIVVO5
X-Message-ID-Hash: IKG3FY3WDGOO7XWGPBR343AX5FQIVVO5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IKG3FY3WDGOO7XWGPBR343AX5FQIVVO5/>
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

