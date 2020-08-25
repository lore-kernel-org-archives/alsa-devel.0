Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B225AC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:18:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB7B2075F
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OUGMYsZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB7B2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA7DA1676;
	Tue, 25 Aug 2020 19:17:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA7DA1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598375913;
	bh=P6abe8O2tIpbxEItnlIt2flOT2dr2l6pTLI8HcDvq7I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OUGMYsZcaIWcDA1ucMp9FpPj8u6+gU3/Gup/+yqBToq/GorKa3aGNhbgC6VfcZes0
	 mHzJH6oWvdkd+HcG8/kYbIZokGSl93gWUU8ybNCKu2T/VDCyAomeI5hd/ZQ0+ksBnN
	 CaeAL4nS6ojx69sndPHVFmmFCsvKEJION5tcMFyQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58B7EF80269;
	Tue, 25 Aug 2020 19:17:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1FE6F80269; Tue, 25 Aug 2020 19:17:41 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFA19F80143
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 19:17:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFA19F80143
IronPort-SDR: 0oPmmQ4hbgyv1g4JHdtvgsX+KBaXITA/XvuEfXzJoBYUC+OtjzIXs2thLjp9OXn0r/M+Uj+GAg
 t3nipS1wLMMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="135708942"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; d="scan'208";a="135708942"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 10:17:12 -0700
IronPort-SDR: 3J5sB4kkc2mN1d+nqB4YZ35SH7MpSKKoj/cNPuNppRPv27Ipcoqi3wILTGipjJ7zwU5QWHYHcY
 ZOSzYywA4m9A==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; d="scan'208";a="331478405"
Received: from bgarring-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.4.243])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 10:17:10 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] regmap: add SoundWire 1.2 MBQ support
Date: Tue, 25 Aug 2020 12:16:52 -0500
Message-Id: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
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

In preparation of the upstream contribution of SDCA (SoundWire Device
Class for Audio) ASoC codec drivers [1] [2], add regmap support
SoundWire 1.2 MBQ support. The MBQ (Multi-Byte Quantity) registers
need to be handled in a different way from regular 8-bit SoundWire
registers, their main application is going to be for volume/gain
controls.

The 3rd patch was initially suggested for inclusion in the SoundWire
tree, and was modified to add more background information in the
commit message as requested by Vinod Koul.

Pierre-Louis Bossart (4):
  regmap: sdw: move to -EOPNOTSUPP
  regmap: sdw: add required header files
  soundwire: SDCA: add helper macro to access controls
  regmap: sdw: add support for SoundWire 1.2 MBQ

 drivers/base/regmap/Kconfig             |   6 +-
 drivers/base/regmap/Makefile            |   1 +
 drivers/base/regmap/regmap-sdw-mbq.c    | 102 ++++++++++++++++++++++++
 drivers/base/regmap/regmap-sdw.c        |   8 +-
 include/linux/regmap.h                  |  20 +++++
 include/linux/soundwire/sdw_registers.h |  13 +++
 6 files changed, 146 insertions(+), 4 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-sdw-mbq.c


base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
2.25.1

