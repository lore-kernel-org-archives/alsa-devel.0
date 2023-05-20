Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E02C77B7A
	for <alsa-devel@archiver.kernel.org>; Sat, 20 May 2023 14:52:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65DC7825;
	Sat, 20 May 2023 16:51:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65DC7825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684594343;
	bh=H5R/65lIl23iPf9ZUMkz5Q6CL8rZFnB6yUrNFuyLSgg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pID8DrFr9NAocijpkMveeqyrIr/k0urerre0OMdwohhZWX2kq8LUfbPWkDVHHHL7M
	 xgGtOJxZJ/mVZ+Px2tjqCSw/aL+eW3piZFU2S8YupOXl6E5T+xzGNVpWQKB6pOxB+6
	 cfeoJ5eKQqvH9kAAYIg/p/sqVzcPnD3crk5tWXec=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17DE0F8025A; Sat, 20 May 2023 16:51:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE259F8016A;
	Sat, 20 May 2023 16:51:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6244F80272; Sat, 20 May 2023 16:51:01 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr
 [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ECACEF8016A
	for <alsa-devel@alsa-project.org>; Sat, 20 May 2023 16:50:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECACEF8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256
 header.s=t20230301 header.b=e9DSYsns
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id 0Nv5qCAc8f2fi0Nv5qlWU3; Sat, 20 May 2023 16:50:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1684594257;
	bh=Gs5jc+zEfJwVCuLHjEL/NLyniIuEyQrXlCdxCYb+hJA=;
	h=From:To:Cc:Subject:Date;
	b=e9DSYsnsS1ydxT+Dx6SGfc4dIS0EMtm5SjEC8HRqituPaP4K4jRRiAQMh8oO6N0rh
	 1ea+gA1KhSIdWhmRCutIDkacVEJQkOBdN5GjkvZRP06EvdKjFudkN1K8rWu1v0r51M
	 qeU86Dl2YIH5zmS042fE1gUVf752xCOc9TJD0ZuryOnjV0ZkOYJAz/3cdkg5MKc7wN
	 C+u2ZWJnEv2wsQZgeam+kzkJbg6F55k/4Et0vTX+wC/areeSoKkiYLjL2vDAyZ4EHE
	 N7nfFvnhjx6W095nnQPnbEl8A1j/GGQtOVX37tuhrITZq4ePm32WwdesNUStlTJFJD
	 YUqKMEfu0yBbw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 16:50:57 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com
Subject: [PATCH] ASoC: cs42l51: Use the devm_clk_get_optional() helper
Date: Sat, 20 May 2023 16:50:54 +0200
Message-Id: 
 <3debf3bb7ea504ee9ca2d8eb0f948a426681cbdd.1684594240.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5CDXTT7Z7CXZ2JOSVL7IUTCYRN3KZV3S
X-Message-ID-Hash: 5CDXTT7Z7CXZ2JOSVL7IUTCYRN3KZV3S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5CDXTT7Z7CXZ2JOSVL7IUTCYRN3KZV3S/>
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
 sound/soc/codecs/cs42l51.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index e88d9ff95cdf..a67cd3ee84e0 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -724,12 +724,9 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 	dev_set_drvdata(dev, cs42l51);
 	cs42l51->regmap = regmap;
 
-	cs42l51->mclk_handle = devm_clk_get(dev, "MCLK");
-	if (IS_ERR(cs42l51->mclk_handle)) {
-		if (PTR_ERR(cs42l51->mclk_handle) != -ENOENT)
-			return PTR_ERR(cs42l51->mclk_handle);
-		cs42l51->mclk_handle = NULL;
-	}
+	cs42l51->mclk_handle = devm_clk_get_optional(dev, "MCLK");
+	if (IS_ERR(cs42l51->mclk_handle))
+		return PTR_ERR(cs42l51->mclk_handle);
 
 	for (i = 0; i < ARRAY_SIZE(cs42l51->supplies); i++)
 		cs42l51->supplies[i].supply = cs42l51_supply_names[i];
-- 
2.34.1

