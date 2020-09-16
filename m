Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A13C2BB84
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:50:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D7B21D7D
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uNdv/ew4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D7B21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E85D844;
	Wed, 16 Sep 2020 22:49:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E85D844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600289412;
	bh=UnGvRXeTpKQaIkKfD5YoulLcB+gTJt7QxQqVdyU5VpU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uNdv/ew47rLFDnU73YtKJWHE16JeMjtRTUW23xILM3blDdLWFOvOMIukEkjRQ8d7N
	 FYstO908a0r82nh8sl09LI0UXxThDNTR2EhOvs5hy8p/cMs8aCSjQnyLn6pYZaif3Y
	 rrd5JSZVBe5qsXjY8BjB1BLruPAczjvRQ+eCBoV4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1D6DF800E8;
	Wed, 16 Sep 2020 22:49:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E1B0F8015A; Wed, 16 Sep 2020 22:49:20 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 727F0F800E8
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 22:49:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 727F0F800E8
IronPort-SDR: 5+mMrS4wR0q3sesHpyVZJjpLwZF+pitcpTum8EOHZ0tOfFHPDQyLdla/twXzRTMg7gzytK+6Ad
 g4FN5nZTkudQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="139072459"
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; d="scan'208";a="139072459"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 13:49:04 -0700
IronPort-SDR: rMECnu3uG881Z7QgfzH3NkQF9EvYftQUtIoVH6EgA2TYqksgvg8Ef3BlGFnANm4bdYZMCL+aX4
 x1C/wiKLlijg==
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; d="scan'208";a="287321972"
Received: from yipengwa-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.60.40])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 13:49:03 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: rt715: Add module parameter to fix dmic pop sound issue.
Date: Wed, 16 Sep 2020 15:47:58 -0500
Message-Id: <20200916204758.53651-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jack Yu <jack.yu@realtek.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>,
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

From: Jack Yu <jack.yu@realtek.com>

Add module parameter "power_up_delay" to fix pop noise on capture. The
power_up_delay value is set with a default value of 400ms, smaller
values are not recommended.

BugLink: https://github.com/thesofproject/linux/issues/1969
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Jack Yu <jack.yu@realtek.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt715.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index 099c8bd20006..0cf10dec1e3b 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -37,6 +37,10 @@
 
 #include "rt715.h"
 
+static int power_up_delay = 400;
+module_param(power_up_delay, int, 0444);
+MODULE_PARM_DESC(power_up_delay, "RT715 power up delay time in ms");
+
 static int rt715_index_write(struct regmap *regmap, unsigned int reg,
 		unsigned int value)
 {
@@ -498,6 +502,7 @@ static int rt715_set_bias_level(struct snd_soc_component *component,
 			regmap_write(rt715->regmap,
 						RT715_SET_AUDIO_POWER_STATE,
 						AC_PWRST_D0);
+			msleep(power_up_delay);
 		}
 		break;
 
-- 
2.25.1

