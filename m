Return-Path: <SRS0=uf39=JX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9822C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Apr 2021 21:49:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D6961178
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Apr 2021 21:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D6961178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 357B41705;
	Mon, 26 Apr 2021 23:48:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 357B41705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619473757;
	bh=oDxWTHMcorZ027IAbYzYi3U6yZFplTvwOpnOsIF0J/U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BhcVZUjiUadR9uOqqc2ltC8z+0BkE03C6Ved6ijawgTNAtIXJFn+wv/mng85HDodL
	 K8W4fuqC1aPbQdfQPDQK7nHpzE9IfVLn3quBMHNfrSq8lF8CFZAt5+ZN5lZrggrXZU
	 pP+ylE5k4kK7r3EESy1YVVH0wzfa5ANHwPp3+Sbg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F348F80171;
	Mon, 26 Apr 2021 23:47:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C478F80218; Mon, 26 Apr 2021 23:47:33 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72364F800E3
 for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2021 23:47:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72364F800E3
IronPort-SDR: VrQ/STuu6XFrh/uFyNPLCJOWcDmWy1XbIiubTyJCKTzhDf69wncF6liN0ovUVCxWziTPm3bJ5M
 wf9omVXCLmwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="260363941"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; d="scan'208";a="260363941"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2021 14:47:16 -0700
IronPort-SDR: M8vc8q1jugwJ+AkTPuFikMkAejWRaXh+f3FIOyMQe9EbnDfVeUUpd+VTnmIO6CV2N+2uryAXdC
 OKnlLk8Qe4nA==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; d="scan'208";a="422810268"
Received: from bcochran-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.24.80])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2021 14:47:15 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ASoC: codecs: mt6359-accdet: remove useless initialization
Date: Mon, 26 Apr 2021 16:46:58 -0500
Message-Id: <20210426214701.235106-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210426214701.235106-1-pierre-louis.bossart@linux.intel.com>
References: <20210426214701.235106-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

cppcheck warning

sound/soc/codecs/mt6359-accdet.c:417:10: style: Variable 'ret' is
assigned a value that is never used. [unreadVariable]
 int ret = 0;
         ^

sound/soc/codecs/mt6359-accdet.c:464:10: style: Variable 'ret' is
assigned a value that is never used. [unreadVariable]
 int ret = 0;
         ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/mt6359-accdet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 4222aed013f1..78314187d37e 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -414,7 +414,7 @@ static void mt6359_accdet_work(struct work_struct *work)
 
 static void mt6359_accdet_jd_work(struct work_struct *work)
 {
-	int ret = 0;
+	int ret;
 	unsigned int value = 0;
 
 	struct mt6359_accdet *priv =
-- 
2.25.1

