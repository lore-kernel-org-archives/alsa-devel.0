Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD9BC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Jan 2022 13:36:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F9351776;
	Fri, 28 Jan 2022 14:35:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F9351776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643377007;
	bh=aRGWZpsusPhigb6DB8rhf+r9ptnA4+P24cExL8KGEOE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e77PvLEDSgAbZDXH0hdLFDh9W/KUPqx3mmatg82Ux+1YD64jzbVC3roQPW98I/3Vu
	 dBh5FxAgHOiTzWDTaKcfYVfou58mVP5mdHhbiDcXTBmaDxIkIQ5lk8zXzeGFUuBxMb
	 hUISFXFYMhC6RPdIHoxoWw1YjVOyqsAywzd4x/PA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90F3DF80240;
	Fri, 28 Jan 2022 14:35:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA6C0F800C0; Fri, 28 Jan 2022 14:35:55 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BAD1F800C0
 for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2022 14:35:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BAD1F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="nwTMYie+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643376953; x=1674912953;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aRGWZpsusPhigb6DB8rhf+r9ptnA4+P24cExL8KGEOE=;
 b=nwTMYie+z9EO9yI8RZ8FcHhQh9ylO4/ncPBtn61knPheiFgkqCxsNj09
 fygCWy/qKFptRrQdaeh5KTXYesB2wXPM7+MJ1wgWGaYx4oVGlmOJGj3ZI
 jbHs9WuwjToNzLKme40lVkiqCI9ArSyLq9aBPBrSK9Ouh/vaFIfLpANiK
 Xy/TK3bTN/AXskEWQmR6DewCJkRcaYatNEA2oElS7OHDD3VMR2jx1C//X
 wiWxn/MKDmQhDc458/sTMzFq5l//Bj6Xo8qIiZyNhn06dVPArPjs/Riep
 GRl/hMmbOWsGDTNGBLrtzaurqS5OMPJXb842nHxxpemBOF048iIXiroSI Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227790488"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; d="scan'208";a="227790488"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2022 05:35:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; d="scan'208";a="536132810"
Received: from dlita-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.43.152])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2022 05:35:45 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 0/3] SoC: SOF: ipc: Optimizations for tx message
Date: Fri, 28 Jan 2022 15:36:17 +0200
Message-Id: <20220128133620.9411-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, rander.wang@intel.com,
 daniel.baluta@nxp.com
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

The series will drop the internal use of 'header' parameter which is always
set to hdr->cmd.

The other simplification is to use the provided message directly as it is
guarantied to be valid throughout the message sending and we can save memory
by not allocating a temporary buffer, also saving on needles memcpy()
operations.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: SOF: Intel: cnl: Use pm_gate->hdr.cmd in
    cnl_compact_ipc_compress()
  ASoC: SOF: ipc: Drop header parameter from
    sof_ipc_tx_message_unlocked()
  ASoC: SOF: ipc: Do not allocate buffer for msg_data

 sound/soc/sof/intel/cnl.c |  6 ++----
 sound/soc/sof/ipc.c       | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 16 deletions(-)

-- 
2.35.0

