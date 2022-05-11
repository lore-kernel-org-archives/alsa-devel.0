Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A58C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 11 May 2022 17:18:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13CA71A98;
	Wed, 11 May 2022 19:17:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13CA71A98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652289511;
	bh=GGDA2L6QfFN5o3Y4tteKLWLAM2pmth0a41X01raLh0I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q1WySK4HPBq8cJI8hqu7zEXFLQIdvmCrv3/rHFrxhbXkPuRiG+UlQKFnzuQHv2N86
	 joi1ySI3/0TTZEoukFN2SNA/0zTTP3Pl4AduTVSRtWbs6PPiO5un0iefk3O+rNKkcg
	 iIMRV+u+DtNLMDCr0xRsXTp2RasGJr3+6ESBvHbM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA670F804B2;
	Wed, 11 May 2022 19:17:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E133F804B2; Wed, 11 May 2022 19:17:10 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54068F80137
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2022 19:16:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54068F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="dGToZ7/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652289427; x=1683825427;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GGDA2L6QfFN5o3Y4tteKLWLAM2pmth0a41X01raLh0I=;
 b=dGToZ7/CQF/x/KHtuymGw2t99+rnfldOwgbeqa+0KbUe9WVXBjgnoSjw
 Bdl7tO2zwuKvD34qM4BSZZvKP9OtZ4MQz7NAMRv5lklVVig8nAFTd76hG
 HxZSEXHcVeWOCga/zHsGWdR4MumUG1qcw0cWmOkkMUsKf4drRy9lj9oIu
 WUWg4hpk+nEdNUyBZadkBc5qtxfG7SjTHudcG6LrORVszeOtmSfhc9hKm
 BwCTsteGfRQPhM8ARIW1GB7rEM5bOl9+8Hal4tx8Ct2PI0GtTjcrtkOVi
 HHWfaqg5r4IYZrXW9KpNzGzhbwRQyhQOmg/+eF/+9u/MZyqsAydm7qr+E Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269431624"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; d="scan'208";a="269431624"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 10:16:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; d="scan'208";a="697663166"
Received: from sjbrune-mobl.amr.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.254.32.42])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 10:16:53 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] ASoC: SOF: Add IPC4 FW loader support
Date: Wed, 11 May 2022 10:16:43 -0700
Message-Id: <20220511171648.1622993-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: broonie@kernel.org, tiwai@suse.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

The patches in this series add support for FW loading for IPC4 in the SOF
driver.

Ranjani Sridharan (5):
  ASoC: SOF: Intel: HDA: Set IPC4-specific DSP ops for CaVS platforms
  ASoC: SOF: Add IPC4 private header
  ASoC: SOF: Add header for IPC4 manifest
  ASoC: SOF: IPC4: Add FW loader ops
  ASoC: SOF: Intel: HDA: Set up sof_ipc4_fw_data for IPC4

 include/sound/sof/ext_manifest4.h | 119 +++++++++++++++++
 sound/soc/sof/Makefile            |   2 +-
 sound/soc/sof/intel/apl.c         |  29 ++++-
 sound/soc/sof/intel/cnl.c         | 109 +++++++++++++++-
 sound/soc/sof/intel/hda-ipc.c     |  82 ++++++++++++
 sound/soc/sof/intel/hda.h         |   6 +
 sound/soc/sof/intel/tgl.c         |  29 ++++-
 sound/soc/sof/ipc4-loader.c       | 210 ++++++++++++++++++++++++++++++
 sound/soc/sof/ipc4-priv.h         |  44 +++++++
 sound/soc/sof/ipc4.c              |   2 +
 10 files changed, 619 insertions(+), 13 deletions(-)
 create mode 100644 include/sound/sof/ext_manifest4.h
 create mode 100644 sound/soc/sof/ipc4-loader.c
 create mode 100644 sound/soc/sof/ipc4-priv.h

-- 
2.25.1

