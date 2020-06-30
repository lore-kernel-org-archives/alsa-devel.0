Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F5CC433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 06:39:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837AC20747
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 06:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qk9Iv9WF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837AC20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE8FC1663;
	Wed,  1 Jul 2020 08:38:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE8FC1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593585562;
	bh=G4YiaCk95eDDc2xb8Br5dHrqUMDLAdHos1RlGqX/yPg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qk9Iv9WFl+ej/Vl9XiUPI+OvyrzuXl92rUgWwpOIjdk3N+Pik2l+h3ILb8g8ehSjH
	 ceIJI6XbGpKfj4kSno8xhI6SEGO4sGaCcUIOhQSBNjoRZ2eNbI7aWt9zFiy/DWOT/+
	 mOXbf6GFvw7wAYTBxzD6ozvUev7o4k5L/BUbO/ks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DE3AF80217;
	Wed,  1 Jul 2020 08:38:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7041F8021D; Wed,  1 Jul 2020 08:38:29 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02509F801D8
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 08:38:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02509F801D8
IronPort-SDR: fv8PNkQ+qwe2hFX33KIqW1E/y9EHSq7043rxkV4Ae1UTx4TAqId/PyagBaYCdQOkl8x0mLGR25
 tQ4brpSIlcTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="126109900"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; d="scan'208";a="126109900"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 23:38:20 -0700
IronPort-SDR: ToSCKp88eW9y02/v3lQVp5dgFcLZuDbjRIsnu2UT/WB68T7ZgGXPl9jsU/wQhnf0lnAXodnlK7
 ousKrBw0A8gA==
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; d="scan'208";a="454946463"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 23:38:16 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 0/5] soundwire: handle stream at the dailink level
Date: Wed,  1 Jul 2020 02:43:51 +0800
Message-Id: <20200630184356.24939-1-yung-chuan.liao@linux.intel.com>
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

Currently, stream is handled at the dai level. But we have to handle
stream at the dailink level in the multi-cpu dailink usage.

changes in v2:
 - Add kernel doc
 - Use single line trace log

Pierre-Louis Bossart (5):
  soundwire: intel: implement get_sdw_stream() operations
  soundwire: stream: add helper to startup/shutdown streams
  soundwire: intel: remove stream allocation/free
  soundwire: cadence: allocate/free dma_data in set_sdw_stream
  soundwire: intel: don't free dma_data in DAI shutdown

 Documentation/driver-api/soundwire/stream.rst | 11 ++-
 drivers/soundwire/cadence_master.c            | 52 +++++++---
 drivers/soundwire/intel.c                     | 82 ++++------------
 drivers/soundwire/stream.c                    | 98 +++++++++++++++++++
 include/linux/soundwire/sdw.h                 |  2 +
 5 files changed, 167 insertions(+), 78 deletions(-)

-- 
2.17.1

