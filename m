Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02769C77B73
	for <alsa-devel@archiver.kernel.org>; Wed, 31 May 2023 03:18:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF1D2846;
	Wed, 31 May 2023 05:17:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF1D2846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685503087;
	bh=1MyuBzg/rXNODw6gij/Uy3ks1qAp9FzmB1Vw7BzGHV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XueYicxwF+zPA8HFa7uF4J7O0r3yc3btFFp+gZUjvo/XEkq6KAwJiI5nUk1HBk58B
	 XF/Je77avVXbS0RWVemrz1D1SmMLOZCvSLdXvYfexxjK7ma3UKPbeWs+Yjtq6BUicN
	 pGJOTMMJZAN/RK596Y08SJmI20/fVyJReofOmww8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0AA6F8057D; Wed, 31 May 2023 05:16:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CAB9F8057C;
	Wed, 31 May 2023 05:16:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5CE4AF80564; Wed, 31 May 2023 05:16:05 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1D5E4F8042F
	for <alsa-devel@alsa-project.org>; Wed, 31 May 2023 05:15:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D5E4F8042F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=C0FZKLxA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685502944; x=1717038944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1MyuBzg/rXNODw6gij/Uy3ks1qAp9FzmB1Vw7BzGHV8=;
  b=C0FZKLxAwHTjOIQ3QMuj2C7157h0y3TXm3Am8A04PVy2eVwQjTV3pKZZ
   zOlJhqqHzbJIA2NK88Q2HKZ+qaAli/zoojVIc++acSDogQrbT0YDsiCAP
   +Z2SF/5o6Jg1uT0zp/AiDmDy5cS6SIMpgXZvwmxeEHedSbp72GIro7WIM
   WJnLPRcK+7J2QiipL6zMRVyauF+6hzsBQffC9NXbZT3/h7tEwjomVrheg
   UW3LoJlsjG/2WgRXIpflL8g64SyZFjlX5m3x6As0KrWyR+EKmmWUfuv62
   uDIk80IV8YnrSovSwO6wR29iELU9BJVykk7/mxAPtKCiTR/tczRTZkH5i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357507675"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400";
   d="scan'208";a="357507675"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 20:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="739769528"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400";
   d="scan'208";a="739769528"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 20:15:38 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 3/4] soundwire: extend parameters of new_peripheral_assigned()
 callback
Date: Wed, 31 May 2023 11:37:35 +0800
Message-Id: <20230531033736.792464-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
References: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Z64HZGMTW3LMHQTKQ4UPKVXNRMVD4BRQ
X-Message-ID-Hash: Z64HZGMTW3LMHQTKQ4UPKVXNRMVD4BRQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z64HZGMTW3LMHQTKQ4UPKVXNRMVD4BRQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The parameters are only the bus and the device number, manager ops may
need additional details on the type of peripheral connected, such as
whether it is wake-capable or not.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c             | 2 +-
 drivers/soundwire/intel_auxdevice.c | 4 +++-
 include/linux/soundwire/sdw.h       | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 6f465cce8369..17b9a8bdf234 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -786,7 +786,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 	slave->dev_num = slave->dev_num_sticky;
 
 	if (bus->ops && bus->ops->new_peripheral_assigned)
-		bus->ops->new_peripheral_assigned(bus, dev_num);
+		bus->ops->new_peripheral_assigned(bus, slave, dev_num);
 
 	return 0;
 }
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 30f3d2ab80fd..c1df6f014e6b 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -60,7 +60,9 @@ static int generic_post_bank_switch(struct sdw_bus *bus)
 	return sdw->link_res->hw_ops->post_bank_switch(sdw);
 }
 
-static void generic_new_peripheral_assigned(struct sdw_bus *bus, int dev_num)
+static void generic_new_peripheral_assigned(struct sdw_bus *bus,
+					    struct sdw_slave *slave,
+					    int dev_num)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 8a7541ac735e..41a856bedf1e 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -861,7 +861,9 @@ struct sdw_master_ops {
 	int (*pre_bank_switch)(struct sdw_bus *bus);
 	int (*post_bank_switch)(struct sdw_bus *bus);
 	u32 (*read_ping_status)(struct sdw_bus *bus);
-	void (*new_peripheral_assigned)(struct sdw_bus *bus, int dev_num);
+	void (*new_peripheral_assigned)(struct sdw_bus *bus,
+					struct sdw_slave *slave,
+					int dev_num);
 };
 
 /**
-- 
2.25.1

