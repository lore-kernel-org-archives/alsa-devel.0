Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C993C5AD5A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:24:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE83B60191;
	Wed, 12 Aug 2026 11:24:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE83B60191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526673;
	bh=xo1poeIZSXWhFu8Z59FlKesikj7/JBi6ReIj+nJGSKk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TmWmW/JwQjvxMCscFkjQElMbl7D0ffyhx/eNOi3DBCoSrlaQKdFN6u6hck6JFYS5L
	 5PqmrBHmoGuzpLMKCAqvSE9a3YPWh6l81Yx3pRXZrXybCN48c4oBjPNhXCxIfGaZBr
	 yvkQGZ+2U0JNql7QdagGnCdVAhxbP/q/oHB3Beiw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E72C0F805EC; Wed, 12 Aug 2026 11:24:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CCC62F805EC;
	Wed, 12 Aug 2026 11:23:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0E0FF8047D; Fri,  7 Aug 2026 16:19:51 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=43.163.128.49
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786112391;
	b=oT6/4yhmvSm8h6LMeWL/GFYESgwpjTI3V+VW9GKL2qeRPsgRDH44g6+Pk4qFtcc99YrN
	 RUgbfVVNHY3QLnZrTv7CqqMCOpBb//DoKBloxefMOCdGbIREBmJXPCNFNxu/7kKIFa7m2
	 4U/F07gjp5Ey1+MXK51Us68Xg/jhC72Y7oyYU3YYhQ0q2FO7tqzdX/XpGHF+rU1TePdu2
	 /31Jwv3BVLeIhVuWIElKLEBhRqG4LQ8KqmthOznUJ71+6ZtL3cD0kbS98ZRk9Of+r7Obi
	 m0+vg8IOKa3xTy4Ed521yZ1195EzWjXmnBcR29TFNEw8htlIkOrmYDnNtSHexRtqfaQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786112391;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date:MIME-Version;
	bh=xo1poeIZSXWhFu8Z59FlKesikj7/JBi6ReIj+nJGSKk=;
	b=eNl1GU/KIBBJdheOyT2wnoKee9+D9Ke5F93m7n/LJJfQFBaUw2Bvu5BHC+M3GpzmFbJt
	 a5ry7aOmRqf9SJ1wSkJdTvikk/td55feQ2puYoicxF4OHMcIL8yMJjaWqD8QFlLmP8h5H
	 8sS9mdtNnR3TmdkYZcuK/l8XHXh4tBHm7nQ057QqieKV+l5uC6zRUSzOoW/mg7O9NGIQz
	 Gh8/ytOsHt8WlTMWHSMpcDdMZJbPvFXKwMQZKYC7/EXOZp6OkgrdkGjCRd8MgI3PrrwXh
	 NY/4DNTCPSVK6Cdbt9bYqk44fz164YgMfd9j89TpsgueFiZIlPCjhM/Aeq+CCU1b/ZQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=nXu0l8ir;
	arc=none smtp.remote-ip=43.163.128.49
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BA0ABF800AC
	for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2026 16:19:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA0ABF800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=nXu0l8ir
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786112386; bh=51KrcFiptP6M9Wn+JdOtCz/dSpKZuroZWGIkhaxsIfU=;
	h=From:To:Cc:Subject:Date;
	b=nXu0l8irbnJ+S7fyPmvfTq5GqG/G9sZ2OD6EOCDAR33H76g3eF81iFYQptLjIi27b
	 FkR6EVJQ4rhp6aycsYKOpmafRxMy9JygcXQCJ1KbnzXv5cxctmUAarHgdjmzlz7f3e
	 nRnFvuBxDhtyn6e5K6QqHOgZrdo1TLqzUMqyFuT4=
