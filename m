Return-Path: <SRS0=gTnd=YB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F008BC4360C
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Oct 2019 16:49:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A692070B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Oct 2019 16:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="g12lNZYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A692070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA9401676;
	Tue,  8 Oct 2019 18:48:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA9401676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570553355;
	bh=hGIoHwKw5+WbiGfGZzMEzfXSmPrvQ4kT7c4YTwkVaQE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g12lNZYcFumSLZJcmQHhG09/TpW7b1+bmYOScWzqRVWDfLqUKNhLwGNgb2xp3J3NL
	 8TZ+oe9ZKhmsvd6OsOJNS9JLK8J1TVujBTj+T0kCz9LLrOVAgbY8QQ5kVxJ950A/T+
	 ZEbVJeZ+NeresxQLhu6iGZoHzYllxFw4hXL7BpUU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEFF8F80636;
	Tue,  8 Oct 2019 18:45:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10C68F8060F; Tue,  8 Oct 2019 18:44:59 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82B4CF804CA
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2019 18:44:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82B4CF804CA
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 09:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; d="scan'208";a="218338333"
Received: from kwwong-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.251.150.53])
 by fmsmga004.fm.intel.com with ESMTP; 08 Oct 2019 09:44:49 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue,  8 Oct 2019 11:44:39 -0500
Message-Id: <20191008164443.1358-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008164443.1358-1-pierre-louis.bossart@linux.intel.com>
References: <20191008164443.1358-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 5/9] ASoC: SOF: imx: Describe ESAI parameters
	to be sent to DSP
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

From: Daniel Baluta <daniel.baluta@nxp.com>

Introduce sof_ipc_dai_esai_params to keep information that
we get from topology and we send to DSP FW.

Also bump the ABI minor to reflect the changes on DSP FW.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/dai-imx.h     | 34 +++++++++++++++++++++++++++++++++
 include/sound/sof/dai.h         |  2 ++
 include/uapi/sound/sof/abi.h    |  2 +-
 include/uapi/sound/sof/tokens.h |  3 +--
 4 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 include/sound/sof/dai-imx.h

diff --git a/include/sound/sof/dai-imx.h b/include/sound/sof/dai-imx.h
new file mode 100644
index 000000000000..e02fb0b0fae1
--- /dev/null
+++ b/include/sound/sof/dai-imx.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright 2019 NXP
+ *
+ * Author: Daniel Baluta <daniel.baluta@nxp.com>
+ */
+
+#ifndef __INCLUDE_SOUND_SOF_DAI_IMX_H__
+#define __INCLUDE_SOUND_SOF_DAI_IMX_H__
+
+#include <sound/sof/header.h>
+
+/* ESAI Configuration Request - SOF_IPC_DAI_ESAI_CONFIG */
+struct sof_ipc_dai_esai_params {
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
+
+#endif
diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index 0f1235022146..c229565767e5 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -11,6 +11,7 @@
 
 #include <sound/sof/header.h>
 #include <sound/sof/dai-intel.h>
+#include <sound/sof/dai-imx.h>
 
 /*
  * DAI Configuration.
@@ -73,6 +74,7 @@ struct sof_ipc_dai_config {
 		struct sof_ipc_dai_dmic_params dmic;
 		struct sof_ipc_dai_hda_params hda;
 		struct sof_ipc_dai_alh_params alh;
+		struct sof_ipc_dai_esai_params esai;
 	};
 } __packed;
 
diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index a0fe0d4c4b66..ebfdc20ca081 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -26,7 +26,7 @@
 
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
-#define SOF_ABI_MINOR 10
+#define SOF_ABI_MINOR 11
 #define SOF_ABI_PATCH 0
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
diff --git a/include/uapi/sound/sof/tokens.h b/include/uapi/sound/sof/tokens.h
index 8f996857fb24..da18c9de1056 100644
--- a/include/uapi/sound/sof/tokens.h
+++ b/include/uapi/sound/sof/tokens.h
@@ -111,7 +111,6 @@
 /* TODO: Add SAI tokens */
 
 /* ESAI */
-#define SOF_TKN_IMX_ESAI_FIRST_TOKEN		1100
-/* TODO: Add ESAI tokens */
+#define SOF_TKN_IMX_ESAI_MCLK_ID		1100
 
 #endif
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
