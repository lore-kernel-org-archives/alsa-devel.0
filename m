Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCF4C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Nov 2022 02:16:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE9471661;
	Fri, 11 Nov 2022 03:15:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE9471661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668132994;
	bh=sFoTlN5v6r79HUZxzN2vBniRQPFO0vULAV0J7b3pGgI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KKM5Dzdm0kJjg1QqrQusv4ZlLiExR5Bin985Q3FtCiQth+ELOEdEolq3AGDhc9imB
	 SEqgs1wPAbQRzqwOwRXjPK7ZOymxyiJnd/b9ZjVXtEOn4Gc4kpzoBt6TOe6vDRs1XB
	 Xea+V+9tFPGoounMMddacp+2+ACj6KlnbqsaQofI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F2ADF804FF;
	Fri, 11 Nov 2022 03:15:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8C0DF804FB; Fri, 11 Nov 2022 03:14:57 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D2E1F80104
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2022 03:14:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D2E1F80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="G21vEaPQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668132893; x=1699668893;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sFoTlN5v6r79HUZxzN2vBniRQPFO0vULAV0J7b3pGgI=;
 b=G21vEaPQTjsxl3Cof2hkFfAN94Gn45OzUfZSiIkf03TpRnqnp9/S1W3r
 qBxT8LXZBVW/tmxx2FWcYNwMYXefU/Zkr/LeH4Y9AyyHENFdrAQS3wmH5
 vd7UUUZlTtUUHPLkSz/6T7ZpnkmaG3Zz/zxYtmuNys6HBajn41ISdUCTy
 m4Xwx1tawUc1nSnFRSuTa7KAGtNIxAwNgRRGpWd2VJVuEf6JIW4Nu9Gs0
 +MyswPuPdkehCpTon2mBYZL2S3rBIaPh9pZBxiZHraFylxgTzGYaYwzG8
 +G3cUZtOemQAYfcSN6HozuNXNtpGIpAGA+EuFWLnZybACAG1nwRqfLs8C A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291904412"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; d="scan'208";a="291904412"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 18:14:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="615335551"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; d="scan'208";a="615335551"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 18:14:46 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 2/2] soundwire: enable optional clock registers for SoundWire
 1.2 devices
Date: Fri, 11 Nov 2022 10:16:33 +0800
Message-Id: <20221111021633.39908-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111021633.39908-1-yung-chuan.liao@linux.intel.com>
References: <20221111021633.39908-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 bard.liao@intel.com, linux-kernel@vger.kernel.org
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

The bus supports the mandatory clock registers for SDCA devices, these
registers can also be optionally supported by SoundWire 1.2 devices
that don't follow the SDCA class specification.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 7 ++++---
 include/linux/soundwire/sdw.h | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index c23275b443ac..55d393247a0f 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1233,10 +1233,11 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
 
 	/*
 	 * frequency base and scale registers are required for SDCA
-	 * devices. They may also be used for 1.2+/non-SDCA devices,
-	 * but we will need a DisCo property to cover this case
+	 * devices. They may also be used for 1.2+/non-SDCA devices.
+	 * Driver can set the property, we will need a DisCo property
+	 * to discover this case from platform firmware.
 	 */
-	if (!slave->id.class_id)
+	if (!slave->id.class_id && !slave->prop.clock_reg_supported)
 		return 0;
 
 	if (!mclk_freq) {
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 8fb458931772..9a49263c53cf 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -365,6 +365,9 @@ struct sdw_dpn_prop {
  * @sink_dpn_prop: Sink Data Port N properties
  * @scp_int1_mask: SCP_INT1_MASK desired settings
  * @quirks: bitmask identifying deltas from the MIPI specification
+ * @clock_reg_supported: the Peripheral implements the clock base and scale
+ * registers introduced with the SoundWire 1.2 specification. SDCA devices
+ * do not need to set this boolean property as the registers are required.
  */
 struct sdw_slave_prop {
 	u32 mipi_revision;
@@ -388,6 +391,7 @@ struct sdw_slave_prop {
 	struct sdw_dpn_prop *sink_dpn_prop;
 	u8 scp_int1_mask;
 	u32 quirks;
+	bool clock_reg_supported;
 };
 
 #define SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY	BIT(0)
-- 
2.25.1

