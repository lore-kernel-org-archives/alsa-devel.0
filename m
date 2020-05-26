Return-Path: <SRS0=6DhY=7I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D046EC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 20:41:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55838207CB
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 20:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QRZV8rQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55838207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3501177A;
	Tue, 26 May 2020 22:41:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3501177A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590525711;
	bh=11z3RDeXNS/VhQwdl8+zDEWpaBGjVLYOIvZPBuLjLcQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QRZV8rQBULzqnSAYECkOWbc3NV0Beo3IS3lCNLra+EEmJemrX9cpmtDEJAMV2TzU8
	 OolaxBqOl1ZAyvmxIDUTI14iupkoDx4HBYpQWfFn6MfJHDb4S+0Vcru7inebmV5Gdp
	 RlguWNI3ZbqMkGC07dYu0itDVnY/GLabIw/iUB7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 182AEF802DD;
	Tue, 26 May 2020 22:37:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6199F80299; Tue, 26 May 2020 22:37:05 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51282F8015D
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2020 22:36:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51282F8015D
IronPort-SDR: CVx9l6CPFqRv8IrXNIddhTlEd3E90bSSwBYRmf5HyUkwPG61CdFnmMyCd1EKApf8uo2AyuyTRc
 wt2+HC/ohCaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 13:36:50 -0700
IronPort-SDR: xaF/x1ZGbedq+t8GHwdmPqXacxQSmTkWPWOpDrWtkT6sc9J+XgTiXo/Td1a1A8yGipwo++/GxU
 6AvWU2mj+20Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; d="scan'208";a="270208885"
Received: from lfnguyen-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.229.61])
 by orsmga006.jf.intel.com with ESMTP; 26 May 2020 13:36:50 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/8] ASoC: SOF: ipc: ignore DSP replies received when they are
 not expected
Date: Tue, 26 May 2020 15:36:37 -0500
Message-Id: <20200526203640.25980-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526203640.25980-1-pierre-louis.bossart@linux.intel.com>
References: <20200526203640.25980-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

We currently ignore the reply messages from the DSP
when they are not expected but call it out as an error.
Change the error message to a debug message.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc.c      | 9 ++++-----
 sound/soc/sof/sof-priv.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index f7a0353596fb..36e2d4d43da4 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -335,21 +335,20 @@ int sof_ipc_tx_message_no_pm(struct snd_sof_ipc *ipc, u32 header,
 EXPORT_SYMBOL(sof_ipc_tx_message_no_pm);
 
 /* handle reply message from DSP */
-int snd_sof_ipc_reply(struct snd_sof_dev *sdev, u32 msg_id)
+void snd_sof_ipc_reply(struct snd_sof_dev *sdev, u32 msg_id)
 {
 	struct snd_sof_ipc_msg *msg = &sdev->ipc->msg;
 
 	if (msg->ipc_complete) {
-		dev_err(sdev->dev, "error: no reply expected, received 0x%x",
+		dev_dbg(sdev->dev,
+			"no reply expected, received 0x%x, will be ignored",
 			msg_id);
-		return -EINVAL;
+		return;
 	}
 
 	/* wake up and return the error if we have waiters on this message ? */
 	msg->ipc_complete = true;
 	wake_up(&msg->waitq);
-
-	return 0;
 }
 EXPORT_SYMBOL(snd_sof_ipc_reply);
 
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 3ed39b887214..64f28e082049 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -480,7 +480,7 @@ int snd_sof_fw_parse_ext_data(struct snd_sof_dev *sdev, u32 bar, u32 offset);
  */
 struct snd_sof_ipc *snd_sof_ipc_init(struct snd_sof_dev *sdev);
 void snd_sof_ipc_free(struct snd_sof_dev *sdev);
-int snd_sof_ipc_reply(struct snd_sof_dev *sdev, u32 msg_id);
+void snd_sof_ipc_reply(struct snd_sof_dev *sdev, u32 msg_id);
 void snd_sof_ipc_msgs_rx(struct snd_sof_dev *sdev);
 int snd_sof_ipc_stream_pcm_params(struct snd_sof_dev *sdev,
 				  struct sof_ipc_pcm_params *params);
-- 
2.20.1

