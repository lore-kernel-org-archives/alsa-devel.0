Return-Path: <SRS0=2sca=CU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E47C43461
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:35:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B158B22208
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZTfRX5Al"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B158B22208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C565167E;
	Fri, 11 Sep 2020 19:34:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C565167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599845711;
	bh=swaYRIxHeIaAUeEpu5OuRsiQs52Z0duE/jT4WPDhr6U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZTfRX5AlQlwN+wUp1Z5nRvJqnIrG4+DzUF4UzD4iICaSJwVt9A/+9k84mYlTWjn3e
	 Ko6VHOGnNGDABj/JFtvG6+eZ2ocH8RiF9FecKH3WGL9d2VIAQA4bomtGvL/WNpyHKj
	 mYxkGHPHoovaiXSBVH+5vBdqEYuUUKOVRtyPcgKI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C759AF802E2;
	Fri, 11 Sep 2020 19:32:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7EADF802DF; Fri, 11 Sep 2020 19:31:58 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3A43F80227
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2020 19:31:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3A43F80227
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0AE131BF20F;
 Fri, 11 Sep 2020 17:31:44 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Date: Fri, 11 Sep 2020 19:31:40 +0200
Message-Id: <20200911173140.29984-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911173140.29984-1-miquel.raynal@bootlin.com>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
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

At power-up the analog circuits may take up to one full second before
being charged with the default configuration. Using the analog blocks
before they are ready generates a *very* crappy sound.

Enable the fast charge feature, which will require a bit more power
than normal charge but will definitely speed up the starting operation
by shrinking this delay to up to 40 ms.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 8 ++++++++
 sound/soc/codecs/tlv320aic32x4.h | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 7a1ffbaf48be..5fb8ba109bc9 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1009,6 +1009,14 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 				AIC32X4_LADC_EN | AIC32X4_RADC_EN);
 	snd_soc_component_write(component, AIC32X4_ADCSETUP, tmp_reg);
 
+	/*
+	 * Enable the fast charging feature and ensure the needed 40ms ellapsed
+	 * before using the analog circuits.
+	 */
+	snd_soc_component_write(component, AIC32X4_REFPOWERUP,
+				AIC32X4_REFPOWERUP_40MS);
+	msleep(40);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 38f47704bb75..7550122e9f8a 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -96,6 +96,7 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
 #define AIC32X4_FLOATINGINPUT	AIC32X4_REG(1, 58)
 #define AIC32X4_LMICPGAVOL	AIC32X4_REG(1, 59)
 #define AIC32X4_RMICPGAVOL	AIC32X4_REG(1, 60)
+#define AIC32X4_REFPOWERUP	AIC32X4_REG(1, 123)
 
 /* Bits, masks, and shifts */
 
@@ -205,6 +206,12 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
 #define AIC32X4_RMICPGANIN_IN1L_10K	0x10
 #define AIC32X4_RMICPGANIN_CM1R_10K	0x40
 
+/* AIC32X4_REFPOWERUP */
+#define AIC32X4_REFPOWERUP_SLOW		0x04
+#define AIC32X4_REFPOWERUP_40MS		0x05
+#define AIC32X4_REFPOWERUP_80MS		0x06
+#define AIC32X4_REFPOWERUP_120MS	0x07
+
 /* Common mask and enable for all of the dividers */
 #define AIC32X4_DIVEN           BIT(7)
 #define AIC32X4_DIV_MASK        GENMASK(6, 0)
-- 
2.20.1

