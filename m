Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1986CC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 20:23:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2279220716
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 20:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eNBmPCcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2279220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12458850;
	Tue, 17 Dec 2019 21:22:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12458850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576614229;
	bh=Xe6gvTvyHID0ew2zqc3Mx8Iu2WUdjirv1W21Xk7JUWY=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eNBmPCcXDw6n7Y3itR3L2peNISm8SbYl2IH1CCmdGOeDcc6GfeaMtmmv9ffTbA8sI
	 jwERYYOih1RnUnE2mNY20wSYuIKyV1fx6mGOm3tHEdCmdoSMDRZVOlgYPMsoigEvKT
	 aqsqQpff31ctigl5rQusr3BCJNc8PIjVEnr6sgPc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19C46F80260;
	Tue, 17 Dec 2019 21:22:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DA40F8025A; Tue, 17 Dec 2019 21:22:56 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02560F8020B
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 21:22:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02560F8020B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 12:22:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; d="scan'208";a="266679223"
Received: from smcdonal-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.83.42])
 by FMSMGA003.fm.intel.com with ESMTP; 17 Dec 2019 12:22:48 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 17 Dec 2019 14:22:23 -0600
Message-Id: <20191217202231.18259-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/8] ASoC: SOF: Intel: add module namespace
	support
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

A lot of the existing SOF/Intel drivers expose ops structures or
helpers that should not be visible or loadable by other
drivers. During the last round of SoundWire reviews, GregKH suggested
the use of module namespaces [1] to avoid exposing symbols that are only
meant to be used in a restricted context.

This patchset suggests the use of namespaces for the different Intel
parts, largely modeled after the existing hiearchical Kconfig
options. While several SOF reviewers suggested on GitHub that this use
of namespaces was too fine-grained, it can also be argued that this
level of detail helps identify cases where the existing structures are
not properly defined. We found such a case with the Xtensa
architecture abstraction and another code partitioning issue for the
SoundWire driver yesterday.

Module namespaces are currently not used widely in kernel circles,
this is a first attempt to test the water for audio drivers and gather
comments from maintainers/reviewers.

[1] https://www.kernel.org/doc/html/latest/core-api/symbol-namespaces.html

Pierre-Louis Bossart (8):
  ASoC: SOF: Intel: add module namespace for legacy IPC
  ASoC: SOF: Intel: add namespaces for BAYTRAIL and MERRIFIELD
  ASoC: SOF: Intel: add namespace for BROADWELL
  ASoC: SOF: remove references to Haswell
  ASoC: SOF: Intel: add namespace for HDA_COMMON
  ASoC: SOF: Intel: hda: add namespace for hda-codec functionality
  ASoC: SOF: move arch_ops under ops
  ASoC: SOF: Intel: add namespace for XTENSA

 include/sound/sof.h             |  1 -
 sound/soc/sof/Kconfig           |  2 +-
 sound/soc/sof/intel/apl.c       |  6 ++++--
 sound/soc/sof/intel/bdw.c       |  8 ++++++--
 sound/soc/sof/intel/byt.c       | 20 ++++++++++++++------
 sound/soc/sof/intel/cnl.c       | 14 ++++++++------
 sound/soc/sof/intel/hda-codec.c | 14 +++++++-------
 sound/soc/sof/intel/hda.c       |  3 +++
 sound/soc/sof/intel/intel-ipc.c |  8 ++++----
 sound/soc/sof/intel/shim.h      |  6 ++----
 sound/soc/sof/sof-acpi-dev.c    | 26 ++------------------------
 sound/soc/sof/sof-pci-dev.c     | 12 ++----------
 sound/soc/sof/sof-priv.h        |  4 +++-
 sound/soc/sof/xtensa/core.c     |  2 +-
 14 files changed, 57 insertions(+), 69 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