Received: from xein-hyper ([2409:8a34:4ca0:240c:7a9d:f2ca:5878:ef73])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 4EB9D6D5; Fri, 07 Aug 2026 22:19:43 +0800
X-QQ-mid: xmsmtpt1786112383t22kjoe52
Message-ID: <tencent_428392223C2AD3BF23E7ABAA7521FE5C0C07@qq.com>
X-QQ-XMAILINFO: OYTBn1rNHH7tqoFZ9pKTlSFZeI3n6XXSYvZATJGHJSc5jijF62KbdVNYhk5Vgg
	 1NPIjdzLXpM7redqpEO3pvtd9qV3x5XoXHnkQH0zVdZqyJ8ZLAC5l7tb+5J1HWomj9VfnOPdLava
	 5FRW5kf1GHvWIJxr/XeVbGTbnlar5oTnHJW/8dSQQX1iFFAIYHGvvawIQ+NHhJuJ4Ddd3rXL/P6+
	 mB12z1T1Dw+LiEYEGNlRK/g6d+dUmHW+hIN1MBCjBA1Nbqrzqt8MohJD0Il16Omp8LtrrDKSCthP
	 EXIzOl9A+QNOnP2LQC7ysnV17RvkzZZl2C9RFGbW4Odp6W71FTRXXya+OF1/VkI48/49jTMoFfqH
	 ZT6FqkoMP6bHi9fbBdNQkG9o3wDKmkeW1kG+UTBnkJcJJI7A0JthFlP4Z6G4hjU6mt3kEG4/K46y
	 GoO117tUALFPfBdg2EPfcsmGpfpEiC334HwKl5b7foNVJb/cjIknmONrTpWqd29jkoc5QjyHgQTe
	 plf/l4MQrwTdqe2IliDp0gTaFn33adr7k39ufHs/l2GBXJ3XF+DzEf+M7PhCfiUt4u62ouUAS+Hf
	 sRtlNkyfVbk9aCOg99cfHrx9cxNeM0nygZCSO5na33mivxhUO3CiVPoeYHsW9Lo9bg93vUngZQgN
	 wsIYeHiCUVIaaod3KD3v9mFgzDXJOmxgvUKAZQ4LwLJMClUglnhx7N8uMpbQH7BqfEI3bbMMJkp9
	 u52LgS994gnIL1+FyX+bh9mvh0hElbARK+folwYBg70JYC3GKfDkNbdQ0/4xFeLe1wrooMInX+Z+
	 f90uTuMMkTRIDn8nWrxzSbUTHGMA5ZkwLbl7vPjkoAoSA7yvbLVtmhljZBGUH94BSi3Mk2mHJuwD
	 84o1eKAKBso1zKhQpKe45/YO/5qfiOs99o/DssS4nfB9+GcxiR577EEmSxect1T4CrFGPZetlx7K
	 J12btww+KkahmVo8SSRHds4D9mtgxwM3JL5F8+N+LXEIyohVaB+compWRXhk3M6EWatRvUWJRtnN
	 wCshwXQs7cOALJTRl6AGGzT2aDgQMss9FNWrfEY8vCuXANhLMkwCutVGXBC1qOSdKf6MHNucqNgX
	 yg4TqEVJsvc8/WbchbgarMksV8A3AQeVVNGYulwX95gWZ6zWXNTSkfzTse3Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Lin Xianglin <1021538027@qq.com>
To: alsa-devel@alsa-project.org
Cc: linux-sound@vger.kernel.org,
	Vijendar.Mukunda@amd.com,
	venkataprasad.potturu@amd.com,
	broonie@kernel.org,
	Lin Xianglin <1021538027@qq.com>
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for HyperX OMEN Gaming Laptop
 16-ap1xxx
Date: Fri,  7 Aug 2026 22:19:43 +0800
X-OQ-MSGID: <20260807141943.9059-1-1021538027@qq.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: 1021538027@qq.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 54JVSDNXIBIGVFSE6HC4TVNP6YAS6CY6
X-Message-ID-Hash: 54JVSDNXIBIGVFSE6HC4TVNP6YAS6CY6
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:23:54 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/54JVSDNXIBIGVFSE6HC4TVNP6YAS6CY6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The HyperX OMEN Gaming Laptop 16-ap1xxx (HP board 8F06) has an
internal digital microphone array attached to the AMD ACP PDM
controller, but the acp6x machine driver does not register the DMIC
sound card because this board is missing from the DMI quirk table,
leaving the internal microphone unusable.

Add a DMI quirk entry for the HP board "8F06" so the acp6x DMIC
capture card gets registered.

Signed-off-by: Lin Xianglin <1021538027@qq.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index de5c895..ae86d3a 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -724,6 +724,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8E35"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8F06"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.55.0

