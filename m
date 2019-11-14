Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0D5C432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:30:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F7A206F0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZdZkubrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F7A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A30131697;
	Thu, 14 Nov 2019 19:29:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A30131697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573756213;
	bh=fVY5Nm2s+7evtSEOumzL1CaDdosKWz+hRunVrhh3IaE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZdZkubrlu37rmQYVfZ5FUxprww41R3sWUjWqXw7nWHzDmD1qJ62oap3jAxESQeVBT
	 IUrVu4l8tEl3usspTmaXFEEu3nv8d+0OmmnNca5Pu0jti9MBASkn1zS4Dol+fowYur
	 hllJSQn7NapzJLl0q9N0pf1gwHa5H1v+MOTZ/hus=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78D1DF80248;
	Thu, 14 Nov 2019 19:18:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EEE2F8013C; Thu, 14 Nov 2019 19:18:09 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BE5AF8012E
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 19:18:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BE5AF8012E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2019 10:17:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; d="scan'208";a="195123556"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
 by orsmga007.jf.intel.com with ESMTP; 14 Nov 2019 10:17:58 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Thu, 14 Nov 2019 12:16:57 -0600
Message-Id: <20191114181702.22254-18-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
References: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v3 17/22] soundwire: stream: remove redundant
	pr_err traces
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Only keep pr_err to flag critical configuration errors that will
typically only happen during system integration.

For errors on prepare/deprepare/enable/disable, the caller can do a
much better job with more information on the DAI and device that
caused the issue.

Suggested-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/stream.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index e69f94a8c3a8..178ae92b8cc1 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1554,8 +1554,6 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
 	sdw_acquire_bus_lock(stream);
 
 	ret = _sdw_prepare_stream(stream);
-	if (ret < 0)
-		pr_err("Prepare for stream:%s failed: %d\n", stream->name, ret);
 
 	sdw_release_bus_lock(stream);
 	return ret;
@@ -1622,8 +1620,6 @@ int sdw_enable_stream(struct sdw_stream_runtime *stream)
 	sdw_acquire_bus_lock(stream);
 
 	ret = _sdw_enable_stream(stream);
-	if (ret < 0)
-		pr_err("Enable for stream:%s failed: %d\n", stream->name, ret);
 
 	sdw_release_bus_lock(stream);
 	return ret;
@@ -1698,8 +1694,6 @@ int sdw_disable_stream(struct sdw_stream_runtime *stream)
 	sdw_acquire_bus_lock(stream);
 
 	ret = _sdw_disable_stream(stream);
-	if (ret < 0)
-		pr_err("Disable for stream:%s failed: %d\n", stream->name, ret);
 
 	sdw_release_bus_lock(stream);
 	return ret;
@@ -1756,8 +1750,6 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 	ret = _sdw_deprepare_stream(stream);
-	if (ret < 0)
-		pr_err("De-prepare for stream:%d failed: %d\n", ret, ret);
 
 	sdw_release_bus_lock(stream);
 	return ret;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
