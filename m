Return-Path: <SRS0=6+tk=JN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F83C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 19:14:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B0B613BB
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 19:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B0B613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3904316FB;
	Fri, 16 Apr 2021 21:13:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3904316FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618600470;
	bh=YoVQhA/dRFTnvr193OUICiWFGB4FXKXgx4JVbK1S+W4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fOx8kOz6oGnOPBkswu6smdcE+RcrzPlq9F5la62T8ukOL6mRfOrTM94CQ9D19eX3l
	 aOWUfktQf+eQkkl4oc4KVeDxH1+xF/DI9rWFFGMmJfRdBJ25k5y4lXBZGeeBx4LFvt
	 ivuI14KukddG9xDocWezoz5n+hy0fWVMZS291Aa8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2354F80269;
	Fri, 16 Apr 2021 21:13:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97340F80128; Fri, 16 Apr 2021 21:13:15 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B64CF80271
 for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2021 21:12:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B64CF80271
IronPort-SDR: wcy3hnq92leXGkTdygIfpB4PeEJU2LTDDwGpluVW9hbaPXV1RZthIFY17X9GfjD9S1DCioIxJQ
 a2Pv5AgvrinA==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256407098"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; d="scan'208";a="256407098"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 12:11:58 -0700
IronPort-SDR: u9NfTdiWUnQNAIr1/a4cGBn3fSSM6jCLaoA8bCwPwx2RL1NjgwMnPcR4CCh8hrgNHF/EUtHvE/
 JZRQXDGpFaSw==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; d="scan'208";a="612838746"
Received: from paulsoum-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.66.118])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 12:11:58 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/5] ASoC: soc-core: fix always-false condition
Date: Fri, 16 Apr 2021 14:11:42 -0500
Message-Id: <20210416191144.27006-4-pierre-louis.bossart@linux.intel.com>
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

sound/soc/soc-core.c:2784:6: style: Condition '!num_routes' is always
false [knownConditionTrueFalse]
 if (!num_routes) {
     ^
sound/soc/soc-core.c:2777:17: note: Assuming that condition
'num_routes<0' is not redundant
 if (num_routes < 0 || num_routes & 1) {
                ^
sound/soc/soc-core.c:2783:2: note: Compound assignment '/=', assigned
value is 0
 num_routes /= 2;
 ^
sound/soc/soc-core.c:2784:6: note: Condition '!num_routes' is always
false
 if (!num_routes) {
     ^

The documentation for of_property_count_string reads

"
 * Returns the number of strings on
 * success, -EINVAL if the property does not exist, -ENODATA if property
 * does not have a value, and -EILSEQ if the string is not null-terminated
 * within the length of the property data.
"

Since the case for num_routes == 0 is not possible, let's remove this
test.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/soc-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aee91bde9fb8..3a4ae52e5280 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2781,11 +2781,6 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 		return -EINVAL;
 	}
 	num_routes /= 2;
-	if (!num_routes) {
-		dev_err(card->dev, "ASoC: Property '%s's length is zero\n",
-			propname);
-		return -EINVAL;
-	}
 
 	routes = devm_kcalloc(card->dev, num_routes, sizeof(*routes),
 			      GFP_KERNEL);
-- 
2.25.1

