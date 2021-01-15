Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D100EC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 05:39:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB0A23A23
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 05:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB0A23A23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5135517A8;
	Fri, 15 Jan 2021 06:38:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5135517A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610689181;
	bh=7UUScoDG6HtTKK3D9RmvcMg+7AfbrVDSuUnfys/ewwA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CE2FewxEl3cWOh2dq/tQANWZQCCM0kxtzxb8bnA6yjpzNpL8zkrf3fFKfHIa7ZWTg
	 6FEX+xm7IjdJihVgGvi8WHpqNYOgBdfiAkVzBXvrdvapkJ0OPSOTNm+W9BxARdiIHi
	 bkgYI45YWA4uk4KsfckqYwn4i4Kjh9lGdQ8QE2Dk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17F69F8016D;
	Fri, 15 Jan 2021 06:37:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B90EF8029B; Fri, 15 Jan 2021 06:37:53 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECA56F80113
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 06:37:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECA56F80113
IronPort-SDR: fKwTp407d9vPOf2ZOQjTrG+sIVsD9kQKEEOTl6I5DzU2gsFW3mPAFxIjItxdittHNAeNbbCwBA
 9+s/clItMIvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="240046281"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; d="scan'208";a="240046281"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 21:37:41 -0800
IronPort-SDR: g0hzGoynIz+FAkoIGrwwCuXmSbhF3yQ5TnAYMEaf90rJ3Vq1dBiWDddkCmaKD9z/u5JOLbAn9B
 P+deQjwnk49w==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; d="scan'208";a="382542427"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 21:37:38 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 1/5] soundwire: use consistent format for Slave devID logs
Date: Fri, 15 Jan 2021 13:37:34 +0800
Message-Id: <20210115053738.22630-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
References: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org, jank@cadence.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We mix decimal and hexadecimal values, this leads to confusions in
dmesg logs and bug reports. Let's add a 0x prefix for all hexadecimal
values and a format when more than 4 bits are used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c   |  5 ++---
 drivers/soundwire/slave.c | 10 ++++------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index d1e8c3a54976..3cc006bfae71 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -679,9 +679,8 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
 	id->class_id = SDW_CLASS_ID(addr);
 
 	dev_dbg(bus->dev,
-		"SDW Slave class_id %x, part_id %x, mfg_id %x, unique_id %x, version %x\n",
-				id->class_id, id->part_id, id->mfg_id,
-				id->unique_id, id->sdw_version);
+		"SDW Slave class_id 0x%02x, mfg_id 0x%04x, part_id 0x%04x, unique_id 0x%x, version 0x%x\n",
+		id->class_id, id->mfg_id, id->part_id, id->unique_id, id->sdw_version);
 }
 
 static int sdw_program_device_num(struct sdw_bus *bus)
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index a08f4081c1c4..180f38bd003b 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -163,15 +163,13 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
 
 			if (id.unique_id != id2.unique_id) {
 				dev_dbg(bus->dev,
-					"Valid unique IDs %x %x for Slave mfg %x part %d\n",
-					id.unique_id, id2.unique_id,
-					id.mfg_id, id.part_id);
+					"Valid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
+					id.unique_id, id2.unique_id, id.mfg_id, id.part_id);
 				ignore_unique_id = false;
 			} else {
 				dev_err(bus->dev,
-					"Invalid unique IDs %x %x for Slave mfg %x part %d\n",
-					id.unique_id, id2.unique_id,
-					id.mfg_id, id.part_id);
+					"Invalid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
+					id.unique_id, id2.unique_id, id.mfg_id, id.part_id);
 				return -ENODEV;
 			}
 		}
-- 
2.17.1

