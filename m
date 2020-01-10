Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F82C282DD
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 22:03:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D89C2082E
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 22:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vJZLg/UZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D89C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A5FD16CA;
	Fri, 10 Jan 2020 23:02:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A5FD16CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578693787;
	bh=hjHskpA2bgMh7lpBHELxoh6yCnRvJhr4Oi3phU7bsxU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vJZLg/UZo9ovvU7pYaoc2Yx0JJa1FLOOosWgmLRnardUTk937kuE/VM3lzREtjsxT
	 MJ4jlhPtP8uIWJmL+eeIJmk5uFhi62kSaVSily1doNzI42WbcYatJNOZ0tZ0KGmEjm
	 hFGEqKeUyNQ//t0lK+xFQYfdZYGMBVzg1UiTghyY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0149F802A1;
	Fri, 10 Jan 2020 22:57:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7334F80277; Fri, 10 Jan 2020 22:57:52 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEF2FF80246
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 22:57:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BEF2FF80246
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 13:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; d="scan'208";a="218782809"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com)
 ([10.254.183.94])
 by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2020 13:57:45 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 10 Jan 2020 15:57:31 -0600
Message-Id: <20200110215731.30747-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
References: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH 6/6] soundwire: bus: check first if Slaves
	become UNATTACHED
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

Before checking for the presence of Device0, we first need to clean-up
the internal state of Slaves that are no longer attached.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index be5d437058ed..66fd09e36b73 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -979,6 +979,24 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 	struct sdw_slave *slave;
 	int i, ret = 0;
 
+	/* first check if any Slaves fell off the bus */
+	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
+		mutex_lock(&bus->bus_lock);
+		if (test_bit(i, bus->assigned) == false) {
+			mutex_unlock(&bus->bus_lock);
+			continue;
+		}
+		mutex_unlock(&bus->bus_lock);
+
+		slave = sdw_get_slave(bus, i);
+		if (!slave)
+			continue;
+
+		if (status[i] == SDW_SLAVE_UNATTACHED &&
+		    slave->status != SDW_SLAVE_UNATTACHED)
+			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
+	}
+
 	if (status[0] == SDW_SLAVE_ATTACHED) {
 		dev_dbg(bus->dev, "Slave attached, programming device number\n");
 		ret = sdw_program_device_num(bus);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
