Return-Path: <SRS0=6+tk=JN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62C5C433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 19:15:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0565C613BB
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 19:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0565C613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2239516F8;
	Fri, 16 Apr 2021 21:14:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2239516F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618600518;
	bh=9HWTJYgQ0zZxrKQklwvKwYEHylPAQrFQncOTHIUkhwg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=goMZ7iM53Y0UKa3pH29bBF8OC/mb4XLKVkNDND16B+lqjWEsvS0WT+zp//kb5TYlm
	 3kSm/r3PRDe2MxFz7YaSsvQwzJRoQHBxqKeTNuiipt04Fhb97U47MhrVxjpY9owVOy
	 pqxiOPemxsIK0jzY5DhAqWvW/zsjpPMnS7+QdPMQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20C4EF8042F;
	Fri, 16 Apr 2021 21:13:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0637F8025B; Fri, 16 Apr 2021 21:13:15 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AC7FF8025B
 for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2021 21:12:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AC7FF8025B
IronPort-SDR: 3TXaR/ureSViL/yYLz42XdXfihuf8fRz3NbkRVsW9ftV3SnMlKiKL351m2fszVQQv3lKclGDFd
 KZJH20buAAfw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256407102"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; d="scan'208";a="256407102"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 12:11:59 -0700
IronPort-SDR: x+WCM+OG11nFALj1ANcaCehUs4OikLkzTGBvvWYhL34zyabeCKVdzpqZNt2bhuAZUhDedJS68S
 sED/GWl5LUhQ==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; d="scan'208";a="612838749"
Received: from paulsoum-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.66.118])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 12:11:58 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/5] ASoC: codecs: lpass-rx-macro: remove useless return
Date: Fri, 16 Apr 2021 14:11:43 -0500
Message-Id: <20210416191144.27006-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416191144.27006-1-pierre-louis.bossart@linux.intel.com>
References: <20210416191144.27006-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>, broonie@kernel.org,
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

cppcheck warning:

sound/soc/codecs/lpass-rx-macro.c:1626:9: warning: Identical condition
and return expression 'ret', return value is always 0
[identicalConditionAfterEarlyExit]
 return ret;
        ^
sound/soc/codecs/lpass-rx-macro.c:1623:6: note: If condition 'ret' is
true, the function will return/exit
 if (ret)
     ^
sound/soc/codecs/lpass-rx-macro.c:1626:9: note: Returning identical
expression 'ret'
 return ret;
        ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/codecs/lpass-rx-macro.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 8e6a47f152ad..b0ebfc8d180c 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -1620,8 +1620,6 @@ static int rx_macro_set_interpolator_rate(struct snd_soc_dai *dai,
 		return ret;
 
 	ret = rx_macro_set_mix_interpolator_rate(dai, rate_val, sample_rate);
-	if (ret)
-		return ret;
 
 	return ret;
 }
-- 
2.25.1

