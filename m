Return-Path: <SRS0=7xvc=JU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522D1C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 18:27:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35FF613CC
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 18:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35FF613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 595B8170C;
	Fri, 23 Apr 2021 20:26:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 595B8170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619202462;
	bh=fVCDzoK6nKK/pLngLwZgMoY/CosPoYWPGKebZ6wdUTI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ChpilEYEwY8/dRgKmcuQp4naAD5JbDU/6dH1y2cIGRK4hB/App//IKXb1moFnJHaE
	 2s2jQVcjt7xxutPKczm1nRBpV30x0x7QTBw5FZEGLwIJsmunZtdgOohfWZ2OHgsGeD
	 jJU1Lyzsm+48yZIVYj/GAA3z78FXuN0fgpPJdXVo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B58F5F8028B;
	Fri, 23 Apr 2021 20:24:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C48D3F800AE; Fri, 23 Apr 2021 20:24:46 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 919B2F800AE
 for <alsa-devel@alsa-project.org>; Fri, 23 Apr 2021 20:24:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 919B2F800AE
IronPort-SDR: FwWOazLEQxSiLEGsSGTXYdAGH9RcnSStm8SrQP8zGRGoGr4UNP9072+SmaXaOcrPGrCda3RWwM
 V1DarrOb73Kg==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="216800312"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; d="scan'208";a="216800312"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2021 11:24:29 -0700
IronPort-SDR: PPMozkHLAIBdUAvX8jNtyk1sKmp6UfYQODVmNI0wMvS1Jwy8I7tyuEmC7NH3Prk8/dt6LgkJLq
 I4cgGPhwYKrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; d="scan'208";a="392155981"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga007.fm.intel.com with ESMTP; 23 Apr 2021 11:24:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 12EF81C8; Fri, 23 Apr 2021 21:24:45 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 04/14] spi: pxa2xx: Replace header inclusions by forward
 declarations
Date: Fri, 23 Apr 2021 21:24:31 +0300
Message-Id: <20210423182441.50272-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
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

When the data structure is only referred by pointer, compiler may not need
to see the contents of the data type. Thus, we may replace header inclusions
by respective forward declarations. Due to above add missed headers as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c   |  4 ++--
 drivers/spi/spi-pxa2xx-pci.c   |  1 +
 drivers/spi/spi-pxa2xx.c       |  2 ++
 drivers/spi/spi-pxa2xx.h       | 18 ++++++++++--------
 include/linux/spi/pxa2xx_spi.h |  2 ++
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 2e4a49567146..e00dbadd39ec 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -9,11 +9,11 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/pxa2xx_ssp.h>
 #include <linux/scatterlist.h>
 #include <linux/sizes.h>
-#include <linux/spi/spi.h>
+
 #include <linux/spi/pxa2xx_spi.h>
+#include <linux/spi/spi.h>
 
 #include "spi-pxa2xx.h"
 
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index f60ed4c62000..5af0a3fbc1b0 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+
 #include <linux/spi/pxa2xx_spi.h>
 
 #include <linux/dmaengine.h>
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e9dddcbd92f1..0296cbdee848 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
@@ -25,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 6724d7e056ce..739e264feaa6 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -7,16 +7,18 @@
 #ifndef SPI_PXA2XX_H
 #define SPI_PXA2XX_H
 
-#include <linux/atomic.h>
-#include <linux/dmaengine.h>
-#include <linux/errno.h>
-#include <linux/io.h>
 #include <linux/interrupt.h>
-#include <linux/pxa2xx_ssp.h>
-#include <linux/scatterlist.h>
+#include <linux/io.h>
+#include <linux/types.h>
 #include <linux/sizes.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/pxa2xx_spi.h>
+
+#include <linux/pxa2xx_ssp.h>
+
+struct gpio_desc;
+struct pxa2xx_spi_controller;
+struct spi_controller;
+struct spi_device;
+struct spi_transfer;
 
 struct driver_data {
 	/* SSP Info */
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 31f00c7f4f59..1e0e2f136319 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -5,6 +5,8 @@
 #ifndef __linux_pxa2xx_spi_h
 #define __linux_pxa2xx_spi_h
 
+#include <linux/types.h>
+
 #include <linux/pxa2xx_ssp.h>
 
 #define PXA2XX_CS_ASSERT (0x01)
-- 
2.30.2

