Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E25C33C9E
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:53:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3D620728
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jf5a85xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3D620728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DC3F170C;
	Wed, 15 Jan 2020 00:52:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DC3F170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579046017;
	bh=UokQBDvDGomiWJvadxTpAMi4LZJEa72itrO6GULoPc8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jf5a85xF+61ZG45QJUtvQl5AcJ5RuorhAuSNBRiMXoUoSO95kKu9+dz+0Fk04GhzP
	 46qd5e1Tzujsgv7wkwH/ZBDs2GPonfN09SYoZ4GwOAKF4ZFqtkFFVEHxZoXsiUF5AI
	 IAELnidUazMHCuXTgPren6LnZp8avuJ6zGUlMvC4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B203CF8014D;
	Wed, 15 Jan 2020 00:52:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CF1EF800B9; Wed, 15 Jan 2020 00:52:45 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C17EF800B9
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2020 00:52:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C17EF800B9
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jan 2020 15:52:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; d="scan'208";a="217922976"
Received: from emkilgox-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.0.151])
 by orsmga008.jf.intel.com with ESMTP; 14 Jan 2020 15:52:37 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 14 Jan 2020 17:52:22 -0600
Message-Id: <20200114235227.14502-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v2 0/5] soundwire: stream: fix state machines
	and transitions
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

The existing stream support works fine with simple cases, but does not
map well with ALSA transitions for underflows/resume where prepare()
can be called multiple times. Concurrency with multiple devices per
links or multiple streams enabled on the same link also needs to be
fixed.

These patches are the result of hours of validation on the Intel side
and should benefit other implementations since there is nothing
hardware-specific. The Intel-specific changes being reviewed do depend
on those stream changes though to be functional.

Changes since v1:
Removed spurious code block change flagged by Vinod

No change (replies provided in v1 thread)
Github link issue is public, no reason to remove it
Bandwidth computation on ALSA prepare/start (for resume cases) handled
internally in stream layer.
Kept emacs comment formatting.
No additional code/test for concurrent streams (not supported due to locking)

Bard Liao (1):
  soundwire: stream: only prepare stream when it is configured.

Pierre-Louis Bossart (2):
  soundwire: stream: update state machine and add state checks
  soundwire: stream: do not update parameters during DISABLED-PREPARED
    transition

Rander Wang (2):
  soundwire: stream: fix support for multiple Slaves on the same link
  soundwire: stream: don't program ports when a stream that has not been
    prepared

 Documentation/driver-api/soundwire/stream.rst | 61 +++++++++----
 drivers/soundwire/stream.c                    | 90 ++++++++++++++++---
 2 files changed, 124 insertions(+), 27 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
