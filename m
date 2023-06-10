Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A13C77B7A
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jun 2023 14:04:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4056B84A;
	Sat, 10 Jun 2023 16:03:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4056B84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686405846;
	bh=QAiEjd0VzSRQVdILJj/SOOLojghwTPUunvANP7CFLb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gDwV4WzO38Kj2tTiH0xa7SSzImI7iEdqooqEFRoNmRW/TJ+ij/3T4uzJV8CRYW0XQ
	 2rW68hw5lpJT1cv1/gX70hEu1WFKPVZl6JSo0wHpUkh9sl9FTS9Uk0PUzbtMA2WBII
	 vjDQflmnNw0MAbjg45jWUyGosr3uxMRUeMe4oELo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D799F80600; Sat, 10 Jun 2023 15:59:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A32DF805FE;
	Sat, 10 Jun 2023 15:59:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEFC0F804DA; Sat, 10 Jun 2023 15:58:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7474AF80199
	for <alsa-devel@alsa-project.org>; Sat, 10 Jun 2023 15:58:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7474AF80199
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kuWQxWKj
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 34B8D60A3B;
	Sat, 10 Jun 2023 13:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EE3C433D2;
	Sat, 10 Jun 2023 13:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686405492;
	bh=QAiEjd0VzSRQVdILJj/SOOLojghwTPUunvANP7CFLb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kuWQxWKj89dYnF3wUPiL3rzSIQrSVGPhnslmheHBRvTpeDA1O+DObtVaYbHYv1fEU
	 BXAt8gAtFTrxHigTjRglHWdpDpyY+NhPqS1cj3IB0Q4sD1QJEYGY5IsHQOl7KDqncq
	 EN9zS8WUJfhHqg+DKKHHw5elR/YnREuQEG84dKndDhMThPeBGA7HDH/tRvHJBJVLG6
	 uMB0kVZxfoKMttrBkdcYWHbayA7UmCTqwY/KxT05jonIWcP6H3yiM5ClB8ugJiqLaR
	 DEh4TNdD26eTiQJbOaZyjly66pCJOLMU5ANaAGqyb3NaepYTzQhK8ALhEnX0DigapG
	 PsyKJ7ZXRpOYw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 10 Jun 2023 14:57:51 +0100
Subject: [PATCH 05/16] ASoC: rt5514: Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-asoc-rt-maple-v1-5-729c6553cdcf@kernel.org>
References: <20230609-asoc-rt-maple-v1-0-729c6553cdcf@kernel.org>
In-Reply-To: <20230609-asoc-rt-maple-v1-0-729c6553cdcf@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QAiEjd0VzSRQVdILJj/SOOLojghwTPUunvANP7CFLb4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIFjGPb9eJ7lDZTRX2dqewCYI1w5pEG3tkQ/TZ3p
 WxvALEeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISBYwAKCRAk1otyXVSH0H+hB/
 0R9ygFsfnZic8CihNl8hSlDlkGQW4lafgY1rJPS3qAwoLRKBB31ikEmkReHCjmDsvZEFQcQ2vGFdbw
 STNZPBfRHFC9MS3FoVP5yOR8+S/f7XjUYqk2eSDqYwNSFDSs3b/qzbvyLmBdZgF9tsIq6yDQprcG4B
 xDjrW0u2mV0zs/zasu9a8BAmPYXUcS1+vfeWfNOLlPenk9DKpunJtyVniAcEuIgUNRLfWECSw0DfrY
 DUuumUpzYXyNqV88BLxezexbcpNDtZo2jBVq5lsTAn582Ow2ffCE14A2pTkMvpv8Asm67QeJNWtTwt
 EIzXHEkWo5eUy/1DSDU9neJtHYLbdG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 6QULHXGX6CCWZGHMYPAUOZTCIOCIVH57
X-Message-ID-Hash: 6QULHXGX6CCWZGHMYPAUOZTCIOCIVH57
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6QULHXGX6CCWZGHMYPAUOZTCIOCIVH57/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The rt5514 can only support single register read and write operations
so does not benefit from block writes. This means it gets no benefit from
using the rbtree register cache over the maple tree register cache so
convert it to use maple trees instead, it is more modern.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index b9bcf04d4dc9..cebd2087cb72 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1195,7 +1195,7 @@ static const struct regmap_config rt5514_regmap = {
 	.reg_read = rt5514_i2c_read,
 	.reg_write = rt5514_i2c_write,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = rt5514_reg,
 	.num_reg_defaults = ARRAY_SIZE(rt5514_reg),
 	.use_single_read = true,

-- 
2.30.2

