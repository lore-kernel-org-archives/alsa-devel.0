Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E18C83017
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 13:28:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F0E206F9
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 13:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FBvb2CtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F0E206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE74A16AE;
	Tue, 24 Nov 2020 14:27:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE74A16AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606224528;
	bh=P4a8LqTrxH4OeBW42ihIdZy5Hj+Pt+hgib+3cF9IX+8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FBvb2CtIepH+9EoOhtm0VI+DRKl1o1RAl64ecbyL7QFCIv137CDte1qwMkVf5PbTr
	 gYMnpbz7UCLUjLRt+tzxbLMHspuOo1j/5gIgFFznqVbOSKFHjHxorbP9sYakY1Be9O
	 pmbrSN8Ze+Zhx1plpUpznN8KlwvkEYkqEC1kNtrc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAAA4F804CB;
	Tue, 24 Nov 2020 14:26:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64326F800C1; Tue, 24 Nov 2020 14:26:18 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0667F80166
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 14:26:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0667F80166
IronPort-SDR: fWAhkAwreSBWLMhEYBjzKlApqOhWfkqxwN6AIIB67LSwJHnRhj8Q2Ev9/wOYPsYSynFY8FDda6
 9SIpsHcusZPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172039557"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="172039557"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 05:26:10 -0800
IronPort-SDR: fHdFmb8eD5rqHQHfgTS7u9kPrLx9ko70HZtRBx70s+S7BzIwmwr4GApkTc4UgBAdcJ39+fv15g
 5dFHJydQTw8w==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="546830617"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 05:26:06 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 3/5] soundwire: registers: add definitions for clearable
 interrupt fields
Date: Tue, 24 Nov 2020 09:33:16 +0800
Message-Id: <20201124013318.8963-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
References: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
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

DP0 has reserved fields and the read-only SDCA_CASCADE bit. We should
not try to write values in these fields, so add a formal definition
for clearable interrupts to be used in DP0 interrupt handling.

DPN also has reserved fields so add definitions for clearable
interrupts as well.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_registers.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index f420e8059779..0cb1a22685b8 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -41,6 +41,12 @@
 #define SDW_DP0_INT_IMPDEF1			BIT(5)
 #define SDW_DP0_INT_IMPDEF2			BIT(6)
 #define SDW_DP0_INT_IMPDEF3			BIT(7)
+#define SDW_DP0_INTERRUPTS			(SDW_DP0_INT_TEST_FAIL | \
+						 SDW_DP0_INT_PORT_READY | \
+						 SDW_DP0_INT_BRA_FAILURE | \
+						 SDW_DP0_INT_IMPDEF1 | \
+						 SDW_DP0_INT_IMPDEF2 | \
+						 SDW_DP0_INT_IMPDEF3)
 
 #define SDW_DP0_PORTCTRL_DATAMODE		GENMASK(3, 2)
 #define SDW_DP0_PORTCTRL_NXTINVBANK		BIT(4)
@@ -241,6 +247,11 @@
 #define SDW_DPN_INT_IMPDEF1			BIT(5)
 #define SDW_DPN_INT_IMPDEF2			BIT(6)
 #define SDW_DPN_INT_IMPDEF3			BIT(7)
+#define SDW_DPN_INTERRUPTS			(SDW_DPN_INT_TEST_FAIL | \
+						 SDW_DPN_INT_PORT_READY | \
+						 SDW_DPN_INT_IMPDEF1 | \
+						 SDW_DPN_INT_IMPDEF2 | \
+						 SDW_DPN_INT_IMPDEF3)
 
 #define SDW_DPN_PORTCTRL_FLOWMODE		GENMASK(1, 0)
 #define SDW_DPN_PORTCTRL_DATAMODE		GENMASK(3, 2)
-- 
2.17.1

