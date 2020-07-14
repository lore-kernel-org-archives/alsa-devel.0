Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62A7C433E5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:34:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E70206D5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WViRGCZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E70206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBF901660;
	Wed, 15 Jul 2020 11:33:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBF901660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594805638;
	bh=HcDFWjUqz+Mqr0LBxnFco62GiPVhl+/KT9MbJSWrjT4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WViRGCZWnUa7i3qPnEzECmbM4u8BogTvPTXBXxSbDznFJlXnJHI7iz6gOZQu540T5
	 ybx3siLk2XnjoYaKZJUZb/K61J0ti6SEjG8awpp81TgChojCt0C1vFRkwYz3VO7LJG
	 c+Frdl2CDtqyuO0L/4QRPf8TnQjo1ub2Dk1IrYmo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1522CF8021D;
	Wed, 15 Jul 2020 11:32:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 400CCF80227; Wed, 15 Jul 2020 11:32:15 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46CD1F80217
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 11:32:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46CD1F80217
IronPort-SDR: qKs3fDTI0FWn16X66PoCcPcwN0eIfmd9kXJ5dMhsjJIeTdr1Y2zA3LWKv8at/L34n8M1umYWzb
 UtE1+SVvympQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="137241502"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; d="scan'208";a="137241502"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 02:32:04 -0700
IronPort-SDR: CGidmK//KfAqvtPF13ztwd8cu+OmxMBIBBmgxo9a42dlEeYtmG5VDpXqm/OPEfzLS+4v7xs+ec
 qmpW/HuM+PyA==
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; d="scan'208";a="460006226"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 02:32:00 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 1/2] soundwire: sdw.h: fix PRBS/Static_1 swapped definitions
Date: Wed, 15 Jul 2020 05:37:43 +0800
Message-Id: <20200714213744.24674-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714213744.24674-1-yung-chuan.liao@linux.intel.com>
References: <20200714213744.24674-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Table 110 "Port Data Modes" of the SoundWire 1.2 specification lists
PRBS as b01 and Static_1 as b11. The existing headers swapped the two
values, fix.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 4057adf7f049..6452bac957b3 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -152,19 +152,19 @@ enum sdw_data_direction {
  *
  * @SDW_PORT_DATA_MODE_NORMAL: Normal data mode where audio data is received
  * and transmitted.
+ * @SDW_PORT_DATA_MODE_PRBS: Test mode which uses a PRBS generator to produce
+ * a pseudo random data pattern that is transferred
+ * @SDW_PORT_DATA_MODE_STATIC_0: Simple test mode which uses static value of
+ * logic 0. The encoding will result in no signal transitions
  * @SDW_PORT_DATA_MODE_STATIC_1: Simple test mode which uses static value of
  * logic 1. The encoding will result in signal transitions at every bitslot
  * owned by this Port
- * @SDW_PORT_DATA_MODE_STATIC_0: Simple test mode which uses static value of
- * logic 0. The encoding will result in no signal transitions
- * @SDW_PORT_DATA_MODE_PRBS: Test mode which uses a PRBS generator to produce
- * a pseudo random data pattern that is transferred
  */
 enum sdw_port_data_mode {
 	SDW_PORT_DATA_MODE_NORMAL = 0,
-	SDW_PORT_DATA_MODE_STATIC_1 = 1,
+	SDW_PORT_DATA_MODE_PRBS = 1,
 	SDW_PORT_DATA_MODE_STATIC_0 = 2,
-	SDW_PORT_DATA_MODE_PRBS = 3,
+	SDW_PORT_DATA_MODE_STATIC_1 = 3,
 };
 
 /*
-- 
2.17.1

