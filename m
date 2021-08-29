Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F93C432BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 15:14:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D8F61053
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 15:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58D8F61053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dnyon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C38D21749;
	Wed,  1 Sep 2021 17:13:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C38D21749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630509248;
	bh=5QaN/XpQgIgjf/BOnDZmch+mx9yG/wxC151DFF3SAUw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LNNLi1cr1lTyofBoFbH7zlNM5iwd/Wt/VQCDuZQo4XidTDm0gPdmwPYij975Omev7
	 N+QPiydzmespz27+jQGen0f2IIpGhWt2+gWC6yZLe02XNc4sni8NH0Xb+xfyVjxr1B
	 O4Py3Gs+qjQD9sMnYYj0ZGQgFic7BnChlTvKek9I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83B65F80256;
	Wed,  1 Sep 2021 17:12:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43894F80269; Sun, 29 Aug 2021 17:50:13 +0200 (CEST)
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BD27F80143
 for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2021 17:50:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BD27F80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=dnyon.com header.i=@dnyon.com
 header.b="ZvctsjpC"
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by dnyon.com (Postfix) with ESMTPSA id 04AA84044F;
 Sun, 29 Aug 2021 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
 t=1630252199; bh=5QaN/XpQgIgjf/BOnDZmch+mx9yG/wxC151DFF3SAUw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZvctsjpCo3QxKIjSknqPJcA067nU10lUTzVDEIrZxH31EdgtJwFBexvFUGoBI3yMb
 h512MGuyWrNbQpWwxWiHTossxl0uPXfMOp/Y9wgYaoUx3rhpQ1pIZy71ktTkvVxamq
 JBOx57hehjpgycF/i44mgVnNj45zPQaR4hEYSsnZlsgszKW4WERdhAKssyPSUXVjkJ
 VqzT8ScDIQO861dp7zcsrNHJgqyuuyoXin7bu2rgWDlOBb4eeecU12e3Rc0ESdArbC
 Sz3ZD4hdNYrHDpX+NvbWFKeOZTLQdNVTE4r2c+fFJy2qaihyrerCbFEiAYKrwfqGh1
 nz/coYqTlmwOQ==
From: Alejandro Tafalla <atafalla@dnyon.com>
To: 
Subject: [PATCH 1/2] ASoC: max98927: Handle reset gpio when probing i2c
Date: Sun, 29 Aug 2021 17:45:43 +0200
Message-Id: <20210829154545.383119-2-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829154545.383119-1-atafalla@dnyon.com>
References: <20210829154545.383119-1-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Sep 2021 17:12:33 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Alejandro Tafalla <atafalla@dnyon.com>
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
 sound/soc/codecs/max98927.c | 16 ++++++++++++++++
 sound/soc/codecs/max98927.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 8b206ee77709..dacf64c4cdf7 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -898,6 +898,22 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	max98927->reset_gpio
+		= devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(max98927->reset_gpio)) {
+		ret = PTR_ERR(max98927->reset_gpio);
+		dev_err(&i2c->dev,
+			"Failed to request GPIO reset pin, error %d\n", ret);
+		return ret;
+	}
+
+	if (max98927->reset_gpio) {
+		gpiod_set_value_cansleep(max98927->reset_gpio, 0);
+		usleep_range(5, 10)
+		gpiod_set_value_cansleep(max98927->reset_gpio, 1);
+		usleep_range(1, 5)
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98927->regmap,
 		MAX98927_R01FF_REV_ID, &reg);
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index 05f495db914d..5c04bf38e24a 100644
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -255,6 +255,7 @@ struct max98927_priv {
 	struct regmap *regmap;
 	struct snd_soc_component *component;
 	struct max98927_pdata *pdata;
+	struct gpio_desc *reset_gpio;
 	unsigned int spk_gain;
 	unsigned int sysclk;
 	unsigned int v_l_slot;
-- 
2.32.0

