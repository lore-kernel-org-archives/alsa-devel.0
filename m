Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16637C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:31:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D489207F5
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FItD30OK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D489207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3184C1681;
	Wed,  1 Jul 2020 20:30:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3184C1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593628289;
	bh=4lR34V7XFFxPWCI0Vp5oa47KFDsdYQigst13E0ihHYQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FItD30OKea3INjgMUH30kEcyydqWd888iZD+oote8zKrwvNT8koUYS/t3Nl4ojxrJ
	 qUZbJsJXJvT9TFD4/q6ZEibEZDTIc7v+6gg0TFC/Vcss4+Cot65+V5JqZp/Tw33IsU
	 tMV3cqI8AWRbq9aeUe7C8140fSRCn+y16BDGOHgM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9892F8031A;
	Wed,  1 Jul 2020 20:25:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B76FCF802F7; Wed,  1 Jul 2020 20:25:00 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5AFFF802E3
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 20:24:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5AFFF802E3
IronPort-SDR: cxg79ZFAoTLT30vw06xWa2FDj9uc3S7hfiBoCDTnxR4gTvpEJyowiFyFZhe9O5GwwdlfahajUK
 TNcPAknLJ2pQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144841764"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="144841764"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:24:48 -0700
IronPort-SDR: w93MlZB3WzzjwSR0zJWhH0yf1a5S5FeqlaJI0DXEyVXkJ44VHug9r+lQTIURX1uVtCDObXKSzd
 yLD54xgtnAJg==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="425679614"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:24:48 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/11] ASoC: codecs: rt5659: add _maybe_unused as needed
Date: Wed,  1 Jul 2020 13:24:19 -0500
Message-Id: <20200701182422.81496-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 tiwai@suse.de, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
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

Fix W=1 warning by adding __maybe_unused. Maintainers for this file
may want to double-check if those definitions are necessary.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5659.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 541fc6f1089b..40a954e480a5 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -1204,31 +1204,31 @@ static unsigned int rt5659_asrc_clk_map_values[] = {
 	0, 1, 2, 3, 5, 6,
 };
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_da_sto_asrc_enum, RT5659_ASRC_2, RT5659_DA_STO_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_da_monol_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_L_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_da_monor_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_R_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_sto1_asrc_enum, RT5659_ASRC_2, RT5659_AD_STO1_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_sto2_asrc_enum, RT5659_ASRC_3, RT5659_AD_STO2_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_monol_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_L_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_monor_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_R_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-- 
2.25.1

