Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505D5C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:37:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6912065E
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TcZHpy9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6912065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29E391763;
	Wed, 23 Sep 2020 19:36:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29E391763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600882656;
	bh=z+zACkjbfTf8fMrtgCZ0A4mdMmAxRy5gNRgRJS3ZRD0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TcZHpy9Cd2hFOYqi7kultwbo1KM6iij5APTKZWv55yM8ztHxNtJ/lbBMCfRtXwBjq
	 MGdhbWk+JXH2iNtIpvO3qSulIWA9iro9LR5YysKgTX1mx816HLXyd5FzJ/1wnJ0uBo
	 mwbP1ScmPU+GdkMNu3VCkLpt5wZ0ZkhdoF0AcR4I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BFB9F802C4;
	Wed, 23 Sep 2020 19:35:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05AD4F8028D; Wed, 23 Sep 2020 19:35:51 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42167F8015F
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 19:35:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42167F8015F
IronPort-SDR: dwqMzxU17cTjHOuGxh1T4/3MT9fMu6HU25N2E1hGkqam4OiN/UzR080LRjH3rtHBCawNAtoO6p
 9XkB7w/RY26Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="148628843"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="148628843"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 10:35:32 -0700
IronPort-SDR: 2NwVDGtNOh7uP0NE5HwS5n/LEtP2wSH4qPv5u53RmeTIABL6a1BbralLx4lo6F5Oy14nfep7C5
 ntcoMJwP9u9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="335562309"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga004.fm.intel.com with ESMTP; 23 Sep 2020 10:35:30 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH v2 0/6] ASoC: Intel: sdw machine driver updates for 5.10
Date: Wed, 23 Sep 2020 20:33:52 +0300
Message-Id: <20200923173358.3247215-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, daniel.baluta@nxp.com,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

Series including fixes and improvements for Intel SoundWire
machine drivers.

v2 changes:
 - fix the incorrct commit ids in Fixes tags

Bard Liao (1):
  ASoC: Intel: add support for new SoundWire hardware layout on TGL

Pierre-Louis Bossart (4):
  ASoC: Intel: sof_sdw: remove ternary operator
  ASoC: Intel: add codec name prefix to ACPI machine description
  ASoC: Intel: sof_sdw: remove hard-coded codec_conf table
  ASoC: Intel: sof_sdw_rt700: add codec prefix

Rander Wang (1):
  ASOC: Intel: sof_sdw: restore playback functionality with max98373
    amps

 include/sound/soc-acpi.h                      |   2 +
 sound/soc/intel/boards/sof_sdw.c              | 170 +++++++++---------
 sound/soc/intel/boards/sof_sdw_common.h       |   3 +
 sound/soc/intel/boards/sof_sdw_max98373.c     |  36 +++-
 sound/soc/intel/boards/sof_sdw_rt700.c        |   6 +-
 .../intel/common/soc-acpi-intel-cml-match.c   |  10 ++
 .../intel/common/soc-acpi-intel-cnl-match.c   |   1 +
 .../intel/common/soc-acpi-intel-icl-match.c   |   6 +
 .../intel/common/soc-acpi-intel-tgl-match.c   |  67 +++++++
 9 files changed, 216 insertions(+), 85 deletions(-)

-- 
2.27.0

