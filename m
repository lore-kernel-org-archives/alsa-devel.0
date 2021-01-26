Return-Path: <SRS0=d1MO=G5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C59C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 08:39:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C495E22DFB
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 08:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C495E22DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B32E17B3;
	Tue, 26 Jan 2021 09:38:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B32E17B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611650342;
	bh=7qm+aixV+nP9VpFPtrN/jREgIG41bQoriDFD1MYQ8Tw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LqrNxNByOqK1pMGVzj+NpKbgE1NJo3gk2yPpQNAyL3mP8uIfMEaSTVt/Xb+uwFSzr
	 5WLFyARG9wbGFNH6dlfQrPJTGT7DckV+UIVQYMVKBkwBfOLGyRaJ5A5+JNNqTkbu8o
	 uKg6LDXtJP/Ea3B2QuuGNuTuHAVc3LsLwQY+P/hE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 873E2F80130;
	Tue, 26 Jan 2021 09:38:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9CBDEF8020D; Tue, 26 Jan 2021 09:38:08 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3A1AF80130
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2021 09:38:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3A1AF80130
IronPort-SDR: H2S0tN5GYqJEAZUIwqrOf0RMH0sGPVxcg1OuZIQvAxHq1W6IqwCtJOANBTwZgLGIfcR8Xgb8KL
 ixi2jyXfOlGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="198653701"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="198653701"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 00:37:57 -0800
IronPort-SDR: +zyozuRQn8lz0RxRfSC5afVN3ieABG3WvjsYCtO3LcLcwuCoKulEKbGSQMlwIS+Lj7hNH408Ut
 jzvBWKVYTW0Q==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="577731212"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 00:37:53 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 0/3] soundwire: clear bus clash/parity interrupt before the
 mask is enabled
Date: Tue, 26 Jan 2021 16:37:43 +0800
Message-Id: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
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

The SoundWire specification allows a Slave device to report a bus clash
or parity error with the in-band interrupt mechanism.
Unfortunately, on some platforms, these errors are randomly reported and
don't seem to be valid.
This series suggests the addition of a Master level quirk to discard such
interrupts. The quirk should in theory have been added at the Slave level,
but since the problem was detected with different generations of Slave
devices it's hard to point to a specific IP. The problem might also be
board-dependent and hence dealing with a Master quirk is simpler.

Bard Liao (2):
  soundwire: bus: clear bus clash interrupt before the mask is enabled
  soundwire: intel: add SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH quirk

Pierre-Louis Bossart (1):
  soundwire: bus: clear parity interrupt before the mask is enabled

 drivers/soundwire/bus.c       | 19 +++++++++++++++++++
 drivers/soundwire/intel.c     |  3 +++
 include/linux/soundwire/sdw.h |  5 +++++
 3 files changed, 27 insertions(+)

-- 
2.17.1

