Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212DFC77B7A
	for <alsa-devel@archiver.kernel.org>; Sat, 20 May 2023 14:50:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5624D827;
	Sat, 20 May 2023 16:49:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5624D827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684594201;
	bh=fa27yVs6X2uouywmwITPJ3AELkSe0a3F8azMMfpFNkA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=aH8U9fgnboWmFApic4FJAq6jeaxUROI2R5gHz1DX1v0o+sZisngGKJ9e63BX1GARH
	 tBPHCUvQU8tQoHrdaHxHfjz4xa21gdpO5mY8UvBxwcT1XW26OgTbjIQNIXEFIpBMvC
	 BjNEaKbEyopW2M+wJ4yd07SI9Zog/uuvwJQsjfNQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F728F8025A; Sat, 20 May 2023 16:48:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DB3FF80272;
	Sat, 20 May 2023 16:48:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8227CF80272; Sat, 20 May 2023 16:48:32 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr
 [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 88590F8016A
	for <alsa-devel@alsa-project.org>; Sat, 20 May 2023 16:48:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88590F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256
 header.s=t20230301 header.b=kyxN6/xc
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id 0NsaqFMzTeM6M0NsaqgBHC; Sat, 20 May 2023 16:48:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1684594104;
	bh=xlCNSpYIx4Q8P0eGlPFP+zmi7PyQkFEulkiKsfmFMe0=;
	h=From:To:Cc:Subject:Date;
	b=kyxN6/xcEUZaNVqZX14x0TxlXwiJz7wRFmXY2e5XyX4ujmXgp4CsKYz3gg6Ak1Gjh
	 LfGy732H4WrerhkumLSW82tnOjo6wByee5faFkuYOQZ4qwlh/9b0Y380N1WMsSrO+3
	 5rIM6bfS5qjNbMPNN739Jf6rFydfI9pxUW1sxOMr5VWUuaiL3dExT6COVb6Atd8/e3
	 BkMfcUF2QheLavBdtfQ1QQuvTSZIOKJ5GdDxHAi6M0FuBWKHfW7YJ7rp0zoapPkV1K
	 UUbalI5DbIrYLRX2nRtyPlQxh7E5NBvuCRi38G56PmEJEWP4sbKSxspC6NJP+cOu8T
	 l9YG/DKrYWBzQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 16:48:24 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: adau1761: Use the devm_clk_get_optional() helper
Date: Sat, 20 May 2023 16:48:19 +0200
Message-Id: 
 <ab0fe7e7ecf965df84b9516ba65428af9b3805c1.1684594081.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZSN6D3M7SBRZE2OSWENNJMKE2OE6PFQE
X-Message-ID-Hash: ZSN6D3M7SBRZE2OSWENNJMKE2OE6PFQE
X-MailFrom: christophe.jaillet@wanadoo.fr
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZSN6D3M7SBRZE2OSWENNJMKE2OE6PFQE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use devm_clk_get_optional() instead of hand writing it.
This saves some LoC and improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/adau17x1.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 634d4dbca5ec..f2932713b4de 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -1059,13 +1059,12 @@ int adau17x1_probe(struct device *dev, struct regmap *regmap,
 	if (!adau)
 		return -ENOMEM;
 
-	adau->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(adau->mclk)) {
-		if (PTR_ERR(adau->mclk) != -ENOENT)
-			return PTR_ERR(adau->mclk);
-		/* Clock is optional (for the driver) */
-		adau->mclk = NULL;
-	} else if (adau->mclk) {
+	/* Clock is optional (for the driver) */
+	adau->mclk = devm_clk_get_optional(dev, "mclk");
+	if (IS_ERR(adau->mclk))
+		return PTR_ERR(adau->mclk);
+
+	if (adau->mclk) {
 		adau->clk_src = ADAU17X1_CLK_SRC_PLL_AUTO;
 
 		/*
-- 
2.34.1

