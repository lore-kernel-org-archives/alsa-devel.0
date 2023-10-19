Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F68CDB465
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Oct 2023 13:19:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 109CB6C1;
	Thu, 19 Oct 2023 15:18:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 109CB6C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697721585;
	bh=qSK0VBrRbQ0cRxnGYX08Q3zan83wa6SdoohFgsvqGyg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=NvqJ3IdKfxYcidgGNKpKNUtbhX3st7wPuqKh6WqYXov5CTJsfMgmG0hSRZNpWwUzX
	 87G1xB9/cmGqgHCZRuNxM1JRKcOGBvPD8ZGF6DTvlgwTowxO5DiIxgGaxC9pvVH0jC
	 8lyYB5oOBx5wHOGUlU/bbSBHW3Wuotyos9FA6oeQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E8CEF80552; Thu, 19 Oct 2023 15:18:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1603AF80166;
	Thu, 19 Oct 2023 15:18:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 295B9F8025F; Thu, 19 Oct 2023 15:18:21 +0200 (CEST)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CCAC9F8019B
	for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2023 15:18:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCAC9F8019B
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1qtSue-0006tu-SQ; Thu, 19 Oct 2023 15:18:08 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	kernel@pengutronix.de
Subject: [PATCH] ASoC: tlv320aic31xx: switch to gpiod_set_value_cansleep
Date: Thu, 19 Oct 2023 15:18:06 +0200
Message-Id: <20231019131806.381280-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: FZLMCETRKMER73W6BGBGNHHAU7AU2FZZ
X-Message-ID-Hash: FZLMCETRKMER73W6BGBGNHHAU7AU2FZZ
X-MailFrom: m.felsch@pengutronix.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FZLMCETRKMER73W6BGBGNHHAU7AU2FZZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Switch to gpiod_set_value_cansleep() to support gpiochips which can
sleep like i2c gpio expanders.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 sound/soc/codecs/tlv320aic31xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 9611aa8acb0d..4d7c5a80c6ed 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1208,7 +1208,7 @@ static int aic31xx_regulator_event(struct notifier_block *nb,
 		 * supplies was disabled.
 		 */
 		if (aic31xx->gpio_reset)
-			gpiod_set_value(aic31xx->gpio_reset, 1);
+			gpiod_set_value_cansleep(aic31xx->gpio_reset, 1);
 
 		regcache_mark_dirty(aic31xx->regmap);
 		dev_dbg(aic31xx->dev, "## %s: DISABLE received\n", __func__);
@@ -1222,9 +1222,9 @@ static int aic31xx_reset(struct aic31xx_priv *aic31xx)
 	int ret = 0;
 
 	if (aic31xx->gpio_reset) {
-		gpiod_set_value(aic31xx->gpio_reset, 1);
+		gpiod_set_value_cansleep(aic31xx->gpio_reset, 1);
 		ndelay(10); /* At least 10ns */
-		gpiod_set_value(aic31xx->gpio_reset, 0);
+		gpiod_set_value_cansleep(aic31xx->gpio_reset, 0);
 	} else {
 		ret = regmap_write(aic31xx->regmap, AIC31XX_RESET, 1);
 	}
-- 
2.39.2

