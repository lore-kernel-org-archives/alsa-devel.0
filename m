Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33136C25B78
	for <alsa-devel@archiver.kernel.org>; Mon, 27 May 2024 19:37:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74DAE950;
	Mon, 27 May 2024 21:36:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74DAE950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716838619;
	bh=uaQrVDIfhVMkQXg7HL+yPst859jXYGd0ylxWouMztp4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=s0R/uILCr/GpF5mTWuwypVoz1TRa0DILwAAzwAP6y/mjVBCPh2qv5Vm2H/jJM89b8
	 sUqphw8+ZlRGVFK0uTnQFyyw8OSZ1xDArmCpAgCBk0HEOI/ZLCN/Au1dX5/jJRMHUr
	 2t6cc+gJPfNzhIOKnT2mq5alVh+WFin0TPsVjKSE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01652F805BE; Mon, 27 May 2024 21:36:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4A17F805BD;
	Mon, 27 May 2024 21:36:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A732DF8051D; Mon, 27 May 2024 21:36:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B5C07F80051
	for <alsa-devel@alsa-project.org>; Mon, 27 May 2024 21:36:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5C07F80051
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Cc/UKHwZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716838574; x=1748374574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uaQrVDIfhVMkQXg7HL+yPst859jXYGd0ylxWouMztp4=;
  b=Cc/UKHwZvnMqnECNgA1G+vLqEnjBhyszs+aIeeH++Gd3ez8PsO2XbDyj
   lcgw7DPIBIQRHlbbUwtNW7ThJtkr4VvhmOQeF3PvDZoB5oT1fJRoq75L/
   aRtXJAbNJF7m2NH9C4sjeoB0aFLUQ0aVCJjbuJ1d0r7pqLAZ25zXLpIsx
   GQiTQuCwLW+uqwRg2D/bNLJDRc+4QvhGMfq7be1AKuUFqPnFj/FOCEksu
   3faHzt9CcH1i007bNpCQnTfeyhdNzoXUCsugoXGMXBdzRkuc8RDBEHasd
   YLALUGebCuVJu/H0jQvSQ07W0tr1vYEKYIrVV2PmH53ZnZHwRP5x7yUbE
   g==;
X-CSE-ConnectionGUID: cE4h6JCGQA+6hXo8UMV7vw==
X-CSE-MsgGUID: Fasc3kt6TXexo2I1cARhWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13339309"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000";
   d="scan'208";a="13339309"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 12:36:09 -0700
X-CSE-ConnectionGUID: gnmBmxaFRw+IaLcP++2zDw==
X-CSE-MsgGUID: UKyQp+snRIKvpnKZvX/gHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000";
   d="scan'208";a="58029750"
Received: from unknown (HELO pbossart-mobl6.lan) ([10.125.110.221])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 12:36:08 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/18] ASoC: Intel: boards: updates for 6.11
Date: Mon, 27 May 2024 14:35:34 -0500
Message-ID: <20240527193552.165567-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FIRRGMFRFT456IS77UCDHGNMWJRXPOVI
X-Message-ID-Hash: FIRRGMFRFT456IS77UCDHGNMWJRXPOVI
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FIRRGMFRFT456IS77UCDHGNMWJRXPOVI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

More simplifications from Brent Lu for Chromebooks, Bard Liao for
SoundWire, and support for new Dell SKUs w/ Cirrus Logic codecs added
by Charles Keepax.

Bard Liao (7):
  ASoC: Intel: sof_sdw_cs42l42: use dai parameter
  ASoC: Intel: sof_sdw_rt711: use dai parameter
  ASoC: Intel: sof_sdw_rt5682: use dai parameter
  ASoC: Intel: sof_sdw_rt700: use dai parameter
  ASoC: Intel: sof_sdw_rt_dmic: use from dai parameter
  ASoC: Intel: sof_sdw_rt_sdca_jack_common: use dai parameter
  ASoC: Intel: sof_sdw: remove get_codec_dai_by_name

Brent Lu (7):
  ASoC: SOF: sof-audio: rename dai clock setting query function
  ASoC: SOF: sof-audio: add sof_dai_get_tdm_slots function
  ASoC: SOF: ipc3-topology: support tdm slot number query
  ASoC: SOF: ipc4-topology: support tdm slot number query
  ASoC: Intel: maxim-common: rewrite max_98373_hw_params function
  ASoC: Intel: sof_da7219: remove local max98373 ops
  ASoC: Intel: sof_da7219: disable max98373 speaker pins in late_probe

Charles Keepax (4):
  ASoC: Intel: sof_sdw: Add missing controls for cs42l43/cs35l56
  ASoC: Intel: soc-acpi: Add match entries for some cs42l43 laptops
  ASoC: Intel: sof_sdw: Add quirks for some new Dell laptops
  ASoC: Intel: sof_sdw: Add quirks from some new Dell laptops

 include/sound/sof.h                           |   1 +
 sound/soc/intel/boards/sof_board_helpers.h    |   2 -
 sound/soc/intel/boards/sof_da7219.c           |  57 ++------
 sound/soc/intel/boards/sof_maxim_common.c     |  84 ++++++++++--
 sound/soc/intel/boards/sof_sdw.c              | 128 +++++++++++++++---
 sound/soc/intel/boards/sof_sdw_common.h       |   4 -
 sound/soc/intel/boards/sof_sdw_cs42l42.c      |  11 +-
 sound/soc/intel/boards/sof_sdw_rt5682.c       |  11 +-
 sound/soc/intel/boards/sof_sdw_rt700.c        |  11 +-
 sound/soc/intel/boards/sof_sdw_rt711.c        |  11 +-
 sound/soc/intel/boards/sof_sdw_rt_dmic.c      |  14 +-
 .../boards/sof_sdw_rt_sdca_jack_common.c      |  11 +-
 .../intel/common/soc-acpi-intel-arl-match.c   |  50 +++++++
 .../intel/common/soc-acpi-intel-rpl-match.c   |  50 +++++++
 sound/soc/sof/ipc3-topology.c                 |  14 +-
 sound/soc/sof/ipc4-topology.c                 |  14 +-
 sound/soc/sof/sof-audio.c                     |  20 ++-
 sound/soc/sof/sof-audio.h                     |   9 +-
 18 files changed, 338 insertions(+), 164 deletions(-)

-- 
2.43.0

