Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F233C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:30:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D7B64F2E
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D7B64F2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A9C4191C;
	Tue,  2 Mar 2021 22:29:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A9C4191C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614720632;
	bh=p2kpx4k7s5EVJpgHKK0cO7GqAcT3zmZlaTWVaf++bqo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qwWZG1GsTtrESl95UWVRMWKoQsYnPWbnU5KUApoFZXk5RmUMfm5/rgPkuRnntB/Cy
	 7ZD/HqZRGLkU68pUCBlxuI4DHZcPn67AScnl9Dhio87hKuuDarIJFyX9fVFpdrlJJs
	 2U+Ok4iPPAgZ7K2RYejWTd4KHfCh5oW7E0GbyUz4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EF5EF804F3;
	Tue,  2 Mar 2021 22:26:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07B2DF804F3; Tue,  2 Mar 2021 22:26:23 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDC87F8032D
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 22:26:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDC87F8032D
IronPort-SDR: HLd53W7CuDUTEkqxLOFyJzLcGf6PJCXqzDmUcXvBnspgeOK6DQy3HgS1dJodUjuVFxpcLDriQ9
 4kgnAFvZ6adg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="183603753"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="183603753"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:26:03 -0800
IronPort-SDR: VcNRi+L8b6KaWWwRn6I5hXMlecsQdOZTb6mWldTeeXQ9mJJ87HXajgq88YWKVbz2oIxDzvk6QT
 1XjCDNaRRYUw==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="399223369"
Received: from btucker-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.60.230])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:25:51 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/24] ASoC: rt1015: clarify expression
Date: Tue,  2 Mar 2021 15:25:07 -0600
Message-Id: <20210302212527.55158-5-pierre-louis.bossart@linux.intel.com>
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

sound/soc/codecs/rt1015.c:894:61: style: Boolean result is used in
bitwise operation. Clarify expression with
parentheses. [clarifyCondition]
  (pll_code.m_bp ? 0 : pll_code.m_code) << RT1015_PLL_M_SFT |
                                                            ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt1015.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 3cd967ae999d..10a7b7745f4b 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -893,8 +893,9 @@ static int rt1015_set_component_pll(struct snd_soc_component *component,
 		pll_code.n_code, pll_code.k_code);
 
 	snd_soc_component_write(component, RT1015_PLL1,
-		(pll_code.m_bp ? 0 : pll_code.m_code) << RT1015_PLL_M_SFT |
-		pll_code.m_bp << RT1015_PLL_M_BP_SFT | pll_code.n_code);
+		((pll_code.m_bp ? 0 : pll_code.m_code) << RT1015_PLL_M_SFT) |
+		(pll_code.m_bp << RT1015_PLL_M_BP_SFT) |
+		pll_code.n_code);
 	snd_soc_component_write(component, RT1015_PLL2,
 		pll_code.k_code);
 
-- 
2.25.1

