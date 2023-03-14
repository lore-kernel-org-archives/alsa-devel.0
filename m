Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BD2C6FD19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Mar 2023 01:45:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19F21147A;
	Tue, 14 Mar 2023 02:45:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19F21147A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678758357;
	bh=NA2gNysK23O2yyiWZ9WhH+HonzPAPVODm9Os9DBHBa4=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=scLqWOxpGdjo95sPLblCY+g5bUgPYv4dp6JWYQ2sVFkM2iRrz2cxpmU4T59CsIASc
	 HC7lgKNGNyElmsamk/P1+8zj14MovGCppVAp8ba0expGzS7uAx2mZrGCy/pt7a2LK9
	 Iqe33Y/WXMr9I3O3eLkXdg29BPUr67B1STW2TR9E=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF516F805BA;
	Tue, 14 Mar 2023 02:41:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 946A5F80579; Tue, 14 Mar 2023 02:41:39 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 083D3F80564
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2023 02:41:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 083D3F80564
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=feSYWJbO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758092; x=1710294092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NA2gNysK23O2yyiWZ9WhH+HonzPAPVODm9Os9DBHBa4=;
  b=feSYWJbOQGcSfj0dZJdpZPMR1Y0M7RSK/pNXiDRK2nBcuW4uBspnTEAV
   iI+Erb6RPWzV2GRVKCc0WAvdozcte3sPUhA/4RLkreO0r7FcnfqcX7LMc
   ySf6PX6ZwCFv3HdGpz1aKzwq5S0YgH3SEHexQfsC57+wYmMcZ17Vl/Yz1
   UjQ9NfqYTGhC0kX8AHuMpTAC2MMWk6HcLyvThFuBvRlmNDeDaXC/mU3T7
   MzrNsiuMVbk/z0nwSstTIVvqR+ZwbKUiuHgvge4RBhLo2gOvglF6ov88S
   ZEvFIAeD15eQDYtSSLQhmqmqpxOgqJMaZVQe/UZ4nAvNWblvGuPbN5F/V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949294"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400";
   d="scan'208";a="316949294"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 18:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327521"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400";
   d="scan'208";a="711327521"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 18:41:28 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 12/16] soundwire: cadence: add helpers to access IP_MCP
 registers
Date: Tue, 14 Mar 2023 09:54:06 +0800
Message-Id: <20230314015410.487311-13-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
References: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SDC3QVLVIRZGOR4C2ZTRW6TUNNMT66R2
X-Message-ID-Hash: SDC3QVLVIRZGOR4C2ZTRW6TUNNMT66R2
X-MailFrom: yung-chuan.liao@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SDC3QVLVIRZGOR4C2ZTRW6TUNNMT66R2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The latest Cadence IP splits some of the existing registers into two,
separated by a fixed offset. The bitfields themselves remain at the
same position, so we can use new helpers to dynamically add the fixed
offset.

For example, the existing MCP_CONFIG is now split in two with
MCP_CONFIG and IP_MCP_CONFIG (the naming comes directly from the
design document).

This patch adds helpers to access registers with the IP_ prefix. The
addition of the 'ip' prefix for helpers, registers and bitfields is
intentional to help reviewers spot any mistake.

For existing solutions, the offset is exactly zero so there's no
functional change - the MCP_CONFIG and IP_MCP_CONFIG are aliased to
the same address.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 16 ++++++++++++++++
 drivers/soundwire/cadence_master.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4f34fc72dbd5..4461a7fa4124 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -205,6 +205,16 @@ static inline void cdns_writel(struct sdw_cdns *cdns, int offset, u32 value)
 	writel(value, cdns->registers + offset);
 }
 
+static inline u32 cdns_ip_readl(struct sdw_cdns *cdns, int offset)
+{
+	return cdns_readl(cdns, cdns->ip_offset + offset);
+}
+
+static inline void cdns_ip_writel(struct sdw_cdns *cdns, int offset, u32 value)
+{
+	return cdns_writel(cdns, cdns->ip_offset + offset, value);
+}
+
 static inline void cdns_updatel(struct sdw_cdns *cdns,
 				int offset, u32 mask, u32 val)
 {
@@ -215,6 +225,12 @@ static inline void cdns_updatel(struct sdw_cdns *cdns,
 	cdns_writel(cdns, offset, tmp);
 }
 
+static inline void cdns_ip_updatel(struct sdw_cdns *cdns,
+				   int offset, u32 mask, u32 val)
+{
+	cdns_updatel(cdns, cdns->ip_offset + offset, mask, val);
+}
+
 static int cdns_set_wait(struct sdw_cdns *cdns, int offset, u32 mask, u32 value)
 {
 	int timeout = 10;
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index dec0b4f993c1..b653734085d9 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -107,6 +107,7 @@ struct sdw_cdns_dai_runtime {
  * @dev: Linux device
  * @bus: Bus handle
  * @instance: instance number
+ * @ip_offset: version-dependent offset to access IP_MCP registers and fields
  * @response_buf: SoundWire response buffer
  * @tx_complete: Tx completion
  * @ports: Data ports
@@ -122,6 +123,8 @@ struct sdw_cdns {
 	struct sdw_bus bus;
 	unsigned int instance;
 
+	u32 ip_offset;
+
 	/*
 	 * The datasheet says the RX FIFO AVAIL can be 2 entries more
 	 * than the FIFO capacity, so allow for this.
-- 
2.25.1

