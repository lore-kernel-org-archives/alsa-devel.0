Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87857C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:33:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1084224672
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZfIlY4Sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1084224672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57ACD166C;
	Wed, 18 Dec 2019 01:32:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57ACD166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576629195;
	bh=wN63DyAz0no5Kbz7fUoWxGP07P0NpybYrTk01V2at3k=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZfIlY4SrK+1BUsKYccT9TOE6C7zBxto0jzuUhu5sOQ1JRwLa6OkrNNI7gao/9DvN1
	 tcgeSCKfZZTEo4ijePw1T1luIn+1iaMXoQn+llGbKepzT+DZxhl0gzUKNw7EH+K41K
	 lmHKfne9M+RsmmNTO6LFJAbHCK03PIbr8R42E21I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7456DF802C4;
	Wed, 18 Dec 2019 01:27:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9D71F80268; Wed, 18 Dec 2019 01:27:03 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4A19F80268
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 01:26:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4A19F80268
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 16:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; d="scan'208";a="217974248"
Received: from dshoemak-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.3.243])
 by orsmga003.jf.intel.com with ESMTP; 17 Dec 2019 16:26:34 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 17 Dec 2019 18:26:15 -0600
Message-Id: <20191218002616.7652-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218002616.7652-1-pierre-louis.bossart@linux.intel.com>
References: <20191218002616.7652-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Guido Roncarolo <guido.roncarolo@nxp.com>
Subject: [alsa-devel] [PATCH 7/8] ASoC: SOF: imx: Describe SAI parameters to
	be sent to DSP
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

From: Guido Roncarolo <guido.roncarolo@nxp.com>

Introduce sof_ipc_dai_sai_params to keep information that
we get from topology and we send to DSP FW.
For the moment it is identical to ESAI one but it will
evolve shortly independently

Signed-off-by: Guido Roncarolo <guido.roncarolo@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/dai-imx.h     | 20 ++++++++++++++++++++
 include/sound/sof/dai.h         |  1 +
 include/uapi/sound/sof/tokens.h |  3 +--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/sound/sof/dai-imx.h b/include/sound/sof/dai-imx.h
index e02fb0b0fae1..ff9088dcc6f2 100644
--- a/include/sound/sof/dai-imx.h
+++ b/include/sound/sof/dai-imx.h
@@ -31,4 +31,24 @@ struct sof_ipc_dai_esai_params {
 	uint16_t reserved2;	/* alignment */
 } __packed;
 
+/* SAI Configuration Request - SOF_IPC_DAI_SAI_CONFIG */
+struct sof_ipc_dai_sai_params {
+	struct sof_ipc_hdr hdr;
+
+	/* MCLK */
+	uint16_t reserved1;
+	uint16_t mclk_id;
+	uint32_t mclk_direction;
+
+	uint32_t mclk_rate;	/* MCLK frequency in Hz */
+	uint32_t fsync_rate;	/* FSYNC frequency in Hz */
+	uint32_t bclk_rate;	/* BCLK frequency in Hz */
+
+	/* TDM */
+	uint32_t tdm_slots;
+	uint32_t rx_slots;
+	uint32_t tx_slots;
+	uint16_t tdm_slot_width;
+	uint16_t reserved2;	/* alignment */
+} __packed;
 #endif
diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index c229565767e5..2565edd336f1 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -75,6 +75,7 @@ struct sof_ipc_dai_config {
 		struct sof_ipc_dai_hda_params hda;
 		struct sof_ipc_dai_alh_params alh;
 		struct sof_ipc_dai_esai_params esai;
+		struct sof_ipc_dai_sai_params sai;
 	};
 } __packed;
 
diff --git a/include/uapi/sound/sof/tokens.h b/include/uapi/sound/sof/tokens.h
index a9a5c4d0a892..2a25cd8da503 100644
--- a/include/uapi/sound/sof/tokens.h
+++ b/include/uapi/sound/sof/tokens.h
@@ -113,8 +113,7 @@
 #define SOF_TKN_EFFECT_TYPE	SOF_TKN_PROCESS_TYPE
 
 /* SAI */
-#define SOF_TKN_IMX_SAI_FIRST_TOKEN		1000
-/* TODO: Add SAI tokens */
+#define SOF_TKN_IMX_SAI_MCLK_ID			1000
 
 /* ESAI */
 #define SOF_TKN_IMX_ESAI_MCLK_ID		1100
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
