Return-Path: <SRS0=rOcL=HY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9E2C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 21:36:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF8A64E41
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 21:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF8A64E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4AA9166A;
	Mon, 22 Feb 2021 22:35:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4AA9166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614029765;
	bh=hmBypRpGvRTnigKoS4F9RD2gX5idMg0m4ejNPDBOkS4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YujJ//73Bn6wia0IpollVJrjymYsyHmhKKUh74Q1v+DvkCTvfvUWOqyNxFDZ6AnLx
	 ufdaz3KlREZHHB3NOihW3tTDq8SWwfkl/wwJfZn3KWobLVT9ku9dArtEtj5OJ2XVFg
	 /3ngy0aeocJPljPOMiFANyqnd5xthwbXItDBpR1A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 975F3F802E2;
	Mon, 22 Feb 2021 22:33:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7836FF8016C; Mon, 22 Feb 2021 22:33:37 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0326AF80129
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 22:33:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0326AF80129
IronPort-SDR: 8NMBGwPgWbzPaG7R8gCDvkP/V4D6rk9UExdrkYFTGWTYpPHewDCDVwoDNbzRHqbAb4DfvRjf6e
 txVPUzV6te/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="171739988"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; d="scan'208";a="171739988"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 13:33:18 -0800
IronPort-SDR: GDq4MatQyeXJYrIbPN+sXtMisoSXdhgDQc67ovIoPr39KaUtKx4HbmjUkq27IDzj4qcIWmbj+W
 8r6oq7NJJESA==
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; d="scan'208";a="423270703"
Received: from sspurohi-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.54.136])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 13:33:17 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 2/6] ASoC: samsung: i2s: remove unassigned variable
Date: Mon, 22 Feb 2021 15:33:02 -0600
Message-Id: <20210222213306.22654-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222213306.22654-1-pierre-louis.bossart@linux.intel.com>
References: <20210222213306.22654-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

cppcheck warning:

sound/soc/samsung/i2s.c:1159:18: style: Variable 'dai' is not assigned
a value. [unassignedVariable]
 struct i2s_dai *dai;
                 ^

This variable is only used for a sizeof(*dai).

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/samsung/i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index b043183174b2..c632842d42eb 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1156,11 +1156,10 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 	static const char *stream_names[] = { "Primary Playback",
 					      "Secondary Playback" };
 	struct snd_soc_dai_driver *dai_drv;
-	struct i2s_dai *dai;
 	int i;
 
 	priv->dai = devm_kcalloc(&priv->pdev->dev, num_dais,
-				     sizeof(*dai), GFP_KERNEL);
+				     sizeof(struct i2s_dai), GFP_KERNEL);
 	if (!priv->dai)
 		return -ENOMEM;
 
-- 
2.25.1

