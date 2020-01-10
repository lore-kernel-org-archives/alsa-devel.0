Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E089CC282DD
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 23:59:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178F92077C
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 23:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ne8X3wR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178F92077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE64716B2;
	Sat, 11 Jan 2020 00:58:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE64716B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578700746;
	bh=ufedfE6Xbs+XrqzY34D/JJlijrg2Bpfce7Hh4b4PAqs=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ne8X3wR9wSfbMk0HDOyugknQObEme2HIjg4gMwsIxeaAU7kseDHVGhBOLihqkSIY6
	 u1Znomhm3Ug945KutvhqO4XydO6U79dK7vjiaY7smk2g/TENhMH4hH80N97kjp86gQ
	 m57WhHMAUudog56rCFL5oANwJYeZeQwqeSKLDaLI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29227F801EB;
	Sat, 11 Jan 2020 00:58:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C92DF800E4; Sat, 11 Jan 2020 00:58:13 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC300F800E4
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2020 00:58:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC300F800E4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 15:58:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; d="scan'208";a="224345288"
Received: from jrderube-mobl5.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.155.251])
 by orsmga003.jf.intel.com with ESMTP; 10 Jan 2020 15:58:05 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 10 Jan 2020 17:57:43 -0600
Message-Id: <20200110235751.3404-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/8] ASOC: SOF: Intel: improvements for
	Broadwell, HDA, OSS
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

This patchset provides general improvements for SOF on Intel
platforms.

First we have good support for SOF on Broadwell now (DMA and stability
issues seem to be being us). The legacy driver remains the
recommendation until UCM and topologies are provided downstream, but
this is promising.

Kai also fixed a couple of user-reported bugs for HDaudio/HDMI support
when external graphics are enabled, and OSS emulation. Additional work
is needed for the case where the Intel internal graphics solution is
disabled.

Also included a change on error logs which apparently made some users
nervous.

Bard liao (1):
  ASoC: SOF: Intel: lower print level to dbg if we will reinit DSP

Kai Vehmanen (3):
  ASoC: SOF: fix PCM playback through ALSA OSS emulation
  ASoC: SOF: Intel: fix HDA codec driver probe with multiple controllers
  ASoC: hdac_hda: Fix error in driver removal after failed probe

Pan Xiuli (1):
  ASoC: Intel: broadwell: change cpu_dai and platform components for SOF

Pierre-Louis Bossart (3):
  ASoC: Intel: bdw-rt5677: fix Kconfig dependencies
  ASoC: Intel: bdw-rt5677: change cpu_dai and platform components for
    SOF
  ASoC: Intel: bdw-rt5650: change cpu_dai and platform components for
    SOF

 sound/soc/codecs/hdac_hda.c         |  4 ++-
 sound/soc/intel/boards/Kconfig      |  3 ++
 sound/soc/intel/boards/bdw-rt5650.c | 10 +++++-
 sound/soc/intel/boards/bdw-rt5677.c | 10 +++++-
 sound/soc/intel/boards/broadwell.c  | 10 +++++-
 sound/soc/sof/intel/hda-codec.c     | 19 +++++++----
 sound/soc/sof/intel/hda-loader.c    |  6 ++--
 sound/soc/sof/pcm.c                 | 53 +++++++++++++++++------------
 8 files changed, 79 insertions(+), 36 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
