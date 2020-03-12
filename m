Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2136CC10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:09:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36D3206E9
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Wh7JRQ40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36D3206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 025331776;
	Thu, 12 Mar 2020 21:08:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 025331776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584043773;
	bh=65/uCN4gEa2iC/laZU9ZKPhnDCaCsqGYm7cKXtNoeXo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wh7JRQ40F2Kv15uXEe6sNbeTF9Yo+WZORpDTHtoOgpLqGi45SoA7seKcxkiFfDWKW
	 bYwctsRvGw3GGcRzNWN7pRdE8/grMYMb++hihTBsqhQmSYPmaAcEatV++HFmXmVXqa
	 6oYXVWB1BknjK0kw9i8AedtvZx7W/Qa2I0Yj5RuE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB221F8029A;
	Thu, 12 Mar 2020 21:06:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A08CAF80273; Thu, 12 Mar 2020 21:06:44 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1D44F801D9
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 21:06:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1D44F801D9
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 13:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; d="scan'208";a="444063056"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com)
 ([10.251.241.169])
 by fmsmga006.fm.intel.com with ESMTP; 12 Mar 2020 13:06:35 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/6] ASoC: SOF: Remove SOF_IPC_EXT_DMA_BUFFER
Date: Thu, 12 Mar 2020 15:06:19 -0500
Message-Id: <20200312200622.24477-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312200622.24477-1-pierre-louis.bossart@linux.intel.com>
References: <20200312200622.24477-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Karol Trzcinski <karolx.trzcinski@linux.intel.com>,
 broonie@kernel.org,
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

From: Karol Trzcinski <karolx.trzcinski@linux.intel.com>

This enum code, and what's more important, related structures is
unused in whole source code, so it shouldn't be kept.

Signed-off-by: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/info.h | 18 +-----------------
 sound/soc/sof/loader.c   |  3 ---
 sound/soc/sof/sof-priv.h |  1 -
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/include/sound/sof/info.h b/include/sound/sof/info.h
index cc3b50b6ae52..438a11fcf272 100644
--- a/include/sound/sof/info.h
+++ b/include/sound/sof/info.h
@@ -28,7 +28,7 @@
 
 /* extended data types that can be appended onto end of sof_ipc_fw_ready */
 enum sof_ipc_ext_data {
-	SOF_IPC_EXT_DMA_BUFFER		= 0,
+	SOF_IPC_EXT_UNUSED		= 0,
 	SOF_IPC_EXT_WINDOW		= 1,
 	SOF_IPC_EXT_CC_INFO		= 2,
 };
@@ -83,22 +83,6 @@ struct sof_ipc_ext_data_hdr {
 	uint32_t type;		/**< SOF_IPC_EXT_ */
 } __packed;
 
-struct sof_ipc_dma_buffer_elem {
-	struct sof_ipc_hdr hdr;
-	uint32_t type;		/**< SOF_IPC_REGION_ */
-	uint32_t id;		/**< platform specific - used to map to host memory */
-	struct sof_ipc_host_buffer buffer;
-} __packed;
-
-/* extended data DMA buffers for IPC, trace and debug */
-struct sof_ipc_dma_buffer_data {
-	struct sof_ipc_ext_data_hdr ext_hdr;
-	uint32_t num_buffers;
-
-	/* host files in buffer[n].buffer */
-	struct sof_ipc_dma_buffer_elem buffer[];
-}  __packed;
-
 struct sof_ipc_window_elem {
 	struct sof_ipc_hdr hdr;
 	uint32_t type;		/**< SOF_IPC_REGION_ */
diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index fc4ab51bacf4..67fc95ace42b 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -95,9 +95,6 @@ int snd_sof_fw_parse_ext_data(struct snd_sof_dev *sdev, u32 bar, u32 offset)
 
 		/* process structure data */
 		switch (ext_hdr->type) {
-		case SOF_IPC_EXT_DMA_BUFFER:
-			ret = 0;
-			break;
 		case SOF_IPC_EXT_WINDOW:
 			ret = get_ext_windows(sdev, ext_hdr);
 			break;
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 5d16f668d16a..38dce54755a6 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -415,7 +415,6 @@ struct snd_sof_dev {
 	u32 enabled_cores_mask; /* keep track of enabled cores */
 
 	/* FW configuration */
-	struct sof_ipc_dma_buffer_data *info_buffer;
 	struct sof_ipc_window *info_window;
 
 	/* IPC timeouts in ms */
-- 
2.20.1

