Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5A6C54E58
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:44:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F6962097;
	Mon, 11 Mar 2024 19:44:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F6962097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710182670;
	bh=iu26nAz5LeR10kqCU52zW6G6ji5s+n5Q4x2xWSNy2VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NLs6zr/OtBLNj6DRzDyJkjC84dlu8evtZLc7U9XBmCK9uHf3akNE/rKdk+kTtmJTy
	 d8VeL0oWa1neYRHx+CKkCY9vw9Jbp8j+wlBtotRqoFbPRVmCOkQeHzNiPOWgCv2X32
	 7cwXYwdxhNK16DaGfB+89qqT0oHoijReNvvSGvVg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E58F2F806C6; Mon, 11 Mar 2024 19:40:18 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A00CF806C8;
	Mon, 11 Mar 2024 19:40:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A74C2F806A7; Mon, 11 Mar 2024 19:40:15 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8B2E9F80587
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2024 19:39:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B2E9F80587
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TLR/kYdK
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1337F60F10;
	Mon, 11 Mar 2024 18:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209B5C433F1;
	Mon, 11 Mar 2024 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182388;
	bh=iu26nAz5LeR10kqCU52zW6G6ji5s+n5Q4x2xWSNy2VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLR/kYdKusZtsgmUX/cUeEI5nQT/nU0rDO/0SWKSRByQwPKEKvY7e42GBh03mk0iL
	 Swf+CH6V/33OzGpjqzQDAzKIQ6nSCmArY8HSyg1I65QP9p1enk7XJGpJP8515VgrRC
	 7/5AzcgQdDR1XXlCixXNMA0yHhy8YqNwcEae8XKsZSr3QCXwviUwfx1m2Xew/9SJXB
	 ifpRfOekG7nGn8PKV7SPzBd97fVobdxsfKqR+FaILTE5t1X6ujcED7sY7vu/1dbQNJ
	 No9rR0wLilns0oJ1HyATYPtOCQfTQ9rgrq1Py+yuXxJXYCNGmvGB2zAO0nmmhN9tf/
	 jK1uR5JomrFVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 5/5] ASoC: wm8962: Fix up incorrect error message
 in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:39:22 -0400
Message-ID: <20240311183923.328881-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183923.328881-1-sashal@kernel.org>
References: <20240311183923.328881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.212
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6ICZXNV4L7K7IOAWQZQ3RE5CYJCVWSOI
X-Message-ID-Hash: 6ICZXNV4L7K7IOAWQZQ3RE5CYJCVWSOI
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6ICZXNV4L7K7IOAWQZQ3RE5CYJCVWSOI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 96e202f8c52ac49452f83317cf3b34cd1ad81e18 ]

Use source instead of ret, which seems to be unrelated and will always
be zero.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-5-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 030471248e0e4..272932e200d87 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2917,7 +2917,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0

