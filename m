Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230A4C001B0
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 23:16:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21D2284D;
	Thu, 13 Jul 2023 01:15:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21D2284D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689203768;
	bh=jH0tc4h0aO75yyuZ8Wux9PHPeYRfDjydLkgn8FKnic8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YbBkhEepXmIKV+gt52tyGNba1FpL9fwOLyC8WQfuS6dudgJB78wWdNhbqPH5VjVnF
	 TGeNZM+g6mZalIdCzEgJ8KgMtHrjxtbA6CnV5mWjIQYzi7e++wdfqIFiNiPePlswDp
	 yQQteViAfTM7LMK2bM4hGdg/kkhPFxvDxd2YA5po=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D53C0F8055C; Thu, 13 Jul 2023 01:14:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11E11F80567;
	Thu, 13 Jul 2023 01:14:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27D2CF800E4; Thu, 13 Jul 2023 01:14:21 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 425DBF800E4
	for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2023 01:14:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 425DBF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ipixi9oz
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BF17B61995;
	Wed, 12 Jul 2023 23:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D612C433C9;
	Wed, 12 Jul 2023 23:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689203656;
	bh=jH0tc4h0aO75yyuZ8Wux9PHPeYRfDjydLkgn8FKnic8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ipixi9oz240Fk6hh6FSP9GhovrfKKEzIsZ3oLPW0q4dhC5+issncyC24vCLZE8Kg/
	 de4TSRZMX3Uqdzdm0x2rs/XDnDO49/TdNIJ/HGweFJJrq6fvH086rAmXjewhIVTaRc
	 xm2KWPlKBf4pTa3sLxRwDjJG8G36WAREu3DQ2aXqoka2GCWPX/59B2VBSLWXJQP8AB
	 hJL880LY3uoLYMF61ZaNe7G/Ho7fYy31SRSyhW1LLFzNu7dnXCbOK2s3+9xzSayDxU
	 5y/UQNyG4kB5Q9ljKwX+pfh97nP/fyndOJw99CNy+96uMzhaX2RTwxOitDLogrV+2m
	 +6TxkVYb7jssw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 13 Jul 2023 00:13:53 +0100
Subject: [PATCH 04/10] ASoC: adau1373: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-asoc-ad-maple-v1-4-7d2f35d42b5f@kernel.org>
References: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
In-Reply-To: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jH0tc4h0aO75yyuZ8Wux9PHPeYRfDjydLkgn8FKnic8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrzO2QeAN1qZjeKDjeWZf5jUfNPUw5eTH1mUr3
 kD7sEN0T62JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK8ztgAKCRAk1otyXVSH
 0H1QB/4iY6SjVxxeAgJ3i31IWjv8dUuMUh56Plmnd8L/Gjj4DPuwDECXfBrKDCEByMAFh3lsyFe
 5uYXMAEeiHZTmYX8Nb/CeGSaWRwBwyYanOMW8GXNjF9kBwsWcm7Iggm3D9SzT3bhPyJqygq4TvJ
 yJGQW9coieAh/qrSrw9Fe2r0ik9MyyR3Sz35lVQkxxReGbtomCRaer5JzqIAQopo8tuCX8MtdJG
 k5B9Z1n/bANKmzw/XpTYlmkSnjpZKXfFiJtghBO3nvLczllwZ0uuxGmHM6HVCNDr+D7MREqifdd
 Z08quqPn7At4SouY/9OpmmJumf3ZiwoXgHfNpcbm8U6B4UQc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: ICULPMOKOMJOLHNIDZFY43EVNC5T7NCM
X-Message-ID-Hash: ICULPMOKOMJOLHNIDZFY43EVNC5T7NCM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ICULPMOKOMJOLHNIDZFY43EVNC5T7NCM/>
List-Archive: <>
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

Update the adau1373 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1373.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index c5b087b8fffc..b0ab0a69b207 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1451,7 +1451,7 @@ static const struct regmap_config adau1373_regmap_config = {
 	.volatile_reg = adau1373_register_volatile,
 	.max_register = ADAU1373_SOFT_RESET,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = adau1373_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(adau1373_reg_defaults),
 };

-- 
2.39.2

