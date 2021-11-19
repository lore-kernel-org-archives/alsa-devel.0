Return-Path: <SRS0=cfk+=QG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB1C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Nov 2021 19:35:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1987261AF0
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Nov 2021 19:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1987261AF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C314A1772;
	Fri, 19 Nov 2021 20:34:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C314A1772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637350510;
	bh=HA2UCaOWOtheg3KpYfWWBH1E+3K3G28UPgGRDe2goVs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tC8zvPS2Xl6oN3y3KifE2/5/pKLDDsre81A684Kc+bk0gDIg2ZcSrp9qkBq9DxMEQ
	 xSsICJ3hryoRptpPwE7Hlh/fJC9Lxr3I9iwif8NfEwAvLzn7CYIPul+bkNTalRwn8N
	 R28BGz2RpQi8V8BqRT5OQmvE9ftNlxI7hzGab1Po=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35CB5F8026D;
	Fri, 19 Nov 2021 20:34:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F08FCF8028B; Fri, 19 Nov 2021 20:34:17 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7DC3EF80115
 for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2021 20:34:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DC3EF80115
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="215192440"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="215192440"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 11:34:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="473651106"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 11:34:01 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 00/10] ASoC: SOF: enable multicore with dynamic pipelines
Date: Fri, 19 Nov 2021 21:26:11 +0200
Message-Id: <20211119192621.4096077-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

Hi,

initial support for SOF dynamic pipelines was added in commit
5fcdbb2d45df ("ASoC: SOF: Add support for dynamic pipelines").

When a pipeline is marked dynamic in the SOF DSP firmware
topology definition (the tplg file kernel loads from filesystem),
it means the pipeline resources are not allocated when DSP is
booted (at driver probe, or at runtime resume), but rather delayed
until the pipeline is actually used.

Until now, it has not been possible to use multiple DSP cores
in a topology that uses dynamic pipeline capability. This patchset
addresses this gap and allows to freely mix dynamic pipelines
and multicore usages in topology definitions.

The series was originally reviewed in
https://github.com/thesofproject/linux/pull/3019

Ranjani Sridharan (10):
  ASoC: SOF: Intel: hda: expose get_chip_info()
  ASoC: SOF: Introduce num_cores and ref count per core
  ASoC: SOF: Add ops for core_get and core_put
  ASoC: SOF: Intel: TGL: set core_get/put ops
  ASoC: SOF: Intel: CNL/ICL/APL: set core_get/core_put ops
  ASoC: SOF: topology: remove sof_load_pipeline_ipc()
  ASoC: SOF: free widgets in sof_tear_down_pipelines() for static
    pipelines
  ASoC: SOF: hda: don't use the core op for power up/power down
  ASoC: SOF: add support for dynamic pipelines with multi-core
  ASoC: SOF: Intel: hda: free DAI widget during stop and suspend

 sound/soc/sof/imx/imx8.c         |   1 +
 sound/soc/sof/imx/imx8m.c        |   1 +
 sound/soc/sof/intel/apl.c        |   5 +-
 sound/soc/sof/intel/bdw.c        |   9 +++
 sound/soc/sof/intel/byt.c        |   9 +++
 sound/soc/sof/intel/cnl.c        |   5 +-
 sound/soc/sof/intel/hda-dai.c    |  23 +------
 sound/soc/sof/intel/hda-dsp.c    |  52 +++++++++++++++-
 sound/soc/sof/intel/hda-loader.c |  24 +++++---
 sound/soc/sof/intel/hda.c        |  17 ++----
 sound/soc/sof/intel/hda.h        |   1 +
 sound/soc/sof/intel/icl.c        |   5 +-
 sound/soc/sof/intel/pci-tng.c    |   9 +++
 sound/soc/sof/intel/shim.h       |   7 +++
 sound/soc/sof/intel/tgl.c        |  46 +++++++++++++-
 sound/soc/sof/ops.h              |  71 ++++++++++++++++------
 sound/soc/sof/sof-audio.c        |  83 +++++++++++++++++++------
 sound/soc/sof/sof-audio.h        |   6 --
 sound/soc/sof/sof-priv.h         |  21 +++++--
 sound/soc/sof/topology.c         | 100 -------------------------------
 20 files changed, 294 insertions(+), 201 deletions(-)


base-commit: 626a3dfbdb5d11f92e709680135abf272057ef59
-- 
2.33.0

