Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECCEC38A2A
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 11:27:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBCF20725
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 11:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TxPcdID5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBCF20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B2C41810;
	Thu,  7 May 2020 13:26:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B2C41810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588850844;
	bh=5lg97HhTO+n1QQL73A/+fsl0zMZeDGn4bMW7HcgtYDY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TxPcdID5JMMHheVLFRWM46C+UvhQ5kbctds99DM2+vW1pNd9+T5ixNd2ph+ubaVVa
	 GaKhIV9BbvXxXGL+1N3isdu151GZbY4PNGHaAFXi7UHNRKLei3MH86iswm12gdruq2
	 tUgDlp9vvmKDOELRf8EDD/nllKmt+9XAF9eO5L9Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03E70F801D9;
	Thu,  7 May 2020 13:25:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62C06F800AD; Thu,  7 May 2020 13:25:41 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA64CF800AD
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 13:25:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA64CF800AD
IronPort-SDR: yQ1Z6UbOtUyChgZYNCSzOiUls1N0Ma3oDb1bIIkUKUpSJY/Am90EvMAHM206PgCxAdo5tcNj+0
 fEBW+zH66emA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 04:25:30 -0700
IronPort-SDR: 0e+MGkVOOXFxbgA++v4CksiIKrnz3BFb1wLrlHpIJyZas9UxUVSl1KXxa/nfivws1G4r658iq1
 A0Q7Xe2hJ22A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; d="scan'208";a="284962575"
Received: from pi-desktop.igk.intel.com ([10.237.148.102])
 by fmsmga004.fm.intel.com with ESMTP; 07 May 2020 04:25:28 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/2] ASoC: Intel: Use readq to read 64 bit registers
Date: Thu,  7 May 2020 09:34:05 -0400
Message-Id: <20200507133405.32251-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507133405.32251-1-amadeuszx.slawinski@linux.intel.com>
References: <20200507133405.32251-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

In order to fix issue described in:
"ASoC: Intel: sst: ipc command timeout"
https://patchwork.kernel.org/patch/11482829/

use readq function, which is meant to read 64 bit values from registers.
On 32 bit platforms it falls back to two readl calls.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reported-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/common/sst-dsp.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index ec66be269b69..36c077aa386e 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -10,7 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/delay.h>
 
 #include "sst-dsp.h"
@@ -34,16 +34,13 @@ EXPORT_SYMBOL_GPL(sst_shim32_read);
 
 void sst_shim32_write64(void __iomem *addr, u32 offset, u64 value)
 {
-	memcpy_toio(addr + offset, &value, sizeof(value));
+	writeq(value, addr + offset);
 }
 EXPORT_SYMBOL_GPL(sst_shim32_write64);
 
 u64 sst_shim32_read64(void __iomem *addr, u32 offset)
 {
-	u64 val;
-
-	memcpy_fromio(&val, addr + offset, sizeof(val));
-	return val;
+	return readq(addr + offset);
 }
 EXPORT_SYMBOL_GPL(sst_shim32_read64);
 
-- 
2.17.1

