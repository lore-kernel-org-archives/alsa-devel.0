Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F42BEB64DA
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jul 2023 00:23:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CCFF83B;
	Thu, 13 Jul 2023 02:22:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CCFF83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689207784;
	bh=nah/tEYBJXlWzhJvP0QxHmrDmQDFpilqGypC1OgFlmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mk843vQD0f397VYOzokVqwQ+G/It+so7fq35lMygo7OzVRACMAUNd+XJj8MiP2EQe
	 QjneeqzVdVOZkcQLlpu4yzGvY2/jAvJARMhszZ5BNkeyLV0AeJbfYV5WuZ7+UNYMPG
	 mjWe7Ri1SvN2psUz6BQTJuKcEFIQt3Qz5HpCCuoA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 925AEF8068D; Thu, 13 Jul 2023 02:15:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A663AF806B5;
	Thu, 13 Jul 2023 02:15:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B97A6F80694; Thu, 13 Jul 2023 02:15:41 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 39D6CF8068D
	for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2023 02:15:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39D6CF8068D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YpXdWb0c
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 21862619AB;
	Thu, 13 Jul 2023 00:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219CBC433CD;
	Thu, 13 Jul 2023 00:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689207336;
	bh=nah/tEYBJXlWzhJvP0QxHmrDmQDFpilqGypC1OgFlmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YpXdWb0cjdS7pmobIBHkx8BVW5lbZzDfitzH0e1fW8JZwMbcUt4daZbmI4FlDuusw
	 OePd10AX2YRlW47EM/7nyMScQ7x0EqxdW0L10iXojgWB3VQ4vCYV5VZa6G9BT4sDyU
	 H+91x/i5t+bqaHpRed2T0O/7YMZCmd1TJZRg/tIGD0IQ5x/ddB/YcLXkoD0s5B2O4e
	 bAeUTUBMgXlSMmyZQYVRiSXbHtAosOXuXK8bcvIGCt2wUHvGliT+LiQgC/DANLaFZY
	 glns0mnkg0j6DzEc9B6yepZOi8LmVrm3V4vF58ypA110MPWqCfPNWXTBFCir/aSFEG
	 ZQylWPt0vqtQA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 13 Jul 2023 01:13:42 +0100
Subject: [PATCH 29/48] ASoC: wm8900: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-asoc-cirrus-maple-v1-29-a62651831735@kernel.org>
References: <20230713-asoc-cirrus-maple-v1-0-a62651831735@kernel.org>
In-Reply-To: <20230713-asoc-cirrus-maple-v1-0-a62651831735@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 asahi@lists.linux.dev, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nah/tEYBJXlWzhJvP0QxHmrDmQDFpilqGypC1OgFlmA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkr0HCwUQxN1vzKeW8KrW8YisioZXXTRxv0guqz
 4UXn05+CoGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK9BwgAKCRAk1otyXVSH
 0FqiB/sFGi36z+nwaIJtnwWsv4s6nQc8WaCGl3Wt64JG6YFEjkKmUFzdirOQ+vaSNl+3rhCeHbl
 L0uqYT5wX/qFpKvj3UKjM4PLKlilBNLMPfarhxZthFYbuB4S6abdub9yAE2gqkqrhfWfOsc5Tgi
 WMZXYcBYHiIxiOHt5eljXMEGkGAlCxo6jM7heJ2Z8UP6P/arZW4ASfgBuWoXNGfvIM1pgeOxTaF
 6zcwJ/btj2M7NxodTmkNXa5lOmJmX0AMjI2Je5bHnzABufRlNa/eJBNKIgFpmtZWCb1YG7na4ik
 5X58n2krs9IRl9RziRYMXE8t0f//9lMyMIMnn+02zWyEGHKZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: Z7BJ332WEJWRSWWLBDI2XFRYXNO6EI37
X-Message-ID-Hash: Z7BJ332WEJWRSWWLBDI2XFRYXNO6EI37
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z7BJ332WEJWRSWWLBDI2XFRYXNO6EI37/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache. In
v6.5 it has also acquired the ability to generate multi-register writes in
sync operations, bringing performance up to parity with the rbtree cache
there.

Update the wm8900 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8900.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 320ccd92f318..84d06c190411 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1223,7 +1223,7 @@ static const struct regmap_config wm8900_regmap = {
 
 	.reg_defaults = wm8900_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm8900_reg_defaults),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.volatile_reg = wm8900_volatile_register,
 };

-- 
2.39.2

