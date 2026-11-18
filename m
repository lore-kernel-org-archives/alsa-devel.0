Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FF3606A320
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2026 03:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=f+g+0+jF;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nJzzQ5FB
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91012601FA;
	Thu, 19 Nov 2026 04:42:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91012601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795059786;
	bh=ZomLfG8+zmLT9HwNavqBSyQ79CdcERtWC2t1IG5DH/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=f+g+0+jF2TPYxxoqP9ePue294Sz+zsmsdq4kImOmxMn3YI4tPHGFM3Rl3ST0YhvhC
	 o5D+KH7BBuUvxjLpXj83HLi1Ik2nq1IoX9pTz227lqgvIf3B0+8qyZBoGGBiFNlUUV
	 w2Mkf9MJ5OZ9tdedDU4qDgkJdR4grxpWWpRaYMjw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91099F805FD; Thu, 19 Nov 2026 04:42:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D900DF80601;
	Thu, 19 Nov 2026 04:42:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2667F805C5; Thu, 19 Nov 2026 04:42:24 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795059743;
	b=ksWcPtQ7R4HAKWuJJWp/pXAUog60Ilcsbuy8iuKDaN2DGkbmhFvKDxXjtvmnmW5p51g9
	 TT3qGdum90qEM52sQyF86RVjmO/Ysyr/zA999VC60MKGkYQX7sANefx6ZrFz53qy+GGeB
	 apZfYIv6GoXCaTXnMi13d7tBL6lQvSEc5AidGn2OQS3jM9XZsbf4ziPbOZrUtFTwTOvrm
	 Xb947KeL0xlLOULCgBxKLUqt4TET3xblhn6BomyhPDzO7rU5v+4DVt39XT7ge7JMsm7IU
	 pT3Xl36pA3FWQKCjs9FI5b19V02rD4b3HVfaiVTsj5Rc8zH0kZHLJd5fOfRMDvC2bxw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795059743;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZomLfG8+zmLT9HwNavqBSyQ79CdcERtWC2t1IG5DH/c=;
	b=oskYLYb8pLtXZkLOUgaU+T2sKza98Mi4kv4ck2DcRFQ2fNdP4bu5VfWbLnB977QLLP3W
	 ma53lBrebVuY407MWgo/NlZuwJy2lte2C/XigY12lJSMR3g6UUOW3WOqO+P1i5yZHJKmH
	 gN70E18H9TFNwB4x2h/tX9GTPrpW/Jp8SQVTHPFQ09Pp3FRc1OpWQDZE3g9Ih29Xgr0zL
	 qQ7xONdaoyuHmdTeoPJgD131h/jOYuK5fWAbr5iMhqAk0S45oRZbtDgBMX48Pc2mkV2th
	 JpR7qV5Yqh0OWjgBWnC7CFrJv4YiywsOn0VmQfvpDJezbX6AI7XcLUUANgI8aNvEyMw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=nJzzQ5FB;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 03996F80124
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2026 04:42:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03996F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=nJzzQ5FB
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A610D475F5;
	Thu, 19 Nov 2026 03:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CCC1F000C4;
	Thu, 19 Nov 2026 03:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795059738;
	bh=tLSMqJBbrE6P0LiEe3l0gpXxHPG9jRCzaeV5vUCTPhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nJzzQ5FBT96cyorC3VRBJ5y56JgQk4rjoRTUyjX3NPAGThkcDCmJjy8hmh0KtN7hc
	 yrQnpHWqfVGZLXmjRKMqmWzlYqvzCjbtGCYbn4cvqW/65Tn87sOSRCB0/fDBrB8giM
	 ncvhCLriEsJ+2yk3u12OwVmxjdVIxDl93flarkbU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	Maxime Ripard <maxime@cerno.tech>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 0949/1848] ASoC: tlv320aic32x4: div: Switch to
 determine_rate
Date: Wed, 18 Nov 2026 15:49:47 +0100
Message-ID: <20261118145956.761154714@linuxfoundation.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118145911.150052362@linuxfoundation.org>
References: <20261118145911.150052362@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ASDOFL5PI3Z5MCSRNZSCE3O6ZQTJIS6W
X-Message-ID-Hash: ASDOFL5PI3Z5MCSRNZSCE3O6ZQTJIS6W
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ASDOFL5PI3Z5MCSRNZSCE3O6ZQTJIS6W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Ripard <maxime@cerno.tech>

[ Upstream commit 2b6c9b0eee89379fda238d543c5acf098a2ac5a5 ]

The tlv320aic32x4 divider clocks implements a mux with a set_parent
hook, but doesn't provide a determine_rate implementation.

This is a bit odd, since set_parent() is there to, as its name implies,
change the parent of a clock. However, the most likely candidate to
trigger that parent change is a call to clk_set_rate(), with
determine_rate() figuring out which parent is the best suited for a
given rate.

The other trigger would be a call to clk_set_parent(), but it's far less
used, and it doesn't look like there's any obvious user for that clock.

So, the set_parent hook is effectively unused, possibly because of an
oversight. However, it could also be an explicit decision by the
original author to avoid any reparenting but through an explicit call to
clk_set_parent().

The driver does implement round_rate() though, which means that we can
change the rate of the clock, but we will never get to change the
parent.

However, It's hard to tell whether it's been done on purpose or not.

Since we'll start mandating a determine_rate() implementation, let's
convert the round_rate() implementation to a determine_rate(), which
will also make the current behavior explicit. And if it was an
oversight, the clock behaviour can be adjusted later on.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://lore.kernel.org/r/20221018-clk-range-checks-fixes-v4-67-971d5077e7d2@cerno.tech
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 8cf9607d2d85 ("ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 2f78e6820c75a..96979243d3a6a 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -326,16 +326,17 @@ static int clk_aic32x4_div_set_rate(struct clk_hw *hw, unsigned long rate,
 				AIC32X4_DIV_MASK, divisor);
 }
 
-static long clk_aic32x4_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *parent_rate)
+static int clk_aic32x4_div_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
 	unsigned long divisor;
 
-	divisor = DIV_ROUND_UP(*parent_rate, rate);
+	divisor = DIV_ROUND_UP(req->best_parent_rate, req->rate);
 	if (divisor > 128)
 		return -EINVAL;
 
-	return DIV_ROUND_UP(*parent_rate, divisor);
+	req->rate = DIV_ROUND_UP(req->best_parent_rate, divisor);
+	return 0;
 }
 
 static unsigned long clk_aic32x4_div_recalc_rate(struct clk_hw *hw,
@@ -354,7 +355,7 @@ static const struct clk_ops aic32x4_div_ops = {
 	.prepare = clk_aic32x4_div_prepare,
 	.unprepare = clk_aic32x4_div_unprepare,
 	.set_rate = clk_aic32x4_div_set_rate,
-	.round_rate = clk_aic32x4_div_round_rate,
+	.determine_rate = clk_aic32x4_div_determine_rate,
 	.recalc_rate = clk_aic32x4_div_recalc_rate,
 };
 
@@ -382,7 +383,7 @@ static const struct clk_ops aic32x4_bdiv_ops = {
 	.set_parent = clk_aic32x4_bdiv_set_parent,
 	.get_parent = clk_aic32x4_bdiv_get_parent,
 	.set_rate = clk_aic32x4_div_set_rate,
-	.round_rate = clk_aic32x4_div_round_rate,
+	.determine_rate = clk_aic32x4_div_determine_rate,
 	.recalc_rate = clk_aic32x4_div_recalc_rate,
 };
 
-- 
2.53.0



