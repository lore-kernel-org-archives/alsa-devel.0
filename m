Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26516C77B7D
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 06:55:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7673D82C;
	Mon, 15 May 2023 08:54:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7673D82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684133712;
	bh=wsFbcSJtx/AlSmGIw0DdUSJEopY6I39DINuaH9UuTy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=d+Wnd8dIcVlLuJuu6feVdXRELyJepXNGTgrab8QmIWl1dsDEN1a9gGk2SO2808Pj1
	 qQH2T3emMznL7WOriQc+ZhCXyUGR1ZcW4dOrvASQwTnGlTnXBHcJ6TLQfFzs1GLtSc
	 1Z+JM6pcHJ7928CDBz6Ze/xV+6OJzSAaM+pnM/cw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75543F8060B; Mon, 15 May 2023 08:51:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 245FCF805F7;
	Mon, 15 May 2023 08:51:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A621DF805E0; Mon, 15 May 2023 08:51:01 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B1566F805CB
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 08:50:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1566F805CB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LCbVvrkX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133458; x=1715669458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wsFbcSJtx/AlSmGIw0DdUSJEopY6I39DINuaH9UuTy0=;
  b=LCbVvrkXEtjU63KHpiGq57B0qROwD3xPmuFq3Gyzx05a4lQj20ZT+AF8
   O8kmkguduTqg+uUS8pS4Yo+lSl4C2yh9UUcBawCk0UpU/mtHCpDU3xRTP
   M+3BUE4UrSqPnmOIRGPyiiXCHFfGbZCvH0WkT1QxKieXQFnDQJq4ACoRg
   hY2N5LaQeYXzXupqI12lYdNF4GEL0Zgv2iLexaIfjJUEIyE7Mlky+OTkk
   RUmmDXvgxMI1wJHdbjCLEEGyWbke+ANYlLAptszY/L/QyXfTRDqPLsqHr
   IqkAejDcuP/om2hb3Ei82NYNLrWzZUW9A+n2ke+oCtrKTpDxz8SE/2f2/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966446"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200";
   d="scan'208";a="349966446"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2023 23:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908736"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200";
   d="scan'208";a="694908736"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2023 23:50:54 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-kernel@vger.kernel.org,
	vinod.koul@linaro.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 15/26] soundwire: intel_ace2x: add sync_arm/sync_go helpers
Date: Mon, 15 May 2023 15:10:31 +0800
Message-Id: <20230515071042.2038-16-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: K5VKVBXU3UWXWW7QCJAE62MGA347T6MP
X-Message-ID-Hash: K5VKVBXU3UWXWW7QCJAE62MGA347T6MP
X-MailFrom: yung-chuan.liao@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Same functionality as before, but with the registers moved to the
HDaudio multi-link area.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index d6d5e6e070f4..20b8806f7de6 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -116,6 +116,41 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 	return ret;
 }
 
+static void intel_sync_arm(struct sdw_intel *sdw)
+{
+	unsigned int link_id = sdw->instance;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	hdac_bus_eml_sdw_sync_arm_unlocked(sdw->link_res->hbus, link_id);
+
+	mutex_unlock(sdw->link_res->shim_lock);
+}
+
+static int intel_sync_go_unlocked(struct sdw_intel *sdw)
+{
+	int ret;
+
+	ret = hdac_bus_eml_sdw_sync_go_unlocked(sdw->link_res->hbus);
+	if (ret < 0)
+		dev_err(sdw->cdns.dev, "%s: SyncGO clear failed: %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int intel_sync_go(struct sdw_intel *sdw)
+{
+	int ret;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	ret = intel_sync_go_unlocked(sdw);
+
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	return ret;
+}
+
 /*
  * DAI operations
  */
@@ -283,6 +318,10 @@ const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 
 	.link_power_up = intel_link_power_up,
 	.link_power_down = intel_link_power_down,
+
+	.sync_arm = intel_sync_arm,
+	.sync_go_unlocked = intel_sync_go_unlocked,
+	.sync_go = intel_sync_go,
 };
 EXPORT_SYMBOL_NS(sdw_intel_lnl_hw_ops, SOUNDWIRE_INTEL);
 
-- 
2.25.1

