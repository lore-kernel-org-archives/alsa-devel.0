Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18072C432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:54:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102412071B
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pqqZVBo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102412071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBD1B74C;
	Thu, 14 Nov 2019 18:54:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBD1B74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573754094;
	bh=svT7b2IR/6mOMqzTGhoqoXqcuytVeWpph2MR8P/j7Pc=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pqqZVBo8k5Na5tYz8XRYB7gWzbdctt3ggVfr+s4rhP5RHSFbgWfnp8KyQOyp6ajSU
	 aLQHWiWkE+HldG9fmdfLgmlop1Cj87ZY8uSj8Xxtr6ifjDxdXtLbNj9GcEourT44ih
	 JzTHFNEDU1/QmWSUB7W9RRnjT+GKgXsvqMZDtTAI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0EC1F800CD;
	Thu, 14 Nov 2019 18:54:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D266BF800EC; Thu, 14 Nov 2019 18:54:01 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 716EFF8007E
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 18:53:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 716EFF8007E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2019 09:53:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; d="scan'208";a="203132942"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
 by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2019 09:53:52 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Thu, 14 Nov 2019 11:53:39 -0600
Message-Id: <20191114175345.21836-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v3 0/6] soundwire: update ASoC interfaces
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

We need new fields in existing structures to
a) deal with race conditions on codec probe/enumeration
b) allow for multi-step ACPI scan/probe/startup on Intel plaforms

These structures will be used by the SOF driver as well as codec
drivers.

To avoid conflicts between ASoC and Soundwire trees, these 6 patches
are provided out-of-order, before the functionality enabled in these
header files is added in follow-up patch series which can be applied
separately in the ASoC and Soundwire trees. As discussed earlier,
Vinod would need to provide an immutable tag for Mark Brown, and the
integration on the ASoC side of SOF changes and new codecs drivers can
proceed in parallel with SoundWire core changes.

Note that the SOF changes are not provided as a v3 today due to
conflicts with other in-flight SOF cleanups to facilitate support for
Device Tree devices. Those changes don't impact the interface
definition suggested here but the machine driver detection for
SoundWire. The changes should be ready in next week.

The mapping between the patches in this series and follow-up ones
shouldn't give anyone a migraine:

soundwire: sdw_slave: add probe_complete structure and new fields
soundwire: bus: fix race condition with probe_complete signaling

soundwire: sdw_slave: add enumeration_complete structure
soundwire: bus: fix race condition with enumeration_complete signaling

soundwire: sdw_slave: add initialization_complete definition
soundwire: bus: fix race condition with initialization_complete signaling

soundwire: sdw_slave: track unattach_request to handle all init sequences
soundwire: bus: fix race condition by tracking UNATTACHED transition

Changes since v2:
Added new field to deal with a race condition leading to a timeout
when the codec goes through a pm_runtime suspend/resume transition
while the Master remains active.
Clarified commit messages with detailed explanations what those race
conditions are and why the changes were introduced.
Reordered fields for Intel routines
Added kernel-doc definitions for structures
Modified the patch subjects to make the mapping between interface definition
and implementation straightforward.

Changes since v1 (no feedback received since October 23)
additional initialization_complete utility to help codec drivers with
their resume operation, waiting for the enumeration to complete is not
always enough.

Pierre-Louis Bossart (5):
  soundwire: sdw_slave: add probe_complete structure and new fields
  soundwire: sdw_slave: add enumeration_complete structure
  soundwire: sdw_slave: add initialization_complete definition
  soundwire: sdw_slave: track unattach_request to handle all init
    sequences
  soundwire: intel: update interfaces between ASoC and SoundWire

Rander Wang (1):
  soundwire: intel: update stream callbacks for hwparams/free stream
    operations

 drivers/soundwire/intel.c           |  20 +++--
 drivers/soundwire/intel.h           |  13 ++--
 drivers/soundwire/intel_init.c      |  31 ++------
 include/linux/soundwire/sdw.h       |  19 +++++
 include/linux/soundwire/sdw_intel.h | 109 +++++++++++++++++++++++++---
 5 files changed, 149 insertions(+), 43 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
