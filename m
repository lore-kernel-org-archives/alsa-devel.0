Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D36606A324
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=s5dvI/T4;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuG2kd4+
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1868E6020B;
	Wed, 11 Nov 2026 09:01:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1868E6020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794384112;
	bh=RMJk5ib2BmeH300cZ/+5xtNScKzOTL1ko7GmLKSQ/q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=s5dvI/T495K9gM+EpOFvrgsPLoVn2amjxUsm9ePZ0IznTXYhdRTf9sarHTQt5yan1
	 O2TywP9avtrmtFHzHEQlt63YpejstpaZpyXEQCtVHuBc0Bb5hXKjakUDlyM8UNHUEX
	 /GMCuTEYEe3pRN7BwciG8StG8KKvXK9l1W1o8iB0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2DF21F80604; Wed, 11 Nov 2026 09:01:16 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74388F80601;
	Wed, 11 Nov 2026 09:01:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36F51F80537; Wed, 11 Nov 2026 09:01:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794384069;
	b=lPwkubi/JwI9q6mJb7Fsr2KLx8BZm45C3BSF4a0BAv967E/qgDXjRhWCrqV77oXT9wJf
	 KmXRoqf7vYmg+4kj3S9n2Q57gamMMB9f875xkr+eWCox+b8es3F+QlP8RIIpVue3GUO0a
	 UQL82KfcPr3UoB5Njv5b0XLS0BTp0c+hmpjRrliGdXAsN3/mq8T/yL40pJCzYWZhjMjjx
	 hKTnDwsM3pzVJ5YQsZ9PJwFVUSXOUNJEYSDZo9Bn4augf4y74Ukvw1Uy11wQI/HxCKers
	 G55fcEYVzMl71Lf1QgeZFJsN4SojAagfNUCcAHSuVacw4PubGi8EOCDm27mCKuF8hmA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794384069;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RMJk5ib2BmeH300cZ/+5xtNScKzOTL1ko7GmLKSQ/q8=;
	b=ZFsefXqFvr7sd4J7qd4kKjRNz9vB0XYEcBaQwk4VJC1W3BASKt06hqYERcncaF0ibqIs
	 4OEnpogsK/da9thSE+p26TxbkAY6f6ecV2aUWwizeQqupAbeeuruFLuxWELRNyaUSalBx
	 upS3XhTDppaDZ6IskV/H1fDcsyOS43nimUdsyQRniETztrSYTdlQM0j0ZPCiUB79OLjMP
	 vltfhuPZcAt5+2Mwe4x09Us4GAOyth5haVUEMu26nBGj1krK+FNtDrH/bBdvzZlk3PFtp
	 TRIbT4z65SZogvAZMOplAFUWu+TqWi0naQHdOExkPh9VEcHhc2bF/RV68d7yOTFQXbg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nuG2kd4+;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B2358F8014C
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2026 09:01:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2358F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nuG2kd4+
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6CA8B60239;
	Wed, 11 Nov 2026 08:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D561F00A05;
	Wed, 11 Nov 2026 08:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384065;
	bh=6vuAFoFnpQs85Cz7CirKHqKfuLYtnlc1QpyvQGLwaCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nuG2kd4+N+P1u15yBVBpRpIdYoPGbpGYB9N0/1poAzhAynLmuu9Iq9pS3bV6FRX77
	 yMHbK+DKvbfHAa/KCCeMmsgJZO/VDuCjW45HZSIniUvOqP7L4D5fZ/2IwJK1PRHxvf
	 /O4TKGgFgeboKt2SX10IDqO65zEY3zaFFrvK/ALn7rOyhxKEXkh9lVk/f8hB/VHrQz
	 z6BY3IbO/MW7/T+V8k3oy0pvHB/R7YEuppnBtI+YQvIog9vp3Pu6/mpe3EySAS8VAF
	 +5BxoW8ewo32UI5IX00b7JPEfbeI26dYIXrGMohljZzmQBT9LF1SC9Ug2hge43h8yt
	 wQ8GCz0/JF7lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maxime Ripard <maxime@cerno.tech>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] ASoC: tlv320aic32x4: div: Switch to determine_rate
Date: Wed, 11 Nov 2026 03:01:00 -0500
Message-ID: <20261111080057.1408504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061052-failed-5.15-8cf9607d2d85@kernel.org>
References: <20261107061052-failed-5.15-8cf9607d2d85@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5ITYHDM3S3W6DAHYDKJPXI44EO3KFMRX
X-Message-ID-Hash: 5ITYHDM3S3W6DAHYDKJPXI44EO3KFMRX
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5ITYHDM3S3W6DAHYDKJPXI44EO3KFMRX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

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

