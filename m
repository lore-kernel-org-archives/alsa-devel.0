Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE36BC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:00:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AE9207FF
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ev6gMK8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AE9207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 966D8843;
	Tue, 17 Dec 2019 10:59:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 966D8843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576576817;
	bh=15zsIvLdGEzXXcF7wklrOAXznweeOl0CbPsf5LNdj5k=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ev6gMK8/b/Xgdu9dVk9PVSbH3Lu3Cmb2UG4MGJBLieW42xKF1JuY9v4rIRLn3esRb
	 WjuarweZ0GWPYkiFV74y1rQoSSuJjvbexA9GFtk40v/mL7RK16eEMofEyWFSfSDHLC
	 d/xpoXV4EWcwkLOsQal0ZyVwtIE5e9wKFi5AOAjE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFE55F8025A;
	Tue, 17 Dec 2019 10:59:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40C4FF80256; Tue, 17 Dec 2019 10:59:25 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C25B4F80100
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 10:59:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C25B4F80100
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 01:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; d="scan'208";a="221716995"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2019 01:59:16 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 17 Dec 2019 10:58:44 +0100
Message-Id: <20191217095851.19629-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>,
 broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
Subject: [alsa-devel] [PATCH 0/7] ALSA: hda: Enable HDAudio compress
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This set of patches provides new interfaces - page allocation - and
runtime flow adjustments - PM support - for compress operations.
For HDA part, work has been done to account for compress streams when
servicing IRQs, setting up BDLs and assigning DMAs.

End goal is to make room for one of DSP debug features: data probing.
It takes advantage of compress streams when extracting data from
running audio pipeline.

Initial review and development of probes can be found under:
https://github.com/thesofproject/linux/pull/1276

with this very set of patches being separated and reviewed on:
https://github.com/thesofproject/linux/pull/1571


Cezary Rojewski (7):
  ALSA: hda: Allow for compress stream to hdac_ext_stream assignment
  ALSA: hda: Prepare for compress stream support
  ALSA: hda: Interrupt servicing and BDL setup for compress streams
  ALSA: core: Expand DMA buffer information
  ALSA: core: Implement compress page allocation and free routines
  ASoC: compress: Add pm_runtime support
  ASoC: SOF: Intel: Account for compress streams when servicing IRQs

 include/sound/compress_driver.h  | 40 ++++++++++++++++++------
 include/sound/hdaudio.h          |  2 ++
 include/sound/hdaudio_ext.h      |  2 ++
 sound/core/compress_offload.c    | 42 ++++++++++++++++++++++++++
 sound/hda/ext/hdac_ext_stream.c  | 46 +++++++++++++++++++++++++---
 sound/hda/hdac_controller.c      |  4 +--
 sound/hda/hdac_stream.c          | 52 ++++++++++++++++++++------------
 sound/soc/soc-compress.c         | 29 +++++++++++++++++-
 sound/soc/sof/intel/hda-stream.c | 26 ++++++++++++++--
 9 files changed, 205 insertions(+), 38 deletions(-)

-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
