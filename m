Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56368C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:33:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A090E64F2C
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A090E64F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F34201AD0;
	Tue,  2 Mar 2021 22:32:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F34201AD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614720808;
	bh=4opAOFTpPjiKbJlwKlrKg/lGIu8gVdteQNL1Kx3jQNw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kVMIIj3SOkeps2v1GSxJPmvem8Qi1nK5IJ4mzQKMKz5P91kAiIp937dJrYE3hdRGA
	 N3BuTrkN9innSCNZNe08HeJWOG5o1jPzZ+2XDBfboL+ujU9Hc9Azb6/JMVrw5vZqqL
	 b5bL0ltJu3eQv+jKXfShNoUEIfapTtEZrVkSbdHk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1461F80430;
	Tue,  2 Mar 2021 22:26:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5B2BF80511; Tue,  2 Mar 2021 22:26:29 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 656F3F80425
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 22:26:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 656F3F80425
IronPort-SDR: Sghn54Ujl68GRySm8yw/bTsGQyL2KFzpy0GbtDtL9tXWftpJIWxP13TtP4lpmVVZpYoBV4jnRn
 yz76oEZJV+KA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174631411"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="174631411"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:26:09 -0800
IronPort-SDR: QEbQagLSPPDlWkM7QiE0c1N//bFmR3FjYGJCZs2CvWBanhPTf/+ZieXOEuD5FCW1EeBWna+d08
 dzPwID67mbQg==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="399223470"
Received: from btucker-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.60.230])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:26:08 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 18/24] ASoC: rt5668: remove useless assignments
Date: Tue,  2 Mar 2021 15:25:21 -0600
Message-Id: <20210302212527.55158-19-pierre-louis.bossart@linux.intel.com>
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

cppcheck warnings:

sound/soc/codecs/rt5668.c:1177:6: style: Redundant initialization for
'idx'. The initialized value is overwritten before it is
read. [redundantInitialization]
 idx = rt5668_div_sel(rt5668, 1500000, div, ARRAY_SIZE(div));
     ^
sound/soc/codecs/rt5668.c:1174:10: note: idx is initialized
 int idx = -EINVAL;
         ^
sound/soc/codecs/rt5668.c:1177:6: note: idx is overwritten
 idx = rt5668_div_sel(rt5668, 1500000, div, ARRAY_SIZE(div));
     ^

sound/soc/codecs/rt5668.c:1202:6: style: Redundant initialization for
'idx'. The initialized value is overwritten before it is
read. [redundantInitialization]
 idx = rt5668_div_sel(rt5668, ref, div, ARRAY_SIZE(div));
     ^
sound/soc/codecs/rt5668.c:1191:25: note: idx is initialized
 int ref, val, reg, idx = -EINVAL;
                        ^
sound/soc/codecs/rt5668.c:1202:6: note: idx is overwritten
 idx = rt5668_div_sel(rt5668, ref, div, ARRAY_SIZE(div));
     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5668.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index d966d6d1bf64..6ab1a8bc3735 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -1171,7 +1171,7 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component =
 		snd_soc_dapm_to_component(w->dapm);
 	struct rt5668_priv *rt5668 = snd_soc_component_get_drvdata(component);
-	int idx = -EINVAL;
+	int idx;
 	static const int div[] = {2, 4, 6, 8, 12, 16, 24, 32, 48, 64, 96, 128};
 
 	idx = rt5668_div_sel(rt5668, 1500000, div, ARRAY_SIZE(div));
@@ -1188,7 +1188,7 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component =
 		snd_soc_dapm_to_component(w->dapm);
 	struct rt5668_priv *rt5668 = snd_soc_component_get_drvdata(component);
-	int ref, val, reg, idx = -EINVAL;
+	int ref, val, reg, idx;
 	static const int div[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48};
 
 	val = snd_soc_component_read(component, RT5668_GPIO_CTRL_1) &
-- 
2.25.1

