Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB2C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:31:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE9664F2C
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE9664F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 726D71AA5;
	Tue,  2 Mar 2021 22:30:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 726D71AA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614720674;
	bh=xwHyQ82ZHpVYvEayV0sQ19jeQANsEVTXn7J9lqdKZY8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V72mkWMunZ8Vr7fSdgWAski1BMvis/4pd1Q9+QrtGcuFUdSwFEsAlO5owr9aGLllX
	 Vq7MF4l+Vr16E1njnILQ8VIh4s0rKcvGdE1A+iUBm89cGoNb187GN0kUoKufMrSQnL
	 2zUP7SKI5byGPsWG+fJ850yDgmoLKXNBAirYxcH4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CC13F80507;
	Tue,  2 Mar 2021 22:26:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D661AF804F1; Tue,  2 Mar 2021 22:26:23 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91F75F8032B
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 22:26:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91F75F8032B
IronPort-SDR: rwzVeQ1k/ZyB1t7YJLMVGWk8GOORbNyC5s7pVgOMwZCnTVpYmsCsB2PFAlfxV9v9bCau2nc+5a
 Iuex9dZOIAUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="183603752"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="183603752"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:26:03 -0800
IronPort-SDR: r18VhWi9xGUBE6gwJTll9wKNx9Vnz17U8q05BuT50ce00wMDQKGKa/itdMLk3lyt2YooHXtito
 4O+Nmgua+VRw==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="399223377"
Received: from btucker-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.60.230])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:25:52 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/24] ASoC: rt1016: clarify expression
Date: Tue,  2 Mar 2021 15:25:08 -0600
Message-Id: <20210302212527.55158-6-pierre-louis.bossart@linux.intel.com>
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

sound/soc/codecs/rt1016.c:503:61: style: Boolean result is used in
bitwise operation. Clarify expression with
parentheses. [clarifyCondition]
  (pll_code.m_bp ? 0 : pll_code.m_code) << RT1016_PLL_M_SFT |
                                                            ^
sound/soc/codecs/rt1016.c:506:40: style: Boolean result is used in
bitwise operation. Clarify expression with
parentheses. [clarifyCondition]
  pll_code.k_bp << RT1016_PLL_K_BP_SFT |
                                       ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt1016.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt1016.c b/sound/soc/codecs/rt1016.c
index c14a809da52b..7561d202274c 100644
--- a/sound/soc/codecs/rt1016.c
+++ b/sound/soc/codecs/rt1016.c
@@ -500,10 +500,11 @@ static int rt1016_set_component_pll(struct snd_soc_component *component,
 		(pll_code.k_bp ? 0 : pll_code.k_code));
 
 	snd_soc_component_write(component, RT1016_PLL1,
-		(pll_code.m_bp ? 0 : pll_code.m_code) << RT1016_PLL_M_SFT |
-		pll_code.m_bp << RT1016_PLL_M_BP_SFT | pll_code.n_code);
+		((pll_code.m_bp ? 0 : pll_code.m_code) << RT1016_PLL_M_SFT) |
+		(pll_code.m_bp << RT1016_PLL_M_BP_SFT) |
+		pll_code.n_code);
 	snd_soc_component_write(component, RT1016_PLL2,
-		pll_code.k_bp << RT1016_PLL_K_BP_SFT |
+		(pll_code.k_bp << RT1016_PLL_K_BP_SFT) |
 		(pll_code.k_bp ? 0 : pll_code.k_code));
 
 	rt1016->pll_in = freq_in;
-- 
2.25.1

