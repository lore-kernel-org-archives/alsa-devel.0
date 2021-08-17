Return-Path: <SRS0=htQG=NI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565B2C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 19:03:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386F960FBF
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 19:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 386F960FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0F7D1672;
	Tue, 17 Aug 2021 21:02:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0F7D1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629227006;
	bh=UJVy7bw6a3CMbYJsNbFzfoqqRW2aI5YEmnqMNFvQ758=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ue+s7M1Q5gSErSCl03oPtOPTCWw95kPF8oTr0V8cdMV3eJY0Gk5fSb+x7o0ug/bvE
	 I7VGvTphue7FHBlfuWA7oQAvvnKkwfKPVF72R7xsc0xJT2ZCWYxveuAi5H7AYagn1p
	 tPu2lVjjag0kR/mPoJCXQqg0+VS/TkP97LaFsomM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 773EEF80272;
	Tue, 17 Aug 2021 21:01:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FEC7F804B0; Tue, 17 Aug 2021 21:01:45 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CDD6F8026D
 for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2021 21:01:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CDD6F8026D
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="215898769"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; d="scan'208";a="215898769"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2021 12:01:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; d="scan'208";a="488147342"
Received: from aaadelek-mobl3.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.12.89])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2021 12:01:31 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 1/2] driver core: export driver_deferred_probe_trigger()
Date: Tue, 17 Aug 2021 14:00:56 -0500
Message-Id: <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, tiwai@suse.de,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
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

The premise of the deferred probe implementation is that a successful
driver binding is a proxy for the resources provided by this driver
becoming available. While this is a correct assumption in most of the
cases, there are exceptions to the rule such as

a) the use of request_firmware_nowait(). In this case, the resources
may become available when the 'cont' callback completes, for example
when if the firmware needs to be downloaded and executed on a SoC
core or DSP.

b) a split implementation of the probe with a workqueue when one or
ore request_module() calls are required: a synchronous probe prevents
other drivers from probing, impacting boot time, and an async probe is
not allowed to avoid a deadlock. This is the case on all Intel audio
platforms, with request_module() being required for the i915 display
audio and HDaudio external codecs.

In these cases, there is no way to notify the deferred probe
infrastructure of the enablement of resources after the driver
binding.

The driver_deferred_probe_trigger() function is currently used
'anytime a driver is successfully bound to a device', this patch
suggest exporing by exporting it so that drivers can kick-off
re-probing of deferred devices at the end of a deferred processing.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/dd.c             | 3 ++-
 include/linux/device/driver.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 437cd61343b2..33eca45aa65a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -171,7 +171,7 @@ static bool driver_deferred_probe_enable = false;
  * changes in the midst of a probe, then deferred processing should be triggered
  * again.
  */
-static void driver_deferred_probe_trigger(void)
+void driver_deferred_probe_trigger(void)
 {
 	if (!driver_deferred_probe_enable)
 		return;
@@ -193,6 +193,7 @@ static void driver_deferred_probe_trigger(void)
 	 */
 	queue_work(system_unbound_wq, &deferred_probe_work);
 }
+EXPORT_SYMBOL_GPL(driver_deferred_probe_trigger);
 
 /**
  * device_block_probing() - Block/defer device's probes
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index a498ebcf4993..2eec79d752a9 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -240,6 +240,7 @@ extern int driver_deferred_probe_timeout;
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 void driver_init(void);
+void driver_deferred_probe_trigger(void);
 
 /**
  * module_driver() - Helper macro for drivers that don't do anything
-- 
2.25.1

