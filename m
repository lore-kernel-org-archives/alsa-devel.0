Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6589FC6FD1F
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Mar 2023 14:02:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44555E87;
	Wed, 22 Mar 2023 15:01:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44555E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679493725;
	bh=JBasbFI/uq7f/ElgY+UaW6HR6Jc6pFScoGpMzD6+wvY=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qPu0XdRhd2oxeNWSxCm998hQkXP17/rEDVoOMtrG87C3Oo02vQWsUgrhp3VTYsQxP
	 iKNaAHU0qsOrXUsV+S62I7AqWv1AzWP71LR65e/8xDFawa0ZPZ22TPvWIJmLNWkvwR
	 YvJW8zsC7K8q2HAyzeZC5WtNgaHuiPllwnTFm/cA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DCC0BF802E8;
	Wed, 22 Mar 2023 15:00:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F201F8024E; Wed, 22 Mar 2023 15:00:46 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DFBC5F8024E
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2023 15:00:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFBC5F8024E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jwXWen+o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679493642; x=1711029642;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JBasbFI/uq7f/ElgY+UaW6HR6Jc6pFScoGpMzD6+wvY=;
  b=jwXWen+oOVvDluzuiNQl1kslT0ewNuazC2gA0raJSB4iIP8AnVVHTAqK
   KsbkMtOE2p+Q0OZHauJ8+3F0wxttIh9Q40EI608tdjcfsdcjUkUkVxJLA
   fw0Nmm6qXd17vAEM+55dm8WFe70jx2FvhtdRE2YOmDuhhwYH4SLjtW+hE
   bPx2aGSQAJlK00F6ajFLsxTjoE/ThqUt7UHcv9gHXxfi1N//jwl3d2CFe
   T6q9G7lpsXK8qlB0eHdwfnjL5fifGiQvv/NQCtzUZAxdRjDlu7tAGDi2l
   GfP9TC09ioBJrbGyK4vMIqVR0SBUvHR1ZgI9vybIQEq5UehByLhrtFR6M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341575977"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400";
   d="scan'208";a="341575977"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2023 06:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="659197887"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400";
   d="scan'208";a="659197887"
Received: from cmelen-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.222.142])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2023 06:57:56 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH v2 0/3] ASoC: SOF: ipc4/intel: Support for ChainDMA
Date: Wed, 22 Mar 2023 15:58:23 +0200
Message-Id: <20230322135826.7199-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FTRF5ZIKWVDB4GBUEBPEI4Z22OPKY6DY
X-Message-ID-Hash: FTRF5ZIKWVDB4GBUEBPEI4Z22OPKY6DY
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 jyri.sarha@intel.com, rander.wang@intel.com,
 sof_ipc4_widget_free@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FTRF5ZIKWVDB4GBUEBPEI4Z22OPKY6DY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Changes since v1:
- Fix missed mutex unlocking in sof_ipc4_widget_free()
  Reported by Dan Carpenter (thank you!)

On a platform when the DSP is in use, we cannot select individual links to use
or not use the DSP, it is either all or none.
On some audio endpoint, like HDMI/DP, it is preferred to not use any processing
in DSP to reduce the latency and to allow bytestream pass-through (DTS, DD, etc)

IPC4 introduces a new type of end-to-end connection within the DSP which is using
the host DMA and link DMA in a single buffer, working back-to-back, passing the
received data without looking at it or trying to understand the format, content.

This mode reduces the latency and allows non PCM streams to be sent from
userspace.

The feature is enabled per PCM bases, signalled in topology.

Regards,
Peter
---

*** BLURB HERE ***

Jyri Sarha (2):
  ASoC: SOF: ipc4: Add macros for chain-dma message bits
  ASoC: SOF: ipc4/intel: Add support for chained DMA

Ranjani Sridharan (1):
  ASoC: SOF: topology: Set pipeline widget before updating IPC
    structures

 include/sound/sof/ipc4/header.h   |  29 +++++++
 include/uapi/sound/sof/tokens.h   |   1 +
 sound/soc/sof/intel/hda-dai-ops.c |  18 ++++-
 sound/soc/sof/ipc4-pcm.c          | 122 +++++++++++++++++++++++++++++-
 sound/soc/sof/ipc4-topology.c     | 122 +++++++++++++++++++++++++++++-
 sound/soc/sof/ipc4-topology.h     |   2 +
 sound/soc/sof/topology.c          |  48 ++++++------
 7 files changed, 310 insertions(+), 32 deletions(-)

-- 
2.40.0

