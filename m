Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBBDC7618D
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Apr 2023 15:52:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BA57F17;
	Thu,  6 Apr 2023 17:51:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BA57F17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680796324;
	bh=LyHJlQRxYcmvFRVotnkXgAUICzUMQRXtMazHJcVmpa4=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SM8qhwk6UTvPVsXLjlJrVyNTgPdInCLJQNFhixPGpuCc9i+IV/cn8j3Zdhhh1ciW9
	 Y32npMK+7EF3mMTT8Unie3CHevLHpbIPQw/hxmZMzZbfbGquggMsSyOlVYe9GAQ1OZ
	 ZbKcxADAum5fh+T4cUWvWg081xHWPMSus5yUJuJQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ACD8FF80249;
	Thu,  6 Apr 2023 17:50:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D99DF80249; Thu,  6 Apr 2023 17:50:47 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6337DF80149
	for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2023 17:50:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6337DF80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZHDX+Zkp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680796243; x=1712332243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LyHJlQRxYcmvFRVotnkXgAUICzUMQRXtMazHJcVmpa4=;
  b=ZHDX+Zkp+Fiy0GOCYikjktGwJBSGSNWAppJ7dw7ME5d1LoMC7OEAL6+G
   pyJZREicgDf+pyo54O5xKHwqzRurXKGkulVag8KIkOEuKprg9PSP7vP+v
   /wKjAtQ4VPtp8gZJ9PxVO7zGpuG+h1t9f5YFyK3QtIdWqqC7MYhrHSaxw
   nsLdTaEGk/26njqco53ct5QR51+pDWUEEhU8scDJtcgZQR+9Or+40KTs5
   UmpBzN4+uClHIXA45Ixhll2z5qJvjqNIjaxNrju4QQfetgDUtzMu9W9z1
   AeQLcfJj1GbOq9JLCSflKuBnY44seNb9GXEBTrDL9cCtBnj+1wWO2FoB/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="331407019"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400";
   d="scan'208";a="331407019"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2023 08:50:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="830802324"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400";
   d="scan'208";a="830802324"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.83.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2023 08:50:38 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ASoC: SOF: add no_reply IPC calls
Date: Thu,  6 Apr 2023 10:50:24 -0500
Message-Id: <20230406155026.18723-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RTXAJOTUKUZM2OPODOSYVL2O76TY6HMR
X-Message-ID-Hash: RTXAJOTUKUZM2OPODOSYVL2O76TY6HMR
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RTXAJOTUKUZM2OPODOSYVL2O76TY6HMR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Simplify IPC messages to avoid passing a reply structure that is not
used later.

Curtis Malainey (2):
  ASoC: SOF: ipc: Add no reply inline calls
  ASoC: SOF: Use no_reply calls for TX

 sound/soc/sof/compress.c                  | 12 +++------
 sound/soc/sof/intel/hda-loader.c          |  2 +-
 sound/soc/sof/ipc3-dtrace.c               | 12 +++------
 sound/soc/sof/ipc3-pcm.c                  |  6 ++---
 sound/soc/sof/ipc3-topology.c             | 33 +++++++----------------
 sound/soc/sof/ipc3.c                      | 12 +++------
 sound/soc/sof/ipc4-pcm.c                  |  6 ++---
 sound/soc/sof/ipc4-topology.c             | 10 +++----
 sound/soc/sof/sof-client-ipc-flood-test.c |  3 +--
 sound/soc/sof/sof-client-probes-ipc3.c    | 12 +++------
 sound/soc/sof/sof-client-probes-ipc4.c    |  4 +--
 sound/soc/sof/sof-client.h                |  4 +++
 sound/soc/sof/sof-priv.h                  | 10 +++++++
 13 files changed, 52 insertions(+), 74 deletions(-)

-- 
2.37.2

