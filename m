Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6A3C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:31:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CA22085B
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DYo1GogN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CA22085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA45E1785;
	Wed, 24 Jun 2020 07:30:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA45E1785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592976662;
	bh=FJoub8v6sXWboMFrZjj+KXKF7PNKx4OIeueczFfMzjk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DYo1GogNPOcnD8gZ8tLmRgd3R+6dHkls6xXuRFEUv8DEF1zHddadfnW4P6jHzGWen
	 Rab7eUdqhqM7C9wh67RdURN8AoLLFZz3hZ5U7H3G4CHLTN3LF+vs93BZ41L+L6BSES
	 jHse9HoTqrFSxg/RjLxfWUB37sjnz3Q+AJbP9m3k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76288F8015B;
	Wed, 24 Jun 2020 07:30:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C00EF801DB; Wed, 24 Jun 2020 07:30:08 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8475AF8012F
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 07:30:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8475AF8012F
IronPort-SDR: Gpf9jnw8m6q3z+EsLuXYE7zST+UG/u8Ypiwx/AZgcar00QxeyIk+XS24ofoTkMLDjLBW6enl18
 tRe3rEyKXC7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="131775824"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="131775824"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 22:29:58 -0700
IronPort-SDR: 14rUsAqnY/CsCOHKN/2Q+3sVDWQksR/qZ5io6U8OjRUBlKWILaXzuZVtw8LVDrUI8SDZm6AjoG
 NwOju7NG6ALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="452513215"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 22:29:54 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 0/9] soundwire: intel: revisit SHIM programming
Date: Wed, 24 Jun 2020 01:35:37 +0800
Message-Id: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
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

This series does some cleanup, revisits SHIM programming sequences,
and merges Soundwire interrupt handlers/threads.

Bard Liao (2):
  soundwire: intel/cadence: merge Soundwire interrupt handlers/threads
  Soundwire: intel_init: save Slave(s) _ADR info in sdw_intel_ctx

Pierre-Louis Bossart (6):
  soundwire: intel: reuse code for wait loops to set/clear bits
  soundwire: intel: revisit SHIM programming sequences.
  soundwire: intel: introduce a helper to arm link synchronization
  soundwire: intel: introduce helper for link synchronization
  soundwire: intel_init: add implementation of sdw_intel_enable_irq()
  soundwire: intel_init: use EXPORT_SYMBOL_NS

Rander Wang (1):
  soundwire: intel: add wake interrupt support

 drivers/soundwire/cadence_master.c  |  18 +-
 drivers/soundwire/cadence_master.h  |   4 +
 drivers/soundwire/intel.c           | 389 ++++++++++++++++++++++------
 drivers/soundwire/intel.h           |   9 +
 drivers/soundwire/intel_init.c      | 101 +++++++-
 include/linux/soundwire/sdw_intel.h |   2 +
 6 files changed, 425 insertions(+), 98 deletions(-)

-- 
2.17.1

