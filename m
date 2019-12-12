Return-Path: <SRS0=r47B=2C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D99C43603
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:48:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF23820652
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Qf4vq1qI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF23820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A85F167D;
	Thu, 12 Dec 2019 02:47:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A85F167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576115318;
	bh=I8JVCpXzQYPtcGOQsqtMrjfTrLARqxcEMhmI6z6sxkI=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qf4vq1qIJ2qeU0hEFozUyDQT3KLW63ONaQSqanMYD6j9DF4HbvHYM5jYqub9cEV/F
	 5NQaOy5+bsOW9z+I3wD/27OAWHHYimzFL2ndIeaB4Uq9bEDydk9jGeQMjrR9/G15Xi
	 mrGl5WCKFYz1wbYlNYLVdVhactsTHV0D/0YsbM+c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C3A8F80264;
	Thu, 12 Dec 2019 02:45:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37B7CF80256; Thu, 12 Dec 2019 02:45:25 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35BD1F800EC
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 02:45:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35BD1F800EC
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Dec 2019 17:45:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; d="scan'208";a="296446070"
Received: from gjang-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.252.207.37])
 by orsmga001.jf.intel.com with ESMTP; 11 Dec 2019 17:45:16 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed, 11 Dec 2019 19:44:59 -0600
Message-Id: <20191212014507.28050-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
References: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v5 03/11] soundwire: sdw_slave: add
	initialization_complete definition
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Slave drivers may have different ways of handling their settings, with
or without regmap.

During the integration of codec drivers, done in partnership between
Intel and Realtek, it became desirable to implement a predictable
order between low-level initializations performed in .update_status()
(invoked by an interrupt thread) and the settings restored in the
resume steps (invoked by the PM core).

This patch builds on the previous solution to wait for the Slave
device to be fully enumerated. The complete() in this case is signaled
not before the .update_status() is called, but after .update_status()
returns. Without this patch, the settings were not properly restored,
leading to timing-dependent 'no sound after resume' or 'no headset
detected after resume' bug reports.

Depending on how initialization is handled, a Slave device driver may
wait for enumeration_complete, or for initialization_complete, both
are valid synchronization points. They are initialized at the same
time, they only differ on when complete() is invoked.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 3fa8d875b16b..ed42cd79eab7 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -554,6 +554,8 @@ struct sdw_slave_ops {
  * @enumeration_complete: completion utility to control potential races
  * on startup between device enumeration and read/write access to the
  * Slave device
+ * @initialization_complete: completion utility to control potential races
+ * on startup between device enumeration and settings being restored
  */
 struct sdw_slave {
 	struct sdw_slave_id id;
@@ -571,6 +573,7 @@ struct sdw_slave {
 	bool probed;
 	struct completion probe_complete;
 	struct completion enumeration_complete;
+	struct completion initialization_complete;
 };
 
 #define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
