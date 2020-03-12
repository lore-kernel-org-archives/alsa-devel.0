Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD2FC10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:35:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0966B20724
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EVLZ9VRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0966B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 502031725;
	Thu, 12 Mar 2020 20:34:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 502031725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584041699;
	bh=0WUpJUOyqZHlDSBF7abuY5J23vQ+Ccws/uGPli0qGBY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EVLZ9VRsM7K3eAgP9MiOUMh26UXcNnK9+5fE8qusAXXAEePMK53QNvDxLmSwnCzkl
	 FjfunXOGkJCmybY5h9Cuf3iB8DUvFrpdCtJkXYzNvfRMiC8LejCU0IQUKj1dGZJBv8
	 ebITUH3zOgKhjvEVW5NLHiNt1bUPjFD7jeQqaTlo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D844F801D9;
	Thu, 12 Mar 2020 20:34:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 388FEF8020C; Thu, 12 Mar 2020 20:34:07 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CC81F800BE
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 20:34:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CC81F800BE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 12:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; d="scan'208";a="243142313"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com)
 ([10.251.241.169])
 by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 12:33:58 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/10] ASoC: SOF: Intel: add SoundWire support
Date: Thu, 12 Mar 2020 14:33:36 -0500
Message-Id: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

This patchset provides the support for SoundWire support on Intel
CometLake, IcelLake and TigerLake RVP platforms and form-factor
devices to be released 'soon'.

The bulk of the code is about detecting a valid SoundWire
configuration from ACPI, and implementing the interfaces suggested in
'[PATCH 0/8] soundwire: remove platform devices, add SOF interfaces'
for interrupts, PCI wakes and clock-stop configurations.

Since that SoundWire series is stuck with no resolution, the build
support for SOF w/ SoundWire is not provided for now, and fall-back
functions will be used. This code is tested on a daily basis in the
SOF tree and is not expected to change. If audio maintainers will only
accept functional code, which isn't unreasonable, I would kindly ask
that they reach out to Vinod Koul.

Bard Liao (1):
  ASoC: SOF: Intel: hda: merge IPC, stream and SoundWire interrupt
    handlers

Pierre-Louis Bossart (7):
  ASoC: soc-acpi: expand description of _ADR-based devices
  ASoC: SOF: Intel: add SoundWire configuration interface
  ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
  ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
  ASoC: SOF: Intel: hda: initial SoundWire machine driver autodetect
  ASoC: SOF: Intel: hda: disable SoundWire interrupts on suspend
  ASoC: SOF: Intel: hda: add parameter to control SoundWire clock stop
    quirks

Rander Wang (2):
  ASoC: SOF: Intel: hda: add WAKEEN interrupt support for SoundWire
  Asoc: SOF: Intel: hda: check SoundWire wakeen interrupt in irq thread

 include/sound/soc-acpi.h                      |  39 +-
 include/sound/sof/dai-intel.h                 |  18 +-
 .../intel/common/soc-acpi-intel-cml-match.c   |  87 +++-
 .../intel/common/soc-acpi-intel-icl-match.c   |  97 ++++-
 .../intel/common/soc-acpi-intel-tgl-match.c   |  49 ++-
 sound/soc/sof/intel/hda-dsp.c                 |   2 +
 sound/soc/sof/intel/hda-loader.c              |  31 ++
 sound/soc/sof/intel/hda.c                     | 399 ++++++++++++++++++
 sound/soc/sof/intel/hda.h                     |  66 +++
 9 files changed, 728 insertions(+), 60 deletions(-)


base-commit: 101247a3b86e1cc0e382b7e887a56176290fc957
-- 
2.20.1

