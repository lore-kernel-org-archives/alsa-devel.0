Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9136C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:28:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302D264F60
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302D264F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2D1E17A7;
	Fri, 12 Mar 2021 19:27:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2D1E17A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615573711;
	bh=mnc5tEJd2ISBluoqFPI12vBauUvrnCqZwdYw3DQdHw0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=otNvoOlOpWOSSytIfRfFV5APl7axZRN7K/g+Pl2Yg3L4OWZhBdS/H344iarxMUKYT
	 zEKkfdgaiW5310QY1it6dTPo54x0YNxSjzepqyt2Kwi8cby2tl76Nv9fPSlNF9oyWT
	 yseoymLooVArqo/KbjmWMvwx58XbJamcELzgmg1g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64CDAF804FB;
	Fri, 12 Mar 2021 19:23:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D150EF801ED; Fri, 12 Mar 2021 19:23:35 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCA8DF80279
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 19:23:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCA8DF80279
IronPort-SDR: HMJ/MueDUL9BulPof4q+GhDivr/ZB5+ij+HIgih7P4Mdu0ASteO0MT6H6SZKSqhdaMR8poSCJC
 V8TRqdVWgZGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="185515205"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="185515205"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:31 -0800
IronPort-SDR: vMplSHCv5mEPnukrrcRjc6KXfk6xTNUJu0wfzFooCUTKsGxGuahYFdqJAT5LRASrP2xONMgZmx
 2otk2ZRhRGCg==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="377791990"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.37.30])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:30 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/23] ASoC: mt6358: remove useless initializations
Date: Fri, 12 Mar 2021 12:22:36 -0600
Message-Id: <20210312182246.5153-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 broonie@kernel.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

cppcheck warnings:

sound/soc/codecs/mt6358.c:334:19: style: Variable 'stage' is assigned
a value that is never used. [unreadVariable]
 int i = 0, stage = 0;
                  ^
sound/soc/codecs/mt6358.c:350:19: style: Variable 'stage' is assigned
a value that is never used. [unreadVariable]
 int i = 0, stage = 0;
                  ^
185/930 files checked 25% done
Checking sound/soc/codecs/mt6359.c ...
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
 sound/soc/codecs/mt6358.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index 1f39d5998cf6..9b263a9a669d 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -331,7 +331,7 @@ static void hp_zcd_disable(struct mt6358_priv *priv)
 
 static void hp_main_output_ramp(struct mt6358_priv *priv, bool up)
 {
-	int i = 0, stage = 0;
+	int i, stage;
 	int target = 7;
 
 	/* Enable/Reduce HPL/R main output stage step by step */
@@ -347,7 +347,7 @@ static void hp_main_output_ramp(struct mt6358_priv *priv, bool up)
 
 static void hp_aux_feedback_loop_gain_ramp(struct mt6358_priv *priv, bool up)
 {
-	int i = 0, stage = 0;
+	int i, stage;
 
 	/* Reduce HP aux feedback loop gain step by step */
 	for (i = 0; i <= 0xf; i++) {
-- 
2.25.1

