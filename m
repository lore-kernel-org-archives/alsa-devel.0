Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962B606A321
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=e6hSG4BF;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNcH9Hva
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 637A6601EF;
	Wed, 11 Nov 2026 09:06:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 637A6601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794384416;
	bh=RMJk5ib2BmeH300cZ/+5xtNScKzOTL1ko7GmLKSQ/q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=e6hSG4BFiZeznwkjH8cnZHoktC/xMi/Z3+D61i/ZNOrW0oyZEr1QtG7fZXhpKvAtD
	 02GqqMB1SzmJv8N/DoPjjrBn8q+tswZ2q4YvuD/noloIcmdnsoH9+mw3XmPOTW7rr2
	 CjJm5yIdWrcqMxbgm4Kn453UFhMyC3sBEcseKzFU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 78968F805F7; Wed, 11 Nov 2026 09:06:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C034F805FF;
	Wed, 11 Nov 2026 09:06:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7B269F80537; Wed, 11 Nov 2026 09:06:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794384374;
	b=AvKZ0K+icEz/xUgOwb/ibjq4JhHzZ9wAPyCBU+nufyqMucMEYryJBz/usS3e64xjYCiv
	 tjPJipTyrw09UJ/1wlMzjjQzu7Ch/SICflI254StLOEPAebHX4ragJ/2iXV1bVWW5f+48
	 y5+gX90rbZrN3TMH+uK3WFiNbrPT8UGtNAUU/OWCnFY2AnZhAhPaOke8Vifs+VMa8wlt8
	 9qls8AN3QZvagAOpwIXQaYL6mkmDWnX4pjdxdaE+VX9HgPXtEO6jtPFGqYaog4S8DA4n9
	 pWXNUly/+ejDzyTMa4T9RQI8rTcS92HD0JVbgKu90WXJ97QWZcXJQRQJ0evgxm59+HQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794384374;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RMJk5ib2BmeH300cZ/+5xtNScKzOTL1ko7GmLKSQ/q8=;
	b=RkbR2tjxJ8oOJgI16IqsRv93JZu3Kj9a0mY45HbfhHrqnnfzEn7J3mMTiwTl46GbBDsa
	 EQ83CPEd+Iv9vOivitBNluMA+4cLBeOPDYkC8DXvNkqUDJqD7OWjzqs2AzPtRC3yR8k6p
	 Q7YpmvVldTGdl9Z3GUqW2+LqXi6PNfV/5dxNLsQezjcWR/KcFV9aabjWasLSdgMrrSV09
	 g28piUt0qFpow6hNhaUMxyWpbyZMg3sDI1Iluy2MqTA8QtAFxuIz9vY1bNGNQkzyXwYu8
	 vQLJXzfzPmReYS4ZDkCl27N+B/QVk5U5xB8ai03xL5AZ6Jit91B8rT2DDPY7sWcD4Nw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GNcH9Hva;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 47563F8014C
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2026 09:06:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47563F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GNcH9Hva
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4122E4099F;
	Wed, 11 Nov 2026 08:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351771F00A05;
	Wed, 11 Nov 2026 08:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384371;
	bh=6vuAFoFnpQs85Cz7CirKHqKfuLYtnlc1QpyvQGLwaCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GNcH9HvaCpLo7uNtE2CeGH+KNHJSWlPwbVI2K0iIyvPIXJGj0QHg4XoLwrlGv2uxR
	 SbZg2AgUNyH9y2IlsxiyOvrDqM9XnEqDXGhw9MiRaf8wOLHD9XPUKxTOUc+drCr0ee
	 V2nqFd6ZbUuYBEEqvs2jmRXUirZrMPc4QleYNZQdeZL5JybkMbKO69+CjNNM3A0ZGm
	 imrqt39PqAzjTe+CINUX5VuS8sjW4LBbRdLL0gFDt9onvUr2zHtK0Vkfw7K1wqZKMy
	 JNC8VatJE3SwZ4JbUp/JzR435Rf86w0JmktGxs6wl4mj3+GmEPkjkh6b6+6rE++SXE
	 +wVDBPKztQmFQ==
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
Subject: [PATCH 5.10.y 1/3] ASoC: tlv320aic32x4: div: Switch to determine_rate
Date: Wed, 11 Nov 2026 03:06:06 -0500
Message-ID: <20261111080414.1413480-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062758-failed-5.10-8cf9607d2d85@kernel.org>
References: <20261107062758-failed-5.10-8cf9607d2d85@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IKS2ZWDA2YYJHSU5BJNK2S22RP6DVMUA
X-Message-ID-Hash: IKS2ZWDA2YYJHSU5BJNK2S22RP6DVMUA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IKS2ZWDA2YYJHSU5BJNK2S22RP6DVMUA/>
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

