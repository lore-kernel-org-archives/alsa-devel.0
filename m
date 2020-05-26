Return-Path: <SRS0=6DhY=7I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA4C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 20:42:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17AFE207CB
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 20:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ndPSsgQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AFE207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 761341787;
	Tue, 26 May 2020 22:42:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 761341787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590525772;
	bh=6d8T635zQiKVKnqA0iRgESBf43k0LA3peWGIMMHp7as=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ndPSsgQliLJ0hTO6XjUW1X+2hvxTJL0AS5LoUYITdKuz90Fm03ih14+kJu8z/d9Yu
	 xJpQIiXbUvKPAvJyV7H2lsN6tu9/nggoPkaKPx6R8xb1DnlGNckbTqaQ+xdWYDYv27
	 Qn1t5pStxJTCnqZfhwjaEfeG1YbsCEtT+xoUb1QA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECCB5F802E9;
	Tue, 26 May 2020 22:37:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93A35F802A8; Tue, 26 May 2020 22:37:08 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5006BF8028F
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2020 22:36:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5006BF8028F
IronPort-SDR: QBJbOfXyZdfBSl2sE24TOh7CEJIi0woCVCF1r9YMjb2w7oEiLLF4/vailtVWmT4GJFKYxJHcgi
 +QB0gXNI4Hyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 13:36:53 -0700
IronPort-SDR: c3SArvpSV+iq5vxeE/1MgPd9EO3EWF3ECmDowPlC4VzeFfqjneUlt2Wn0kovVqegfgNGI7MktR
 C/UQxN+RdwaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; d="scan'208";a="270208893"
Received: from lfnguyen-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.229.61])
 by orsmga006.jf.intel.com with ESMTP; 26 May 2020 13:36:52 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 8/8] ASoC: SOF: Intel: BYT: harden IPC initialization and
 handling
Date: Tue, 26 May 2020 15:36:40 -0500
Message-Id: <20200526203640.25980-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526203640.25980-1-pierre-louis.bossart@linux.intel.com>
References: <20200526203640.25980-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>
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

From: Keyon Jie <yang.jie@linux.intel.com>

On probe and reset, we should not touch the SHIM_IMRD register since
it is configured by firmware.

The driver only configures SHIM_IMRX with the BUSY interrupt enabled
by default and DONE interrupt disabled. When sending an IPC message,
the DONE interrupt is enabled until the DSP response is provided.

This sequence hardens the IPC communication and avoid
interrupt-related issues when adding/removing modules or during system
suspend-resume transitions.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/byt.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index c6ac914ee56c..e6ba8382b1de 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -236,6 +236,10 @@ static irqreturn_t byt_irq_thread(int irq, void *context)
 
 static int byt_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 {
+	/* unmask and prepare to receive Done interrupt */
+	snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR, SHIM_IMRX,
+					   SHIM_IMRX_DONE, 0);
+
 	/* send the message */
 	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
 			  msg->msg_size);
@@ -301,7 +305,7 @@ static void byt_host_done(struct snd_sof_dev *sdev)
 					   SHIM_BYT_IPCD_DONE,
 					   SHIM_BYT_IPCD_DONE);
 
-	/* unmask busy interrupt */
+	/* unmask and prepare to receive next new message */
 	snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR, SHIM_IMRX,
 					   SHIM_IMRX_BUSY, 0);
 }
@@ -311,10 +315,6 @@ static void byt_dsp_done(struct snd_sof_dev *sdev)
 	/* clear DONE bit - tell DSP we have completed */
 	snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR, SHIM_IPCX,
 					   SHIM_BYT_IPCX_DONE, 0);
-
-	/* unmask Done interrupt */
-	snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR, SHIM_IMRX,
-					   SHIM_IMRX_DONE, 0);
 }
 
 /*
@@ -453,9 +453,10 @@ static int byt_suspend(struct snd_sof_dev *sdev, u32 target_state)
 
 static int byt_resume(struct snd_sof_dev *sdev)
 {
-	/* Enable Interrupt from both sides */
-	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRX, 0x3, 0x0);
-	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRD, 0x3, 0x0);
+	/* enable BUSY and disable DONE Interrupt by default */
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRX,
+				  SHIM_IMRX_BUSY | SHIM_IMRX_DONE,
+				  SHIM_IMRX_DONE);
 
 	return 0;
 }
@@ -606,9 +607,10 @@ static int tangier_pci_probe(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
-	/* enable Interrupt from both sides */
-	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRX, 0x3, 0x0);
-	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRD, 0x3, 0x0);
+	/* enable BUSY and disable DONE Interrupt by default */
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRX,
+				  SHIM_IMRX_BUSY | SHIM_IMRX_DONE,
+				  SHIM_IMRX_DONE);
 
 	/* set default mailbox offset for FW ready message */
 	sdev->dsp_box.offset = MBOX_OFFSET;
@@ -808,9 +810,10 @@ static int byt_acpi_probe(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
-	/* enable Interrupt from both sides */
-	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRX, 0x3, 0x0);
-	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRD, 0x3, 0x0);
+	/* enable BUSY and disable DONE Interrupt by default */
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRX,
+				  SHIM_IMRX_BUSY | SHIM_IMRX_DONE,
+				  SHIM_IMRX_DONE);
 
 	/* set default mailbox offset for FW ready message */
 	sdev->dsp_box.offset = MBOX_OFFSET;
-- 
2.20.1

