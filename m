Return-Path: <SRS0=iyFA=JF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27704C433ED
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 14:00:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15FA610E5
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 14:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15FA610E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aksignal.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8204A84D;
	Thu,  8 Apr 2021 15:59:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8204A84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617890420;
	bh=q3q13qMYSyDKU8VayQbJW5NSLwEAwCiiU4ZiReCLz6o=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iLWMYFQcF3Hz+p6x4kWwV2bd/wkX0ND0bLaqs4NxMBOhoQI8S6QQjA1q/zhEfshLC
	 GvXJY2WyiWuVgEUAXmYUejHfAZ91lXdkZGFUq7UcMXI0vMzHWc2rq4ppDnEgcualXT
	 EgMlrb5aoFYBbm2RqExUZhpL+YuAIW/qB8RcQZIE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15169F80169;
	Thu,  8 Apr 2021 15:59:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFB48F8020B; Thu,  8 Apr 2021 15:59:28 +0200 (CEST)
Received: from router.aksignal.cz (router.aksignal.cz [62.44.4.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8857CF800BD
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 15:59:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8857CF800BD
Received: from localhost (localhost [127.0.0.1])
 by router.aksignal.cz (Postfix) with ESMTP id 100D043262;
 Thu,  8 Apr 2021 15:59:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
 by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id XvIQduR5ufg4; Thu,  8 Apr 2021 15:59:14 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
 (Authenticated sender: jiri.prchal@aksignal.cz)
 by router.aksignal.cz (Postfix) with ESMTPSA id 9E5B243261;
 Thu,  8 Apr 2021 15:59:14 +0200 (CEST)
From: Jiri Prchal <jiri.prchal@aksignal.cz>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: codecs: tlv320aic3x: add AIC3106
Date: Thu,  8 Apr 2021 15:59:08 +0200
Message-Id: <20210408135908.125667-1-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Jiri Prchal <jiri.prchal@aksignal.cz>, Liam Girdwood <lgirdwood@gmail.com>
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

In DT binding is mentioned that this driver is compatible with 3106.
So added compatibility string and model number.

-v2: Also added in switches "case AIC3X_MODEL_3106:" to have right widgets etc.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 sound/soc/codecs/tlv320aic3x-i2c.c | 2 ++
 sound/soc/codecs/tlv320aic3x-spi.c | 2 ++
 sound/soc/codecs/tlv320aic3x.c     | 3 +++
 sound/soc/codecs/tlv320aic3x.h     | 1 +
 4 files changed, 8 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x-i2c.c b/sound/soc/codecs/tlv320aic3x-i2c.c
index 4535bb8dbadc..cd0558ed4dd4 100644
--- a/sound/soc/codecs/tlv320aic3x-i2c.c
+++ b/sound/soc/codecs/tlv320aic3x-i2c.c
@@ -40,6 +40,7 @@ static const struct i2c_device_id aic3x_i2c_id[] = {
 	{ "tlv320aic33", AIC3X_MODEL_33 },
 	{ "tlv320aic3007", AIC3X_MODEL_3007 },
 	{ "tlv320aic3104", AIC3X_MODEL_3104 },
+	{ "tlv320aic3106", AIC3X_MODEL_3106 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
@@ -49,6 +50,7 @@ static const struct of_device_id aic3x_of_id[] = {
 	{ .compatible = "ti,tlv320aic33" },
 	{ .compatible = "ti,tlv320aic3007" },
 	{ .compatible = "ti,tlv320aic3104" },
+	{ .compatible = "ti,tlv320aic3106" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, aic3x_of_id);
diff --git a/sound/soc/codecs/tlv320aic3x-spi.c b/sound/soc/codecs/tlv320aic3x-spi.c
index bd78ab0910da..8c7b6bb9223f 100644
--- a/sound/soc/codecs/tlv320aic3x-spi.c
+++ b/sound/soc/codecs/tlv320aic3x-spi.c
@@ -45,6 +45,7 @@ static const struct spi_device_id aic3x_spi_id[] = {
 	{ "tlv320aic33", AIC3X_MODEL_33 },
 	{ "tlv320aic3007", AIC3X_MODEL_3007 },
 	{ "tlv320aic3104", AIC3X_MODEL_3104 },
+	{ "tlv320aic3106", AIC3X_MODEL_3106 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, aic3x_spi_id);
@@ -54,6 +55,7 @@ static const struct of_device_id aic3x_of_id[] = {
 	{ .compatible = "ti,tlv320aic33" },
 	{ .compatible = "ti,tlv320aic3007" },
 	{ .compatible = "ti,tlv320aic3104" },
+	{ .compatible = "ti,tlv320aic3106" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, aic3x_of_id);
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 2f351747b714..7731593a5509 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1003,6 +1003,7 @@ static int aic3x_add_widgets(struct snd_soc_component *component)
 	switch (aic3x->model) {
 	case AIC3X_MODEL_3X:
 	case AIC3X_MODEL_33:
+	case AIC3X_MODEL_3106:
 		snd_soc_dapm_new_controls(dapm, aic3x_extra_dapm_widgets,
 					  ARRAY_SIZE(aic3x_extra_dapm_widgets));
 		snd_soc_dapm_add_routes(dapm, intercon_extra,
@@ -1580,6 +1581,7 @@ static int aic3x_init(struct snd_soc_component *component)
 	switch (aic3x->model) {
 	case AIC3X_MODEL_3X:
 	case AIC3X_MODEL_33:
+	case AIC3X_MODEL_3106:
 		aic3x_mono_init(component);
 		break;
 	case AIC3X_MODEL_3007:
@@ -1646,6 +1648,7 @@ static int aic3x_component_probe(struct snd_soc_component *component)
 	switch (aic3x->model) {
 	case AIC3X_MODEL_3X:
 	case AIC3X_MODEL_33:
+	case AIC3X_MODEL_3106:
 		snd_soc_add_component_controls(component, aic3x_extra_snd_controls,
 				ARRAY_SIZE(aic3x_extra_snd_controls));
 		snd_soc_add_component_controls(component, aic3x_mono_controls,
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 00908f1734a7..7e0063913017 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -20,6 +20,7 @@ int aic3x_remove(struct device *dev);
 #define AIC3X_MODEL_33 1
 #define AIC3X_MODEL_3007 2
 #define AIC3X_MODEL_3104 3
+#define AIC3X_MODEL_3106 4
 
 /* AIC3X register space */
 #define AIC3X_CACHEREGNUM		110
-- 
2.25.1

