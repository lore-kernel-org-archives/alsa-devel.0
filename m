Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4A0C77B75
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 06:55:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 520E9DEF;
	Mon, 15 May 2023 08:55:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 520E9DEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684133754;
	bh=SbHuuXPdMaBgfOruu1bZggLsJuDVCwmXsFFke6IavfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qrBpvkoqC2/hx83hhZvGOXOxUmkLNSG6qH4QMTsUnd13qWu3wvETPlp2sl3hCtwK1
	 AmmoVw3tnUy4WYvhz3BAvcdJPL3Hg+hovZLPn6d16W2co7paVIDGXrm23nM/HZDw+i
	 xxbNPn9rSmcFY5LgjxamRUitSD+sQhW8kt+2Q8Mw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F11BF8061F; Mon, 15 May 2023 08:51:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 380B7F8061F;
	Mon, 15 May 2023 08:51:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 789ACF805F1; Mon, 15 May 2023 08:51:08 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C65BCF805E7
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 08:51:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C65BCF805E7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SFgRPSys
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133466; x=1715669466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SbHuuXPdMaBgfOruu1bZggLsJuDVCwmXsFFke6IavfA=;
  b=SFgRPSysgGimIdgegKfUkSzL11Nzx68KJQiX+4l+LUb3nK8kbnXJwvm5
   A6FQU4c+/Gvc4PJAFLp43is4dMl6mGTGvtI/7YzLZ/GXATDBwN9OsYa7j
   bExzeD9HnKEFQqDp1wrDmsO4KEDghwhbmn2WEwWZqIoFlrPIJ2j73qW9z
   soIpzeSMawJ/hnK9hUD0st2ZBzf2ey0TB6czLjQhBuVkqsa9dcpte+bzI
   cf8ahxSC5fHYwasDeQ6DsVKlD8KgMoDqqOkF72i9XyqPuL8kp5aUSDutL
   omx6/Cy5YcOFWSha2ehMegAM5lPDQjLO/bF4T7lxXjuBqJ8QRdwfmLday
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966493"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200";
   d="scan'208";a="349966493"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2023 23:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908759"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200";
   d="scan'208";a="694908759"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2023 23:51:01 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-kernel@vger.kernel.org,
	vinod.koul@linaro.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 18/26] soundwire: intel_ace2x: add check_cmdsync_unlocked
 helper
Date: Mon, 15 May 2023 15:10:34 +0800
Message-Id: <20230515071042.2038-19-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3RDZ7DN4VU244YI2A2VCUFHXIWHDVZID
X-Message-ID-Hash: 3RDZ7DN4VU244YI2A2VCUFHXIWHDVZID
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
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3RDZ7DN4VU244YI2A2VCUFHXIWHDVZID/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This is the last callback needed for all bus management routines on
new hardware. Same concept as before, just different register.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index fe950b3ea3bc..a12fee8a5bfa 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -186,6 +186,11 @@ static int intel_sync_go(struct sdw_intel *sdw)
 	return ret;
 }
 
+static bool intel_check_cmdsync_unlocked(struct sdw_intel *sdw)
+{
+	return hdac_bus_eml_sdw_check_cmdsync_unlocked(sdw->link_res->hbus);
+}
+
 /*
  * DAI operations
  */
@@ -366,6 +371,7 @@ const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 	.sync_arm = intel_sync_arm,
 	.sync_go_unlocked = intel_sync_go_unlocked,
 	.sync_go = intel_sync_go,
+	.sync_check_cmdsync_unlocked = intel_check_cmdsync_unlocked,
 };
 EXPORT_SYMBOL_NS(sdw_intel_lnl_hw_ops, SOUNDWIRE_INTEL);
 
-- 
2.25.1

