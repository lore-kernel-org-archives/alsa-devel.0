Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9007C46CD2
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jan 2024 15:31:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46A747F8;
	Wed, 24 Jan 2024 16:31:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46A747F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706110270;
	bh=xX8V+ooBoGuO9/qAZe63ZvqC3unGlMbM7oteiXO0RC4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=n613eBTDlFah2NUIr3rbPCmQE4wRj53aMm0TV/brIbQKYZpqv1v3RmUKmdhUF03qG
	 fPay8LwJRIRV4zX11o+CWeVCLZ9KiFEUQ4osh4CcnnAT/3pFcGxqPhXg1zetTgbekR
	 RsHQTkKmHTAEEFD0hTa0LiRfuG78d3QVX/CvH/58=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C7C09F805B6; Wed, 24 Jan 2024 16:30:34 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A514EF805A1;
	Wed, 24 Jan 2024 16:30:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB415F804F1; Wed, 24 Jan 2024 16:30:28 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1DFD6F80149
	for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2024 16:30:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DFD6F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=LweXCt7J
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40O8MvMl030107;
	Wed, 24 Jan 2024 09:30:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=l
	RLqdGz9nV9jBTZzuw5ozwQtDA2zkxWRDOuyDlnnA78=; b=LweXCt7JqcK49xNqX
	jp/83OkDlTze3OwnFiOBAR2BUrWPPy3ikkugkAcdCc7bNBsxBOAylOB0QiqSYNJr
	Xnd9kWLFasRG7pAbdJpobqUV6a3XRP7s41pRXKfyzmm98DkcheM26N0fiUaEOj2Y
	I/RO4rdrwJoc/OgG9JHPMqoCKgb7N3lvKcv7a9BtaCNwTqDz+pPX0o3PMcM7lFbF
	p8PNYvGaWf45HSIV6e+y2ZRegGU9uJRX3soOUiSxVMreZzSCSx3s42AQV7dYe68c
	5pOy22uQtZzd5k+FoKAHaarDBypFg7neXNfws3El6CvQUFhjMttQqiWnj/DdSliE
	dFhZA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9ryqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 09:30:18 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 15:30:16 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 15:30:16 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com
 [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 98D63820246;
	Wed, 24 Jan 2024 15:30:16 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 1/6] spi: cs42l43: Tidy up header includes
Date: Wed, 24 Jan 2024 15:30:11 +0000
Message-ID: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: m-fKSUnpiyZc6hYMIqEPaZ1VCktx70Fo
X-Proofpoint-ORIG-GUID: m-fKSUnpiyZc6hYMIqEPaZ1VCktx70Fo
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: CLNM6LKCKOWQX5FPOGM77ZDLE6UZ5IAA
X-Message-ID-Hash: CLNM6LKCKOWQX5FPOGM77ZDLE6UZ5IAA
X-MailFrom: prvs=8753590469=ckeepax@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CLNM6LKCKOWQX5FPOGM77ZDLE6UZ5IAA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Including some missing headers.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Moved to start of the series

The changes to the MFD headers necessitate the inclusion of of.h here to
keep things building, hence my including this SPI change in the this MFD
series. The rest of the SPI fixups will be sent separately, as they are
also not dependent on this change.

Thanks,
Charles

 drivers/spi/spi-cs42l43.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index d239fc5a49ccc..fb62807fc991c 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -11,7 +11,9 @@
 #include <linux/errno.h>
 #include <linux/mfd/cs42l43.h>
 #include <linux/mfd/cs42l43-regs.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-- 
2.30.2

