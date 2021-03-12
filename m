Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9775DC433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:32:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E8164F69
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E8164F69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8886185F;
	Fri, 12 Mar 2021 19:31:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8886185F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615573968;
	bh=B9XqHD7W49YThUGU6xKhAfiC95cSNFdTCof7xYzKx38=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eVYicZ6VFvxrxvSvcVUUQLAPI0cYsdbMCq6ymWb3mzBa0Svnjfmch8jUc2yedBeUo
	 Hbm8+gdVYzL7WdCPr4k88WIGT2FhzOBmUF1Xhb2MnPW/InXjiGlHO5sO7kZHlwFo6i
	 lU18I24bGaglJUFruhnXDklyC9Zt4bkExAudgB3E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F68BF80548;
	Fri, 12 Mar 2021 19:24:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B596DF8052F; Fri, 12 Mar 2021 19:24:06 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E982CF8051E
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 19:23:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E982CF8051E
IronPort-SDR: DhcHfEGuGHPOytR6z6K1enRorxtuR2Bq1MGMC5HktNdQP+oFjJVMCvZe4/mgc7Z4WEJy/jD5Zm
 puJXOuKpyPcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="188236525"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="188236525"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:56 -0800
IronPort-SDR: 6SOIPlZAxWJEsjsdY7SvKERcoUUu+c1aFiJMLRhHzkT1oGWK5AFgx60v0aiyrBWPOQYChhjLuT
 NROlmJZ+GTLQ==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="377792084"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.37.30])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:55 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 23/23] ASoC: tscs454: remove useless test on PLL disable
Date: Fri, 12 Mar 2021 12:22:46 -0600
Message-Id: <20210312182246.5153-24-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, broonie@kernel.org
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

sound/soc/codecs/tscs454.c:730:37: style: Same value in both branches
of ternary operator. [duplicateValueTernary]
  val = pll1 ? FV_PLL1CLKEN_DISABLE : FV_PLL2CLKEN_DISABLE;
                                    ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/tscs454.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index 1bafc9d1101c..43220bb36701 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -727,7 +727,12 @@ static int pll_power_event(struct snd_soc_dapm_widget *w,
 	if (enable)
 		val = pll1 ? FV_PLL1CLKEN_ENABLE : FV_PLL2CLKEN_ENABLE;
 	else
-		val = pll1 ? FV_PLL1CLKEN_DISABLE : FV_PLL2CLKEN_DISABLE;
+		/*
+		 * FV_PLL1CLKEN_DISABLE and FV_PLL2CLKEN_DISABLE are
+		 * identical zero vzalues, there is no need to test
+		 * the PLL index
+		 */
+		val = FV_PLL1CLKEN_DISABLE;
 
 	ret = snd_soc_component_update_bits(component, R_PLLCTL, msk, val);
 	if (ret < 0) {
-- 
2.25.1

