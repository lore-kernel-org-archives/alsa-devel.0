Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED926C34031
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:48:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7959824125
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iRoKps7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7959824125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEF9D166F;
	Tue, 18 Feb 2020 07:47:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEF9D166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582008482;
	bh=0VRWDibQteTAa/XAIOGvWNyE4iValyzCKYOd5ye1OG8=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:Cc:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=iRoKps7cjI0AKLyoQ/juRikbXfo6fONgEtRNo0NJdkJATNAoSoOKaS5yPnPgXUA4n
	 oN0AbZR1ZMifV6dJPUo55EazPdNlXrPOuwZ4Ein3HG7o19fi5L1SeBBpmljJT3SZNk
	 9A0j4Z87jpNt6pAOLRNqSAQKFVpGupLJhG6umzZ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45F48F80137;
	Tue, 18 Feb 2020 07:46:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B290F8025F; Tue, 18 Feb 2020 07:46:20 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B0BEF80137
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 07:46:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B0BEF80137
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2240F1A1005;
 Tue, 18 Feb 2020 07:46:12 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E6731A3774;
 Tue, 18 Feb 2020 07:46:05 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8738C4034D;
 Tue, 18 Feb 2020 14:45:27 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
 mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] ASoC: fsl_asrc: Move common definition to
 fsl_asrc_common
Date: Tue, 18 Feb 2020 14:39:35 +0800
Message-Id: <d2bbd13f376413d62435a9d78f8b8ef9aff56f58.1582007379.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1582007379.git.shengjiu.wang@nxp.com>
References: <cover.1582007379.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1582007379.git.shengjiu.wang@nxp.com>
References: <cover.1582007379.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

There is a new ASRC included in i.MX serial platform, there
are some common definition can be shared with each other.
So move the common definition to a separate header file.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.h        | 11 +----------
 sound/soc/fsl/fsl_asrc_common.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)
 create mode 100644 sound/soc/fsl/fsl_asrc_common.h

diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 8a821132d9d0..e8abb27ffeda 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -10,8 +10,7 @@
 #ifndef _FSL_ASRC_H
 #define _FSL_ASRC_H
 
-#define IN	0
-#define OUT	1
+#include  "fsl_asrc_common.h"
 
 #define ASRC_DMA_BUFFER_NUM		2
 #define ASRC_INPUTFIFO_THRESHOLD	32
@@ -283,14 +282,6 @@
 #define ASRMCR1i_OW16_MASK		(1 << ASRMCR1i_OW16_SHIFT)
 #define ASRMCR1i_OW16(v)		((v) << ASRMCR1i_OW16_SHIFT)
 
-
-enum asrc_pair_index {
-	ASRC_INVALID_PAIR = -1,
-	ASRC_PAIR_A = 0,
-	ASRC_PAIR_B = 1,
-	ASRC_PAIR_C = 2,
-};
-
 #define ASRC_PAIR_MAX_NUM	(ASRC_PAIR_C + 1)
 
 enum asrc_inclk {
diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h
new file mode 100644
index 000000000000..8acc55778ff2
--- /dev/null
+++ b/sound/soc/fsl/fsl_asrc_common.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 NXP
+ *
+ */
+
+#ifndef _FSL_ASRC_COMMON_H
+#define _FSL_ASRC_COMMON_H
+
+/* directions */
+#define IN	0
+#define OUT	1
+
+enum asrc_pair_index {
+	ASRC_INVALID_PAIR = -1,
+	ASRC_PAIR_A = 0,
+	ASRC_PAIR_B = 1,
+	ASRC_PAIR_C = 2,
+};
+
+#endif /* _FSL_ASRC_COMMON_H */
-- 
2.21.0

