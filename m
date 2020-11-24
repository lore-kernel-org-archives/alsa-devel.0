Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C8C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 13:27:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055012083E
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 13:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QdmDvBvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055012083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FFD81683;
	Tue, 24 Nov 2020 14:26:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FFD81683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606224425;
	bh=4Uj9+ftJ080EADuBIwMAHIr7CcQrCgxgfu2cp0fKJVM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QdmDvBvmq4Frx9G8US3MvcA6ZlK1ZaQqdRCZ4jsI/3TH8ySU56gHJP98iG8scw4sI
	 dDI+ebYhv/O9m4zO59wo8Pl6YJJBOYMeuNDKvNNXiDq0OrItkUyxMRqLc1TV80G62F
	 kGoy1DDoVYEiC3hboeZGHOapO+3PfaZPqBPi4iEc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0599F80161;
	Tue, 24 Nov 2020 14:26:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54D3FF80128; Tue, 24 Nov 2020 14:26:13 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19BECF80128
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 14:26:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19BECF80128
IronPort-SDR: M1GgLsilSQvjfwW3GgR0iaQRNCoIpZUCCwHLnpW3sVi9lsNMaReWl/B+BvMDdsSoRz8RFhGolN
 T13F6gd9E+xQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172039535"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="172039535"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 05:26:02 -0800
IronPort-SDR: P15K+84n5V1KVJuVxYWzDy/ZvAifjRJWVPqU2AXI91CyqvbGYti6bxqQY52QJYsnKPqbO6x9UW
 XNL3nl0jeb/g==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="546830578"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 05:25:58 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 1/5] soundwire: bus: add comments to explain interrupt loop
 filter
Date: Tue, 24 Nov 2020 09:33:14 +0800
Message-Id: <20201124013318.8963-2-yung-chuan.liao@linux.intel.com>
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

The interrupt handling in SoundWire requires software to re-read the
interrupt status after clearing an interrupt. In case the interrupt is
still outstanding, the code in bus.c will loop a number of times,
however that loop is limited to the interrupts detected in the first
read. This strategy helps meet SoundWire requirements without
remaining forever in an interrupt handler.

Add a couple of comments to document this design.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index ffe4600fd95b..45131b9f5080 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1334,6 +1334,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 				"SDW_DP0_INT read failed:%d\n", status2);
 			return status2;
 		}
+		/* filter to limit loop to interrupts identified in the first status read */
 		status &= status2;
 
 		count++;
@@ -1404,6 +1405,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 				"SDW_DPN_INT read failed:%d\n", status2);
 			return status2;
 		}
+		/* filter to limit loop to interrupts identified in the first status read */
 		status &= status2;
 
 		count++;
@@ -1589,7 +1591,10 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 			sdca_cascade = ret & SDW_DP0_SDCA_CASCADE;
 		}
 
-		/* Make sure no interrupts are pending */
+		/*
+		 * Make sure no interrupts are pending, but filter to limit loop
+		 * to interrupts identified in the first status read
+		 */
 		buf &= _buf;
 		buf2[0] &= _buf2[0];
 		buf2[1] &= _buf2[1];
-- 
2.17.1

