Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB68C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:03:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4107464F21
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4107464F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1AA0190D;
	Tue,  2 Mar 2021 22:02:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1AA0190D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614718991;
	bh=nsCbpGpszFYuoa7zwA7/2uL6nOSz2IdWI9yRHnhzLW8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YlOyIhDDWHa+krVtSSm9uozSbwTo6kMkNi3k5sJJoQbQS9CDqVZ8LHGco0b5qFuOQ
	 bd1UXWkqCWiPCR5MO4mak3m6/PDypPrnrWhPUDu+pkuL7zQwCiv4bMvS20lBhJYIMG
	 FVZkb8aWYqPrNFpbvTrJOQYe1+HLZSEy2eNI4zI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 776FEF8032B;
	Tue,  2 Mar 2021 22:00:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CC0DF80424; Tue,  2 Mar 2021 22:00:42 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02BC7F80269
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 22:00:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02BC7F80269
IronPort-SDR: 2GoBVkjSTfu/VqNsTIdP2SlOgD/jBLgKHteF6cGFHN0e2tb1gDyDC7/VBNiawcoBgGW9KPupAH
 VEIolxDeBN3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174623724"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="174623724"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:00:28 -0800
IronPort-SDR: tdYmYUIn8PXQj01K+0Bkevm9C4W1GqJKxHf36VDcnEl3mlgen7LNdQiENPhHXmkrxcXC0DmTNM
 7wvEI6vIUmFA==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="373727796"
Received: from btucker-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.60.230])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:00:27 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/9] ASoC: rt5631: fix kernel-doc warning
Date: Tue,  2 Mar 2021 14:59:20 -0600
Message-Id: <20210302205926.49063-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302205926.49063-1-pierre-louis.bossart@linux.intel.com>
References: <20210302205926.49063-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

make W=1 warning:

sound/soc/codecs/rt5631.c:446: warning: expecting prototype for
onebit_depop_power_stage(). Prototype was for depop_seq_power_stage()
instead

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5631.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index afc1305a7fa5..3000bc128b5b 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -436,7 +436,7 @@ static void onebit_depop_mute_stage(struct snd_soc_component *component, int ena
 }
 
 /**
- * onebit_depop_power_stage - step by step depop sequence in power stage.
+ * depop_seq_power_stage - step by step depop sequence in power stage.
  * @component: ASoC component
  * @enable: power on/off
  *
-- 
2.25.1

