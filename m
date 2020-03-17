Return-Path: <SRS0=KQif=5C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655BC10F29
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:36:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327C420735
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SBUxHVaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327C420735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7282F17AE;
	Tue, 17 Mar 2020 17:36:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7282F17AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584463017;
	bh=aNIB5owoTnQKvhSDF0jMxGw2w3hSLWpNUHJxZC9gwv8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SBUxHVaqAxcqJjWv1lPIEFwTGGXBZ2wKIXC4Y0ioUVr5gzv4v/gInnMU8ARxnO/08
	 /b7VvwJw/TJxpTCSZf3ECNQ4t5oZOPltkxgDh6+Vm2Md+8spmWS52VTu23ePFpSZrA
	 Ek8NwQPmzNmHR4A9bVBfs1hT/MbTHNyv5l8KX6dY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E6B4F800C0;
	Tue, 17 Mar 2020 17:36:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46EF5F8023E; Tue, 17 Mar 2020 17:34:14 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF34CF80217
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2020 17:34:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF34CF80217
IronPort-SDR: oYCnWokhNna7v5X6WDYEIyQ4cVVEMN2LG/FxGE0cK+aShfdINYGKxCU8RlSGdIvpqPUsHVvCIK
 oXziPZl9hxNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 09:34:05 -0700
IronPort-SDR: 4byRzvWkpFm4nBr7uJvK8YG7cFS6Fkjvt6HHpH+7ajiLMcrRxD5yaKgQ0/KY6XmpLDRe7XxW5r
 fY5iU6+JriFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; d="scan'208";a="244533087"
Received: from aavila-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.36.39])
 by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 09:34:02 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 00/17] SoundWire: cadence: add clock stop and fix
 programming sequences
Date: Tue, 17 Mar 2020 11:33:12 -0500
Message-Id: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
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

To make progress with SoundWire support, this patchset provides the
missing support for clock stop modes, and revisits all Cadence Master
register settings. The current code is for some reason not aligned
with internal documentation and hardware recommended flows,
specifically for multi-link operation.

Changes since v1:
Removed log in is_clock_stop(), use the helper in the main
clock_stop() and change return 1->return 0.
Fixed squash issue in patch5 to remove irrelevant udelay() change
Added Patch17 to clear FIFOs and avoid pop noise

Pierre-Louis Bossart (12):
  soundwire: cadence: s/update_config/config_update
  soundwire: cadence: handle error cases with CONFIG_UPDATE
  soundwire: cadence: mask Slave interrupt before stopping clock
  soundwire: cadence: merge routines to clear/set bits
  soundwire: cadence: move clock/SSP related inits to dedicated function
  soundwire: cadence: make SSP interval programmable
  soundwire: cadence: reorder MCP_CONFIG settings
  soundwire: cadence: enable NORMAL operation in cdns_init()
  soundwire: cadence: remove PREQ_DELAY assignment
  soundwire: cadence: remove automatic command retries
  soundwire: cadence: commit changes in the exit_reset() sequence
  soundwire: cadence: multi-link support

Rander Wang (4):
  soundwire: cadence: simplifiy cdns_init()
  soundwire: cadence: add interface to check clock status
  soundwire: cadence: add clock_stop/restart routines
  soundwire: cadence: fix a io timeout issue in S3 test

randerwang (1):
  soundwire: cadence: clear FIFO to avoid pop noise issue on playback
    start

 drivers/soundwire/cadence_master.c | 282 ++++++++++++++++++++++++-----
 drivers/soundwire/cadence_master.h |   9 +-
 drivers/soundwire/intel.c          |   2 +-
 3 files changed, 249 insertions(+), 44 deletions(-)


base-commit: 0b43fef979b4664d51a09dc7e0c430ebb2d18267
-- 
2.20.1

