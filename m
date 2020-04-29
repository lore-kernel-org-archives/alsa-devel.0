Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192D2C83001
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:48:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F9F21775
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OZeS/cfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F9F21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A7691680;
	Thu, 30 Apr 2020 08:47:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A7691680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588229327;
	bh=mu8tOR/H3Sfr06VShFUOXEqDy87jSPLIxZJEB8xB6kE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OZeS/cfeBTGtigqgGH6wev/d9SKRtXlVB/jlXUG65akfcEtgW00OSHyPeHYadnuON
	 JlugDY5+j2tAgbiEO6psSFutIH53P5V9gfdnfyNQ9ULtWd8npbKrafK9bx3g83+zLg
	 ihl9N32yY8YgA3aFTGyZekwXe0EGmBuBH9PK+c4o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73580F80290;
	Thu, 30 Apr 2020 08:46:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B51C2F80290; Thu, 30 Apr 2020 08:46:52 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB58AF8028D
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 08:46:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB58AF8028D
IronPort-SDR: FQMz+qY5pjQFiGeTupSEZ5ly9/Z3sXtvVjAURp2zztePQFMUZEiWCyFKOzab9EBbElDYhET7PA
 WAaG02gCurDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 23:46:34 -0700
IronPort-SDR: FLINvBnF6DVGFZNPKgQvB8JdisnVaRhTTCrQJRjw80Tuoy3qF63OT7zCc13sCEiU4bykvJy6Li
 aLeD2FnvNhcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; d="scan'208";a="249662772"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2020 23:46:30 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 0/3] soundwire: bus_type: add sdw_master_device support
Date: Thu, 30 Apr 2020 02:51:42 +0800
Message-Id: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
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

This series adds sdw master devices support.

Pierre-Louis Bossart (3):
  soundwire: bus: rename sdw_bus_master_add/delete, add arguments
  soundwire: bus_type: introduce sdw_slave_type and sdw_master_type
  soundwire: bus_type: add sdw_master_device support

 .../driver-api/soundwire/summary.rst          |  7 +-
 drivers/soundwire/Makefile                    |  2 +-
 drivers/soundwire/bus.c                       | 27 ++++---
 drivers/soundwire/bus.h                       |  3 +
 drivers/soundwire/bus_type.c                  | 19 +++--
 drivers/soundwire/intel.c                     |  9 ++-
 drivers/soundwire/master.c                    | 79 +++++++++++++++++++
 drivers/soundwire/qcom.c                      |  7 +-
 drivers/soundwire/slave.c                     |  8 +-
 include/linux/soundwire/sdw.h                 | 22 +++++-
 include/linux/soundwire/sdw_type.h            |  9 ++-
 11 files changed, 160 insertions(+), 32 deletions(-)
 create mode 100644 drivers/soundwire/master.c

-- 
2.17.1

