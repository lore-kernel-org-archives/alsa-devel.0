Return-Path: <SRS0=72a4=G6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25948C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 02:08:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983062065D
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 02:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983062065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 241AA16C3;
	Wed, 27 Jan 2021 03:07:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 241AA16C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611713327;
	bh=i2/0NZ7nH279jVuLLSIwtJ03UQjeMWyoHTxndYK36jA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I7Xc90YcNztZw28KPI2f4q9rJbwN73QNff6WSa93dcKC42GWt9YFIATTddsaso1Th
	 HMFMr+6gtfFl4y+zmc//McPX33XZSNMFkOIrKd0oLV/JBWTkUyuFTGDQVeJ/Z0uixq
	 SHuSDmJsypu/YLrpfo32SRpd7GSrmpg4Rz0FlyMw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DC76F8015B;
	Wed, 27 Jan 2021 03:07:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4ED52F80130; Wed, 27 Jan 2021 03:07:54 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3274F80130
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 03:07:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3274F80130
IronPort-SDR: UqMuFtbMnC1gerUW9kLKVdb2uq/lA75unrRhUjSdZqqiBFqs7cr4YeVkyBJHW+PWoF2Ik4Qrpn
 B+U2/FNm8z0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="176495398"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; d="scan'208";a="176495398"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 18:07:43 -0800
IronPort-SDR: Ak+xiRZczWIxDpE/rCHRwMNB+mACpYJ7fdv+G67dvZJxASIa4CnYNlxOsXefgDiw1tCF0Lri6C
 gTiwyNxkhipQ==
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; d="scan'208";a="472975609"
Received: from laurafux-mobl.amr.corp.intel.com (HELO
 rsridh-mobl1.localdomain) ([10.254.96.47])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 18:07:43 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/2] ASoC: SOF: Intel: hda: Enable DMI L1 for power savings
Date: Tue, 26 Jan 2021 18:07:35 -0800
Message-Id: <20210127020737.1088960-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 tiwai@suse.com, sathyanarayana.nujella@intel.com
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

This series includes 2 patches that enable DMI L1 for D0I3-compatible
streams and trace DMA stream to maximise power savings on Intel
HDA platforms.

v2 changes:
FIx compilation error when probes feature is enabled in SOF Kconfig.

Ranjani Sridharan (2):
  ASoC: SOF: Intel: hda: enable DMI L1 for D0i3-compatible streams
  ASoC: SOF: Intel: hda: Enable DMI L1 for trace

 sound/soc/sof/intel/hda-compress.c |  2 +-
 sound/soc/sof/intel/hda-loader.c   |  2 +-
 sound/soc/sof/intel/hda-pcm.c      | 16 ++++++++++++-
 sound/soc/sof/intel/hda-stream.c   | 38 +++++++++++++++++-------------
 sound/soc/sof/intel/hda-trace.c    |  4 ++--
 sound/soc/sof/intel/hda.h          |  6 ++++-
 6 files changed, 46 insertions(+), 22 deletions(-)

-- 
2.25.1

