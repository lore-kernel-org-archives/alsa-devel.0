Return-Path: <SRS0=rARa=DB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0529C4363D
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:45:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE99F206FB
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fLHnxMzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE99F206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED6001807;
	Thu, 24 Sep 2020 21:44:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED6001807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600976748;
	bh=I8iNOIAO8F5bV8hkyP219mFuQBBM2f3ZW71kNhbYPM4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fLHnxMzLFlL1dykoyc04LdLlMbINIVpn+NF+1rE/KGGVNzqpWuVqdfGpDQYirdeZM
	 CelR0s/j8LlNUS7HkGk24ZZXC9iVcCehhEgldmHog+wcjDdT1FGISOn2AIISe86QqG
	 lzz50aJQp0a/Q0rqAhueslHF3jjBM9c3LUfRh3zM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 599E9F800B4;
	Thu, 24 Sep 2020 21:44:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3750EF8023E; Thu, 24 Sep 2020 21:44:56 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC2B6F800B4
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2020 21:44:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC2B6F800B4
IronPort-SDR: BYxZ3sUeRmwn+OXxQiQSbDkVcqwj/V0KtRJ93MnosuIC463L7PLD7sE2HRrc+8xR8OYXsiJYjb
 G5kWfQe3SzTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="141336257"
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; d="scan'208";a="141336257"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 12:44:43 -0700
IronPort-SDR: Svwdl09qs7sVzBDijdWPPh2bDR1vhqI2Kd17Cf3yOTWw3lhyTizPHv1hh7jwEItmujgaZsa888
 9KKvkJ2i3WHw==
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; d="scan'208";a="291360627"
Received: from inwhanki-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.115.252])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 12:44:41 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org,
	srinivas.kandagatla@linaro.org
Subject: [PATCH v3 0/2] soundwire: sysfs: expose device number and status
Date: Thu, 24 Sep 2020 14:44:28 -0500
Message-Id: <20200924194430.121058-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, gregkh@linuxfoundation.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>,
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

This patchset combines three contributions:

Srinivas Kandagalta suggested creating a device even it's detected on
the bus but not described in platform firmware. I suggested adding the
device number and status to show the difference with 'ghost' devices,
described in firmware but not physically present. Vinod suggested a
simpler way to report the status.

I did not keep Vinod's patch separate since it was using the same
group attribute as the other properties, which prevents status and
device number from being reported if there is no firmware and no
driver.

These patches were tested on Qualcomm and Intel platforms.

v3: add Co-developed-by tags and move 'status' and 'device_number' to
device level instead of a dev-status directory.

v2: as suggested by GregKH, add attribute group by default by setting
the groups pointer at the device level.

Pierre-Louis Bossart (1):
  soundwire: sysfs: add slave status and device number before probe

Srinivas Kandagatla (1):
  soundwire: bus: add enumerated Slave device to device list

 .../ABI/testing/sysfs-bus-soundwire-slave     | 18 ++++++
 drivers/soundwire/bus.c                       |  9 +++
 drivers/soundwire/bus.h                       |  2 +
 drivers/soundwire/bus_type.c                  |  9 +++
 drivers/soundwire/slave.c                     |  6 +-
 drivers/soundwire/sysfs_local.h               |  4 ++
 drivers/soundwire/sysfs_slave.c               | 58 ++++++++++++++++++-
 7 files changed, 103 insertions(+), 3 deletions(-)

-- 
2.25.1

