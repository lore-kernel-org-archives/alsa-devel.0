Return-Path: <SRS0=m63s=CO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B35BC433E2
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:24:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A70B20E65
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rIoUmCF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A70B20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 472DB1B04;
	Sat,  5 Sep 2020 08:23:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 472DB1B04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599287077;
	bh=/6ovzl882hppiTLycTx4/fkgDv74abJvRaN/tprMr0U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rIoUmCF17xzgoiHFQZt9XHBLjj3o1Iht6Vmeq8VA3FxYYr1gtxeu2RvYtgmhsubYM
	 qRG/LvGmCnA2oAK1D+DodW4/EkCYe++f77Z/EDieLIaQAWxog6fWD1YouPWTrBBQ5c
	 EyjKMX/IWzFSVvNokNMHeGjgSpV36xfLthdLlhRs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87A4BF800F0;
	Sat,  5 Sep 2020 08:22:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4144F8020D; Sat,  5 Sep 2020 08:22:52 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D674F8020D
 for <alsa-devel@alsa-project.org>; Sat,  5 Sep 2020 08:22:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D674F8020D
IronPort-SDR: kOdlU3nhsp0e9B8iZDgLWzN66mv63M9+l48GW17TT1Bk5xbAceNt48zx+fzd+IwK/GAqqKMNWz
 RQXmBumgr06A==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="145547453"
X-IronPort-AV: E=Sophos;i="5.76,392,1592895600"; d="scan'208";a="145547453"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 23:22:42 -0700
IronPort-SDR: ePrJxyatEex3FEpv9afxriiqBih7gHrglUBpHtZohFczib72VOgz7E5Oo1dCTZAQbBh8ZCH+JW
 Ta5022Q17Ubw==
X-IronPort-AV: E=Sophos;i="5.76,392,1592895600"; d="scan'208";a="478804264"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 23:22:38 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v3 1/3] ASoC: soc-dai: clarify return value for
 get_sdw_stream()
Date: Sat,  5 Sep 2020 02:28:52 +0800
Message-Id: <20200904182854.3944-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
References: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Previous changes move to use ERR_PTR(-ENOTSUPP), but it's not clear
what implementations can return in case of errors. Explicitly document
that NULL is not a possible return value, only ERR_PTR with a negative
error code is valid.

Fixes: 308811a327c38 ('ASoC: soc-dai: return proper error for get_sdw_stream()')
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/sound/soc-dai.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 776a60529e70..8b693dade9c6 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -471,7 +471,8 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
  * This routine only retrieves that was previously configured
  * with snd_soc_dai_get_sdw_stream()
  *
- * Returns pointer to stream or -ENOTSUPP if callback is not supported;
+ * Returns pointer to stream or an ERR_PTR value, e.g.
+ * ERR_PTR(-ENOTSUPP) if callback is not supported;
  */
 static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
 					       int direction)
-- 
2.17.1

