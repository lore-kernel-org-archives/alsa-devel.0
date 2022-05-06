Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A084C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  6 May 2022 13:28:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE062182B;
	Fri,  6 May 2022 15:27:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE062182B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651843687;
	bh=St3pjYJCptFZg+sqb5RrNtN/QKh6uPFDxt+2I/i2wbg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ckTKqopTeyBLeQz+G4CDwrO6RTYkDM/3g4eFTD20K8l4EXfya3y2UhNAq4QcEeuWZ
	 nel6i6CuWxX1FNZ6Pv4sxhqFYm5dMcLj3aRVtLOg8PyKglLlfrNNbMoCV9M6jpWm3h
	 fBhY4ho3SgIH3WWitD2sE2EVi4kzkNVeXAK41sIE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E1DBF800E3;
	Fri,  6 May 2022 15:26:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5AF3F80508; Fri,  6 May 2022 15:26:47 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79F2BF800F0
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2022 15:26:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79F2BF800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="lKblsAuF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651843594; x=1683379594;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=St3pjYJCptFZg+sqb5RrNtN/QKh6uPFDxt+2I/i2wbg=;
 b=lKblsAuFV2nfhqosc5AaeSN4XmtahNkDnCR38ojQRpjvjYU/jO64LUKV
 TWFzNDbdcUePfAUUIEgKwaBNK9/BHfIVIxWWg6ZhoMXHCyEw7SwmwDj2u
 sKXkOrwQQsv5erexpbHoliqYA9wv9nuaz1snINyq3/3j0DHdMtGme6QG6
 TgjTy31sxRsgoYPr6JOtceWLDCOK5DxzwfkFndzsnUzvI1q5QXGrdn7Rc
 DRVYA8XMl35Kx8RQzPECBFbOo8K7/66F2bVfSYYsqo1Kou1xBt6RXbMzU
 4KYIvXiIx3rQ9K68is1o757Dg9KWZSk5TeSFtyg+kCPVMmOzxgUaD+4Bt A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="293672780"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293672780"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 06:26:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="585971550"
Received: from oelagadx-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.61.230])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 06:26:24 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, yung-chuan.liao@linux.intel.com,
 rander.wang@intel.com
Subject: [PATCH 0/8] ASoC: SOF: sof-client: Update for different IPC versions
Date: Fri,  6 May 2022 16:26:39 +0300
Message-Id: <20220506132647.18690-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
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

The current IPC client infrastructure can only be used with IPC3.
This series carries updates for the core side of the client support to handle
IPC4 messages and updates the ipc message injector to be usable with IPC4.

The IPC flood test is only supported by SOF_IPC (IPC3), we are not going to
create the aux device for it at all if the firmware is using IPC4.

Regards,
Peter
---
Peter Ujfalusi (8):
  ASoC: SOF: sof-client: Add API to get the maximum IPC payload size
  ASoC: SOF: ipc-msg-injector: Query the maximum IPC payload size
  ASoC: SOF: sof-client-probes: Query the maximum IPC payload size
  ASoC: SOF: sof-client: Add API to get the ipc_type
  ASoC: SOF: sof-client: Add support IPC4 message sending
  ASoC: SOF: ipc-msg-injector: Separate the message sending
  ASoC: SOF: ipc-msg-injector: Add support for IPC4 messages
  ASoC: SOF: sof-client: IPC flood test can only work with SOF_IPC

 sound/soc/sof/sof-client-ipc-msg-injector.c | 181 ++++++++++++++++++--
 sound/soc/sof/sof-client-probes.c           |   5 +-
 sound/soc/sof/sof-client.c                  |  66 ++++++-
 sound/soc/sof/sof-client.h                  |   2 +
 4 files changed, 227 insertions(+), 27 deletions(-)

-- 
2.36.0

