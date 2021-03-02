Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C8FC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 00:35:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 053AE64D73
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 00:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053AE64D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FC101687;
	Tue,  2 Mar 2021 01:34:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FC101687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614645339;
	bh=1BBEp1AYy4S8wPIZGQL8CF3OJ0cELABcaRS2Sd+Dleo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E2cOm5Ot/4O7XHtPMLw8sjCrFp+ECemXQs2yPPuAgACKV7nqBl4NWJg6bDObYDtMB
	 aQDrUupApjO5O2kG+9hpX3MOdcsiLLOws6qQSvITurPz2TALXe7J4tGcPj0hp9b+pX
	 6mFGUo96AyhiBFGL49sqsLirmm9ZsukcPYsCS/so=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D68A7F804C1;
	Tue,  2 Mar 2021 01:31:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B501F80475; Tue,  2 Mar 2021 01:31:57 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C1F6F802E3
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 01:31:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C1F6F802E3
IronPort-SDR: Txw3dNQTk96e0UbtvUFotXyEP8cCvD9SmR29+IyQ7AHU+KDtx0TzvMcbffrWvbttPvn3Sx99hP
 NCtodtPmWMlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="248048806"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="248048806"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 16:31:49 -0800
IronPort-SDR: L/UMQV13GKAqhZb6jfrwzUlHB3hP6RDoc4I3ZjwtcGY/huVG6Js44k9RNP3e14kKskLd+D0sQE
 lm8jVo6CrKDg==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="444512630"
Received: from josemrod-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.215.233])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 16:31:48 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 7/7] ALSA: hda: intel-sdw-acpi: add missing include files
Date: Mon,  1 Mar 2021 18:31:25 -0600
Message-Id: <20210302003125.1178419-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302003125.1178419-1-pierre-louis.bossart@linux.intel.com>
References: <20210302003125.1178419-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, arnd@arndb.de, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, Bard Liao <bard.liao@intel.com>
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

We rely on implicit includes, list out explicitly what this code
relies on.

Suggested-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
---
 sound/hda/intel-sdw-acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/intel-sdw-acpi.c b/sound/hda/intel-sdw-acpi.c
index 6359936a1503..c0123bc31c0d 100644
--- a/sound/hda/intel-sdw-acpi.c
+++ b/sound/hda/intel-sdw-acpi.c
@@ -6,7 +6,12 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/fwnode.h>
 #include <linux/module.h>
 #include <linux/soundwire/sdw_intel.h>
 #include <linux/string.h>
-- 
2.25.1

