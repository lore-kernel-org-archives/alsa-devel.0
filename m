Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A58EC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 23:58:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 654C417DB;
	Wed, 27 Apr 2022 01:58:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 654C417DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651017530;
	bh=V6orb7xMJrGLhUt7lGhLbHJI6NNpt/GIKG7ukF/7V64=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRmRVtt0COOJxcYf+ZWsgn+DJ8EyGrpgal5JJ9c3EHU01B0bP2EERDOG/n7HfB4xC
	 81aDHlIIh9EAUKpMelvjmbElhODpXUGwKwRfA7WA8FJ9kUr7f6FF1bY4LKGfr4dq9V
	 eNNx/sqo+Scm9Q00uIBp4ypaW4IYQQEkczq5mgc4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42775F80510;
	Wed, 27 Apr 2022 01:56:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 665DFF8014B; Wed, 27 Apr 2022 01:56:49 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B79B0F80171
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2022 01:56:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B79B0F80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="L9q1BQ/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651017402; x=1682553402;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V6orb7xMJrGLhUt7lGhLbHJI6NNpt/GIKG7ukF/7V64=;
 b=L9q1BQ/2RRWF+6UIN4H8coiD4bRYNJ3w34NGMuyhaGZWH7wiCydEbnCQ
 uKJZGSIdSBr1wi+AMxpIWYTLtHMN4hiQigj0iCF96ze/h/PZBt2HCBfUT
 5iaTZ6kxtxw+JINugwi4lFmMnthx9sV93S8qfdIc9Zz/COP7nqKfCyzOA
 ZUzq5bmFiGVRCh8EEQaC06MEyrdGnUW3BEJ7SU8TVhI+0CE8jjbr14hgg
 ifeqy3rb7DRclEhce2VIvYKIDGZRzagTvUquD/WEUuYRva36EiJs8x5EU
 cM9RDPWNGal8JFIyC2HBSxi7K1rEQ7ghlVBPPO4GIYGj3yj0c71T6DWEQ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="290908853"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="290908853"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 16:56:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="730515044"
Received: from htamura-mobl2.gar.corp.intel.com (HELO bard-pc.domain.name)
 ([10.252.185.30])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 16:56:38 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 4/5] soundwire: intel: use pm_runtime_resume_and_get()
Date: Wed, 27 Apr 2022 07:56:22 +0800
Message-Id: <20220426235623.4253-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
References: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com, bard.liao@intel.com
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

Use pm_runtime_resume_and_get() to replace the pm_runtime_get_sync() and
pm_runtime_put_noidle() pattern.

No functional changes.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 63101f1ba271..ad41b50f2ef1 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -799,12 +799,11 @@ static int intel_startup(struct snd_pcm_substream *substream,
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	ret = pm_runtime_get_sync(cdns->dev);
+	ret = pm_runtime_resume_and_get(cdns->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(cdns->dev,
-				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
 				    __func__, ret);
-		pm_runtime_put_noidle(cdns->dev);
 		return ret;
 	}
 	return 0;
-- 
2.25.1

