Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78BEC07E95
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 03:23:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F600613AF
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 03:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F600613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5E751681;
	Wed, 14 Jul 2021 05:22:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5E751681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626233009;
	bh=ndpeEnr8jRPyrnNwkyGJKXx2ztLwjgsxzgeBT2mIyU0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qtYzxHu7e/gWrtzJOWtEvqxPDsbcxWGDcGk5/P7l2umIpq7p8IFIVVWc3/xNiK47O
	 DASKbVneMCBbCgqe2c/ZGOTiixtFgYAAarKuz+va99bEoNVSDtX+/4EEfgJ8Y1L/n1
	 pDLhJLIDUZzlzxHzINM5jO/SdwSV7RjmhaaCt+rc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B941F8026D;
	Wed, 14 Jul 2021 05:22:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58023F8025B; Wed, 14 Jul 2021 05:22:34 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4720DF8011C
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 05:22:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4720DF8011C
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="232086408"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; d="scan'208";a="232086408"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2021 20:22:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; d="scan'208";a="459818090"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2021 20:22:19 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 00/10] soundwire/ASoC: add mockup codec support
Date: Wed, 14 Jul 2021 11:21:59 +0800
Message-Id: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 broonie@kernel.org, sanyog.r.kale@intel.com, bard.liao@intel.com
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

Adding mockup SoundWire codec is useful to debug driver/topology changes
without having any actual device connected.

Bard Liao (2):
  soundwire: stream: don't abort bank switch on Command_Ignored/-ENODATA
  soundwire: stream: don't program mockup device ports

Pierre-Louis Bossart (8):
  ASoC: codecs: add SoundWire mockup device support
  ASoC: soc-acpi: cnl: add table for SoundWire mockup devices
  ASoC: soc-acpi: tgl: add table for SoundWire mockup devices
  ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests
  soundwire: add flag to ignore all command/control for mockup devices
  soundwire: bus: squelch error returned by mockup devices
  soundwire: cadence: add debugfs interface for PDI loopbacks
  soundwire: cadence: override PDI configurations to create loopback

 drivers/soundwire/bus.c                       |  10 +-
 drivers/soundwire/cadence_master.c            | 174 ++++++++--
 drivers/soundwire/cadence_master.h            |   3 +
 drivers/soundwire/stream.c                    |   5 +-
 include/linux/soundwire/sdw.h                 |   3 +
 sound/soc/codecs/Kconfig                      |  18 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/sdw-mockup.c                 | 312 ++++++++++++++++++
 sound/soc/intel/boards/Kconfig                |   1 +
 sound/soc/intel/boards/sof_sdw.c              |  41 +++
 sound/soc/intel/common/Makefile               |   3 +-
 .../intel/common/soc-acpi-intel-cnl-match.c   |  15 +
 .../common/soc-acpi-intel-sdw-mockup-match.c  | 166 ++++++++++
 .../common/soc-acpi-intel-sdw-mockup-match.h  |  17 +
 .../intel/common/soc-acpi-intel-tgl-match.c   |  23 ++
 15 files changed, 754 insertions(+), 39 deletions(-)
 create mode 100644 sound/soc/codecs/sdw-mockup.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdw-mockup-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdw-mockup-match.h

-- 
2.17.1

