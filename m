Return-Path: <SRS0=eswj=3E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ABEC33C9E
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 00:10:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D415924673
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 00:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZO2UUDX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D415924673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D71816C1;
	Wed, 15 Jan 2020 01:09:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D71816C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579047034;
	bh=xs7X6Bv651kTCro2Xy9ciV73n5kKUwLVPbhzhZqspt8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZO2UUDX3fUo6UbuRVU7Z06SJ6lK0Ik9ezA8LyzGXga73sY9a8A9H0FuA2lNo8/HpR
	 SpI5KtEP3IREdlFnttEjZOq7pDoea56gs+KadYBNuMRZeF1SbqaU9KnTU7LzhSUPhC
	 1S4IrCkcOcDUQUW3TSgrrTuRvwlYhQo/xYp4K0TQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FB73F8016F;
	Wed, 15 Jan 2020 01:09:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3878DF8014E; Wed, 15 Jan 2020 01:09:41 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D95FFF800B9
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2020 01:09:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D95FFF800B9
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jan 2020 16:09:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; d="scan'208";a="273468527"
Received: from emkilgox-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.0.151])
 by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2020 16:09:33 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 14 Jan 2020 18:08:34 -0600
Message-Id: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH 00/10] soundwire: bus: fix race conditions,
	add suspend-resume
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

The existing mainline code for SoundWire does not handle critical race
conditions, and does not have any support for pm_runtime suspend or
clock-stop modes needed for e.g. jack detection or external VAD.

As suggested by Vinod, these patches for the bus are shared first -
with the risk that they are separated from their actual use in Intel
drivers, so reviewers might wonder why they are needed in the first
place.

For reference, the complete set of 90+ patches required for SoundWire
on Intel platforms is available here:

https://github.com/thesofproject/linux/pull/1692

These patches are not Intel-specific and are likely required for
e.g. Qualcomm-based implementations.

All the patches in this series were generated during the joint
Intel-Realtek validation effort on Intel reference designs and
form-factor devices. The support for the initialization_complete
signaling is already available in the Realtek codecs drivers merged in
the ASoC tree (rt700, rt711, rt1308, rt715)

Pierre-Louis Bossart (8):
  soundwire: bus: fix race condition with probe_complete signaling
  soundwire: bus: fix race condition with enumeration_complete signaling
  soundwire: bus: fix race condition with initialization_complete
    signaling
  soundwire: bus: add PM/no-PM versions of read/write functions
  soundwire: bus: write Slave Device Number without runtime_pm
  soundwire: bus: add helper to clear Slave status to UNATTACHED
  soundwire: bus: disable pm_runtime in sdw_slave_delete
  soundwire: bus: don't treat CMD_IGNORED as error on ClockStop

Rander Wang (2):
  soundwire: bus: fix io error when processing alert event
  soundwire: bus: add clock stop helpers

 drivers/soundwire/bus.c       | 509 ++++++++++++++++++++++++++++++++--
 drivers/soundwire/bus.h       |   9 +
 drivers/soundwire/bus_type.c  |   5 +
 drivers/soundwire/slave.c     |   4 +
 include/linux/soundwire/sdw.h |  24 ++
 5 files changed, 526 insertions(+), 25 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
