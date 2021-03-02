Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3D4C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:30:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5776F64F32
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5776F64F32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3E011A95;
	Tue,  2 Mar 2021 22:29:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3E011A95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614720645;
	bh=Q065eO8MejPruu882TJVdLj59j5lXFpi+/XuT/44aeU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fYZSLtJ7F8UqJCXBIWidzOnJEgNS0NcGXTbTg+ezBR2GE0t2+QRUG1DilmxjQpgQJ
	 Hv6pdJDtAh5ESjn1Ae/8dP/e7cErU+3f9lmKR143FZ31OJwCj15U20T6N1H1pPl60A
	 9783n9FEHRJNhp8p8laoizaAGEZUcoejchGfeEHY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C204F804FA;
	Tue,  2 Mar 2021 22:26:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75986F8032D; Tue,  2 Mar 2021 22:26:23 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D270EF80423
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 22:26:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D270EF80423
IronPort-SDR: sjq619QcZt5ytA6CHQJj8IFMq7PM6aDY1wSXv92YB0n58XmlmbDxPpFP4BDY+4qlEsCSrKR60z
 +PcRRlvKvbuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174631400"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="174631400"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:26:08 -0800
IronPort-SDR: 8kCVpxLF5xNGOjvSgtOMdyH4PHmNsboeXcWPD1VC+7Ew769hH21NFvUiYgfzKz69kuqJaGjBMx
 8Wn8nVVC8zEw==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="399223468"
Received: from btucker-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.60.230])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:26:07 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 17/24] ASoC: rt5668: clarify expression
Date: Tue,  2 Mar 2021 15:25:20 -0600
Message-Id: <20210302212527.55158-18-pierre-louis.bossart@linux.intel.com>
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

sound/soc/codecs/rt5668.c:2185:61: style: Boolean result is used in
bitwise operation. Clarify expression with
parentheses. [clarifyCondition]
  (pll_code.m_bp ? 0 : pll_code.m_code) << RT5668_PLL_M_SFT |
                                                            ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5668.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index bc69adc9c8b7..d966d6d1bf64 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -2182,8 +2182,8 @@ static int rt5668_set_component_pll(struct snd_soc_component *component,
 	snd_soc_component_write(component, RT5668_PLL_CTRL_1,
 		pll_code.n_code << RT5668_PLL_N_SFT | pll_code.k_code);
 	snd_soc_component_write(component, RT5668_PLL_CTRL_2,
-		(pll_code.m_bp ? 0 : pll_code.m_code) << RT5668_PLL_M_SFT |
-		pll_code.m_bp << RT5668_PLL_M_BP_SFT);
+		((pll_code.m_bp ? 0 : pll_code.m_code) << RT5668_PLL_M_SFT) |
+		(pll_code.m_bp << RT5668_PLL_M_BP_SFT));
 
 	rt5668->pll_in = freq_in;
 	rt5668->pll_out = freq_out;
-- 
2.25.1

