Return-Path: <SRS0=3Kie=HU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F762C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 22:34:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE4B64EB9
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 22:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE4B64EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FF509F6;
	Thu, 18 Feb 2021 23:33:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FF509F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613687682;
	bh=A2uGarlMSyDQ6ZoGrxQiT5WyjcTX5kCsdoAt8N/v5v8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H1YR32kUV+QSWugcQxJmVrHZam/qDIY0vD8M4sLsm2+oGP1UnPBF9vpxzeZlBPokg
	 CSYkLd0P0/aFsCRqbikRfxe0Y1y7sLAzGZTL2VrKnmoybpzg2oOZUQyh9o79miI23Y
	 ZuMxaE9oaFTsd+/TR1Ms2MI5JuA3LFOjhdKFofSc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65D00F804AD;
	Thu, 18 Feb 2021 23:30:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF7C6F8015A; Thu, 18 Feb 2021 23:30:00 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2159AF80275
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2021 23:29:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2159AF80275
IronPort-SDR: ibcccN5dgsa6sePZh2yCApyi1qMM7aqVA+JdujC8tMz5otd2bbCpHmoJq02u53LqK7zfU2rPC+
 KDdvi84Chu8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="182875670"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="182875670"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 14:29:45 -0800
IronPort-SDR: hBsyFSNwA20LgdDw3zo99OyynS1XAo3wFx5yfeRKToVAqTQ4qGIdg6vwRoWmXhrUt5067F+e7F
 FYmKdQsJwQJg==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="364990853"
Received: from tphilli1-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.64.38])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 14:29:42 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 09/10] ASoC: wcd934x: remove useless return
Date: Thu, 18 Feb 2021 16:29:15 -0600
Message-Id: <20210218222916.89809-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218222916.89809-1-pierre-louis.bossart@linux.intel.com>
References: <20210218222916.89809-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org,
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

sound/soc/codecs/wcd934x.c:1571:9: warning: Identical condition and
return expression 'ret', return value is always 0
[identicalConditionAfterEarlyExit]
 return ret;
        ^
sound/soc/codecs/wcd934x.c:1568:6: note: If condition 'ret' is true,
the function will return/exit
 if (ret)
     ^
sound/soc/codecs/wcd934x.c:1571:9: note: Returning identical
expression 'ret'
 return ret;
        ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/wcd934x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 40f682f5dab8..d461a3747b4d 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -1565,8 +1565,6 @@ static int wcd934x_set_interpolator_rate(struct snd_soc_dai *dai,
 		return ret;
 	ret = wcd934x_set_mix_interpolator_rate(dai, (u8)rate_val,
 						sample_rate);
-	if (ret)
-		return ret;
 
 	return ret;
 }
-- 
2.25.1

