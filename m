Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9CEC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:27:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A14764F2E
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A14764F2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1620B1933;
	Tue,  2 Mar 2021 22:26:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1620B1933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614720448;
	bh=zJSNBOvPxaH+E7XZpPM5QUID9YrJxwHYHC1En1S7WTs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VvcqWz6eu8VdvT3b6XGt9AOVdUN2SeJTzp9NSZEciestRFOMgwCLdiDWNlQvU2uDw
	 zmWR/HuL/CILALPMvy0JszUJ/bRVToNfNy9nSeE0pqkjtPg83MV+jvj8jRTT2emNcb
	 vQaom5RSiKtBn64phV/7jiA4vQ5qmUyWAqH1sAsQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87C84F80431;
	Tue,  2 Mar 2021 22:26:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 879DCF80227; Tue,  2 Mar 2021 22:26:12 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A170F80227
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 22:26:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A170F80227
IronPort-SDR: CMVRvOYCkpahg+BDBOR/A2Nqm5eb3c0bSCr54oepnAUA1AKo6jg081bU+FkV9LzWMbXOAeHVpp
 U8/JX/6sBUhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="183603747"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="183603747"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:26:03 -0800
IronPort-SDR: FAfiMJfWPeSetIMkqIkRenYMJHhQ1fuu+a4ONvfUl3Ck/M+4yEyuMAwO3VU1Jx9f1Yj+PMJPaT
 xtUGvz1oGCbQ==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="399223343"
Received: from btucker-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.60.230])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:25:39 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 01/24] ASoC: rt1011: use logical OR
Date: Tue,  2 Mar 2021 15:25:04 -0600
Message-Id: <20210302212527.55158-2-pierre-louis.bossart@linux.intel.com>
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

cppcheck complains a lot about mixing booleans and bitwise operations.

There is no good reason to use && and |, fix with ||

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt1011.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 6877be5f36b9..b9dadc8243b3 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1089,25 +1089,21 @@ static int rt1011_recv_spk_mode_put(struct snd_kcontrol *kcontrol,
 
 static bool rt1011_validate_bq_drc_coeff(unsigned short reg)
 {
-	if ((reg == RT1011_DAC_SET_1) |
-		(reg >= RT1011_ADC_SET && reg <= RT1011_ADC_SET_1) |
-		(reg == RT1011_ADC_SET_4) | (reg == RT1011_ADC_SET_5) |
-		(reg == RT1011_MIXER_1) |
-		(reg == RT1011_A_TIMING_1) | (reg >= RT1011_POWER_7 &&
-		reg <= RT1011_POWER_8) |
-		(reg == RT1011_CLASS_D_POS) | (reg == RT1011_ANALOG_CTRL) |
-		(reg >= RT1011_SPK_TEMP_PROTECT_0 &&
-		reg <= RT1011_SPK_TEMP_PROTECT_6) |
-		(reg >= RT1011_SPK_PRO_DC_DET_5 && reg <= RT1011_BAT_GAIN_1) |
-		(reg >= RT1011_RT_DRC_CROSS && reg <= RT1011_RT_DRC_POS_8) |
-		(reg >= RT1011_CROSS_BQ_SET_1 && reg <= RT1011_BQ_10_A2_15_0) |
-		(reg >= RT1011_SMART_BOOST_TIMING_1 &&
-		reg <= RT1011_SMART_BOOST_TIMING_36) |
-		(reg == RT1011_SINE_GEN_REG_1) |
-		(reg >= RT1011_STP_ALPHA_RECIPROCAL_MSB &&
-		reg <= RT1011_BQ_6_PARAMS_CHECK_5) |
-		(reg >= RT1011_BQ_7_PARAMS_CHECK_1 &&
-		reg <= RT1011_BQ_10_PARAMS_CHECK_5))
+	if ((reg == RT1011_DAC_SET_1) ||
+		(reg >= RT1011_ADC_SET && reg <= RT1011_ADC_SET_1) ||
+		(reg == RT1011_ADC_SET_4) || (reg == RT1011_ADC_SET_5) ||
+		(reg == RT1011_MIXER_1) ||
+		(reg == RT1011_A_TIMING_1) ||
+		(reg >= RT1011_POWER_7 && reg <= RT1011_POWER_8) ||
+		(reg == RT1011_CLASS_D_POS) || (reg == RT1011_ANALOG_CTRL) ||
+		(reg >= RT1011_SPK_TEMP_PROTECT_0 && reg <= RT1011_SPK_TEMP_PROTECT_6) ||
+		(reg >= RT1011_SPK_PRO_DC_DET_5 && reg <= RT1011_BAT_GAIN_1) ||
+		(reg >= RT1011_RT_DRC_CROSS && reg <= RT1011_RT_DRC_POS_8) ||
+		(reg >= RT1011_CROSS_BQ_SET_1 && reg <= RT1011_BQ_10_A2_15_0) ||
+		(reg >= RT1011_SMART_BOOST_TIMING_1 && reg <= RT1011_SMART_BOOST_TIMING_36) ||
+		(reg == RT1011_SINE_GEN_REG_1) ||
+		(reg >= RT1011_STP_ALPHA_RECIPROCAL_MSB && reg <= RT1011_BQ_6_PARAMS_CHECK_5) ||
+		(reg >= RT1011_BQ_7_PARAMS_CHECK_1 && reg <= RT1011_BQ_10_PARAMS_CHECK_5))
 		return true;
 
 	return false;
-- 
2.25.1

