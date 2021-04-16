Return-Path: <SRS0=6+tk=JN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4829C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 19:14:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C61611AF
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 19:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C61611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C64C16DC;
	Fri, 16 Apr 2021 21:13:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C64C16DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618600483;
	bh=RDF3XZ4AForZdea9QCgBsAOa1NAOQgRFwRbLOKOy/7Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qm8Z21peSy0a8SanSRLDFUouA6EFNhE1CFRVMyzpbj4kSynRI9SI+itAR2pS9ilyp
	 +XU3LgDZlNf66WkVoSWHOgvBaxqPMBxfO+gqW2Bk9R49GDmbeBkcCgyxAp3Y3/TL9Q
	 LvXf76Z7Cg6yVMxA9yRF372/IKrndA+9nlGwKBTM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D426F80423;
	Fri, 16 Apr 2021 21:13:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9058BF8042F; Fri, 16 Apr 2021 21:13:15 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDA88F80273
 for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2021 21:12:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDA88F80273
IronPort-SDR: yqIh/QWdudCqekUty7z5pC+8Ffd5mNcAEUOJabTimhYB96fiCSP7AGMyn1OWIUgmRwzuNMlLd7
 CA4q5CTuh1kg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256407106"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; d="scan'208";a="256407106"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 12:12:00 -0700
IronPort-SDR: eVQm2TETPGYjhy37+80iknYjwbg8SsJPzgqWF2soFTb+HRmipDX8uEQ96oU0hOmVITruLLpxJQ
 7qZ7gCavvwZw==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; d="scan'208";a="612838754"
Received: from paulsoum-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.66.118])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 12:11:59 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/5] ASoC: codecs: rt5682: clarify expression
Date: Fri, 16 Apr 2021 14:11:44 -0500
Message-Id: <20210416191144.27006-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416191144.27006-1-pierre-louis.bossart@linux.intel.com>
References: <20210416191144.27006-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>, broonie@kernel.org,
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

sound/soc/codecs/rt5682.c:2404:42: style: Boolean result is used in
bitwise operation. Clarify expression with
parentheses. [clarifyCondition]
   (pll_code.m_bp << RT5682_PLL_M_BP_SFT | RT5682_PLL_RST));
                                         ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/codecs/rt5682.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 0e2a10ed11da..a5aacfe01a0d 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2401,7 +2401,7 @@ static int rt5682_set_component_pll(struct snd_soc_component *component,
 			(pll_code.n_code << RT5682_PLL_N_SFT) | pll_code.k_code);
 		snd_soc_component_write(component, RT5682_PLL_CTRL_2,
 			((pll_code.m_bp ? 0 : pll_code.m_code) << RT5682_PLL_M_SFT) |
-			(pll_code.m_bp << RT5682_PLL_M_BP_SFT | RT5682_PLL_RST));
+			((pll_code.m_bp << RT5682_PLL_M_BP_SFT) | RT5682_PLL_RST));
 	}
 
 	rt5682->pll_in[pll_id] = freq_in;
-- 
2.25.1

