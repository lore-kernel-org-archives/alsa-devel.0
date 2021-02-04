Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492D8C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 20:20:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7198F64DDE
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 20:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7198F64DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBFF8167E;
	Thu,  4 Feb 2021 21:19:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBFF8167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612470041;
	bh=3BpM0EYwD/30Mvg/plfYXRYweXZe1Qk+gsbkuhOgoL4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kcadH683Wg3mUuh8LT0BqhrKEcsYaDOMZPwveHQIyVIF3nqLftHq434tAIYqGMxl7
	 4p9daB8qAmzaw3CdkGoSWW3B1OLO5adjhnvuq4rQ41Zoql+h5IwJHWQbyWEn6YATpo
	 WTm5oRgnyeySvq3aLb6PgHfn+pJpQEZxUvEWqsTU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50A64F8021C;
	Thu,  4 Feb 2021 21:18:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5EC3F802C8; Thu,  4 Feb 2021 21:18:12 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5996F8021C
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 21:18:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5996F8021C
IronPort-SDR: xyiqWARy3J1jYYQTnYmwVXsDeZmaIthX9QcXDFZhfunNKNskrZEJwiFwl6P+um43kSxKmSnYv9
 2eQVoUnE67yw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="177817717"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="177817717"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 12:17:59 -0800
IronPort-SDR: +/UFy7d4h8A8BowIS+SnOWjbT+HjuHaFNhvG3/800Rereqk8n9ajfvWnzvc6efvw4VWt5wHyon
 W3RuAT9xBmNw==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="373011159"
Received: from jdasilva-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.66.22])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 12:17:57 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org,
	Shuming Fan <shumingf@realtek.com>
Subject: [PATCH 4/4] ASoC: rt5682: do nothing in rt5682_suspend/resume in sdw
 mode
Date: Thu,  4 Feb 2021 14:17:39 -0600
Message-Id: <20210204201739.25206-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204201739.25206-1-pierre-louis.bossart@linux.intel.com>
References: <20210204201739.25206-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 vkoul@kernel.org, broonie@kernel.org,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

regcache sync will be done in sdw device suspend/resume functions.
And we have different jack detection mechanism for SoundWire.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5682.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 185906d6d4e0..b306ac4b9b2e 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2910,6 +2910,9 @@ static int rt5682_suspend(struct snd_soc_component *component)
 {
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
 
+	if (rt5682->is_sdw)
+		return 0;
+
 	regcache_cache_only(rt5682->regmap, true);
 	regcache_mark_dirty(rt5682->regmap);
 	return 0;
@@ -2919,6 +2922,9 @@ static int rt5682_resume(struct snd_soc_component *component)
 {
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
 
+	if (rt5682->is_sdw)
+		return 0;
+
 	regcache_cache_only(rt5682->regmap, false);
 	regcache_sync(rt5682->regmap);
 
-- 
2.25.1

