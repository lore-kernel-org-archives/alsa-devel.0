Return-Path: <SRS0=1fsy=7W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809DEC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:51:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18A22078D
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bJcFIL2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18A22078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CDC6168C;
	Tue,  9 Jun 2020 10:50:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CDC6168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591692659;
	bh=KQaWDyFudnl3sObg2y3IZDmMHkxvnwPAmhZd8vHFfqg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bJcFIL2+nJ2mIJ+opom4whQVEEw6Pbk3nDUOq4/9bEXzgcYVGtFIXTDuUtffa26lh
	 FHQN0e78kaZzMR1KRedjG59nvQIgDGSTk73Pq17uIa6cQx8F4cgpg0sG2YlhLXc9Ir
	 SFCKqJnXf/jEt9BEe4uUd+8M1xahaH3Op4a2bKuU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B12F6F80299;
	Tue,  9 Jun 2020 10:49:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B20CF8028C; Tue,  9 Jun 2020 10:49:17 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79979F8028C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 10:49:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79979F8028C
IronPort-SDR: GVQn+Uy7Q6PvgB2JKI6eaujROAn7/JrxKXczmUFj6LegiZu27EFb4ODpXO7dNO1zLGMcXEnJNq
 usnZ7NZZhxGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2020 01:48:52 -0700
IronPort-SDR: 7yonVY59kWE9uNCVidUEnpiMFOD+LWoHztW5Cj8cuLFu7pz7NBubQir4W+6VvfUuYtyt+jAFvo
 m/lzNksQuAjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; d="scan'208";a="473001803"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2020 01:48:47 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 0/4] soundwire: add SoundWire 1.2 spec support
Date: Tue,  9 Jun 2020 04:54:32 +0800
Message-Id: <20200608205436.2402-1-yung-chuan.liao@linux.intel.com>
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

This series adds basic support for SoundWire 1.2.

Pierre-Louis Bossart (4):
  soundwire: add definitions for 1.2 spec
  soundwire: bus_type: convert open-coded while() to for() loop
  soundwire: extend SDW_SLAVE_ENTRY
  soundwire: bus: initialize bus clock base and scale registers

 drivers/soundwire/bus.c                 | 107 ++++++++++++++++++++++
 drivers/soundwire/bus_type.c            |  19 ++--
 include/linux/mod_devicetable.h         |   2 +
 include/linux/soundwire/sdw.h           |  11 ++-
 include/linux/soundwire/sdw_registers.h | 117 +++++++++++++++++++++++-
 scripts/mod/devicetable-offsets.c       |   2 +
 scripts/mod/file2alias.c                |   6 +-
 7 files changed, 250 insertions(+), 14 deletions(-)

-- 
2.17.1

