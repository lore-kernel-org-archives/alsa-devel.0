Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D22AC4332D
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:33:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18ED2076F
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RtqBFbvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18ED2076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3729F166A;
	Fri, 20 Mar 2020 17:32:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3729F166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584722019;
	bh=J26EJoDY2foVZeV69u60FY3d29bcQYnGQfEI4pzYNOs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RtqBFbvw2jeA7YANaNuJ77hYJPhbyGMf5RlT2I1cTVucNjx9CzhVT4jpPFWbLbX8L
	 VuCUW1ZlKZ32pMeBcgfmbI1yDvJHs0DPA46Im1pCzT+rQYXvzK27MH9ZXeHh7CEugi
	 FzpVxRlk4r+AAFWoUukE6bFTC2h5Y3IesAralFQs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B59B0F802A7;
	Fri, 20 Mar 2020 17:30:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79FEFF8028B; Fri, 20 Mar 2020 17:30:19 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E365F80256
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 17:30:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E365F80256
IronPort-SDR: NkETo/rDSG5G3+MLCJXXFiBhxBadthagHSiCZhPc5QMO6wEUnFb2Ig8aChrRrK/R+65gQyVGUn
 z4+liVHo7cDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 09:30:09 -0700
IronPort-SDR: 6bn7FFdVrLHJSMqkvB+QYysCZhQCP4T0EM+s/wzOq5LaGg6kRWWemKKPKJXJ/u3PWOPgh9/AF8
 lnAS982dP7WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; d="scan'208";a="248930955"
Received: from manallet-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.34.12])
 by orsmga006.jf.intel.com with ESMTP; 20 Mar 2020 09:30:06 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/5] soundwire: master: use device node pointer from master
 device
Date: Fri, 20 Mar 2020 11:29:45 -0500
Message-Id: <20200320162947.17663-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
References: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

device_node pointer is required for scanning slave devices, update
it from the master device.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index fbfa1c35137d..817ad434d4af 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -51,6 +51,7 @@ struct sdw_master_device
 	init_completion(&md->probe_complete);
 
 	md->dev.parent = parent;
+	md->dev.of_node = parent->of_node;
 	md->dev.fwnode = fwnode;
 	md->dev.bus = &sdw_bus_type;
 	md->dev.type = &sdw_master_type;
-- 
2.20.1

