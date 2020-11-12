Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C77DC2D0E4
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 22:39:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F4322227
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 22:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t3urlidP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F4322227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2943C181E;
	Thu, 12 Nov 2020 23:39:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2943C181E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605220790;
	bh=azCyWjlrf52LZlKhRfrd/TOC3wVN2HKW1wGoDGI+guA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t3urlidPirPzTCJ7EtPBGocqK9ImJOElucqnyi5pJTGSjbD685zDiq/kemssa4bSm
	 4E3fzrzKgd4VqCJqP8oVFZUdGrumljA/L9iHLf6koIShEilBrgRT9tQar6SW1jGVfb
	 iGpRB77yLxTvrPFztjCqJSy8zCpsgqkweJkKbefE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24407F802C4;
	Thu, 12 Nov 2020 23:38:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BCAAF8021C; Thu, 12 Nov 2020 23:38:57 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B1F8F8007E
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 23:38:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B1F8F8007E
IronPort-SDR: yKwcJtK1rlqGgXcW+y4yk89xF30JCdvP8uQn5BKYvQ3poWgrkFF629S6wMNgw1UZHYnnCrOhML
 9OtIImDRv0aA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="166884993"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; d="scan'208";a="166884993"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 14:38:50 -0800
IronPort-SDR: 3d+e7C5oDLqt68HNzwKu1LpJibKoHzqX2RRf/tBISW1IXZAhEjkGJtf6wSTxvEkDnegAzU41Q0
 9PeXU/5gWyLw==
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; d="scan'208";a="323797442"
Received: from gjshield-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.213.180.118])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 14:38:49 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/14] ASoC: Intel/SOF: extend run-time driver selection to
 ACPI devices
Date: Thu, 12 Nov 2020 16:38:11 -0600
Message-Id: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Hans de Goede <hdegoede@redhat.com>, broonie@kernel.org,
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

The module snd-intel-dspcfg, suggested by Jaroslav last year,
currently provide the means to select a PCI driver at run-time, based
on quirks, recommendations or user selection via a kernel
parameter. This capability removed a lot of confusions in
distributions and removed the need for recompilations to select legacy
HDaudio, SST or SOF drivers.

This patchset extends the concept to ACPI devices. This was driven by
the desire to at some point deprecate the Atom/SST driver for Baytrail
and Cherrytrail, which is no longer maintained by Intel. By having the
SOF driver enabled by distributions for Baytrail/Cherrytrail, we can
enable more end-user tests and make the transition easier for
distributions (likely in 2021 at this point).

This patchset provides the same solution for Broadwell, mainly to have
a single build for all Intel platforms. SOF on Broadwell remains an
option not recommended for distributions, as long as the 'catpt'
driver is maintained there is no burning desire to make SOF the
default on the three Broadwell-based platforms with the DSP
enabled.

Pierre-Louis Bossart (14):
  ASoC: Intel: broadwell: add missing pm_ops
  ASoC: Intel: bdw-rt5677: add missing pm_ops
  ALSA: hda: intel-dsp-config: add helper for ACPI DSP driver selection
  ASoC: soc-acpi: add helper to identify parent driver.
  ASoC: Intel: boards: byt/cht: set card and driver name at run time
  ASoC: Intel: byt/cht: set pm ops dynamically
  ASoC: SOF: acpi: add dynamic selection of DSP driver
  ASoC: Intel: Atom: add dynamic selection of DSP driver
  ASoC: SOF: Intel: allow for coexistence between SOF and Atom/SST
    drivers
  ALSA: hda: intel-dsp-config: add Broadwell ACPI DSP driver selection
  ASoC: Intel: broadwell: set card and driver name dynamically
  ASoC: Intel: catpt: add dynamic selection of DSP driver
  ASoC: SOF: Intel: allow for coexistence between SOF and catpt drivers
  ALSA: hda: intel-dsp-config: ignore dsp_driver parameter for PCI
    legacy devices

 include/sound/intel-dsp-config.h             |   7 ++
 include/sound/soc-acpi.h                     |   6 +
 sound/hda/intel-dsp-config.c                 | 111 +++++++++++++++++++
 sound/soc/intel/Kconfig                      |   2 +
 sound/soc/intel/atom/sst/sst_acpi.c          |   8 ++
 sound/soc/intel/boards/bdw-rt5650.c          |  17 ++-
 sound/soc/intel/boards/bdw-rt5677.c          |  18 ++-
 sound/soc/intel/boards/broadwell.c           |  20 ++--
 sound/soc/intel/boards/bytcht_cx2072x.c      |  27 +++--
 sound/soc/intel/boards/bytcht_da7213.c       |  27 +++--
 sound/soc/intel/boards/bytcht_es8316.c       |  29 +++--
 sound/soc/intel/boards/bytcr_rt5640.c        |  30 +++--
 sound/soc/intel/boards/bytcr_rt5651.c        |  27 +++--
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |  29 +++--
 sound/soc/intel/boards/cht_bsw_nau8824.c     |  29 +++--
 sound/soc/intel/boards/cht_bsw_rt5645.c      |  38 ++++---
 sound/soc/intel/boards/cht_bsw_rt5672.c      |  29 +++--
 sound/soc/intel/catpt/device.c               |  12 ++
 sound/soc/sof/intel/Kconfig                  |  33 +++---
 sound/soc/sof/sof-acpi-dev.c                 |  14 ++-
 20 files changed, 392 insertions(+), 121 deletions(-)

-- 
2.25.1

