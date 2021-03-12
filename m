Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02DFC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:29:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA1764F6A
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA1764F6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0FF217AE;
	Fri, 12 Mar 2021 19:28:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0FF217AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615573766;
	bh=nL7ghtSbh3Bx+otJ0Hsa65PXO+JETHuxipzloUOCswA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gRSk2ZKUcoimJmn1XgOy3HwG6w5o2DqYAo5ym26/IAQTQcORZ1bb92CGk66HW5koQ
	 9JvKOb+nAnbVR/1VlE5L371H97tkpT9TXTOSTpftkaqWsbr+JW/twodKCrRSdsmy9n
	 vOUGRC9wuwIZCrfmfit46Ui24XFet+vqEPMd0LoU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 626E3F80519;
	Fri, 12 Mar 2021 19:23:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77A29F80482; Fri, 12 Mar 2021 19:23:38 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B97E4F800BF
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 19:23:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B97E4F800BF
IronPort-SDR: I2AHrLjgBAxBh50YTMESNxGsf2SB2b7D00kPoDUnaWIUbisf8tsnMQWW0wsW2/wnBWVjLYCtjA
 xrPPLK4INW5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="185515202"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="185515202"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:29 -0800
IronPort-SDR: PIY0q2vSlc4LCYnkXD6p76ix5kuPwdko3K3KL5zxMrAyi0CtIAwocPC5liOp82yYpX+75AUSML
 mrNCB0Fndrsw==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="377791975"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.37.30])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:28 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 12/23] ASoC: max98090: remove useless assignment
Date: Fri, 12 Mar 2021 12:22:35 -0600
Message-Id: <20210312182246.5153-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

sound/soc/codecs/max98090.c:1835:16: style: Variable 'test_diff' is
assigned a value that is never used. [unreadVariable]
 int test_diff = INT_MAX;
               ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 06276ff5f8a3..bc30a1dc7530 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1832,7 +1832,7 @@ static const struct dmic_table dmic_table[] = { /* One for each pclk freq. */
 static int max98090_find_divisor(int target_freq, int pclk)
 {
 	int current_diff = INT_MAX;
-	int test_diff = INT_MAX;
+	int test_diff;
 	int divisor_index = 0;
 	int i;
 
-- 
2.25.1

