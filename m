Return-Path: <SRS0=RV9o=ZS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB6C432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:16:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC352073F
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OqEpLLnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC352073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D98F515E4;
	Tue, 26 Nov 2019 15:15:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D98F515E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574777802;
	bh=nb4tm1gXw6gkbEqljW+tqTYPZHGwgv/k65x4kag6i+0=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OqEpLLnjDBHHBWCjTF+Dhx7UNc25yVojJCkBV+G0ocjZgW5X4t/7DUNAzKdCKpAyC
	 0a3FVQa2u2TaA43Adyb4NYppWBB/Bgpus/qu3Nl6U/JuPriF28I3UN+3dyjd0s6XNC
	 iTsn6CZjE/ntZvgg1GeFAbqhmQPJsQKpCSPVp6LU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D83CF80159;
	Tue, 26 Nov 2019 15:15:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01FFEF801F2; Tue, 26 Nov 2019 15:15:51 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E5D9F80149
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2019 15:15:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E5D9F80149
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Nov 2019 06:15:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; d="scan'208";a="206470123"
Received: from vramali2-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.155.193])
 by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2019 06:15:45 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 26 Nov 2019 08:15:33 -0600
Message-Id: <20191126141533.21601-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH] ASoC: SOF: Intel: BYT: fix a copy/paste
	mistake in byt_dump()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Keyon Jie <yang.jie@linux.intel.com>

The shim registers in BYT/CHT/BSW are 64bits based, correct the
copy/paste (from bdw.c where the shim registers are 32bits based) error
in byt_dump().

Fixes: 3a9e204d4e36 ("ASoC: SOF: Intel: Add context data to any IPC timeout")
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/byt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 2abf80b3eb52..b9061b79a57b 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -145,33 +145,33 @@ static void byt_dump(struct snd_sof_dev *sdev, u32 flags)
 	struct sof_ipc_dsp_oops_xtensa xoops;
 	struct sof_ipc_panic_info panic_info;
 	u32 stack[BYT_STACK_DUMP_SIZE];
-	u32 status, panic, imrd, imrx;
+	u64 status, panic, imrd, imrx;
 
 	/* now try generic SOF status messages */
-	status = snd_sof_dsp_read(sdev, BYT_DSP_BAR, SHIM_IPCD);
-	panic = snd_sof_dsp_read(sdev, BYT_DSP_BAR, SHIM_IPCX);
+	status = snd_sof_dsp_read64(sdev, BYT_DSP_BAR, SHIM_IPCD);
+	panic = snd_sof_dsp_read64(sdev, BYT_DSP_BAR, SHIM_IPCX);
 	byt_get_registers(sdev, &xoops, &panic_info, stack,
 			  BYT_STACK_DUMP_SIZE);
 	snd_sof_get_status(sdev, status, panic, &xoops, &panic_info, stack,
 			   BYT_STACK_DUMP_SIZE);
 
 	/* provide some context for firmware debug */
-	imrx = snd_sof_dsp_read(sdev, BYT_DSP_BAR, SHIM_IMRX);
-	imrd = snd_sof_dsp_read(sdev, BYT_DSP_BAR, SHIM_IMRD);
+	imrx = snd_sof_dsp_read64(sdev, BYT_DSP_BAR, SHIM_IMRX);
+	imrd = snd_sof_dsp_read64(sdev, BYT_DSP_BAR, SHIM_IMRD);
 	dev_err(sdev->dev,
-		"error: ipc host -> DSP: pending %s complete %s raw 0x%8.8x\n",
+		"error: ipc host -> DSP: pending %s complete %s raw 0x%llx\n",
 		(panic & SHIM_IPCX_BUSY) ? "yes" : "no",
 		(panic & SHIM_IPCX_DONE) ? "yes" : "no", panic);
 	dev_err(sdev->dev,
-		"error: mask host: pending %s complete %s raw 0x%8.8x\n",
+		"error: mask host: pending %s complete %s raw 0x%llx\n",
 		(imrx & SHIM_IMRX_BUSY) ? "yes" : "no",
 		(imrx & SHIM_IMRX_DONE) ? "yes" : "no", imrx);
 	dev_err(sdev->dev,
-		"error: ipc DSP -> host: pending %s complete %s raw 0x%8.8x\n",
+		"error: ipc DSP -> host: pending %s complete %s raw 0x%llx\n",
 		(status & SHIM_IPCD_BUSY) ? "yes" : "no",
 		(status & SHIM_IPCD_DONE) ? "yes" : "no", status);
 	dev_err(sdev->dev,
-		"error: mask DSP: pending %s complete %s raw 0x%8.8x\n",
+		"error: mask DSP: pending %s complete %s raw 0x%llx\n",
 		(imrd & SHIM_IMRD_BUSY) ? "yes" : "no",
 		(imrd & SHIM_IMRD_DONE) ? "yes" : "no", imrd);
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
