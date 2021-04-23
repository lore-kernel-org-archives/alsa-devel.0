Return-Path: <SRS0=7xvc=JU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A82C433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 18:27:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85829613CB
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 18:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85829613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 096AE170B;
	Fri, 23 Apr 2021 20:26:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 096AE170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619202437;
	bh=tHZAI6HqUCnbIRIs2ZrVZpvbRlLREJCLzLfIzYNrjqU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JzL4qxVunFWlBf+7gunSyVHAmtfbnNPmlaKIDPW5KBstBWRdFAhw4X2K4Ax4JZxxo
	 dq9VM7vA/cPHeaCyVNWCeL7vJlR/FAWgWcKAU2hpxXjI55kTkmly4X1COzYTaEMsW0
	 eD+wiQ9P2gmufDDz5eTCMuvffVRho02uwphi7aFw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CA2BF804B4;
	Fri, 23 Apr 2021 20:24:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48B4EF804AD; Fri, 23 Apr 2021 20:24:45 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12198F8025A
 for <alsa-devel@alsa-project.org>; Fri, 23 Apr 2021 20:24:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12198F8025A
IronPort-SDR: ak3LGXPoTOG4F1OmXFTg9fHGjsWKdohBgSer49wp4uF2Az1ARJJWgvXF9/8HaXUsNvsZpY+S83
 5BSlTIwymCbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="257419358"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; d="scan'208";a="257419358"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2021 11:24:34 -0700
IronPort-SDR: T5VDpAcrUDPQV+RBXIfMSnlvoAss8srtFtswn2sZ0B6TOHoWIXuwrDSk1htQaDqM37SkuV5iH4
 inoOyvhDMbvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; d="scan'208";a="614792178"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2021 11:24:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 374B3450; Fri, 23 Apr 2021 21:24:45 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
Date: Fri, 23 Apr 2021 21:24:34 +0300
Message-Id: <20210423182441.50272-8-andriy.shevchenko@linux.intel.com>
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

Currently we have three times the same few lines repeated in the code.
Deduplicate them by newly introduced int_stop_and_reset() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0296cbdee848..4dab47e18d10 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -620,13 +620,20 @@ static void reset_sccr1(struct driver_data *drv_data)
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
 }
 
-static void int_error_stop(struct driver_data *drv_data, const char* msg)
+static void int_stop_and_reset(struct driver_data *drv_data)
 {
-	/* Stop and reset SSP */
+	/* Clear and disable interrupts */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
 	reset_sccr1(drv_data);
-	if (!pxa25x_ssp_comp(drv_data))
-		pxa2xx_spi_write(drv_data, SSTO, 0);
+	if (pxa25x_ssp_comp(drv_data))
+		return;
+
+	pxa2xx_spi_write(drv_data, SSTO, 0);
+}
+
+static void int_error_stop(struct driver_data *drv_data, const char *msg)
+{
+	int_stop_and_reset(drv_data);
 	pxa2xx_spi_flush(drv_data);
 	pxa2xx_spi_off(drv_data);
 
@@ -638,11 +645,7 @@ static void int_error_stop(struct driver_data *drv_data, const char* msg)
 
 static void int_transfer_complete(struct driver_data *drv_data)
 {
-	/* Clear and disable interrupts */
-	write_SSSR_CS(drv_data, drv_data->clear_sr);
-	reset_sccr1(drv_data);
-	if (!pxa25x_ssp_comp(drv_data))
-		pxa2xx_spi_write(drv_data, SSTO, 0);
+	int_stop_and_reset(drv_data);
 
 	spi_finalize_current_transfer(drv_data->controller);
 }
@@ -1151,11 +1154,7 @@ static int pxa2xx_spi_slave_abort(struct spi_controller *controller)
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
-	/* Stop and reset SSP */
-	write_SSSR_CS(drv_data, drv_data->clear_sr);
-	reset_sccr1(drv_data);
-	if (!pxa25x_ssp_comp(drv_data))
-		pxa2xx_spi_write(drv_data, SSTO, 0);
+	int_stop_and_reset(drv_data);
 	pxa2xx_spi_flush(drv_data);
 	pxa2xx_spi_off(drv_data);
 
-- 
2.30.2

