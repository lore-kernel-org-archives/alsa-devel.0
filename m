Return-Path: <SRS0=ik9t=YS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9BCA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 22:54:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295FD21D82
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 22:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LAkzexfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295FD21D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66E271942;
	Sat, 26 Oct 2019 00:53:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66E271942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572044061;
	bh=cc92I24EoYkTrugYF3foKOSLH82CgIaMCYK/9iGRIM0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LAkzexfZOonvm9oq19em3t1LWJUV7UtoxMipj1sXSizva79a60hbeQ1mFQfGT5kru
	 +k7IDuQBKNXSR9c0l6lVubqJc0XwU2KitLP/i8g/LxBLajG1RFpYRWaOllJ1bWYZg8
	 VlSg5l8+310mNzrQiBTfABIfQmZ/OcxLedA7CreY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80E80F80756;
	Sat, 26 Oct 2019 00:42:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37B8CF803A6; Sat, 26 Oct 2019 00:42:01 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22547F803D7
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2019 00:41:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22547F803D7
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 15:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; d="scan'208";a="210458223"
Received: from archagam-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.252.139.180])
 by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2019 15:41:48 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 25 Oct 2019 17:41:14 -0500
Message-Id: <20191025224122.7718-19-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025224122.7718-1-pierre-louis.bossart@linux.intel.com>
References: <20191025224122.7718-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 18/26] ASoC: SOF: Intel: CNL: add support for
	sending compact IPC
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

For compact IPCs, we will send the IPC header/command via the HIPCIDR
register and the first 32bit payload via the HIPCIDD register, no
mailbox will be used.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/cnl.c | 42 ++++++++++++++++++++++++++++++++++-----
 sound/soc/sof/intel/hda.h |  1 +
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 982b81a0b13a..0e1e265f3f3b 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -17,6 +17,7 @@
 
 #include "../ops.h"
 #include "hda.h"
+#include "hda-ipc.h"
 
 static const struct snd_sof_debugfs_map cnl_dsp_debugfs[] = {
 	{"hda", HDA_DSP_HDA_BAR, 0, 0x4000, SOF_DEBUGFS_ACCESS_ALWAYS},
@@ -150,14 +151,45 @@ static void cnl_ipc_dsp_done(struct snd_sof_dev *sdev)
 				CNL_DSP_REG_HIPCCTL_DONE);
 }
 
+static bool cnl_compact_ipc_compress(struct snd_sof_ipc_msg *msg,
+				     u32 *dr, u32 *dd)
+{
+	struct sof_ipc_pm_gate *pm_gate;
+
+	if (msg->header == (SOF_IPC_GLB_PM_MSG | SOF_IPC_PM_GATE)) {
+		pm_gate = msg->msg_data;
+
+		/* send the compact message via the primary register */
+		*dr = HDA_IPC_MSG_COMPACT | HDA_IPC_PM_GATE;
+
+		/* send payload via the extended data register */
+		*dd = pm_gate->flags;
+
+		return true;
+	}
+
+	return false;
+}
+
 static int cnl_ipc_send_msg(struct snd_sof_dev *sdev,
 			    struct snd_sof_ipc_msg *msg)
 {
-	/* send the message */
-	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
-			  msg->msg_size);
-	snd_sof_dsp_write(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDR,
-			  CNL_DSP_REG_HIPCIDR_BUSY);
+	u32 dr = 0;
+	u32 dd = 0;
+
+	if (cnl_compact_ipc_compress(msg, &dr, &dd)) {
+		/* send the message via IPC registers */
+		snd_sof_dsp_write(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDD,
+				  dd);
+		snd_sof_dsp_write(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDR,
+				  CNL_DSP_REG_HIPCIDR_BUSY | dr);
+	} else {
+		/* send the message via mailbox */
+		sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
+				  msg->msg_size);
+		snd_sof_dsp_write(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDR,
+				  CNL_DSP_REG_HIPCIDR_BUSY);
+	}
 
 	return 0;
 }
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 99ec60218c16..52a87a47029d 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -312,6 +312,7 @@
 #define CNL_DSP_REG_HIPCTDD		(CNL_DSP_IPC_BASE + 0x08)
 #define CNL_DSP_REG_HIPCIDR		(CNL_DSP_IPC_BASE + 0x10)
 #define CNL_DSP_REG_HIPCIDA		(CNL_DSP_IPC_BASE + 0x14)
+#define CNL_DSP_REG_HIPCIDD		(CNL_DSP_IPC_BASE + 0x18)
 #define CNL_DSP_REG_HIPCCTL		(CNL_DSP_IPC_BASE + 0x28)
 
 /*  HIPCI */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
