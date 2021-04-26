Return-Path: <SRS0=uf39=JX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E88AC433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Apr 2021 21:49:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA97C61178
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Apr 2021 21:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA97C61178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 239A916F9;
	Mon, 26 Apr 2021 23:48:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 239A916F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619473748;
	bh=zlCrBlr3G2O+0OuLinpmH6gyxJF3pwzC9wYY+IaDuDs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lIeE6KuGfnTVu/wMOT6mUHT34ScSbGFwtwEICZJ2tz9jp/Dh05ArVavlzDa7AOpmt
	 69aXCZ44qe4dK4IRHr9AJkKFS76DUk7HuDG8/7GBJY1biFSlTrXQtZAzTsg8dBgLVj
	 5wrZ8NRrmkTO+U/Q/2MsQ4zdR7tsjRtCcz06aE7s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B56AF80165;
	Mon, 26 Apr 2021 23:47:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B430DF802E3; Mon, 26 Apr 2021 23:47:32 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3922BF8012A
 for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2021 23:47:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3922BF8012A
IronPort-SDR: 0TOE/h2n/niaqo6ViQ9isuF737S50IQ61fbcVqYCq8J4OEU3LeC7GhNFdZMVqyyv/EA3FUJn42
 Z9uC6JPaBvMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="260363955"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; d="scan'208";a="260363955"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2021 14:47:20 -0700
IronPort-SDR: /3f4MTVux5EaQo00bN+rTcULWATMZEAH1S0MtnwJNiz5zJEnB809X46GtK2yG64gr8Aiu0dJdg
 idKY55sEmTyA==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; d="scan'208";a="422810271"
Received: from bcochran-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.24.80])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2021 14:47:16 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/4] ASoc: codecs: mt6359: remove useless initializations
Date: Mon, 26 Apr 2021 16:46:59 -0500
Message-Id: <20210426214701.235106-3-pierre-louis.bossart@linux.intel.com>
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

cppcheck warning:

sound/soc/codecs/mt6359.c:274:8: style: Variable 'i' is assigned a
value that is never used. [unreadVariable]
 int i = 0, stage = 0;
       ^
sound/soc/codecs/mt6359.c:274:19: style: Variable 'stage' is assigned
a value that is never used. [unreadVariable]
 int i = 0, stage = 0;
                  ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/mt6359.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index b909b36582b7..2d6a4a29b850 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -271,7 +271,7 @@ static void hp_aux_feedback_loop_gain_ramp(struct mt6359_priv *priv, bool up)
 
 static void hp_in_pair_current(struct mt6359_priv *priv, bool increase)
 {
-	int i = 0, stage = 0;
+	int i, stage;
 	int target = 0x3;
 
 	/* Set input diff pair bias select (Hi-Fi mode) */
-- 
2.25.1

