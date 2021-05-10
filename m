Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1219BC433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:46:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED4E6112F
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED4E6112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE7EC16B3;
	Mon, 10 May 2021 14:46:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE7EC16B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620650811;
	bh=uV/OnLN74LZ5R7idsmHoOoMuZGJAA/3/O2wlYnV5ONk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O0cCV4tZY/qGomAFghZmDrAnH3sm152Tl0wdrs913Zujo+kRhr9Va4QARnz//9gqy
	 TJLkxiwPnuhDyniFwImKD++bjs+gs4wb9oXfeSQ3Ent2qK4oQYH/WYTHf3rfkmAhYZ
	 23wi2pbqnhO6UdxWwstI9/oZdg1TyQCJbrcJKIKk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8470EF80506;
	Mon, 10 May 2021 14:41:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10C26F804DF; Mon, 10 May 2021 14:41:40 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C183F800B4
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 14:41:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C183F800B4
IronPort-SDR: hq3UCEtMdGez3qXn7RZ7incdCys/58ntMqAZFPMLsMaq3nKCt653KOkPWXWq5AsAVm2ccqMCkC
 aulagl6HXmWw==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="263114689"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; d="scan'208";a="263114689"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 05:41:24 -0700
IronPort-SDR: k96x0w/6iJcHK4jc3IfdWDRaVBSgVDOc2v1wMLmgRwvpleZHRvcxjbK4W0i052cWV7T70MzHuB
 LaITi/jTN75g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; d="scan'208";a="624267516"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga005.fm.intel.com with ESMTP; 10 May 2021 05:41:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id A05A4543; Mon, 10 May 2021 15:41:37 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v3 07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
Date: Mon, 10 May 2021 15:41:27 +0300
Message-Id: <20210510124134.24638-8-andriy.shevchenko@linux.intel.com>
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

Currently we have three times the same few lines repeated in the code.
Deduplicate them by newly introduced int_stop_and_reset() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1d4c7f4217ed..5572eec68381 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -620,13 +620,20 @@ static void reset_sccr1(struct driver_data *drv_data)
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
 }
 
-static void int_error_stop(struct driver_data *drv_data, const char *msg)
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
 
@@ -638,11 +645,7 @@ static void int_error_stop(struct driver_data *drv_data, const char *msg)
 
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

