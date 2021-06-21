Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BC1C4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 19:42:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96E56115B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 19:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96E56115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C5C5839;
	Mon, 21 Jun 2021 21:41:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C5C5839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624304540;
	bh=8Yci0FcLHAaRI1dUWJTn0hcSZca/N0IcurtgHcZfEEU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QnjfgfUuXjnvSf8jfJv3Km3cOa1GooiTmL//Uqntv4oiEsfYVjuZpcx8ziMtN9+Xz
	 iq/DGaiLiZnA0mjkT3nYMnVZ9mNoPTu4r+xZxXFN/HDNNc0d8+nn5M/0IxN57E7BJz
	 01cM5qgbE3T3o3n+/+LODLoZcWpTtlflnF+uCZZQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B586AF80279;
	Mon, 21 Jun 2021 21:41:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CA40F80279; Mon, 21 Jun 2021 21:41:28 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E4E6F80137
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 21:41:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E4E6F80137
IronPort-SDR: hVXCf9SF7AScRIaV8jwaRLXxQNncsXx1Wj4s4xhafH8New56r866PHDmVuoc+6r9Svc6+WSGCq
 xcdU+jb1I7NQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="203903321"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="203903321"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 12:41:17 -0700
IronPort-SDR: S76TTYFh45cCRD0qEaxtRLuK9LftJ4Vy4yf23xVQTSwhESnVZQw5nc6QRhFbodTsuCWkv88dMf
 H7PEyp/mQK7Q==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="486619015"
Received: from gwhaugh-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.175.53])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 12:41:16 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 00/10] ASoC: Intel: machine driver corrections
Date: Mon, 21 Jun 2021 14:40:47 -0500
Message-Id: <20210621194057.21711-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

Some of these patches dealing with Sparse warnings were submitted
earlier but not merged. I grouped them with a couple of fixes from
Kai.

v2:
added Mark Brown in CC, was missed in v1
added Richard Fitzgerald Tested-by  

Kai Vehmanen (3):
  ASoC: Intel: sof_sdw: use mach data for ADL RVP DMIC count
  ASoC: Intel: sof_sdw: remove hdac-hdmi support
  ASoC: Intel: skl_hda_dsp_generic: Update Kconfig documentation

Pierre-Louis Bossart (7):
  ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characters
  ASoC: Intel: glk_rt5682_max98357a: shrink platform_id below 20
    characters
  ASoC: Intel: kbl_da7219_max98357a: shrink platform_id below 20
    characters
  ASoC: Intel: sof_da7219_max98373: shrink platform_id below 20
    characters
  ASoC: Intel: sof_sdw: fix signed/unsigned warning
  ASoC: Intel: soc-acpi: add ull suffix for SoundWire _ADR values
  ASoC: Intel: use MODULE_DEVICE_TABLE with platform_device_id tables

 sound/soc/intel/boards/Kconfig                |  7 ++--
 sound/soc/intel/boards/bxt_da7219_max98357a.c |  4 +-
 sound/soc/intel/boards/bxt_rt298.c            |  3 +-
 sound/soc/intel/boards/ehl_rt5660.c           |  2 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c |  4 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c |  4 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c  |  5 +--
 sound/soc/intel/boards/kbl_rt5660.c           |  2 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c  |  3 +-
 .../intel/boards/kbl_rt5663_rt5514_max98927.c |  2 +-
 .../soc/intel/boards/skl_nau88l25_max98357a.c |  3 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c |  3 +-
 sound/soc/intel/boards/skl_rt286.c            |  3 +-
 sound/soc/intel/boards/sof_cs42l42.c          |  3 +-
 sound/soc/intel/boards/sof_da7219_max98373.c  |  6 +--
 sound/soc/intel/boards/sof_rt5682.c           | 20 +++-------
 sound/soc/intel/boards/sof_sdw.c              |  5 +--
 sound/soc/intel/boards/sof_sdw_common.h       |  1 -
 sound/soc/intel/boards/sof_sdw_hdmi.c         | 37 +-----------------
 .../intel/common/soc-acpi-intel-adl-match.c   | 28 +++++++-------
 .../intel/common/soc-acpi-intel-cml-match.c   | 20 +++++-----
 .../intel/common/soc-acpi-intel-cnl-match.c   |  2 +-
 .../intel/common/soc-acpi-intel-glk-match.c   |  2 +-
 .../intel/common/soc-acpi-intel-icl-match.c   | 12 +++---
 .../intel/common/soc-acpi-intel-jsl-match.c   |  6 +--
 .../intel/common/soc-acpi-intel-kbl-match.c   |  2 +-
 .../intel/common/soc-acpi-intel-tgl-match.c   | 38 +++++++++----------
 27 files changed, 83 insertions(+), 144 deletions(-)

-- 
2.25.1

