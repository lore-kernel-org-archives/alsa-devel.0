Return-Path: <SRS0=+0+W=NV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393D4C432BE
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 10:50:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB93610FA
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 10:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACB93610FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dnyon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 055E01728;
	Mon, 30 Aug 2021 12:49:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 055E01728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630320603;
	bh=t0sArD8RpMG3ILMbA97+7fmkKdN7C7bsh9csIcYpttI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R2C51rL8MFVSfcEcc+D8hRq/tRL41UeExPtgNRmELBYUHCTfyeg62rKAGFOWHAc6D
	 o0AYejgrC7QXMOqwAOrrGXq3RdzoBUNhUbvjzx4UKrqIiwrmuj6mvQ0O1F7NLYJEY6
	 wxZwBW5pq5mYQKw6gZM6WJ1ZJcumS9OsXnhCqVVw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77732F804B0;
	Mon, 30 Aug 2021 12:48:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59E64F804D0; Mon, 30 Aug 2021 12:48:51 +0200 (CEST)
Received: from dnyon.com (dnyon.com [82.223.165.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33104F8020D
 for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2021 12:48:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33104F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=dnyon.com header.i=@dnyon.com
 header.b="E2mfoS8g"
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by dnyon.com (Postfix) with ESMTPSA id AB0E24044F;
 Mon, 30 Aug 2021 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
 t=1630320493; bh=t0sArD8RpMG3ILMbA97+7fmkKdN7C7bsh9csIcYpttI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E2mfoS8gdyXLMY3r3u7GbvheW78qI8B1nzDUjXmhyEVsryiiC0Ut2aNmCVEmtO9H8
 9JRtwr4Pv+TBI1yW+afpkD5Mk9hYSv27yOW1FKFx67TpfLueJ4w6trEHgDZC3z8UN5
 HKtNoOWxnQYVBREwEPkICzIm5qniIlWFVrWUAXw4J53Snuj0oxBu1E8MZBoQTmx55M
 ESmErt0iP7kZVDWM41eiz9SSKtZqpkPnL5wGVIqteCpz/01oK+ssFA5oQhbMJoHl2O
 sI9yuam5L1We5TKRgHj79dBF22C3224EgYymHieHlSB9k+8I+n+9/bIuwPdl5u0Vci
 Uatywb8bjuQrA==
From: Alejandro Tafalla <atafalla@dnyon.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, alsa-devel@alsa-project.org
Subject: [PATCH v2 1/2] ASoC: max98927: Handle reset gpio when probing i2c
Date: Mon, 30 Aug 2021 12:44:23 +0200
Message-Id: <20210830104426.487246-2-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210830104426.487246-1-atafalla@dnyon.com>
References: <20210830104426.487246-1-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Alejandro Tafalla <atafalla@dnyon.com>
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

Drive the reset gpio if defined in the DTS node.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 sound/soc/codecs/max98927.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 8b206ee77709..84a159de4b26 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -868,6 +868,7 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	int ret = 0, value;
 	int reg = 0;
 	struct max98927_priv *max98927 = NULL;
+	struct gpio_desc *reset_gpio;
 
 	max98927 = devm_kzalloc(&i2c->dev,
 		sizeof(*max98927), GFP_KERNEL);
@@ -898,6 +899,20 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	reset_gpio
+		= devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio)) {
+		ret = PTR_ERR(reset_gpio);
+		return dev_err_probe(&i2c->dev, ret,
+			"failed to request GPIO reset pin");
+	}
+
+	if (reset_gpio) {
+		usleep_range(8000, 10000);
+		gpiod_set_value_cansleep(reset_gpio, 1);
+		usleep_range(1000, 5000);
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98927->regmap,
 		MAX98927_R01FF_REV_ID, &reg);
-- 
2.32.0

