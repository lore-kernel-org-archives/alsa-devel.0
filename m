Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF107C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 21:09:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7726E21775
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 21:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SagqP2O8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7726E21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8863B1670;
	Tue, 17 Dec 2019 22:08:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8863B1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576616962;
	bh=NAfFwxZQwGqR4qeM8hxwmul27yM+QKLbE8aVEx665Jw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SagqP2O8LSPwjfSLDIyu7T1PgcFqHr959NGiBuIZvds2svPRYEAghMWnuElMw+xFY
	 OJneisk4taHHbdxj6TPpmpG2W0lIlHMjvqjufMszs9GpoHjUQe8A+gAv5w3tLa8lLS
	 mUPuPKgQ2/PyIeYaXxM5MykRwhZJhfS671lQbZNA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16446F802A9;
	Tue, 17 Dec 2019 22:03:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD656F80273; Tue, 17 Dec 2019 22:03:36 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EFDFF80100
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 22:03:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EFDFF80100
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 13:03:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; d="scan'208";a="240560978"
Received: from smcdonal-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.83.42])
 by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2019 13:03:28 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 17 Dec 2019 15:03:04 -0600
Message-Id: <20191217210314.20410-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v5 07/17] soundwire: slave: move uevent
	handling to slave device level
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

Currently the .uevent callback is set at the bus level. This is not
necessary, we only really need to deal with uevents for the Slave
device, so move the uevent handling at that level.

Suggested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.h      | 2 ++
 drivers/soundwire/bus_type.c | 3 +--
 drivers/soundwire/slave.c    | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index cb482da914da..be01a5f3d00b 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -6,6 +6,8 @@
 
 #define DEFAULT_BANK_SWITCH_TIMEOUT 3000
 
+int sdw_uevent(struct device *dev, struct kobj_uevent_env *env);
+
 #if IS_ENABLED(CONFIG_ACPI)
 int sdw_acpi_find_slaves(struct sdw_bus *bus);
 #else
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 9719680a1e48..605bc7ae57a8 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -47,7 +47,7 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
 			slave->id.mfg_id, slave->id.part_id);
 }
 
-static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
+int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct sdw_slave *slave;
 	char modalias[32];
@@ -76,7 +76,6 @@ static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
 struct bus_type sdw_bus_type = {
 	.name = "soundwire",
 	.match = sdw_bus_match,
-	.uevent = sdw_uevent,
 };
 EXPORT_SYMBOL_GPL(sdw_bus_type);
 
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index c87267f12a3b..014c3ece1f17 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -17,6 +17,7 @@ static void sdw_slave_release(struct device *dev)
 struct device_type sdw_slave_type = {
 	.name =		"sdw_slave",
 	.release =	sdw_slave_release,
+	.uevent = sdw_uevent,
 };
 
 static int sdw_slave_add(struct sdw_bus *bus,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
