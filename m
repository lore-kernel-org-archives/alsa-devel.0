Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D35DC07E99
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:45:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F038613BE
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F038613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4818F1749;
	Sat, 10 Jul 2021 04:44:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4818F1749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625885112;
	bh=gQzsgDPXcbcYollQuPdz1JDbABIJHDdOb+hjNlPbhik=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dD98/mCHoWDkylWtQnagTWSpvUvc1z4VRwRKStdJwGVLZy6WDLgwPTTIQGxTCvXMF
	 ucFpUx6QjIA9IbYWGmqq2Va98iE0QnzmzjsjlsMpF9II8QviXvJYpPTSygQH7vZabV
	 G7PZOY7MUydwZJaet1SHHX+VoY9b9GciQGZIuu+U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B66AFF804EB;
	Sat, 10 Jul 2021 04:31:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 154C5F804ED; Sat, 10 Jul 2021 04:31:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70A6BF802BE
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:31:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70A6BF802BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jpNN2G/b"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4A07613C8;
 Sat, 10 Jul 2021 02:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625884296;
 bh=gQzsgDPXcbcYollQuPdz1JDbABIJHDdOb+hjNlPbhik=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jpNN2G/bLEfrpAJVP2lT4hoJ26y4JUU7l8kbN/XOIZ51J2a4uZti4d4UmZak9nhVV
 NjaGJh5thSlT7hebKcgTNzVLDxC790T4syU7Iio7iFwkHJffKMh2R5+JKnMZqUCamL
 ar47f1D7+RR3xFBsHHPG3xvk8uk6SOQXswVI1kI2mon6W79j37yChQFhmqfGgQvoR8
 2XlxnTjsIHtV3RB0Hk/TSgUrDz6N19is5vgh9wemZ/cKRcy5DB2ANecz+LM2iwQznV
 lhn4foncnl+LXu2A6LpgZmVYLHccqzTZohvsx3ZoYLhDK+D9lpxRfHIF8G0T9RdKNE
 RQBuyIJ8h9TyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 42/63] ASoC: soc-core: Fix the error return code
 in snd_soc_of_parse_audio_routing()
Date: Fri,  9 Jul 2021 22:26:48 -0400
Message-Id: <20210710022709.3170675-42-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022709.3170675-1-sashal@kernel.org>
References: <20210710022709.3170675-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 7d3865a10b9ff2669c531d5ddd60bf46b3d48f1e ]

When devm_kcalloc() fails, the error code -ENOMEM should be returned
instead of -EINVAL.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/r/20210617103729.1918-1-thunder.leizhen@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9df20768a8f2..c0e03cc8ea82 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3178,7 +3178,7 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 	if (!routes) {
 		dev_err(card->dev,
 			"ASoC: Could not allocate DAPM route table\n");
-		return -EINVAL;
+		return -ENOMEM;
 	}
 
 	for (i = 0; i < num_routes; i++) {
-- 
2.30.2

