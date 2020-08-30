Return-Path: <SRS0=wuVw=CJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6344C433E2
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 01:23:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BEC2087D
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 01:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gKyBdvIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BEC2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 692EE180B;
	Mon, 31 Aug 2020 03:22:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 692EE180B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598837004;
	bh=KgqbcstOCDZYTWVPfWxt9J2nlJ7y3cb4HRTu24VTyc8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gKyBdvIjPFnzP6n1Jkb9zq1zLvXTeQ9Zrh0m1ecoEJ9nhOMyifaUA04e1iik8dTdd
	 ygpLnUBfcQ9EkpZRYtb8GOKrlcbDu0VXDu7ntS7LHFFywYvT8g1mblsMIkcBxnCaIv
	 GrnBANIEMPTAXKK0/74LjPZprf9VxDjm0nOy9HMo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69E84F802A2;
	Mon, 31 Aug 2020 03:21:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B66F7F80217; Mon, 31 Aug 2020 03:21:38 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22FBAF801EB
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 03:21:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22FBAF801EB
IronPort-SDR: 3v6eJGx5/9fsrR+OUVEwymZiiM5nCAhQg0c4+IEHC5u2843dTphuzeJD+WcBEpRXlASyXzbfdj
 41S6R5YFdc9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="156899768"
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; d="scan'208";a="156899768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2020 18:21:30 -0700
IronPort-SDR: wGI05vG5C9lDG/mW2tvGgOT2yS8ZReo29QIXeGO/HF3Nvns9luXLfHZ1PpHdhP1BF5hEaJuwEa
 EXrg/DGzoXRw==
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; d="scan'208";a="476529203"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2020 18:21:26 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v3 1/3] soundwire: add definition for maximum number of ports
Date: Sun, 30 Aug 2020 21:27:40 +0800
Message-Id: <20200830132742.20404-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830132742.20404-1-yung-chuan.liao@linux.intel.com>
References: <20200830132742.20404-1-yung-chuan.liao@linux.intel.com>
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

A Device may have at most 15 physical ports (DP0, DP1..DP14).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 76052f12c9f7..0aa4c6af7554 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -38,7 +38,8 @@ struct sdw_slave;
 #define SDW_FRAME_CTRL_BITS		48
 #define SDW_MAX_DEVICES			11
 
-#define SDW_VALID_PORT_RANGE(n)		((n) <= 14 && (n) >= 1)
+#define SDW_MAX_PORTS			15
+#define SDW_VALID_PORT_RANGE(n)		((n) < SDW_MAX_PORTS && (n) >= 1)
 
 enum {
 	SDW_PORT_DIRN_SINK = 0,
-- 
2.17.1

