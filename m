Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2628FEB64DA
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jul 2023 00:24:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA0D1E12;
	Thu, 13 Jul 2023 02:24:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA0D1E12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689207892;
	bh=PxsEIEEuKsGyYeu4ZjT3V1J7ugTXZES7jicOx2qd1nQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IQ10nXuxa0zZLW+vo1NCprBLHcaVGd/vzIcq0y7bBsFFmUdRXdfbF7NpjQpwwXB7A
	 dV391dTSu8Ayg1OiJkBLBmr10kLigeGQmbeWyuEthrfYwqpJeWFep5fDnNYX5DPEZa
	 87NDq0CyzXgmkajvOTdUpOKYjTuvvna6LP1s7aF4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75B49F806E3; Thu, 13 Jul 2023 02:16:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 912E5F805BA;
	Thu, 13 Jul 2023 02:16:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 07A6CF806A6; Thu, 13 Jul 2023 02:15:56 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CC663F806B7
	for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2023 02:15:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC663F806B7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Gkr3wwjI
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BDF0761987;
	Thu, 13 Jul 2023 00:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EA3C433C7;
	Thu, 13 Jul 2023 00:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689207351;
	bh=PxsEIEEuKsGyYeu4ZjT3V1J7ugTXZES7jicOx2qd1nQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gkr3wwjIIJY4f7G+qXILoplQWwF3SXHobcwnYEPfj8SpfcSH9w6zg6CZEqOhhmz9I
	 5Zk1CIBUoMUqasuu4mshWYFag1OQWXLgOAHLE1WK00U8NzbaA1b/O0IE80o3cc8ex+
	 xGFhOoT0vPH/l20hNBgHiQYzNHNTvAQZrpuX2ES4LEI3+fD2/0eHzMWCr5rMm4PzH9
	 iYVyvT1p/zDbTX5yRweR2A97DAFfYCxTMtnZFNAX5WotH1QTUAc/unatd2fuXcbW1q
	 CnlGZ1bdGRmLQSpFPkYtFT62UWHgHkJd+nSLIs6RV0UhROTvqBC/Q/P5T1sdveEnK+
	 NX4QgJT78S7cw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 13 Jul 2023 01:13:47 +0100
Subject: [PATCH 34/48] ASoC: wm8962: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-asoc-cirrus-maple-v1-34-a62651831735@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PxsEIEEuKsGyYeu4ZjT3V1J7ugTXZES7jicOx2qd1nQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkr0HG9yNF36RFtUN/aCAIaIPywSpOHKfZ01D+N
 xhkKPzFXD+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK9BxgAKCRAk1otyXVSH
 0MM9B/0QLCzpU6EORsRCJqozpFgEXDJ+3Qz2CuH6boExoofrWLbXsdwIeGVIWLx2SexPTD5RxpV
 A2QD4N94Xj76ZPgOIFnTsYjp4eKxv8iylaDE60cQ8M7FZDoo6CAt3FpidvyE+OyoyUJ3TPDD1t4
 gRBf2CnHMXxR+m3fOQZB/PNS447Uk1vttTD/V1GKThU10sMVY6zEdfOvy+HUO/hN/opwNkBLoLt
 r+y3NjMl9cj/jk6Bf7uj9rwQC1LvH0aCKes2JqL8LAT8Y+QFOuctkvFJF3+fbNoa8uLuWXEbvS3
 ZMEk/I881/cxNhr6kxhObTJGRy20IhqNu9XKiaudbLgFzwlm
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: CQSHK3J7J2J2767WDEZAMQEFLH6VOFQH
X-Message-ID-Hash: CQSHK3J7J2J2767WDEZAMQEFLH6VOFQH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CQSHK3J7J2J2767WDEZAMQEFLH6VOFQH/>
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

Update the wm8962 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 68ea15be7330..83ce5dbecc45 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3573,7 +3573,7 @@ static const struct regmap_config wm8962_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(wm8962_reg),
 	.volatile_reg = wm8962_volatile_register,
 	.readable_reg = wm8962_readable_register,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int wm8962_set_pdata_from_of(struct i2c_client *i2c,

-- 
2.39.2

