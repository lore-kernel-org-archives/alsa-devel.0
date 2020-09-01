Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA18C433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 02:59:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FA8206CD
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 02:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xl0A0qkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FA8206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 592AF17B9;
	Wed,  2 Sep 2020 04:58:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 592AF17B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599015562;
	bh=ww0Od+WFYyJt9RD1/C+R7ISw0prZYH+bxFXYRL7fBSo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xl0A0qklJAWC9sFPblW71w7uUI0Cc6PwpeNNvqaav5FiZ10ikFRR4h5eww4UK9aYN
	 fWV8AWOW6Qz/8xQbS16WcDMCjQzQKDTrdcpmpOeMJvKRmK8WsTE+mbQyBwQez8g51t
	 xkOANcETDt428CHG3Aa2ENvXhd8GRQdYssfJoheg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 759E2F802E3;
	Wed,  2 Sep 2020 04:56:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3171F802E0; Wed,  2 Sep 2020 04:56:42 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09723F8024A
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 04:56:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09723F8024A
IronPort-SDR: IbuYe5MiJmxSd1cdg92vR9IMbQKVin5HIi3YZ1ct2haWje+UTkNL6qAYX7IDGgGPWzAguPALqv
 OpYrTiwvQYww==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="158305763"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; d="scan'208";a="158305763"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 19:56:35 -0700
IronPort-SDR: CHgh3Ia8+8KlG5hhGZ2zo+ve5b+pEwoy+5UJh1ZMl6iL+pcW11BqAWMmqLlXe+ArA8gc2GITAa
 gZfFRplep06w==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; d="scan'208";a="477457273"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 19:56:31 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 3/7] soundwire: intel: fix NULL/ERR_PTR confusion
Date: Tue,  1 Sep 2020 23:02:36 +0800
Message-Id: <20200901150240.19288-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
References: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
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

snd_soc_dai_get_sdw_stream() can only return the pointer to stream or
an ERR_PTR value, NULL is not a possible value.

Fixes: 09553140c8d7b ('soundwire: intel: implement get_sdw_stream() operations')
Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index ebca8ced59ec..bbfb86ffa653 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1106,7 +1106,7 @@ static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
 		dma = dai->capture_dma_data;
 
 	if (!dma)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	return dma->stream;
 }
-- 
2.17.1

