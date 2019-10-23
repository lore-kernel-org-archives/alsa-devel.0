Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28866C47E49
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:47:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397DA21906
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fGmU/Dgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397DA21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D2651614;
	Wed, 23 Oct 2019 23:46:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D2651614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571867228;
	bh=i8yMob7JDXHwsBoY6dv6YTuRf9w/jwcv5js7nAVzS6E=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fGmU/DgjEnqJOjYVrSCy4M8x4JmzQPsntq47F0H1BlAr8e0Gqv2BAIPEFleehxfX4
	 5LyQGd6ZKRcHnDiBUqsLkKdKiGCNZ5VmP+c1ZygdHcZvioxSTEd1G7llE6TdOdtM5Q
	 ZDCHX23WTG6//mRbYSrG6wD8vSfqdpHrpK9nNows=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A81DF8036F;
	Wed, 23 Oct 2019 23:46:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21DC2F80274; Wed, 23 Oct 2019 23:46:16 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D6FEF80274
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 23:46:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D6FEF80274
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Oct 2019 14:46:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; d="scan'208";a="196908081"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.254.95.208])
 by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 14:46:09 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed, 23 Oct 2019 16:45:43 -0500
Message-Id: <20191023214601.883-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH 00/18] soundwire: code hardening and
	suspend-resume support
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

this patchset applies on top of "[PATCH 00/14] soundwire: intel:
implement new ASoC interfaces". It implements a series of improvements
for:
a) interrupt handling on Intel platforms in MSI mode
b) race conditions on codec probe and enumeration
c) suspend-resume issues (clock-stop mode not supported for now)
d) underflow handling
e) updates to the stream state machine which did not support valid
ALSA transitions.

These patches were tested extensively on 4 different platforms and are
viewed as required for any sort of SoundWire-based product.

Bard Liao (3):
  soundwire: intel/cadence: fix timeouts in MSI mode
  soundwire: stream: only prepare stream when it is configured.
  soundwire: intel: reinitialize IP+DSP in .prepare()

Pierre-Louis Bossart (15):
  soundwire: fix race between driver probe and update_status callback
  soundwire: bus: add PM/no-PM versions of read/write functions
  soundwire: bus: write Slave Device Number without runtime_pm
  soundwire: intel: add helpers for link power down and shim wake
  soundwire: intel: Add basic power management support
  soundwire: intel: add pm_runtime support
  soundwire: intel: reset pm_runtime status during system resume
  soundwire: bus: add helper to reset Slave status to UNATTACHED
  soundwire: intel: call helper to reset Slave states on resume
  soundwire: bus: check first if Slaves become UNATTACHED
  soundwire: add enumeration_complete signaling
  soundwire: intel: disable pm_runtime when removing a master
  soundwire: bus: disable pm_runtime in sdw_slave_delete
  soundwire: stream: update state machine and add state checks
  soundwire: stream: do not update parameters during DISABLED-PREPARED
    transition

 Documentation/driver-api/soundwire/stream.rst |  63 +++-
 drivers/soundwire/bus.c                       | 157 +++++++--
 drivers/soundwire/bus.h                       |   3 +
 drivers/soundwire/bus_type.c                  |   5 +
 drivers/soundwire/cadence_master.c            |  17 +-
 drivers/soundwire/cadence_master.h            |   4 +
 drivers/soundwire/intel.c                     | 328 ++++++++++++++++--
 drivers/soundwire/intel.h                     |   2 +
 drivers/soundwire/intel_init.c                |  45 ++-
 drivers/soundwire/slave.c                     |   3 +
 drivers/soundwire/stream.c                    |  64 +++-
 include/linux/soundwire/sdw.h                 |   1 +
 include/linux/soundwire/sdw_intel.h           |   2 +
 13 files changed, 623 insertions(+), 71 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
