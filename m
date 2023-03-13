Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED098C6FD19
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Mar 2023 11:05:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 720631485;
	Mon, 13 Mar 2023 12:04:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 720631485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678705501;
	bh=z0yDTszVdqqMH6WcbmzemIZ3EIQdFOZ/io+UezL2SoQ=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Cd1PLJeUfJ0aYtSEdAc1nr96zUxHRSXXCCu96+dhhy1KotEP3qiuLYqop6Gr0aBF8
	 r6Cfb+DiFiZqjJMQwd0AO3xpuFbBOYIZZ6MS3GOwXeAIZH9o7wFrfHrOCGHYKw+lJ5
	 bFbb3AkuXhcNCwJAW114/GnAqMDVsNckyDbuqx/Q=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 51981F8032D;
	Mon, 13 Mar 2023 12:03:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 530E0F804FE; Mon, 13 Mar 2023 12:03:43 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9863CF80093
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2023 12:03:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9863CF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Y6uISODG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678705415; x=1710241415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z0yDTszVdqqMH6WcbmzemIZ3EIQdFOZ/io+UezL2SoQ=;
  b=Y6uISODGTbdAWqYZ0jgA3XaqmZLOEMEuMa2gTrXunKpyQzH0trVDLMSV
   ubNFxzBupgUNykhPA0DH1ApPeBfED9dTrFt9FS6oqgHv4K3XOVjSWlz3/
   DMgFEFqbHbToQ6VVYd/EG5oNTDsVlVcQQs2/eRbNEGhw61V+F4jTXwUZ2
   InWubhEvR64q3xuIxpZjR4ulCN5pTSDO1rGVucHgaaOZzYJtRW8BVTX/N
   lfQyPqsiw+O1ML8y0WcxoZAkjj5IjC6xWkGUa792XXGzEpZ+rvcZPbveQ
   sFVkbVzfK31QxxHpULMe6hCJJ7IvPsELJhSLUtWXSVz9mIW5DAxuLvbE/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="423384064"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400";
   d="scan'208";a="423384064"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 04:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="655939060"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400";
   d="scan'208";a="655939060"
Received: from tchambon-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.43.68])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 04:03:20 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 0/7] ASoC: SOF: ipc4: Add support for bytes control
Date: Mon, 13 Mar 2023 13:03:37 +0200
Message-Id: <20230313110344.16644-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KUDW7Y2KP5BHD42TVI32K7ALIF3L5RLY
X-Message-ID-Hash: KUDW7Y2KP5BHD42TVI32K7ALIF3L5RLY
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 yung-chuan.liao@linux.intel.com, libin.yang@intel.com,
 jaska.uimonen@linux.intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KUDW7Y2KP5BHD42TVI32K7ALIF3L5RLY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

This series will add support for bytes control and topology types.
With IPC4 only the binary payload is sent to the firmware via LARGE_CONFIG
message (which does similar multi-part message handling as the IPC3 control
message did).

The bytes payload itself is not checked by the kernel but user space expected to
wrap it in sof_abi_hdr struct in order to get the target information of the
binary data.

The SOF firmware and sof-ctl have been updated to support blobs used in IPC4
setups.

Regards,
Peter
---
Libin Yang (2):
  ASoC: SOF: ipc4-control: set_volume_data only applies to VOLSW family
  ASoC: SOF: ipc4-topology: Add support for TPLG_CTL_BYTES

Peter Ujfalusi (5):
  ASoC: SOF: ipc3-control: Rename snd_sof_refresh_control()
  ASoC: SOF: ipc3-control: Merge functions to handle bytes_ext get
    variants
  ASoC: SOF: uapi: header: Convert sof_abi_hdr comments to kernel style
  ASoC: SOF: uapi: header: Update sof_abi_hdr doc for IPC4 use
  ASoC: SOF: ipc4-control: Add support for bytes control get and put

 include/uapi/sound/sof/abi.h    |   2 +
 include/uapi/sound/sof/header.h |  27 +++-
 sound/soc/sof/ipc3-control.c    |  90 ++++-------
 sound/soc/sof/ipc4-control.c    | 260 +++++++++++++++++++++++++++++++-
 sound/soc/sof/ipc4-topology.c   |  67 ++++++++
 5 files changed, 368 insertions(+), 78 deletions(-)

-- 
2.39.2

