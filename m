Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF96C433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:27:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1932098B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f6GfsGmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1932098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51DFE17E6;
	Tue,  1 Sep 2020 18:26:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51DFE17E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598977655;
	bh=J5dd01A6mRS1PAjdELRfNCwVZ6hMWeaAuSrTwfx4iDw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f6GfsGmdh/rVcEhi5GKnFUDfaD0PpPvfaRKwX+4adWQLMUjfKDi40oWjHsqX6Yms+
	 c3WBjZgGMbc5SMLfd/pMSU3Y7JUcqF8vQyLAwqFq1O44olPY97HeoVWXc6YB93Iz9n
	 dK604WNskGHqf4/PSNVKxfXs0lLtqp3oqeLt/hXI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AADAEF802E0;
	Tue,  1 Sep 2020 18:24:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC6DEF80217; Tue,  1 Sep 2020 18:23:14 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D1F9F8020D
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 18:22:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D1F9F8020D
IronPort-SDR: aQpVOBhQCqFkMjq/VAcqv0ZVRsWeu7JjLGqoyuMOnvWHdqijH4y8JtdpCJmLVa0R+OIhzu80Rs
 QMOJPt/PDdsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="144889300"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; d="scan'208";a="144889300"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 09:22:43 -0700
IronPort-SDR: 0LpA9QvK4HwtJdVRQjORXNDoeWeGP66Is4tii0vMwLlTxwz6gkbGVnUahUUZNdzHMHhiZxjpNU
 EmHMqHW9nlHQ==
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; d="scan'208";a="477261181"
Received: from tracimsx-mobl5.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.252.140.215])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 09:22:41 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/3] regmap: add SoundWire 1.2 MBQ support
Date: Tue,  1 Sep 2020 11:22:22 -0500
Message-Id: <20200901162225.33343-1-pierre-louis.bossart@linux.intel.com>
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

In preparation of the upstream contribution of SDCA (SoundWire Device
Class for Audio) ASoC codec drivers [1] [2], add regmap support
SoundWire 1.2 MBQ support. The MBQ (Multi-Byte Quantity) registers
need to be handled in a different way from regular 8-bit SoundWire
registers, their main application is going to be for volume/gain
controls.

The second patch was initially suggested for inclusion in the
SoundWire tree, and was modified to add more background information on
SDCA in the commit message as requested by Vinod Koul.

Changes since v1:
Rebased on regmap tree (conflict with SPI stuff).
Removed mod_devicetable.h header
Removed -EOPNOTSUPP error codes, use -ENOTSUPP
Added long description of SDCA
Used FIELD_PREP/GET as suggested by Vinod Koul
Added Bard Liao's Acked-by tag.

Pierre-Louis Bossart (3):
  regmap: sdw: add required header files
  soundwire: SDCA: add helper macro to access controls
  regmap: sdw: add support for SoundWire 1.2 MBQ

 drivers/base/regmap/Kconfig             |   6 +-
 drivers/base/regmap/Makefile            |   1 +
 drivers/base/regmap/regmap-sdw-mbq.c    | 101 ++++++++++++++++++++++++
 drivers/base/regmap/regmap-sdw.c        |   2 +
 include/linux/regmap.h                  |  21 +++++
 include/linux/soundwire/sdw_registers.h |  33 ++++++++
 6 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-sdw-mbq.c


base-commit: d17343b87da422a59d99a3ed130573dbeb96c582
-- 
2.25.1

