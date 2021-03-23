Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAC5C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 05:09:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6781F619A0
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 05:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6781F619A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D3DD1607;
	Tue, 23 Mar 2021 06:08:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D3DD1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616476144;
	bh=tHDNjEv+lZtOQdCXRVlxI1AueFsyBEH6DDiJsskcbv0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gwr1pUXHbTbIEBujEc9eCxYzXD0zGmWR3E9WRKpPNckl6vL2YNlCmGY95n9IK9K9Z
	 xfyaZCcoWjmwL51d337emsAGNqt5mjxzav+UomejsuGQMR1esPfL1T21FluwzuiI1o
	 573h5ryPolbavijdUNAFTXws6YWqqnJPIwdgVFGo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11308F8025F;
	Tue, 23 Mar 2021 06:07:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94429F8028D; Tue, 23 Mar 2021 06:07:27 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1EB72F80257
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 06:07:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EB72F80257
IronPort-SDR: Duc36UAAD5pefFq4dElkpQXQ+RtmKmGx3S6xznYnIh24+CuPl8xZIRUEfhZQtdAdRLWbAMuI8O
 i78YNao2xYAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189805380"
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; d="scan'208";a="189805380"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 22:07:12 -0700
IronPort-SDR: 2g+QbbLTG9piWLLnkm6TrIcb4ktNShOK5MGWU9XimSPag/ptxen6c2QGdV7ejFvWxXuWROapG8
 7mtnXOfCLmiw==
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; d="scan'208";a="414800903"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 22:07:11 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH 1/2] soundwire: add definition for DPn BlockPackingMode
Date: Tue, 23 Mar 2021 13:07:00 +0800
Message-Id: <20210323050701.23760-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210323050701.23760-1-yung-chuan.liao@linux.intel.com>
References: <20210323050701.23760-1-yung-chuan.liao@linux.intel.com>
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
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

For some reason we don't have an enum for this concept. Add
definitions following Table 102 of the SoundWire 1.2 specification.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index eaa1486bdca9..350436db6ddb 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -125,6 +125,12 @@ enum sdw_dpn_grouping {
 	SDW_BLK_GRP_CNT_4 = 3,
 };
 
+/* block packing mode enum */
+enum sdw_dpn_pkg_mode {
+	SDW_BLK_PKG_PER_PORT = 0,
+	SDW_BLK_PKG_PER_CHANNEL = 1
+};
+
 /**
  * enum sdw_stream_type: data stream type
  *
-- 
2.17.1

