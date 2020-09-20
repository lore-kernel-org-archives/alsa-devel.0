Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB1DC43463
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:26:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8221720809
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b72WvmOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8221720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7160D1664;
	Mon, 21 Sep 2020 09:26:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7160D1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600673214;
	bh=l0IHsGCDDq7MZZKUOSWe1EH9MsI31n3TaCeBCt60tvQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b72WvmOSHNbqt36tTpbrjkorThBDYgdwI+VwHEk70iOsa2Ju3R1Vqdqp1tpRVvxmW
	 lEPWKXxJ4m1aGMj0Lb7rsEdWTZ7n5MoJ5/T56X+8h54wa4/SLU8ZYd6XU/3RSSvhRT
	 Ts/v/DIe0ZjzRa4p7fMk++X9vSN2PFBJaVNclCHk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FBF8F80161;
	Mon, 21 Sep 2020 09:26:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D40CF8020B; Mon, 21 Sep 2020 09:26:00 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06CA2F8010A
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 09:25:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06CA2F8010A
IronPort-SDR: gZ1oW265i8ira/ZR+F/mw2MuO+FRpQxODJqF2/sCKB0zYyDeCQ/9s+mP8tb6Igue2tRLRlGFA9
 X+vZaAlCn35g==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="139824314"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="139824314"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 00:25:47 -0700
IronPort-SDR: XuY87G/blZLuUuWCPRFOxUsjWco43PVQqg3IOA1Ug9z0CYrfG76ZjEKGkriS5w7ZVT9V20CWOh
 4+Dr/N12P55w==
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="485325626"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 00:25:43 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 0/3] soundwire: enable Data Port test modes
Date: Mon, 21 Sep 2020 03:32:04 +0800
Message-Id: <20200920193207.31241-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

Test modes are required for all SoundWire IP, and help debug
integration issues. This series adds debugfs support and data
port test fail interrupt to enable data port test mode feature
on Intel platforms. 

Pierre-Louis Bossart (3):
  soundwire: enable Data Port test modes
  soundwire: intel: enable test modes
  soundwire: cadence: add data port test fail interrupt

 drivers/soundwire/bus.c                       |  6 +++
 drivers/soundwire/cadence_master.c            | 27 ++++++++++--
 .../soundwire/generic_bandwidth_allocation.c  |  6 ++-
 drivers/soundwire/intel.c                     | 42 +++++++++++++++++++
 drivers/soundwire/stream.c                    |  3 +-
 include/linux/soundwire/sdw.h                 |  6 +++
 6 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.17.1

