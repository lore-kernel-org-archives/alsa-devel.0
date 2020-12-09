Return-Path: <SRS0=RrJr=FN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F95C4167B
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 05:39:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0801923B6C
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 05:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0801923B6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7900216F4;
	Wed,  9 Dec 2020 06:38:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7900216F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607492368;
	bh=dNRywSzfXvnb4tZ52bJvLf9G15SwFvB7hoRQU6gCxTk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ek/H6CH1acLtn67V2AcsEhSL0dJWYJvIW9kuNIenaW3fKbIrkM7Cyy4T0hD2U8S3U
	 3eFkWttswO21oUNEESOh5VoQF98dWiZ+nA1KgfZBWZd5XtUUGa39KT7jhuW4TylaFf
	 1C+2tLzDZmPAMKl19ydnVvjFHx5S7BLJJkyxpt8s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D91CF804FA;
	Wed,  9 Dec 2020 06:35:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17723F804FB; Wed,  9 Dec 2020 06:35:39 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 572DDF804F1
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 06:35:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 572DDF804F1
IronPort-SDR: fOHm0HtMPy2rrS0tylyAo/9l1gH4zV2AUwGGpWoC5Jp1y8GZUBVn1IuyiZrWD5zWwqcnPYmVAj
 pqC7YoGqJ3Ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="153259035"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; d="scan'208";a="153259035"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2020 21:35:35 -0800
IronPort-SDR: ukk4+RtIpceF0Ger3Jk/VJjHVGsWTPNjV/JqJwWdeoidKHl64irqi5WO3shIUWKJY53x2tJ4K5
 XOEMtzWAxIuA==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; d="scan'208";a="363989576"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2020 21:35:32 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 7/9] regmap: sdw-mbq: use MODULE_LICENSE("GPL")
Date: Wed,  9 Dec 2020 13:34:57 +0800
Message-Id: <20201209053459.5515-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209053459.5515-1-yung-chuan.liao@linux.intel.com>
References: <20201209053459.5515-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

"GPL v2" is the same as "GPL". It exists for historic reasons.
See Documentation/process/license-rules.rst

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/base/regmap/regmap-sdw-mbq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
index 6675c3a4b829..fe3ac26b66ad 100644
--- a/drivers/base/regmap/regmap-sdw-mbq.c
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -98,4 +98,4 @@ struct regmap *__devm_regmap_init_sdw_mbq(struct sdw_slave *sdw,
 EXPORT_SYMBOL_GPL(__devm_regmap_init_sdw_mbq);
 
 MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
2.17.1

