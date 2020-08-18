Return-Path: <SRS0=bO7z=B5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EC5C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 02:03:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320542067C
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 02:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jmNDdwp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320542067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B687917D9;
	Wed, 19 Aug 2020 04:02:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B687917D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597802628;
	bh=VtQhF8Cr0LWuGLfxgEpaEuTce33w934EGjmwjKqVc0c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jmNDdwp0Rx7lEMif4FWN/1XJGkQoU36Ipll9OwNsjB7hX5wpXz9PBvAB7DLu3M4ko
	 NGnFEAPSZQQudjtKoDXjompUbcPc/0hND9oB5JZK3LvZa2J65UwJ8PacSdkeN3JraK
	 UxOFrBhu/Bc0P/tG2XppPjd/Q7tGcM6JXHyIip5A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EDECEF802D2;
	Wed, 19 Aug 2020 04:01:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED222F8025A; Wed, 19 Aug 2020 04:01:04 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 279A4F80218
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2020 04:00:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 279A4F80218
IronPort-SDR: lLenenCTYeIrvpavaZOcxeJDwcaPj9QTpXroiEgZqUvrtfAbLXUp7oT+LDpZfOH4Br8dzqi7it
 MEuRRKSO3D2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239865515"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; d="scan'208";a="239865515"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 19:00:51 -0700
IronPort-SDR: s9c0d/XzZPEr3Zy2PPpg07nlISYLs6xtPDJsVZTsdT0LbbDhgRiIl+/vEFXdL8+AfGFRl0sDkx
 /VYmOGkZeMRg==
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; d="scan'208";a="279565060"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 19:00:47 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 2/7] soundwire: bus: filter-out unwanted interrupt reports
Date: Tue, 18 Aug 2020 22:06:51 +0800
Message-Id: <20200818140656.29014-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
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

Unlike the traditional usage, in the SoundWire specification the
interrupt masks only gate the propagation of an interrupt condition to
the PING frame status. They do not gate the changes of the INT_STAT
registers, which will happen regardless of the mask settings. See
Figure 116 of the SoundWire 1.2 specification for an in-depth
description of the interrupt model.

When the bus driver reads the SCP_INT1_STAT register, it will retrieve
all the interrupt status, including for the mask fields that were not
explicitly set. For example, even if the PARITY mask is not set, the
PARITY error status will be reported if an implementation-defined
interrupt for jack detection is enabled and occurs.

Filtering undesired interrupt reports and handling has to be
implemented in software. This patch enables this filtering for the
INT1_IMPL_DEF, PARITY and BUS_CLASH interrupt sources.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 3b6a87bc254e..9e5bcd0dd115 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1394,12 +1394,14 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		 * interrupt
 		 */
 		if (buf & SDW_SCP_INT1_PARITY) {
-			dev_err(&slave->dev, "Parity error detected\n");
+			if (slave->prop.scp_int1_mask & SDW_SCP_INT1_PARITY)
+				dev_err(&slave->dev, "Parity error detected\n");
 			clear |= SDW_SCP_INT1_PARITY;
 		}
 
 		if (buf & SDW_SCP_INT1_BUS_CLASH) {
-			dev_err(&slave->dev, "Bus clash error detected\n");
+			if (slave->prop.scp_int1_mask & SDW_SCP_INT1_BUS_CLASH)
+				dev_err(&slave->dev, "Bus clash detected\n");
 			clear |= SDW_SCP_INT1_BUS_CLASH;
 		}
 
@@ -1411,9 +1413,11 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		 */
 
 		if (buf & SDW_SCP_INT1_IMPL_DEF) {
-			dev_dbg(&slave->dev, "Slave impl defined interrupt\n");
+			if (slave->prop.scp_int1_mask & SDW_SCP_INT1_IMPL_DEF) {
+				dev_dbg(&slave->dev, "Slave impl defined interrupt\n");
+				slave_notify = true;
+			}
 			clear |= SDW_SCP_INT1_IMPL_DEF;
-			slave_notify = true;
 		}
 
 		/* Check port 0 - 3 interrupts */
-- 
2.17.1

