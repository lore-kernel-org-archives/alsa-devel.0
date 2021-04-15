Return-Path: <SRS0=rm39=JM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25985C433B4
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 17:52:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651AE61132
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 17:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651AE61132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE963165D;
	Thu, 15 Apr 2021 19:51:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE963165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618509155;
	bh=c9yDkirQPnv8xuZqPDAU6S7QxFOtyI4bGUOnJC4rrRk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LPuVtxO4q19UTbSxIAQdfrHqucvhYECFj7b6vvMUuRN0+SUHXk+G8WMwNHpZIzatK
	 6zVQWbGXRozdEYwYP1UyHBq73pw2Is3rTmLXcyuoiGymwPlAo+kzcZTyY7EAgXsb4C
	 gYhCe2QMP9XXHiee3iLikp3LTdKfbpilkXgi4wfk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E395BF8023A;
	Thu, 15 Apr 2021 19:50:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B6A4CF8042F; Thu, 15 Apr 2021 19:50:50 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A36F3F8022B
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 19:50:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A36F3F8022B
IronPort-SDR: H/cV91bZSpmjdVpcwjbyeTB05QGohzH+RkqxVyf6KceRzkWgRCz2A+fp9jo+yQLShpzdgdG2LU
 5elf/p+iBi9A==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="174400785"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; d="scan'208";a="174400785"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 10:50:33 -0700
IronPort-SDR: mB2UInlcWpC6c6qdaFFmSvU7KPKcE0T7YC6c134pFrzoJH6KWGysUn/pQxpBbzAfLI86gCCfu3
 QdNocalx6zHg==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; d="scan'208";a="382804624"
Received: from lesterhu-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.33.4])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 10:50:33 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/9] ASoC: Intel: add new TGL/ADL configurations
Date: Thu, 15 Apr 2021 12:50:04 -0500
Message-Id: <20210415175013.192862-1-pierre-louis.bossart@linux.intel.com>
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

Very little code but quite a few descriptors to add TigerLake (TGL)
/AlderLake (ADL) ACPI match tables for I2S and SoundWire devices, new
dailinks for Bluetooth offload. Some day this will be read from
platform firmware.

Also clarify how microphones are handled for SoundWire devices, and
create modules to avoid linking the same code multiple times.

Pierre-Louis Bossart (5):
  ASoC: Intel: soc-acpi: add ADL SoundWire base configurations
  ASoC: Intel: soc-acpi: add ADL jack-less SoundWire configurations
  ASoC: Intel: sof_sdw: add mutual exclusion between PCH DMIC and RT715
  ASoC: Intel: boards: handle hda-dsp-common as a module
  ASoC: Intel: boards: create sof-maxim-common module

Vamshi Krishna Gopal (3):
  ASoC: Intel: soc-acpi: add entries for i2s machines in ADL match table
  ASoC: Intel: sof_sdw: add quirk for new ADL-P Rvp
  ASoC: Intel: boards: add support for adl boards in sof-rt5682

Yong Zhi (1):
  ASoC: Intel: Boards: tgl_max98373: Add BT offload support

 sound/soc/intel/boards/Kconfig                |  18 ++
 sound/soc/intel/boards/Makefile               |  28 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c |   1 +
 sound/soc/intel/boards/bxt_rt298.c            |   1 +
 sound/soc/intel/boards/cml_rt1011_rt5682.c    |   1 +
 sound/soc/intel/boards/ehl_rt5660.c           |   1 +
 sound/soc/intel/boards/glk_rt5682_max98357a.c |   1 +
 sound/soc/intel/boards/hda_dsp_common.c       |   5 +
 sound/soc/intel/boards/skl_hda_dsp_generic.c  |   1 +
 sound/soc/intel/boards/sof_da7219_max98373.c  |   1 +
 sound/soc/intel/boards/sof_maxim_common.c     |  24 +-
 sound/soc/intel/boards/sof_maxim_common.h     |   6 +-
 sound/soc/intel/boards/sof_pcm512x.c          |   1 +
 sound/soc/intel/boards/sof_rt5682.c           |  67 ++++-
 sound/soc/intel/boards/sof_sdw.c              |  32 ++-
 sound/soc/intel/boards/sof_sdw_common.h       |   1 +
 sound/soc/intel/boards/sof_sdw_max98373.c     |   4 +-
 .../intel/common/soc-acpi-intel-adl-match.c   | 249 ++++++++++++++++++
 18 files changed, 415 insertions(+), 27 deletions(-)

-- 
2.25.1

