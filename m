Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4151C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:07:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9F3610FC
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D9F3610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 642BF836;
	Wed,  6 Oct 2021 13:06:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 642BF836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633518466;
	bh=k8g4mlUDhMVM0MFUNmf5+zReLCJgDEPtl2pVen6shc8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=La9A4vGKnfOCUG4R9KQ/gM+wt2I9KxUorBT7aMYf3SVUBOaZmF11LasOfs3nddw00
	 NQRW6aXF7kxA2hw6cEW6BrtBWETMaCRLom+xUyxD8bK4at8UyegHNdgcp3Kklp7n9f
	 +ETxLnckbiRiJhbckzda/zGzeA0TV/dEp/UZYDas=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEF42F802D2;
	Wed,  6 Oct 2021 13:06:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0EBF3F8025C; Wed,  6 Oct 2021 13:06:54 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69508F80229
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 13:06:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69508F80229
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="223366411"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="223366411"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 04:06:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="439080899"
Received: from byurovit-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.39.239])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 04:06:38 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 00/19] ASoC: SOF: Improvements for debugging
Date: Wed,  6 Oct 2021 14:06:26 +0300
Message-Id: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

The aim of this series is to clean up, make it easier to interpret and less
'chatty' prints aimed for debugging errors.

For example currently the DSP/IPC dump is printed every time we have an IPC
timeout and it is posible to lost the first and more indicative dump to find the
rootcause.

Regards,
Peter
---
Peter Ujfalusi (18):
  ASoC: SOF: debug: Swap the dsp_dump and ipc_dump sequence for
    fw_exception
  ASoC: SOF: ipc and dsp dump: Add markers for better visibility
  ASoC: SOF: Print the dbg_dump and ipc_dump once to reduce kernel log
    noise
  ASoC: SOF: loader: Print the DSP dump if boot fails
  ASoC: SOF: intel: atom: No need to do a DSP dump in atom_run()
  ASoC: SOF: debug/ops: Move the IPC and DSP dump functions out from the
    header
  ASoC: SOF: debug: Add SOF_DBG_DUMP_OPTIONAL flag for DSP dumping
  ASoC: SOF: intel: hda-loader: Use snd_sof_dsp_dbg_dump() for DSP dump
  ASoC: SOF: Drop SOF_DBG_DUMP_FORCE_ERR_LEVEL and sof_dev_dbg_or_err
  ASoC: SOF: debug: Print out the fw_state along with the DSP dump
  ASoC: SOF: ipc: Re-enable dumps after successful IPC tx
  ASoC: SOF: ops: Force DSP panic dumps to be printed
  ASoC: SOF: Introduce macro to set the firmware state
  ASoC: SOF: intel: hda: Drop 'error' prefix from error dump functions
  ASoC: SOF: core: Clean up snd_sof_get_status() prints
  ASoC: SOF: loader: Drop SOF_DBG_DUMP_REGS flag when firmware start
    fails
  ASoC: SOF: Intel: hda-loader: Drop SOF_DBG_DUMP_REGS flag from
    dbg_dump calls
  ASoC: SOF: Intel: hda: Dump registers and stack when SOF_DBG_DUMP_REGS
    is set

Pierre-Louis Bossart (1):
  ASoC: SOF: core: debug: force all processing on primary core

 sound/soc/sof/core.c             | 24 ++++++-------
 sound/soc/sof/debug.c            | 61 ++++++++++++++++++++++++++++++--
 sound/soc/sof/intel/atom.c       |  5 +--
 sound/soc/sof/intel/hda-loader.c | 11 +++---
 sound/soc/sof/intel/hda.c        | 16 +++------
 sound/soc/sof/ipc.c              | 10 ++++--
 sound/soc/sof/loader.c           | 11 ++++--
 sound/soc/sof/ops.c              |  3 ++
 sound/soc/sof/ops.h              | 12 +------
 sound/soc/sof/pm.c               |  6 ++--
 sound/soc/sof/sof-priv.h         | 31 ++++++++++------
 sound/soc/sof/topology.c         |  6 ++++
 12 files changed, 131 insertions(+), 65 deletions(-)

-- 
2.33.0

