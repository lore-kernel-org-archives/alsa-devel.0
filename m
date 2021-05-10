Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC354C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:43:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E37761075
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E37761075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C55D16AE;
	Mon, 10 May 2021 14:42:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C55D16AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620650589;
	bh=KDhJ4U4zfZRJMlrlKv6Wy1ZXfHORD+AQMBhzTOqmoR0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ttePaD+dXhYnARNBubViBTkjVaf9QC/xU0Q3Kxt5sz/wFwBgdgfEroz5EL1nc3Vlz
	 Gts9gjiv5QVQAeS5OIM+iLnmBRq5ykWjixTaA1FT47czg7dTsPrCfgDJbLqRlUO4Ez
	 2yGHkyKrYxdwOYMmgYTgBq1kikv0BQWAr2nNUfKE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10A97F80431;
	Mon, 10 May 2021 14:41:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FBAEF80475; Mon, 10 May 2021 14:41:29 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A781F8020C
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 14:41:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A781F8020C
IronPort-SDR: Od6VspusgoNyiTIYrKmNijJ7C7vijxfFJvBoGZSvkffRHAq5R+a+m+rdIJl/kd806UgGpG50ke
 xZXj+bKh+fIg==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="178772953"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; d="scan'208";a="178772953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 05:41:20 -0700
IronPort-SDR: 4NLjiemwXayWVocA9x8TEyGfOKixLkp4pjp/7TxYg/lE3YnRfFa9yBUs2qoFAkOPBGAEfBDkEe
 TcvCjaiwBf/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; d="scan'208";a="436125938"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga008.jf.intel.com with ESMTP; 10 May 2021 05:41:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 70AD512A; Mon, 10 May 2021 15:41:37 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v3 04/14] spi: pxa2xx: Replace header inclusions by forward
 declarations
Date: Mon, 10 May 2021 15:41:24 +0300
Message-Id: <20210510124134.24638-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
References: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
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
index f588fad77fc0..a259be12d326 100644
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
index 0f3f7d725937..1d4c7f4217ed 100644
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

