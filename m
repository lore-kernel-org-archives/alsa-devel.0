Return-Path: <SRS0=hLTZ=7B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AD5C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 05:42:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB8B2075F
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 05:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B70suoeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB8B2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEF3D17D3;
	Tue, 19 May 2020 07:41:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEF3D17D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589866925;
	bh=AKqRxWb2ky8aioMfXcwVpba06MKB1Sr/AGTl8wT1oQg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B70suoeYPjVYiBL6dMYGgXAzRAUwN11gzIcFz67Bx+DZCr3tXT8K7MjJpztsD3kH8
	 Z16hwcLG7UoFC5+s/OPHE/XJitq4VNefDrxeP9q0W1OJbqowtBeWVm6kBMfuRD25cc
	 4kuvJBEaoEKxoc/fzJwmawqP9gVe47l+p1XgLxmk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82A70F802A9;
	Tue, 19 May 2020 07:38:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D65FAF802A2; Tue, 19 May 2020 07:38:44 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 972FEF800C9
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2020 07:38:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 972FEF800C9
IronPort-SDR: ke2pNKSNbxou8S/QjtYhjMJSK1mVOAoQH42TUnaYJ9+AAHlNRsi0EnQLu5VP37xJVLM8GX51aA
 hWs0KUU4qSRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2020 22:38:34 -0700
IronPort-SDR: rprKud2ASA/3Nc7i0qLhTHu3lEEKQpIJh3WEGfILRP9ubQiQVmzCkXJtlbDjxKz5a5DwoWHZ8V
 AMAaCIhloYXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; d="scan'208";a="288836611"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga004.fm.intel.com with ESMTP; 18 May 2020 22:38:30 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 5/5] soundwire: master: add runtime pm support
Date: Tue, 19 May 2020 01:43:22 +0800
Message-Id: <20200518174322.31561-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
References: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

We need to enable runtime_pm on master device with generic helpers,
so that a Slave-initiated wake is propagated to the bus parent.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/master.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 6be0a027def7..5411791e6aff 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -3,6 +3,7 @@
 
 #include <linux/device.h>
 #include <linux/acpi.h>
+#include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
 #include "bus.h"
@@ -14,9 +15,15 @@ static void sdw_master_device_release(struct device *dev)
 	kfree(md);
 }
 
+static const struct dev_pm_ops master_dev_pm = {
+	SET_RUNTIME_PM_OPS(pm_generic_runtime_suspend,
+			   pm_generic_runtime_resume, NULL)
+};
+
 struct device_type sdw_master_type = {
 	.name =		"soundwire_master",
 	.release =	sdw_master_device_release,
+	.pm = &master_dev_pm,
 };
 
 /**
-- 
2.17.1

