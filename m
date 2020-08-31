Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026A7C433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:39:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758DC2064B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MoZRncsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758DC2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0663116DE;
	Tue,  1 Sep 2020 03:38:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0663116DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598924388;
	bh=KgqbcstOCDZYTWVPfWxt9J2nlJ7y3cb4HRTu24VTyc8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MoZRncsKzdenvSLSGwVoRSI0vNX5VwqKsde4pMJDbSzb8opJrelR5ZoCeMJxi5MVK
	 PR7XQhOgMf5GL4RVK40JIlHl0YV5TX+xwuAbOmt0VXH0TJlERHCgezEkKfxtWzXP0M
	 pFuWMHlkdDXQ1hCOLq+QAHh1cm2gXOXqRw+r/f/Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F20D6F802BC;
	Tue,  1 Sep 2020 03:37:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D967EF80278; Tue,  1 Sep 2020 03:37:20 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 478D1F800BA
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 03:37:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 478D1F800BA
IronPort-SDR: zZ+Ovf+MY8DYIlhAnHM0C39T4g8SQLALCDagdcgLW5d0yp5yB6slC4dJ4YvKqqHr9/cTfYk7VU
 taGUzylV4Qhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="157090545"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; d="scan'208";a="157090545"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 18:37:13 -0700
IronPort-SDR: jL5ldI/3OnHsq+A4LgqWDrckXyvBnGayk4IFMzysijZaWM6obnU4j2m5Lcu6QUU45RCELEWOL8
 mJKvLwlQZLWA==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; d="scan'208";a="476984142"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 18:37:09 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v4 2/3] soundwire: add definition for maximum number of ports
Date: Mon, 31 Aug 2020 21:43:17 +0800
Message-Id: <20200831134318.11443-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831134318.11443-1-yung-chuan.liao@linux.intel.com>
References: <20200831134318.11443-1-yung-chuan.liao@linux.intel.com>
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

