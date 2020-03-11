Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A335C0044D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:47:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C5120736
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mCeQ2X5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C5120736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74AC916A2;
	Wed, 11 Mar 2020 19:46:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74AC916A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583952468;
	bh=UiVNMudkEH/n9Lu7zrmWpfRYhxPqsuXMm0ciPo/uZJI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mCeQ2X5VClOnoo5VPR8TL7pgk6/4S7Jseob+AKLxlSiqYUB5zRmdQll/QsO2riOqJ
	 OkoaWUjn1t8yvsxVrw5Uz8WHr1jjqn/bEdfyw2Me5Uo3iqG96sX4n6hL/xxHbyehA4
	 wj8atgULZ8lORTDqejIj+u2s0tNrngauTphIhCIE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 750DEF802E8;
	Wed, 11 Mar 2020 19:42:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C3ADF802A1; Wed, 11 Mar 2020 19:42:00 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FA43F8028D
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 19:41:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FA43F8028D
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 11:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; d="scan'208";a="441776266"
Received: from fjan-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
 by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 11:41:54 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/16] soundwire: cadence: merge routines to clear/set bits
Date: Wed, 11 Mar 2020 13:41:20 -0500
Message-Id: <20200311184128.4212-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

Use a single loop to wait for hardware to set/clear fields.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index a4ba57f44c1f..22ff66d38a4a 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -211,26 +211,6 @@ static inline void cdns_updatel(struct sdw_cdns *cdns,
 	cdns_writel(cdns, offset, tmp);
 }
 
-static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
-{
-	int timeout = 10;
-	u32 reg_read;
-
-	writel(value, cdns->registers + offset);
-
-	/* Wait for bit to be self cleared */
-	do {
-		reg_read = readl(cdns->registers + offset);
-		if ((reg_read & value) == 0)
-			return 0;
-
-		timeout--;
-		usleep_range(50, 100);
-	} while (timeout != 0);
-
-	return -EAGAIN;
-}
-
 static int cdns_set_wait(struct sdw_cdns *cdns, int offset, u32 mask, u32 value)
 {
 	int timeout = 10;
@@ -249,6 +229,14 @@ static int cdns_set_wait(struct sdw_cdns *cdns, int offset, u32 mask, u32 value)
 	return -ETIMEDOUT;
 }
 
+static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
+{
+	writel(value, cdns->registers + offset);
+
+	/* Wait for bit to be self cleared */
+	return cdns_set_wait(cdns, offset, value, 0);
+}
+
 /*
  * all changes to the MCP_CONFIG, MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL
  * need to be confirmed with a write to MCP_CONFIG_UPDATE
-- 
2.20.1

