Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCE7C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 12:23:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D37A6325A
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 12:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D37A6325A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87B3C16A0;
	Mon, 15 Nov 2021 13:23:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87B3C16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636979032;
	bh=l8NVcFx1UtPiGLOQnf/XdgVu5ChbfBnerADa+8WYqD4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DOtDTC0A+l+wCypaI10EaDyWIwd0JbMPBxr/zrHmKlnP8Ge+kv/1oYagpKep1RfI8
	 6/cK8RiLynBGx4Bcne9HSq+7vAmU5rro2n1XzpuioFm2oZtRpPRTHuS2IvnQ8TgqzR
	 NqdWVjF9+gbZ2O6czk7eTqTQqItQstnQ5/I5Rd3I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9930F802A0;
	Mon, 15 Nov 2021 13:23:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D978F800FA; Mon, 15 Nov 2021 13:23:00 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47029F800FA
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 13:22:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47029F800FA
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220639115"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; d="scan'208";a="220639115"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 04:22:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; d="scan'208";a="505899042"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 04:22:50 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [RESEND PATCH 00/10] ASoC: Intel: sof_sdw: Use fixed DAI link id
Date: Mon, 15 Nov 2021 20:22:31 +0800
Message-Id: <20211115122241.13242-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com
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

This series provides a way to use constant dailink numbers for different
devices. So that we don't need to renumber them in topologies.
Some patches with different purpose are sent together in this series
since they are dependent.

Bard Liao (8):
  ASoC: intel: sof_sdw: return the original error number
  ASoC: intel: sof_sdw: rename be_index/link_id to link_index
  ASoC: intel: sof_sdw: Use a fixed DAI link id for AMP
  ASoC: intel: sof_sdw: move DMIC link id overwrite to
    create_sdw_dailink
  ASoC: intel: sof_sdw: remove SOF_RT715_DAI_ID_FIX quirk
  ASoC: intel: sof_sdw: remove sof_sdw_mic_codec_mockup_init
  ASoC: intel: sof_sdw: remove get_next_be_id
  ASoC: intel: sof_sdw: add link adr order check

Pierre-Louis Bossart (2):
  ASoC: Intel: sof_sdw: fix jack detection on HP Spectre x360
    convertible
  ASoC: Intel: sof_sdw: add SKU for Dell Latitude 9520

 sound/soc/intel/boards/sof_sdw.c            | 152 ++++++++++----------
 sound/soc/intel/boards/sof_sdw_common.h     |   7 +-
 sound/soc/intel/boards/sof_sdw_rt715.c      |   7 -
 sound/soc/intel/boards/sof_sdw_rt715_sdca.c |   7 -
 4 files changed, 85 insertions(+), 88 deletions(-)

-- 
2.17.1

