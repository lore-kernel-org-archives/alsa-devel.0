Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0CDC3815B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 06:48:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A5B2072B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 06:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mPOR/Rtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A5B2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3A051671;
	Mon, 20 Apr 2020 08:47:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3A051671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587365289;
	bh=UPO63IA0et1J4dPogihqVT364iAzPTcSgK1yZK+KSWo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mPOR/Rtx82R65QVfPbSK+drUyPHoSuHTa+FK2rE9YxY52Kbnu5aB2Jr4+hyOSGnhI
	 U5KtrFt0nbYYKbgnZJrO2V/RTbobZBuDlKwMF++LVEQ3QwjZc6Qg7AhBODONxscbyZ
	 UN3jWkgQwoJDUScGC+3V608AQnAVuEjuDS38fkmk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88894F8025E;
	Mon, 20 Apr 2020 08:46:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57AB1F8020C; Mon, 20 Apr 2020 08:46:23 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0472BF8012F
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 08:46:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0472BF8012F
IronPort-SDR: mzvBz/5DiQB21vKkJlwCPwg25xaLLP2PrJXqKBwRtPss3NxTyOo6BtfdMUsoPCpMLxNV1KETQR
 Rfz1WCjI7bKQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 23:46:14 -0700
IronPort-SDR: kYsZmxlvfHVouUJz0fAMsoxJ/AXjI3zVXW7Ypty2ZvLx/CCneH2fs77gev+QuMC2YYzH7s4JJO
 GD7KISwO7cOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; d="scan'208";a="254845027"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga003.jf.intel.com with ESMTP; 19 Apr 2020 23:46:10 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 2/4] soundwire: slave: don't init debugfs on device
 registration error
Date: Mon, 20 Apr 2020 02:51:15 +0800
Message-Id: <20200419185117.4233-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419185117.4233-1-yung-chuan.liao@linux.intel.com>
References: <20200419185117.4233-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, tiwai@suse.de,
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The error handling flow seems incorrect, there is no reason to try and
add debugfs support if the device registration did not
succeed. Return on error.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/soundwire/slave.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index aace57fae7f8..4bacdb187eab 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -68,6 +68,8 @@ static int sdw_slave_add(struct sdw_bus *bus,
 		list_del(&slave->node);
 		mutex_unlock(&bus->bus_lock);
 		put_device(&slave->dev);
+
+		return ret;
 	}
 	sdw_slave_debugfs_init(slave);
 
-- 
2.17.1

