Return-Path: <SRS0=G6+L=HV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45ADC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:12:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5988064EB8
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5988064EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB2B11677;
	Sat, 20 Feb 2021 00:11:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB2B11677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613776326;
	bh=oXssArbE7xCiHRselzQerfcu5q9yHmMQfF393+gO5uI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tel+oJ+BcwOUhBbG3oiiWtK2yOkS0vv5WY/sdFWFwBpmX6ZbOd5/AA3SwAYvxfF6X
	 3wZM24zyaN66SDRpdXPtbkaSNEvyn8SgmgKwESj7+vLttgXAnrmvdkc6eFZZSKUp38
	 DbKZ9hjs5ibwT1psp0jf9SmA8cLpTYaysU2e/sSc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30873F8025B;
	Sat, 20 Feb 2021 00:09:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5872F802D2; Sat, 20 Feb 2021 00:09:49 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FD76F8026C
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 00:09:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FD76F8026C
IronPort-SDR: msBSv3opRJyIhm58Xn3/1oEw3bkghMVYNGMAtL9wYav3uLOzTvDD72XlSYXQhuCQ3omUTzls3K
 S7s7tmzexLcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="163139068"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="163139068"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:09:33 -0800
IronPort-SDR: dzAobzlPSnWYRAfxhgiHKj+MFP63Tw17VESCX7ZRUeyDsikTL+Wcbf6KKEI9GcX60bCfcxhgVR
 h7USWXdd1waQ==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="365362859"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.153.34])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:09:32 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 6/6] ASoC: samsung: tm2_wm5510: remove shadowing variable
Date: Fri, 19 Feb 2021 17:09:18 -0600
Message-Id: <20210219230918.5058-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219230918.5058-1-pierre-louis.bossart@linux.intel.com>
References: <20210219230918.5058-1-pierre-louis.bossart@linux.intel.com>
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
index da6204248f82..b9c17fdd168d 100644
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

