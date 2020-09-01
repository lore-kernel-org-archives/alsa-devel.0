Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F72C433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 03:06:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82B32068F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 03:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZZqipZLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82B32068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D24B180C;
	Wed,  2 Sep 2020 05:05:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D24B180C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599016001;
	bh=6IQxaTOYQmUWhjtOST6Y4Ze9yweDWEszkCarYuP4264=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZZqipZLeF0XGS0Auqh2JGh0lbVWDw/YxdE98kfmaxRseWX3PsB5wNFjls1ywhN+aR
	 uoPfWxwoZ68EmsYQpZhlsJmbSdJSIvQSRUJZ/v13bSRx5xiQfYz6ZYvzA5J7TAIdIY
	 IkFuu5p+4YneRdRxc0o48JRqpeh/364uJlYKitHo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 054A1F80333;
	Wed,  2 Sep 2020 05:00:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02A12F802A1; Wed,  2 Sep 2020 05:00:14 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 903D0F80212
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 05:00:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 903D0F80212
IronPort-SDR: Q3hzrqbNdlh8xKp0UkTUqDAIEGLzCtYUp6yi4lVKGo26Q2jfkpFMokqV1pjedWgVKeKttz65dR
 JzxTGPXRBsdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="156570788"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; d="scan'208";a="156570788"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 20:00:11 -0700
IronPort-SDR: mTk9y5kQaV0jCQIOaOAx1/+oRola6e0yPJG1/wFHORiIVZuR5TQk+Jh9eRfu6XTrcYz4C+soUO
 ZZTiVUsmgJwA==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; d="scan'208";a="283588208"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 20:00:07 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 08/10] soundwire: intel: add error log for clock-stop
 invalid configs
Date: Tue,  1 Sep 2020 23:05:54 +0800
Message-Id: <20200901150556.19432-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
References: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
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

Detect cases where the clock is assumed to be stopped but the IP is
not in the relevant state. There is no real way to recover here, but
adding an error log can help detect bad programming sequences or race
conditions.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 272826973426..97c8cfc54ddd 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1931,6 +1931,11 @@ static int intel_resume_runtime(struct device *dev)
 			}
 		}
 	} else if (!clock_stop_quirks) {
+
+		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
+		if (!clock_stop0)
+			dev_err(dev, "%s invalid configuration, clock was not stopped", __func__);
+
 		ret = intel_init(sdw);
 		if (ret) {
 			dev_err(dev, "%s failed: %d", __func__, ret);
-- 
2.17.1

