Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AE3C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 10:48:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F26082A;
	Mon, 31 Jul 2023 12:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F26082A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690800520;
	bh=jfPcQDQQ9NxIL14JjRxj4GHbXkTl80Z6WGewjirrcc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IosfT4DFj33/ZfpSSMNONkAFniCoVSPn9g5wKQTakO3X92o1Z87ogM3FBSP96eD3R
	 i/TDYnCeTofvqfl0C7M5WlLWYhhuAKxEAoJ+OpaUq78+FYeRHpiiBZKQ7Pv5SIk8aB
	 UvoNP/yz/YhXpl97qAMV19G9iG3Y85EKv0ITXtGY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C304AF80425; Mon, 31 Jul 2023 12:47:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 233C0F80425;
	Mon, 31 Jul 2023 12:47:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC3A0F8025A; Mon, 31 Jul 2023 12:47:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 99ADEF8015B
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 12:47:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99ADEF8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kPkCWhYR
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DBD1F60FFF;
	Mon, 31 Jul 2023 10:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6365AC433CA;
	Mon, 31 Jul 2023 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690800432;
	bh=jfPcQDQQ9NxIL14JjRxj4GHbXkTl80Z6WGewjirrcc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kPkCWhYRl1FDao9RD3qbwS3/23Lm2IkNgwe6dPGQMga1KWGZrZSyB4GlPCT4rdmix
	 MMthLOQcMzm4YAYV8KT5XqtxVuw/icG9LrdEnDG0CwDC/bsFZhfYdl78qhZeGaolOF
	 88Plx9WToq6U3yWp3eANp9IX1gNRu0y/Rskvx4T5xzOECnXXwL0pFaWR0OJ92ODd3v
	 9j4SFUTlNHj+WscVgMJ1VnAqqZNbD4NX5863Cf4F1zM9Rf3mjONqKEeFEs01fpypqh
	 lDQnlrlfI2EoVYlTRmINlYa5tGOufXRj6G2iRFa5lpbFwoX63Qb6/ky0CoSWVLQ2ZN
	 N09kE38Gr6w2g==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 31 Jul 2023 11:47:02 +0100
Subject: [PATCH 1/2] ASoC: wm8960: Read initial MCLK rate from clock API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-asoc-wm8960-clk-v1-1-69f9ffa2b10a@kernel.org>
References: <20230731-asoc-wm8960-clk-v1-0-69f9ffa2b10a@kernel.org>
In-Reply-To: <20230731-asoc-wm8960-clk-v1-0-69f9ffa2b10a@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jfPcQDQQ9NxIL14JjRxj4GHbXkTl80Z6WGewjirrcc4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkx5EpYLSag08ByPKzevSqFb8As1JhRsoipRsvS
 33EN7MkCTSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMeRKQAKCRAk1otyXVSH
 0J8pB/9ECMm/qvY122kBK3IPcbjpRU277KyyeoX6335LwYOrZttI79ho7mfy+W9WEmaENIm7AAA
 amf6+C8nFcMxiKVMaZRB84/N8sxFv337ukGohaUgPoN4ES5cXyrh3z0pS0ZYVzlqGJRjU31lOgk
 4XqCchdcIwRDlbtqxiVl7SX7DDcyz9wtYQtK/Zrd3lqw95KIj9R9Ei5OqvWoWe+cuMFYdL9rz/u
 27H41koXZvzPNU5O4s0F+v1heZplNZ3N9UwPN4dKmaTjDjlJCxngPl5ZDUa7Iql2C+Fqohnmmkg
 C/HhvLns7vLCvcKGGRJyq/RhyJhGt7doUg6p6TtG1KIBgthc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 24BXDWZ56ZVLQXBQXY5RCX7V654YJWHM
X-Message-ID-Hash: 24BXDWZ56ZVLQXBQXY5RCX7V654YJWHM
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/24BXDWZ56ZVLQXBQXY5RCX7V654YJWHM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

When we have a MCLK provided by the clock API read the rate at startup
and store it so that there's something set before the machine driver has
done clocking configuration (eg, if it only configures clocking based on
sample rate).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 366f5d769d6d..c0ce1ef75a74 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1425,6 +1425,14 @@ static int wm8960_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(wm8960->mclk)) {
 		if (PTR_ERR(wm8960->mclk) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
+	} else {
+		ret = clk_get_rate(wm8960->mclk);
+		if (ret >= 0) {
+			wm8960->freq_in = ret;
+		} else {
+			dev_err(&i2c->dev, "Failed to read MCLK rate: %d\n",
+				ret);
+		}
 	}
 
 	wm8960->regmap = devm_regmap_init_i2c(i2c, &wm8960_regmap);

-- 
2.39.2

