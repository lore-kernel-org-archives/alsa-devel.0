Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7E7C04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 14:49:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3188D6143D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 14:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3188D6143D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 856291696;
	Mon, 24 May 2021 16:48:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 856291696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621867753;
	bh=vDmDR8rBz5cxhgymzBsBDhzNOahKdYK7bBgaf5bEXag=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MTvO60Opqtmpt4rb6T5HTM7BCU919MQqBawFQAqLKEVbpvPfO9G5FAFz1gCmkev4k
	 56UHvKkPMzIDGI6osZC6IYuR7p+YtRKY8scB334EQLqlA7wcv7L48Gbi1iQaiGZTWP
	 yMzf4PQU7G3ihB/JYLfZiwourwfhpDMAXr7ULPlg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0716F80482;
	Mon, 24 May 2021 16:47:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1857BF804A9; Mon, 24 May 2021 16:47:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 833A8F80482
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 16:47:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 833A8F80482
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Os3vwjUJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FDA6613BF;
 Mon, 24 May 2021 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621867619;
 bh=vDmDR8rBz5cxhgymzBsBDhzNOahKdYK7bBgaf5bEXag=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Os3vwjUJVVW98bqN9pa5qIHSUy8z0efpNoyEUTdKL42xglO42Vc6WPsmuvwXrd9DZ
 zvi6ZG1qz8uo3PlguIYADHm0vRb2V8pXGONa/AasWTufdLsmyHfbFrnj20LKijzD2N
 5e2NwQ72HaXiDX1QCM63AloDEYfjUv1SGP/FL6Tc4WsqOajxZjW9H5FCwY47XGWO+x
 VtRTro5wUd/BRYtYNh7PjcPPyncUcc6VIdjQiQo76lozAnhgAmIMn+6IMg3qcIu7F1
 A/1ffyJQlU53pb3CV+cw/nAOX0UytE0N7E7yv4q96RnkarCCmrAANJd0mNp/Ekn0a4
 7+AuLPCkTSU6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 29/63] Revert "ASoC: rt5645: fix a NULL pointer
 dereference"
Date: Mon, 24 May 2021 10:45:46 -0400
Message-Id: <20210524144620.2497249-29-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524144620.2497249-1-sashal@kernel.org>
References: <20210524144620.2497249-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Kangjie Lu <kjlu@umn.edu>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 1e0ce84215dbfd6065872e5d3755352da34f198b ]

This reverts commit 51dd97d1df5fb9ac58b9b358e63e67b530f6ae21.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to be incorrect for the reasons
below, so it must be reverted.  It will be fixed up "correctly" in a
later kernel change.

Lots of things seem to be still allocated here and must be properly
cleaned up if an error happens here.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20210503115736.2104747-55-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5645.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 63a7e052eaa0..ab06133a85da 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3407,9 +3407,6 @@ static int rt5645_probe(struct snd_soc_component *component)
 		RT5645_HWEQ_NUM, sizeof(struct rt5645_eq_param_s),
 		GFP_KERNEL);
 
-	if (!rt5645->eq_param)
-		return -ENOMEM;
-
 	return 0;
 }
 
-- 
2.30.2

