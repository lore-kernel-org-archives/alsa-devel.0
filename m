Return-Path: <SRS0=bO7z=B5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647F3C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 02:04:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33182067C
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 02:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jSzNPhSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33182067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7547117DE;
	Wed, 19 Aug 2020 04:03:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7547117DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597802673;
	bh=iDCUY729GppLoSP/SJR0ja71cuSCj5U8IvbvjTFq+E4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jSzNPhSqgc6TpHg80eFWvelDTw3z+pHN6wjDHVdWe68Y+Wj3FxsYLLL0FPN6JgXzw
	 g3nBPIo+DzgKe/Ji4ipjpa6d1m146lELEvPpu5DhQxy8yEaQFnvgXXj0GQ5Oy98Zsv
	 DVmGn/+juG4QNLp3h2nTSoawgrgpH+Qu0qLQLwms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5835F802E3;
	Wed, 19 Aug 2020 04:01:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B1ACF802A9; Wed, 19 Aug 2020 04:01:06 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8233F80114
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2020 04:00:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8233F80114
IronPort-SDR: SwFV2LU66dm7zeJcme2kHP9uPYFHxfhUyzrz8vvMjQQrAEvK995z76jKeIXOHC57F9laodzV1a
 k2wizZIvtJbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239865543"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; d="scan'208";a="239865543"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 19:00:59 -0700
IronPort-SDR: 8O9wl9OXXY3v7qbKIzVtJsDElyQFSs8nf7Iuv0+gLmQvvXHWl9WLzywcFtRIyoY7XF3WuzsiR+
 gBbt8hu6lQ9Q==
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; d="scan'208";a="279565098"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 19:00:55 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 4/7] soundwire: bus: use quirk to filter out invalid parity
 errors
Date: Tue, 18 Aug 2020 22:06:53 +0800
Message-Id: <20200818140656.29014-5-yung-chuan.liao@linux.intel.com>
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

If a Slave device reports with a quirk that its initial parity check
may be incorrect, filter it but keep the parity checks active in
steady state.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 8 +++++++-
 include/linux/soundwire/sdw.h | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index cddf39e3adfc..869290a8db40 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1362,6 +1362,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	unsigned long port;
 	bool slave_notify = false;
 	u8 buf, buf2[2], _buf, _buf2[2];
+	bool parity_check;
+	bool parity_quirk;
 
 	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
 
@@ -1394,7 +1396,11 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		 * interrupt
 		 */
 		if (buf & SDW_SCP_INT1_PARITY) {
-			if (slave->prop.scp_int1_mask & SDW_SCP_INT1_PARITY)
+			parity_check = slave->prop.scp_int1_mask & SDW_SCP_INT1_PARITY;
+			parity_quirk = !slave->first_interrupt_done &&
+				(slave->prop.quirks & SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY);
+
+			if (parity_check && !parity_quirk)
 				dev_err(&slave->dev, "Parity error detected\n");
 			clear |= SDW_SCP_INT1_PARITY;
 		}
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 3550ab530c43..19bec6e4bbb6 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -356,6 +356,7 @@ struct sdw_dpn_prop {
  * @src_dpn_prop: Source Data Port N properties
  * @sink_dpn_prop: Sink Data Port N properties
  * @scp_int1_mask: SCP_INT1_MASK desired settings
+ * @quirks: bitmask identifying deltas from the MIPI specification
  */
 struct sdw_slave_prop {
 	u32 mipi_revision;
@@ -378,8 +379,11 @@ struct sdw_slave_prop {
 	struct sdw_dpn_prop *src_dpn_prop;
 	struct sdw_dpn_prop *sink_dpn_prop;
 	u8 scp_int1_mask;
+	u32 quirks;
 };
 
+#define SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY	BIT(0)
+
 /**
  * struct sdw_master_prop - Master properties
  * @revision: MIPI spec version of the implementation
-- 
2.17.1

