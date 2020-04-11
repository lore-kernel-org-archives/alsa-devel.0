Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F10C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:46:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096A0206B6
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ggcq8X/Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="pZ18SmGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096A0206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6012C1685;
	Tue, 14 Apr 2020 09:45:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6012C1685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586850409;
	bh=GTY/6od8qqyBypWNBke+awRbTCkmxD1Uaj4Vd7knGSk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ggcq8X/Zd45LRpXGQ6LV71loBxT9yGxZP2oT9jCzGd3iWC1WnmF7+znltenwGrIVg
	 4s3QsGXB0c2Lmn0zAiQN2epL50lPjYCTVJeh4bt5gzJYvrceVlTr4UpU0xZfV58mDu
	 UqrVVL/ehJnzd1gO1r00vvZtGCc5fbtyT4LwQX/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67E23F802A7;
	Tue, 14 Apr 2020 09:42:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A2FEF80213; Sat, 11 Apr 2020 10:04:27 +0200 (CEST)
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA75DF801D8
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2020 10:04:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA75DF801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="pZ18SmGR"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1586592265; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=UvI36xKVTG9KhWdViCLUZ8fjtO3Tz0+ISM05HTaavuQ=;
 b=pZ18SmGRGnR7U3o05rhiCevzJQo430gKg2dhhZyUp6RAIIxkxz/MHVyQcVQSapwg8q9HAKvd
 DDYV/jG7zIoiZoEVNACAnKah34BDlTkxOcjzgx+FawWrwPIx3myKdqPEQqbkNKopGx6Bo0cz
 RzYDIf1DErMehLpIoasfRx2DWvk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e917a04.7f5a977c3d50-smtp-out-n03;
 Sat, 11 Apr 2020 08:04:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 7CF3EC4478C; Sat, 11 Apr 2020 08:04:19 +0000 (UTC)
Received: from c-ajitp-linux.qualcomm.com
 (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ajitp)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C6D9C433CB;
 Sat, 11 Apr 2020 08:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C6D9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=ajitp@codeaurora.org
From: Ajit Pandey <ajitp@codeaurora.org>
To: alsa-devel@alsa-project.org, broonie@kernel.org,
 devicetree@vger.kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
 srinivas.kandagatla@linaro.org
Subject: [PATCH 06/11] dt-bindings: sound: Add bindings related to lpass-cpu
 configuration
Date: Sat, 11 Apr 2020 13:32:46 +0530
Message-Id: <1586592171-31644-7-git-send-email-ajitp@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
X-Mailman-Approved-At: Tue, 14 Apr 2020 09:41:46 +0200
Cc: Ajit Pandey <ajitp@codeaurora.org>, linux-kernel@vger.kernel.org,
 tiwai@suse.com
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

Add header defining dts properties related to lpass cpu MI2S dai's.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
---
 include/dt-bindings/sound/qcom,lpass.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 include/dt-bindings/sound/qcom,lpass.h

diff --git a/include/dt-bindings/sound/qcom,lpass.h b/include/dt-bindings/sound/qcom,lpass.h
new file mode 100644
index 00000000..4e6c6bc
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,lpass.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ *
+ * lpass.h -- DT bindings properties related to LPASS MI2S dai's
+ */
+
+#ifndef _DT_BINDINGS_LPASS_H
+#define _DT_BINDINGS_LPASS_H
+
+/* MI2S dai id */
+#define MI2S_PRIMARY	0
+#define MI2S_SECONDARY	1
+#define MI2S_TERTIARY	2
+#define MI2S_QUATERNARY	3
+
+/* MI2S dai's data line mask */
+#define SD0		1
+#define SD1		2
+#define SD2		3
+#define SD3		4
+
+/*MI2S dai' loopback mask */
+#define DISABLE		0
+#define ENABLE		1
+
+/* MI2S dai's wssrc mask */
+#define INTERNAL	0
+#define EXTERNAL	1
+
+#endif /* __DT_BINDINGS_LPASS_H__ */
-- 
1.9.1
