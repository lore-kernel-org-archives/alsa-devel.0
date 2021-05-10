Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EEBC433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:45:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E06961075
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E06961075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70F0D16BA;
	Mon, 10 May 2021 14:44:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70F0D16BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620650720;
	bh=Eow7T4182eUiR0GIBEOlqKwtSncKX3IE56AMTup06VU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aQtu2r9ZBZ3AisInEEuggYkhyZDn247HfiGdagKXD8KCupL+UMBLavAZYFG2da6v7
	 rj9HKEc2Xws3Cxj1ROnH0TzO1E2ZCQmx6qL5KlJUo888HKVXLte3ZK98w8vgNxaJLS
	 CkKWip+TaGlPNG2RobYhSumi3n8RSEASKJtOTehA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84815F804A9;
	Mon, 10 May 2021 14:41:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E33B8F80272; Mon, 10 May 2021 14:41:34 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49D92F80272
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 14:41:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49D92F80272
IronPort-SDR: YWHAYJObq2yhVqNP90jq4l9e49fafhlYaRexiBqkGwEz8sOPW/X0LZzKo2iRdPOgfZz/nBMPrP
 a/ZZpGl1Poew==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="284668268"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; d="scan'208";a="284668268"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 05:41:23 -0700
IronPort-SDR: qxtEAUyUL8Rq2EkFNaJFKm1ws9a0ghx+MIVDB7HyOtsZQfq8UXDaBAjWk7k2jEp7vHTmqUv9k5
 ejsakoIDQOnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; d="scan'208";a="433796216"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga008.fm.intel.com with ESMTP; 10 May 2021 05:41:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 857BD202; Mon, 10 May 2021 15:41:37 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v3 05/14] spi: pxa2xx: Unify ifdeffery used in the headers
Date: Mon, 10 May 2021 15:41:25 +0300
Message-Id: <20210510124134.24638-6-andriy.shevchenko@linux.intel.com>
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

The two headers have quite different ifdeffery to prevent multiple inclusion.
Unify them with the pattern that in particular reflects their location.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pxa2xx_ssp.h     | 6 +++---
 include/linux/spi/pxa2xx_spi.h | 7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 7f73b26ed22e..14b049840faf 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -11,8 +11,8 @@
  *       PXA3xx     SSP1, SSP2, SSP3, SSP4
  */
 
-#ifndef __LINUX_SSP_H
-#define __LINUX_SSP_H
+#ifndef __LINUX_PXA2XX_SSP_H
+#define __LINUX_PXA2XX_SSP_H
 
 #include <linux/bits.h>
 #include <linux/compiler_types.h>
@@ -270,4 +270,4 @@ static inline struct ssp_device *pxa_ssp_request_of(const struct device_node *n,
 static inline void pxa_ssp_free(struct ssp_device *ssp) {}
 #endif
 
-#endif
+#endif	/* __LINUX_PXA2XX_SSP_H */
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 1e0e2f136319..12ef04d0896d 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -2,8 +2,8 @@
 /*
  * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
  */
-#ifndef __linux_pxa2xx_spi_h
-#define __linux_pxa2xx_spi_h
+#ifndef __LINUX_SPI_PXA2XX_SPI_H
+#define __LINUX_SPI_PXA2XX_SPI_H
 
 #include <linux/types.h>
 
@@ -51,4 +51,5 @@ struct pxa2xx_spi_chip {
 extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info);
 
 #endif
-#endif
+
+#endif	/* __LINUX_SPI_PXA2XX_SPI_H */
-- 
2.30.2

