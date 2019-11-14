Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A8BC432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:27:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6B9206F0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MH4p56Y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6B9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BD9A168D;
	Thu, 14 Nov 2019 19:26:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BD9A168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573756060;
	bh=dqt2YW24hSMMYXeGUj1GHP3mniG9E00/saKAGRcaiso=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MH4p56Y0oA4j8WdBL/WRcAXCZPk3MOPTf79VISougfow3awrNIAISb7cUBBkQpa/S
	 Fk6vd/hgm6VL4cA0o6uDuT3QOwLP61UiCOFWoXqEfVvRotIfuO28r6Ciqi5C7VqZog
	 Lj59E2liDUSFL0EMKQEHhfRGXeLqTHT90R4FZ2JE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3BC4F80216;
	Thu, 14 Nov 2019 19:18:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0EA9F80130; Thu, 14 Nov 2019 19:18:00 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39AFDF80108
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 19:17:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39AFDF80108
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2019 10:17:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; d="scan'208";a="195123508"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
 by orsmga007.jf.intel.com with ESMTP; 14 Nov 2019 10:17:50 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Thu, 14 Nov 2019 12:16:53 -0600
Message-Id: <20191114181702.22254-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
References: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v3 13/22] soundwire: bus: fix race condition
	with initialization_complete signaling
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

Waiting for the enumeration to be complete may not be enough for a
Slave driver, there is a possible race condition between resume
operations and initializations handled in an interrupt thread, which
can results in settings not being fully restored after system or
pm_runtime resume.

This patch builds on the changes added for enumeration_complete,
init_completion() is called when the Slave device becomes UNATTACHED,
as done with enumeration_complete.

The difference with the enumeration_complete case is that complete()
is signaled after the Slave device is fully initialized after the
.update_status() callback is called.

A Slave device driver can decide to wait on either of the two
complete() cases, depending on its initialization code and
requirements.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c   | 8 ++++++++
 drivers/soundwire/slave.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index e34b5ed534b3..329f35a40649 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -648,6 +648,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 			__func__, slave->dev_num);
 
 		init_completion(&slave->enumeration_complete);
+		init_completion(&slave->initialization_complete);
 
 	} else if (status == SDW_SLAVE_ATTACHED) {
 		dev_dbg(&slave->dev,
@@ -1051,6 +1052,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 {
 	enum sdw_slave_status prev_status;
 	struct sdw_slave *slave;
+	bool attached_initializing;
 	int i, ret = 0;
 
 	/* first check if any Slaves fell off the bus */
@@ -1096,6 +1098,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		if (!slave)
 			continue;
 
+		attached_initializing = false;
+
 		switch (status[i]) {
 		case SDW_SLAVE_UNATTACHED:
 			if (slave->status == SDW_SLAVE_UNATTACHED)
@@ -1122,6 +1126,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			if (prev_status == SDW_SLAVE_ALERT)
 				break;
 
+			attached_initializing = true;
+
 			ret = sdw_initialize_slave(slave);
 			if (ret)
 				dev_err(bus->dev,
@@ -1140,6 +1146,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		if (ret)
 			dev_err(slave->bus->dev,
 				"Update Slave status failed:%d\n", ret);
+		if (attached_initializing)
+			complete(&slave->initialization_complete);
 	}
 
 	return ret;
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 76fdfbd8b50d..d2a952d9bd47 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -53,6 +53,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
 	init_completion(&slave->enumeration_complete);
+	init_completion(&slave->initialization_complete);
 	slave->dev_num = 0;
 	init_completion(&slave->probe_complete);
 	slave->probed = false;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
