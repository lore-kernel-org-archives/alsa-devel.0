Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01939C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:34:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4901264E76
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4901264E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9100A1689;
	Tue,  9 Feb 2021 00:34:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9100A1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612827291;
	bh=ASHsyaz+zrokNAae7ZFEUUjxTrnn59l3QjBMKP+twxw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cNsaxc4IDJ0+NyG+vPEqiPqxCo6RsODKzLcS9faZpcWdqrHvhHTGdwsl8Eu/fEkkE
	 PF2538zJq4Z3i5rgh6WhXbGH/hAYXkfogRbIZj1O/rBSYAXSgc8EQb5z+bGcwLP87X
	 PoWdBHpfplFfH4zOS7VKRiYz08QH8oIO4ELCAXjA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DA981F8026B;
	Tue,  9 Feb 2021 00:34:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D573F80169; Tue,  9 Feb 2021 00:33:58 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82BECF80169
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:33:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82BECF80169
IronPort-SDR: rr4+Gsk90m2Fi17vrzXVtHzuoxgN/vEXXJuzjCDlghaSHeQB7gHzcjVN9CwR55rXEMupm2Hreg
 eFSR3Sb6mLxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="168923489"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="168923489"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:50 -0800
IronPort-SDR: Na4Gjdb7emfaNtXWxsviB/2lCmVzs37/DLb/hR+elqUKK4/aMaDme3Jpv0CWGtwnrB7QlGM9vk
 8fRaXXdZZqoA==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="374741319"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:49 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 00/11] ASoC: SOF/Intel/SoundWire: add missing quirks and
 DMIC support
Date: Mon,  8 Feb 2021 17:33:25 -0600
Message-Id: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

HP Spectre x360 convertible devices rely on a mixed SoundWire+DMIC
configuration which wasn't well supported. This lead to the discovery
that we missed the TGL_HDMI quirk on a number of Dell devices, the
addition of DMIC autodetection (based on NHLT tables), the addition of
new component strings needed by UCM, and work-arounds due to
problematic DSDT tables.

Changes since v1:
Rebase to remove first three patches already merged.
Fix allmodconfig issues (undeclared kernel parameter)

Bard Liao (1):
  ASoC: intel: sof_sdw: add trace for dai links

Guennadi Liakhovetski (1):
  ASoC: SOF: Intel: HDA: don't keep a temporary variable

Pierre-Louis Bossart (8):
  ASoC: Intel: sof_sdw: reorganize quirks by generation
  ASoC: Intel: sof-sdw: indent and add quirks consistently
  ASoC: Intel: sof_sdw: add quirk for HP Spectre x360 convertible
  ASoC: Intel: sof_sdw: add mic:dmic and cfg-mics component strings
  ASoC: Intel: soc-acpi: add ACPI matching table for HP Spectre x360
  ASoC: SOF: Intel: SoundWire: refine ACPI match
  ASoC: SOF: Intel: detect DMIC number in SoundWire mixed config
  ASoC: SOF: Intel: hda: add dev_dbg() when DMIC number is overridden

Rander Wang (1):
  ASoC: Intel: sof_sdw: detect DMIC number based on mach params

 sound/soc/intel/boards/sof_sdw.c              | 134 ++++++-----
 .../intel/common/soc-acpi-intel-tgl-match.c   |  20 ++
 sound/soc/sof/intel/hda.c                     | 212 ++++++++++++------
 3 files changed, 244 insertions(+), 122 deletions(-)

-- 
2.25.1

