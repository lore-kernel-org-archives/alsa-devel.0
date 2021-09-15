Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F359C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 12:22:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9813961350
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 12:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9813961350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2AC2181A;
	Wed, 15 Sep 2021 14:21:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2AC2181A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631708542;
	bh=6lvfXuUcUTTHiqN+H0JPa3IxrR2B/ivVnk16UtddFW0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bUAeddfRJqL7RbD8aKln2XUoRgISsb6eCqxYjrQd6BrtoqNyEwRGzNCKGMTBkNgm+
	 Gwbixzu9aQ5euPMaOy7aEGYckUrlPwRNuR3vhrdqXqHf3UUNG6p3WGY0ng9w2DFQwn
	 i28iJ6fCAm+Qd9bZVnA4gY8so5ysi2alxsFD0Smc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25DE4F8032C;
	Wed, 15 Sep 2021 14:21:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FE77F80132; Wed, 15 Sep 2021 14:21:30 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DDE1F80132
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 14:21:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DDE1F80132
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="219117481"
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; d="scan'208";a="219117481"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 05:21:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; d="scan'208";a="544901564"
Received: from msavu-mobl1.ti.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.216.36])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 05:21:18 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 00/12] ASoC: SOF: Abstract away the 'bar' usage (mostly)
Date: Wed, 15 Sep 2021 15:21:04 +0300
Message-Id: <20210915122116.18317-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 daniel.baluta@gmail.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

The direct use of 'bar' as address regions in SOF can limit portability and
makes assumption that all platforms are using memory mapped regions or BARs
to communicate with the DSP.

The core API should not use 'bar' in it's parameter lists or make assumption
that the platform needs to comply with this system integration.

Use the region type as an ID in core and translate that in platform dependent
code to a way to access registers, mailbox or DSP memory.

Regards,
Peter
---
Peter Ujfalusi (12):
  ASoC: SOF: Intel: bdw: Set the mailbox offset directly in bdw_probe
  ASoC: SOF: ipc: Remove snd_sof_dsp_mailbox_init()
  ASoC: SOF: imx: Do not initialize the snd_sof_dsp_ops.read64
  ASoC: SOF: imx: imx8: Bar index is only valid for IRAM and SRAM types
  ASoC: SOF: imx: imx8m: Bar index is only valid for IRAM and SRAM types
  ASoC: SOF: loader: No need to export snd_sof_fw_parse_ext_data()
  ASoC: SOF: core: Do not use 'bar' as parameter for block_read/write
  ASoC: SOF: debug: Add generic API and ops for DSP regions
  ASoC: SOF: imx: Provide debugfs_add_region_item ops for core
  ASoC: SOF: Intel: Provide debugfs_add_region_item ops for core
  ASoC: SOF: loader: Use the generic ops for region debugfs handling
  ASoC: SOF: debug: No need to export the snd_sof_debugfs_io_item()

 sound/soc/sof/debug.c         |  24 ++++--
 sound/soc/sof/imx/imx8.c      |  17 +++--
 sound/soc/sof/imx/imx8m.c     |  13 +++-
 sound/soc/sof/intel/apl.c     |   1 +
 sound/soc/sof/intel/bdw.c     |   5 +-
 sound/soc/sof/intel/byt.c     |   2 +
 sound/soc/sof/intel/cnl.c     |   1 +
 sound/soc/sof/intel/icl.c     |   1 +
 sound/soc/sof/intel/pci-tng.c |   1 +
 sound/soc/sof/intel/tgl.c     |   1 +
 sound/soc/sof/ipc.c           |  34 +++------
 sound/soc/sof/loader.c        | 137 +++++++++++++++-------------------
 sound/soc/sof/ops.h           |  25 +++++--
 sound/soc/sof/sof-priv.h      |  55 +++++++-------
 sound/soc/sof/utils.c         |  28 +++++--
 15 files changed, 187 insertions(+), 158 deletions(-)

-- 
2.33.0

