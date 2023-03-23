Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBDEC6FD1C
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Mar 2023 05:36:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8651ECB;
	Thu, 23 Mar 2023 06:36:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8651ECB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679549816;
	bh=q80CBcxn2QOQK8sFpcJ2zT5Gn5sp4JMMdHxIOJazfZ4=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fBkR91WqBTS7iKHlRhU77cF5UclSZe03L1BQjZOmbzuj3vpBfX2PeEfl9R6rXJuir
	 HRw2cUi/9BhklvUnxU6mYMKr/TKnFmBBgh/hQNOlADTAXlD2IyetIVgKzUi1LU86Dc
	 PcZuvlJd6hnLYe0AoHJsHeRRc2JVKfoRYsVukU/E=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E77A8F805A0;
	Thu, 23 Mar 2023 06:33:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D02CDF804FE; Thu, 23 Mar 2023 06:31:09 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3CA94F80544
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2023 06:30:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CA94F80544
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mDIgIF2W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549435; x=1711085435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q80CBcxn2QOQK8sFpcJ2zT5Gn5sp4JMMdHxIOJazfZ4=;
  b=mDIgIF2WAxRw7k+ZJksiLT71c3C6WtbfQucyIOmvrZrLb3lgvMMdtHgq
   rln809ZNHJikhGQn1nQa7CqokTqapKAGWySZP3Y3nOVFrMXYhiwqP+tMO
   nB7rXa1KEbfX0iHu5y9sZntyO7hqsbKWfHKwHvDnS/DnrCEV8osEpVMmF
   ASmgUOSCqp6pYJwCRasp60AXMN+x8wAAeY8w+crytPazr5sbohGw3zQDD
   28WYkcfpdJFnsrlppAyLrwwYQuQEGyPr9oKJwDpFczQnUraRcDJ5Xm4+H
   dXghyHpT7iI0MaXRN1l1H8NUYSXBS0doB2Dajf3u6TGjFtUx5LANmnYbK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779470"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400";
   d="scan'208";a="327779470"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2023 22:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567220"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400";
   d="scan'208";a="675567220"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2023 22:30:28 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org,
	broonie@kernel.org
Subject: [PATCH 16/20] soundwire: intel_ace2x: use common helpers for bus
 start/stop
Date: Thu, 23 Mar 2023 13:44:48 +0800
Message-Id: <20230323054452.1543233-17-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WT2ZYD7NRE5KJJ5BJN6YTKLSKHRJLDLZ
X-Message-ID-Hash: WT2ZYD7NRE5KJJ5BJN6YTKLSKHRJLDLZ
X-MailFrom: yung-chuan.liao@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com, tiwai@suse.de
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WT2ZYD7NRE5KJJ5BJN6YTKLSKHRJLDLZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The sequences are so far identical, so the abstraction is a bit
over-engineered. In time we will simplify if there is no need to
special case or work-around programming sequences.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 20b8806f7de6..2e33e8a00b55 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -316,6 +316,12 @@ const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 
 	.register_dai = intel_register_dai,
 
+	.check_clock_stop = intel_check_clock_stop,
+	.start_bus = intel_start_bus,
+	.start_bus_after_reset = intel_start_bus_after_reset,
+	.start_bus_after_clock_stop = intel_start_bus_after_clock_stop,
+	.stop_bus = intel_stop_bus,
+
 	.link_power_up = intel_link_power_up,
 	.link_power_down = intel_link_power_down,
 
-- 
2.25.1

