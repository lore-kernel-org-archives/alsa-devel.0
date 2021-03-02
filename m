Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C15C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:33:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F29564F2D
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F29564F2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3A231AAB;
	Tue,  2 Mar 2021 22:32:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3A231AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614720783;
	bh=HFa39RY8K0gutsKE89eCe/LW4WUCYXuS9crw+mYvKuw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BiHQJCoVYvaF083T4gjjIibuLKtOoQedykFE1uNT+6RO1JtifxilYqbgj5M6h5NHL
	 8C+o387qSXtbkOgXon2D8GkkLlXI1EQUzM2zV0Mma/G5C6BruNlfxjHZU5Nj8SyeYF
	 K4MdU0ZJlFew/LP3CUo/cly9czFHT3a+tibmwoVo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 576E4F804AA;
	Tue,  2 Mar 2021 22:26:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D2E6F80515; Tue,  2 Mar 2021 22:26:29 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9E07F80227
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 22:26:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9E07F80227
IronPort-SDR: jegtdrFOmvE4mV0DWd68ypzj+b3D2o/mr/6VEmNAXbQsGjZ0EEwlE5X4NuZPNBm5CMMRSE1gkI
 H9bH4UlwLfzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="183603756"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="183603756"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:26:03 -0800
IronPort-SDR: +BNZRdALnas4+QNi3fxyeSJ6jerr9kVpDwgN3L0OeH9BMskTO/vU3UQCXFzRTtg0PUjFRpZdey
 Do+jhENooWlg==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="399223402"
Received: from btucker-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.60.230])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:25:56 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/24] ASoC: rt5640: clarify expression
Date: Tue,  2 Mar 2021 15:25:11 -0600
Message-Id: <20210302212527.55158-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302212527.55158-1-pierre-louis.bossart@linux.intel.com>
References: <20210302212527.55158-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Shuming Fan <shumingf@realtek.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>
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

sound/soc/codecs/rt5640.c:1923:61: style: Boolean result is used in
bitwise operation. Clarify expression with
parentheses. [clarifyCondition]
  (pll_code.m_bp ? 0 : pll_code.m_code) << RT5640_PLL_M_SFT |
                                                            ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5640.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index a5674c227b3a..8c1766954b92 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1918,10 +1918,10 @@ static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 		pll_code.n_code, pll_code.k_code);
 
 	snd_soc_component_write(component, RT5640_PLL_CTRL1,
-		pll_code.n_code << RT5640_PLL_N_SFT | pll_code.k_code);
+		(pll_code.n_code << RT5640_PLL_N_SFT) | pll_code.k_code);
 	snd_soc_component_write(component, RT5640_PLL_CTRL2,
-		(pll_code.m_bp ? 0 : pll_code.m_code) << RT5640_PLL_M_SFT |
-		pll_code.m_bp << RT5640_PLL_M_BP_SFT);
+		((pll_code.m_bp ? 0 : pll_code.m_code) << RT5640_PLL_M_SFT) |
+		(pll_code.m_bp << RT5640_PLL_M_BP_SFT));
 
 	rt5640->pll_in = freq_in;
 	rt5640->pll_out = freq_out;
-- 
2.25.1

