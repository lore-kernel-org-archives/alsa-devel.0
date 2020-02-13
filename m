Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA74C352A3
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:31:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E8921734
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pox/elAn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rsbhc4ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E8921734
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DC4B1682;
	Thu, 13 Feb 2020 04:31:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DC4B1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581564710;
	bh=PQzqpIRSFhea41V39gS4dnVhrK1A6NXsf9n4kV7aRfY=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pox/elAnddrkS8XOjDg3+suhIiimLuY62XWPtQgtgx+8aeZFscHBfm+BwvnoprPFm
	 rv89GvcUjOWL5NQ7fhkoq/sKkbgdt6rYKIGoBRBK4jh0KskYicq+vjbwtrP2YfQOZE
	 rPaxQdhXyehO8NBAPzJ9zfMPThoFanxUUFYBk6iw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 347EBF8028F;
	Thu, 13 Feb 2020 04:28:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69BACF80290; Thu, 13 Feb 2020 04:28:27 +0100 (CET)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90012F8028C
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 04:28:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90012F8028C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="rsbhc4ma"
Received: by mail-pf1-x449.google.com with SMTP id z26so2822063pfr.9
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 19:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ABP64oLgld5vXEPTFiENx6A7aVpO8Fw6bmZeeUtOJMQ=;
 b=rsbhc4maH2PcWoKjR/UCQmHYfFZPMQ1dvwvrKAK8pZQJ0uxSn84lOmOYOKJtVzd1MY
 hEzFVpxy064Xbyr/NlFPQp4z9h25mnXvYCNhoiCQqtk4BSCVwWCXW6r8RB+BtGMQkBuC
 51yMYso+hrR9KyuI64UQT7K9klhLAHrIMPTyGb7ks9Q9d4BR62nrz/LUAOpXS+ReMUel
 CvMGVj96oexr8LCXovUzOHm3zR85NPn4jwi4bxbzTeKYq7axrDfN7J7m2An1EuANtQoV
 9JNbtfk4xEAYzd1HZKNjGHvqK+krBA96aw/gBT/3EQ6WGahQc+CAv4D/fpq+bH3hJYwb
 WazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ABP64oLgld5vXEPTFiENx6A7aVpO8Fw6bmZeeUtOJMQ=;
 b=oQXNUfGKx8pz1A/i6tELNTM3a+8q/aCX7uWExg0Ph4Bf/7OfBPu3KTw/XLSkah3Nmw
 LT9JDE/jOnxrr4Yzju8ezM7OSam4yFn4WFfgyjZLPIA/KCjyqkYi6Hcf3tOy2r7QUY1N
 aQn7z1ktzICIYsi9l4v9Q6FoWdeYPIg574SYuNp3N1mk0yoj5Oxb1bzX+LfpIulrk3LH
 O8W8ujRPt5CMbVUvTPG/SS2RoLo5LDfrcpFweVQEb0c9FLBjoLKfuHeEoJYmEivzh1sS
 BDfKIMt4wtTWHqaX1ypjWi0eR6SFkFZp8KMKMDNOQTXrTGTgiZhV0oXdls1LWSFE7Ucu
 i0fg==
X-Gm-Message-State: APjAAAWs30GRrjjhGvWOz9SFFCNO9ComHoozqI2RS9wqN/orJ1b1Nefw
 sjgwQoeXQ3YdUJQnGxjHZMY5TzBfOM1W
X-Google-Smtp-Source: APXvYqzsGCgPrpc3+wqAhg0Fnms9LI242P/AkkvRuoTZU8Dj7I4nFqgjzRhg38k2s49Rlz0Xx41oDOLbQhr9
X-Received: by 2002:a63:2447:: with SMTP id k68mr5210134pgk.368.1581564501877; 
 Wed, 12 Feb 2020 19:28:21 -0800 (PST)
Date: Thu, 13 Feb 2020 11:27:28 +0800
In-Reply-To: <20200213032728.199462-1-tzungbi@google.com>
Message-Id: <20200213112003.4.Ia542007f51d3de753a9e0a83135ee074581dbf71@changeid>
Mime-Version: 1.0
References: <20200213032728.199462-1-tzungbi@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com,
 cychiang@google.com
Subject: [alsa-devel] [RESEND PATCH 4/4] ASoC: mediatek: mt8183-da7219:
	apply some refactors
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

1. Moves headset jack to card-specific storage.
2. Removes trailing blank line.
3. Moves card registration to the end of probe.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../mediatek/mt8183/mt8183-da7219-max98357.c  | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index c7f766f24e44..c0c85972cfb7 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -16,8 +16,6 @@
 #include "../../codecs/da7219-aad.h"
 #include "../../codecs/da7219.h"
 
-static struct snd_soc_jack headset_jack;
-
 enum PINCTRL_PIN_STATE {
 	PIN_STATE_DEFAULT = 0,
 	PIN_TDM_OUT_ON,
@@ -32,6 +30,7 @@ static const char * const mt8183_pin_str[PIN_STATE_MAX] = {
 struct mt8183_da7219_max98357_priv {
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pin_states[PIN_STATE_MAX];
+	struct snd_soc_jack headset_jack;
 };
 
 static int mt8183_mt6358_i2s_hw_params(struct snd_pcm_substream *substream,
@@ -510,6 +509,8 @@ static int
 mt8183_da7219_max98357_headset_init(struct snd_soc_component *component)
 {
 	int ret;
+	struct mt8183_da7219_max98357_priv *priv =
+			snd_soc_card_get_drvdata(component->card);
 
 	/* Enable Headset and 4 Buttons Jack detection */
 	ret = snd_soc_card_jack_new(&mt8183_da7219_max98357_card,
@@ -517,12 +518,12 @@ mt8183_da7219_max98357_headset_init(struct snd_soc_component *component)
 				    SND_JACK_HEADSET |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &headset_jack,
+				    &priv->headset_jack,
 				    NULL, 0);
 	if (ret)
 		return ret;
 
-	da7219_aad_jack_det(component, &headset_jack);
+	da7219_aad_jack_det(component, &priv->headset_jack);
 
 	return ret;
 }
@@ -559,13 +560,6 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
-			__func__, ret);
-		return ret;
-	}
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -607,7 +601,7 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
 				 __func__, ret);
 	}
 
-	return ret;
+	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
 #ifdef CONFIG_OF
@@ -634,4 +628,3 @@ MODULE_DESCRIPTION("MT8183-DA7219-MAX98357 ALSA SoC machine driver");
 MODULE_AUTHOR("Shunli Wang <shunli.wang@mediatek.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("mt8183_da7219_max98357 soc card");
-
-- 
2.25.0.225.g125e21ebc7-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
