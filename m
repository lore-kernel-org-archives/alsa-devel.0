Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78F4CD54B0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Sep 2023 10:43:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B99D9DF6;
	Tue, 19 Sep 2023 12:42:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B99D9DF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695120229;
	bh=FPj8xAZ/tX0/uiWeQ1XcYGgFLfr0YGFIH6xExBsUNdw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jPXUooXFV0BGQn/a3PQflJ8L2nEpH5X1FhmRFNJDWIgUtZDbXtKiZ3fnPQRKfwtQi
	 PUxg2829T0jWW6mag1tZy7diGPF4HmclnvX3TFVg6hapnlGibZCFHwrZkwFZgg6And
	 txp4Q0D93XTg5R5E4IHJZm55k0v5CYJhmRE/rt7E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A12EBF80494; Tue, 19 Sep 2023 12:42:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03CD8F80494;
	Tue, 19 Sep 2023 12:42:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C595DF80125; Tue, 19 Sep 2023 12:42:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3EC67F80125
	for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2023 12:42:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EC67F80125
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kEvaOgTH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695120144; x=1726656144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FPj8xAZ/tX0/uiWeQ1XcYGgFLfr0YGFIH6xExBsUNdw=;
  b=kEvaOgTHcl1tM7uyox+nWbE9lQQZ7e/euUrw60ajWhQbQ3etLS6HkaSE
   ys+8jmW2KnjN+20g1tM6L4WXid9g+WSxYkQhNjg+9WeMSQ9yC0miJTjvx
   u0zIgoZDWPF9ykbw1OCaHB8oCEbsNxNueFJF/TAWcHchMozoMR/9EJFUO
   mpr3N8KPuIDPH6YmIcQnEsAJyJqETZICk1x5kNoFU/cq2Ujmjd+BTd484
   9z7yU8d01/cMLoFdbujSiAbscEbGeapbNqTR0DFrZPsOAIpFdkILWL9We
   LmXF4nxyeKWl2pUraeF4yWcO/j2CGAYNK3OjV4B5JPbEBoLFz+OpWRdQ4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="382658435"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000";
   d="scan'208";a="382658435"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 03:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722823178"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000";
   d="scan'208";a="722823178"
Received: from mokashi-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.50.26])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 03:42:18 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	daniel.baluta@nxp.com,
	rander.wang@intel.com
Subject: [PATCH 0/9] ASoC: SOF: Use generic IPC type identifiers
Date: Tue, 19 Sep 2023 13:42:17 +0300
Message-ID: <20230919104226.32239-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QGIRASOXWEX3FJRM7FN2CVYQDZ2PFDFO
X-Message-ID-Hash: QGIRASOXWEX3FJRM7FN2CVYQDZ2PFDFO
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QGIRASOXWEX3FJRM7FN2CVYQDZ2PFDFO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

rename the IPC type defines to be more generic and intuitive:
SOF_IPC -> SOF_IPC_TYPE_3
SOF_INTEL_IPC4 -> SOF_IPC_TYPE_4

No functional change, just renaming all around.

Regards,
Peter
---
Peter Ujfalusi (9):
  ASoC: SOF: Introduce generic names for IPC types
  ASoC: SOF: sof-pci-dev: Update the ipc_type module parameter
    description
  ASoC: SOF: Kconfig: Rename SND_SOC_SOF_INTEL_IPC4 to SND_SOC_SOF_IPC4
  ASoC: SOF: Use generic names for IPC types
  ASoC: SOF: amd: Use generic names for IPC types
  ASoC: SOF: imx: Use generic names for IPC types
  ASoC: SOF: Intel: Use generic names for IPC types
  ASoC: SOF: mediatek: Use generic names for IPC types
  ASoC: SOF: Drop unused IPC type defines

 include/sound/sof.h                         |   4 +-
 sound/soc/sof/Kconfig                       |   2 +-
 sound/soc/sof/Makefile                      |   4 +-
 sound/soc/sof/amd/pci-rmb.c                 |  10 +-
 sound/soc/sof/amd/pci-rn.c                  |  10 +-
 sound/soc/sof/amd/pci-vangogh.c             |  10 +-
 sound/soc/sof/imx/imx8.c                    |  20 +--
 sound/soc/sof/imx/imx8m.c                   |  10 +-
 sound/soc/sof/imx/imx8ulp.c                 |  10 +-
 sound/soc/sof/intel/Kconfig                 |  14 +-
 sound/soc/sof/intel/apl.c                   |   4 +-
 sound/soc/sof/intel/bdw.c                   |  10 +-
 sound/soc/sof/intel/byt.c                   |  30 ++--
 sound/soc/sof/intel/cnl.c                   |   4 +-
 sound/soc/sof/intel/hda-dai-ops.c           |   4 +-
 sound/soc/sof/intel/hda-dai.c               |   4 +-
 sound/soc/sof/intel/hda-loader.c            |   2 +-
 sound/soc/sof/intel/hda.c                   |   2 +-
 sound/soc/sof/intel/icl.c                   |   4 +-
 sound/soc/sof/intel/pci-apl.c               |  36 ++---
 sound/soc/sof/intel/pci-cnl.c               |  54 ++++----
 sound/soc/sof/intel/pci-icl.c               |  36 ++---
 sound/soc/sof/intel/pci-lnl.c               |  10 +-
 sound/soc/sof/intel/pci-mtl.c               |  12 +-
 sound/soc/sof/intel/pci-skl.c               |  20 +--
 sound/soc/sof/intel/pci-tgl.c               | 144 ++++++++++----------
 sound/soc/sof/intel/pci-tng.c               |  10 +-
 sound/soc/sof/intel/tgl.c                   |   4 +-
 sound/soc/sof/ipc.c                         |   6 +-
 sound/soc/sof/ipc3-dtrace.c                 |   2 +-
 sound/soc/sof/mediatek/mt8186/mt8186.c      |  20 +--
 sound/soc/sof/mediatek/mt8195/mt8195.c      |  10 +-
 sound/soc/sof/sof-acpi-dev.c                |   8 +-
 sound/soc/sof/sof-client-ipc-msg-injector.c |   4 +-
 sound/soc/sof/sof-client-probes.c           |   6 +-
 sound/soc/sof/sof-client.c                  |  26 ++--
 sound/soc/sof/sof-of-dev.c                  |   6 +-
 sound/soc/sof/sof-pci-dev.c                 |   2 +-
 38 files changed, 286 insertions(+), 288 deletions(-)

-- 
2.42.0

