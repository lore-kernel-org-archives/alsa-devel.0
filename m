Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F79C4332E
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 00:37:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A7164FBF
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 00:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A7164FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AF7C16C6;
	Thu, 11 Mar 2021 01:36:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AF7C16C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615423043;
	bh=mb+Us84TfU5huQWfnuIlfDzPAjNm5jY9o5+8sHEe4JE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fST63vHAg/MWLhZngzsdNxLi+syg9Kd8G9v5Gad/ySj+/lfnppIzs2Qnpw6HUgFNY
	 ieQeJNiS2Mp2mVxZafvSDInIB3/L6n5IKBZAUTjp+3UwvyX+d+C01hkeevlERg0otk
	 fnIAolQBgi4/8MK/FuLW1DnCBcy0Y7b9u0mJXePA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2239CF8028D;
	Thu, 11 Mar 2021 01:35:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DF1BF80217; Thu, 11 Mar 2021 01:35:41 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B310F8010D
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 01:35:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B310F8010D
IronPort-SDR: cG8lbJ82o9mtXwJ9Y+MpiSo0Dbse3JAC9WGO+nHhgQtEOJqFQ3gWhk7Bbbxhv4F3ydEw3PlQ5F
 kJkWERKhzwIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="249957224"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; d="scan'208";a="249957224"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 16:35:26 -0800
IronPort-SDR: H2KfJltk9EvPC0zjzLuIZyciyXnJYxlirkMDAYRjN4o8QE4NXScFBRP+QffOpDcFati882Y9dz
 P/oy8h6Sk4Gw==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; d="scan'208";a="520919938"
Received: from theer-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.101.109])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 16:35:25 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 2/2] ASoC: samsung: tm2_wm5110: remove shadowing variable
Date: Wed, 10 Mar 2021 18:35:16 -0600
Message-Id: <20210311003516.120003-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311003516.120003-1-pierre-louis.bossart@linux.intel.com>
References: <20210311003516.120003-1-pierre-louis.bossart@linux.intel.com>
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

sound/soc/samsung/tm2_wm5110.c:552:26: style: Local variable 'args'
shadows outer variable [shadowVariable]
  struct of_phandle_args args;
                         ^
sound/soc/samsung/tm2_wm5110.c:504:25: note: Shadowed declaration
 struct of_phandle_args args;
                        ^
sound/soc/samsung/tm2_wm5110.c:552:26: note: Shadow variable
  struct of_phandle_args args;
                         ^

it's not clear why there was a need for a local variable at a lower
scope, remove it and share the same variable between scopes.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/samsung/tm2_wm5110.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index 125e07f65d2b..c1ab6c3afd0e 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -549,7 +549,6 @@ static int tm2_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < num_codecs; i++) {
-		struct of_phandle_args args;
 
 		ret = of_parse_phandle_with_args(dev->of_node, "i2s-controller",
 						 cells_name, i, &args);
-- 
2.25.1

