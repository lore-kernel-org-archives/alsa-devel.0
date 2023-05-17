Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD241C77B7A
	for <alsa-devel@archiver.kernel.org>; Wed, 17 May 2023 11:15:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78B4D1F6;
	Wed, 17 May 2023 13:15:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78B4D1F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684322150;
	bh=5DZBLVR8fj7Hlj/5x/U4EV4FdPn3n+QxCrvKnSjDzIY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=aR8ggdweEVnmQBz0L65pR5JoEQGmCTClxusZJBCw7qDtnzKMfhF2yPZiePot4xjnO
	 dGjS1z6NnSbFPbFRrv2C2lM6g2ME4k8PtPDJau7yj/ftIc8vFZCTAAO6rTT8HzBc5w
	 88YEX7GKEScRTJu6DxojwTSlxLthD0FJNu2xZhXo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F47EF80549; Wed, 17 May 2023 13:14:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88966F80549;
	Wed, 17 May 2023 13:14:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D1FAF80548; Wed, 17 May 2023 13:14:48 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4A2D8F8016A
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2023 13:14:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A2D8F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sIfEiJbF
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-965f7bdab6bso111872366b.3
        for <alsa-devel@alsa-project.org>;
 Wed, 17 May 2023 04:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322079; x=1686914079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8f/Ov+L9lgAMMtQvsESvWR48vQlBSC6eGHRApShSvK4=;
        b=sIfEiJbFesnboqrvDwg/JbxitCUki5aOESmQeTg6BQTaFmpQel55ARJNOzBd8Mm4FZ
         fL+tqM9jp+I4U1fmvk7eAQehUtyk/TO+AAf9RFsKbKkkeNL6LvaF4LYZf9tyVKUlhdHG
         i/DH2lMxWzJ7WPE4l4CfVfUWeP2GrHWEytoP6jrQX7Zkda97O0tWivR4CwTB9QHVEG1K
         rBrCq0Y2omMSb5Z4kuCIJMQcJtoef5ryB9wcSy0/JXqX6taG1+ccb7qg58us2ne/Zb0p
         7V10XrAmSJFkQZ4ZLTGvktUpzOfMUh1Q3cz8HYSdwZJS0JiMw8iiZs2Yq8MuIiFD1/N1
         tN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322079; x=1686914079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8f/Ov+L9lgAMMtQvsESvWR48vQlBSC6eGHRApShSvK4=;
        b=RPb9Sz9qrXXSa1Tc+4wpZCDYn8OY5K+xJ00ViAlMnC1Ox07sTw1kARP5JlmkecRp7Q
         KkjsbPzhT54csEXrw4WWsj47z/JV5hXp6gZZqjPhlBwCdZxpfnYsdwh9oNG/be22FMww
         KUadCghb7oeqNfRtY9KoTBLRDZGT/AMrOlagb7LbXnJm7IoiX8g/gsIPAJZopVFZTD6P
         cUXtiIDyxT72CdWSnQSj9E6QrQnkbBuLZI09q19az6ew6b3OeR/Z6CI+sST7ZspsmSp+
         /AcLWIrPxPJ1YMc6qcAQXGQIRRst3p6ytN061SMWKQE5PfUJq871utkS1S0Izg6w5zKt
         WwVA==
X-Gm-Message-State: AC+VfDw4fHSsxXGrKAYXw2VyFFE1bcGh9qe4dk9S6Bu2bX6ZT94KXy3w
	oRaKKI+NLN34cjkEj70VbrfwWA==
X-Google-Smtp-Source: 
 ACHHUZ4W3Tqy+kmA5/CrSkwq+i+Z6QU84MiGKQFNv45sP/3v7DwL6mlpqoPP47j1FG0KjZyNBcEakA==
X-Received: by 2002:a17:906:9c83:b0:95f:4889:412a with SMTP id
 fj3-20020a1709069c8300b0095f4889412amr39964429ejc.33.1684322078958;
        Wed, 17 May 2023 04:14:38 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id
 ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/12] ASoC: codecs: rt1308: do not store status in state
 container
Date: Wed, 17 May 2023 13:14:05 +0200
Message-Id: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NB4HZR5Y4DYO6DHJ2TK6MENQ2GCSELM7
X-Message-ID-Hash: NB4HZR5Y4DYO6DHJ2TK6MENQ2GCSELM7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NB4HZR5Y4DYO6DHJ2TK6MENQ2GCSELM7/>
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
 sound/soc/codecs/rt1308-sdw.c | 5 +----
 sound/soc/codecs/rt1308-sdw.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index 1797af824f60..313e97c94532 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -304,9 +304,6 @@ static int rt1308_update_status(struct sdw_slave *slave,
 {
 	struct  rt1308_sdw_priv *rt1308 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt1308->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt1308->hw_init = false;
 
@@ -314,7 +311,7 @@ static int rt1308_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt1308->hw_init || rt1308->status != SDW_SLAVE_ATTACHED)
+	if (rt1308->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt1308-sdw.h b/sound/soc/codecs/rt1308-sdw.h
index 04ff18fa18e2..f816c73e247e 100644
--- a/sound/soc/codecs/rt1308-sdw.h
+++ b/sound/soc/codecs/rt1308-sdw.h
@@ -159,7 +159,6 @@ struct rt1308_sdw_priv {
 	struct snd_soc_component *component;
 	struct regmap *regmap;
 	struct sdw_slave *sdw_slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

