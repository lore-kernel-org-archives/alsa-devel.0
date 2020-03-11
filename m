Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8964C0044D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:42:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8B120736
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LaE6r5qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8B120736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD0271675;
	Wed, 11 Mar 2020 19:41:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD0271675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583952163;
	bh=pOFt92Ht8KRXARpZs5uOQnMWqTW17VFvQ6PQcgok77Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LaE6r5qksxsbKqfkENHmQUTzN2lzBUtfJ2rtGz88a8XTAlY6cYs0kmBfenzqCUlwZ
	 C3qnATKuAODUHpC7nlgZHDGGAB3gxfgIIyBvgheCuNBaQyZktd/99NPq8f6j4YL4/2
	 sxP3NaP5+v4g4q9UHYkD+cI3GbqLssRBneJJb0Uc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8E44F800BE;
	Wed, 11 Mar 2020 19:41:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D78EFF801F8; Wed, 11 Mar 2020 19:41:45 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C649F800B5
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 19:41:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C649F800B5
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 11:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; d="scan'208";a="441776196"
Received: from fjan-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
 by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 11:41:36 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/16] SoundWire: cadence: add clock stop and fix programming
 sequences
Date: Wed, 11 Mar 2020 13:41:12 -0500
Message-Id: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
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

 drivers/soundwire/cadence_master.c | 297 ++++++++++++++++++++++++-----
 drivers/soundwire/cadence_master.h |   9 +-
 drivers/soundwire/intel.c          |   2 +-
 3 files changed, 261 insertions(+), 47 deletions(-)


base-commit: 5de79ba865d7770c3bdde7c266ed425832764aac
-- 
2.20.1

