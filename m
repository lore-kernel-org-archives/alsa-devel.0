Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8991606A321
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=gAoJFi36;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQsAmXqI
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4C3160200;
	Wed, 11 Nov 2026 08:58:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4C3160200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794383903;
	bh=RMJk5ib2BmeH300cZ/+5xtNScKzOTL1ko7GmLKSQ/q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gAoJFi36kb2/dIZLLHg0QRcliCbyYpchg0MzdU5amcS4cv/UFhWecyPF0TdvRlKEG
	 eP82Xh+3OZ9wTujUyZHKYGlsGJcqRtiacg7/eYE2d5QxyLBm8irJAd/7BXv/wnk+GG
	 JDH/IG3C9WMoaWFuEwJbeYozgP3elGJTqer3VcaM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A26A5F80601; Wed, 11 Nov 2026 08:57:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 910EAF805FF;
	Wed, 11 Nov 2026 08:57:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0477F80537; Wed, 11 Nov 2026 08:57:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794383856;
	b=c7TZGzxZdWNcLHIqbhlZrvaE4AL5xA+ctALTARxZ7G78JpwtNyLjstBd/wOxZLi5T6LZ
	 VjDZtbNZVExnhaQFgslS9E92tcXObmm7w7jcQwDe7OlaXOIbSpwr9w+3vVXX5u74ymK7J
	 phyzQ+lTwK+x01EIe3+awy5Rri4yg8BgPj/z+e6GzfdXgJwH62iA9JfxalgRUSka0ysW0
	 OReEm2mlM5635KJgIkc3xKkjDF9MNkQ3SClJRuX46PXLTnuu+/oUdtJOGtbrHn8z8Miu3
	 nfCTBLMFhEZ4d6tH310JwpgXtrUb5a5QiOAX0nNQPDOGjp6rSXvDHGwZLyThcS9+f8Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794383856;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RMJk5ib2BmeH300cZ/+5xtNScKzOTL1ko7GmLKSQ/q8=;
	b=iCMGw4B7zVW4BoI7kRfDdl56ijXWI5TeZsjg23h554CaQkVPAXzxF/GD23pLGaKwwvD/
	 ibTuvEnnrFSLng3AuthzF/Akfm6kIrEaof8pO5AlxkreWce9VCqWH/nHpODDjvhh47OVH
	 63jAMoRib2V0jVc1XCPi9cDtQUC0ilIY1XKukU6bZg2RT0gsUaPfzg7BRmCX9AOiRogZv
	 BcyCBIclux5M1VTgrnsAQTFWOATExss2mxTb6WVgzIuPKG1gtxOi2jmQxSnhXnIG26f/T
	 dGwbS+K8IoVEWC6VB1nXShbx1qzdw/NNJog6JoHiiXvMJ7bONhQCvq1oqFcQBUtFR/g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IQsAmXqI;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4FCE5F80020
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2026 08:57:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FCE5F80020
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IQsAmXqI
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E8B3D4757D;
	Wed, 11 Nov 2026 07:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32A31F00A05;
	Wed, 11 Nov 2026 07:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794383851;
	bh=6vuAFoFnpQs85Cz7CirKHqKfuLYtnlc1QpyvQGLwaCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IQsAmXqILL31xGtjdrDjJnnmtogYsR+HVQIReSwTe87cJriIiRipmUkTrRm9oYjmC
	 Nab+Cuye1X+P1daEaXOK12Wt2iG2tdJVt0xMXZScJo+2/9N6/TKwG6ggLuh8JZ8f7J
	 YbZRC8QJrfA+z/Qz5/FF7Y0P6dM42iQdl6f87L8IRogS6UOwx1LFWreJnIl4FOkaUM
	 Vv2GNgkwRLCdMZ8bn9DTHarWGbXzs4+MOgetJk+Ci9HBSWartrWz0u0PlHnDbBmf0C
	 /ATamilXJoUAoPSlQpT484ckmbJU/SCfcNk9opPLarcyQAx5fHKQjWVNiVwpGJJVX4
	 qmmHz/pGmc5Yg==
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
Subject: [PATCH 6.1.y 1/3] ASoC: tlv320aic32x4: div: Switch to determine_rate
Date: Wed, 11 Nov 2026 02:57:27 -0500
Message-ID: <20261111075524.1400365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055343-failed-6.1-8cf9607d2d85@kernel.org>
References: <20261107055343-failed-6.1-8cf9607d2d85@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BLZERBFSWHSRHRK6XVVJWTYG4FGZ6BOR
X-Message-ID-Hash: BLZERBFSWHSRHRK6XVVJWTYG4FGZ6BOR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BLZERBFSWHSRHRK6XVVJWTYG4FGZ6BOR/>
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

