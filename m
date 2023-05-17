Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15056C77B75
	for <alsa-devel@archiver.kernel.org>; Wed, 17 May 2023 11:17:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD191201;
	Wed, 17 May 2023 13:16:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD191201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684322223;
	bh=gOCFW+czvs5/FtDVB7qpuxbW4fyvAsTQZKe2NB38AB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=o2P3Z4SNldiS2oRPy3teMoyl8ylzuqAvsyeG1Sagy2JgcU+i64fhv1LJ92HT2eWJO
	 Y1d+TlOkr+B/ZxPTXjTWQbms0tGkFTyEglQtd8r2pb7FKPSuvwGZQIA+e72TrhlyR8
	 xVBFiMjxSZCYM3hdviQxqoSkRUWN+/D/Q17W5B5I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C40DF8059F; Wed, 17 May 2023 13:15:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F5DCF80587;
	Wed, 17 May 2023 13:15:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3A07F80548; Wed, 17 May 2023 13:14:52 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ECEC0F8016A
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2023 13:14:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECEC0F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dJ/Pmlpb
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-510bcd2d6b8so5691596a12.0
        for <alsa-devel@alsa-project.org>;
 Wed, 17 May 2023 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322086; x=1686914086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAU6nE7Iv32gPNvrQJaHKSe4IIom2DPSRL0YbepC1JY=;
        b=dJ/PmlpbNmfHmuYdjH3uO1ElApNK26oJ6na+aMD1yfJb05UDsLjz0xzUQTE/abm0yF
         zbx6naNOO2gKrAAsT5hyVVuz+j8ikJ/doxEQfVfSDF/ljofMQWyaBDeE9u14oK62/Wg/
         xSIAetdKH2r59SbWqeWex5CKGvgTBS+G52EYglrZnOGuq2IENBj4Zwqrl/aLWic6zaTR
         0NIY3KBh7oR+Z1I6Gxv/gf2kMRHJkoQGBahe4Y8/aVsAb7rBDD9/A+yas/Ild289fXk8
         EfK+Znx5j8oBJa9m6rR/Oo4lqtGuzB5qoV2RwqJcdqyxLiOMlxeuo0sWGQY4pjqC/RCT
         Ro5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322086; x=1686914086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAU6nE7Iv32gPNvrQJaHKSe4IIom2DPSRL0YbepC1JY=;
        b=GWqt0K9unJ8ffaopVNch+nUnC1gwfvLh2PdFregw3hMqPh/i/TkdLjxdBL2Yp7hTyC
         aRUweNIirR4nEjYKLobeC2+3ZAPdSlXdK7WVRbdFHfp5jDpUIlIFlbIBvRc2aaDFMp/F
         cCSVkwKIlq/yCTUrIVnRVy4pm4DsJkBWH+ZMLnPIHLJ76Qp5O9pbCaipRKsmEJA5WkLD
         xdqC+gTyD8EC4f0VGTkBMFpCOsFOyhC9P1UoPxTwUU1hlnTA/vDnOVGuh4uPQIxBD3OW
         k/+FI1Ud4yFeKOo8x9+lRBTS+8h2w2O0PJtBnE1p8Pl/OcgeEP3+6soJHySAt27WF/bC
         sh/Q==
X-Gm-Message-State: AC+VfDwjTQeFqDVdd8ITDpaH4YdACKT7eet32McGYSeBH42NhOLGvXRr
	Rube5hZCQqYKumygFMgwe0sgdg==
X-Google-Smtp-Source: 
 ACHHUZ62iLS7FU6ngzK688zw4Cj+axv3xqRuHEDoRc8fnW0FTcROJc2cF0ZL0r8I9am/kqhPnH+4GA==
X-Received: by 2002:a17:907:6da0:b0:959:b757:e49 with SMTP id
 sb32-20020a1709076da000b00959b7570e49mr1997236ejc.1.1684322086159;
        Wed, 17 May 2023 04:14:46 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id
 ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/12] ASoC: codecs: rt712-sdca-dmic: do not store status in
 state container
Date: Wed, 17 May 2023 13:14:12 +0200
Message-Id: <20230517111416.424420-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
References: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3Q33BJI5D345JIEMKGU76PW4KBI3F77O
X-Message-ID-Hash: 3Q33BJI5D345JIEMKGU76PW4KBI3F77O
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3Q33BJI5D345JIEMKGU76PW4KBI3F77O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Driver in its update status callback stores Soundwire device status in
state container but it never uses it later.  Simplify the code a bit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt712-sdca-dmic.c | 5 +----
 sound/soc/codecs/rt712-sdca-dmic.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt712-sdca-dmic.c b/sound/soc/codecs/rt712-sdca-dmic.c
index 09807b6d6353..847198e6c07e 100644
--- a/sound/soc/codecs/rt712-sdca-dmic.c
+++ b/sound/soc/codecs/rt712-sdca-dmic.c
@@ -803,9 +803,6 @@ static int rt712_sdca_dmic_update_status(struct sdw_slave *slave,
 {
 	struct rt712_sdca_dmic_priv *rt712 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt712->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt712->hw_init = false;
 
@@ -813,7 +810,7 @@ static int rt712_sdca_dmic_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt712->hw_init || rt712->status != SDW_SLAVE_ATTACHED)
+	if (rt712->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt712-sdca-dmic.h b/sound/soc/codecs/rt712-sdca-dmic.h
index 74c29677c251..110154e74efe 100644
--- a/sound/soc/codecs/rt712-sdca-dmic.h
+++ b/sound/soc/codecs/rt712-sdca-dmic.h
@@ -16,7 +16,6 @@ struct  rt712_sdca_dmic_priv {
 	struct regmap *mbq_regmap;
 	struct snd_soc_component *component;
 	struct sdw_slave *slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

