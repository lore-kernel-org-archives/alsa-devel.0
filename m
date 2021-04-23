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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82126C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 16:36:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCBF611CC
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 16:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCBF611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48C8316C8;
	Fri, 23 Apr 2021 18:35:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48C8316C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619195800;
	bh=tHZAI6HqUCnbIRIs2ZrVZpvbRlLREJCLzLfIzYNrjqU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vAqTl+SQErunWilA2jWN4Hewp0iEIYtdSBYRgv/vPKcqXa96b0XZBNd/3cRau+45z
	 qqQR7PTHfJAgF8q1YVueFtLOf0NlfC4jnmLBvhXy+uPUF0Qzn+CIvktSRt0o32Jwpt
	 jUhutNpLJ0kQn1SaBEdxWsBsXx07aeP42G2cJZcQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3BFCF80425;
	Fri, 23 Apr 2021 18:34:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB6B4F80425; Fri, 23 Apr 2021 18:34:56 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B511F8019B
 for <alsa-devel@alsa-project.org>; Fri, 23 Apr 2021 18:34:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B511F8019B
IronPort-SDR: 5QElEqx+1oymwVzCnr5Uba9OE/ByazO7IbK6dRmpp9VUBsTUk9I/fTnhw3tpvNo5hD1G3sr9Ja
 UGa2Fu7XNzNQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="196207754"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; d="scan'208";a="196207754"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2021 09:34:45 -0700
IronPort-SDR: aGfRC6eHIiaAHzhD3asgWFjtwXMEw4FMrHLMro5KfX6CXSi88je7n2gFSfR5pY9nUuTA1rdalI
 WTo69CvlZJhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; d="scan'208";a="453620726"
Received: from black.fi.intel.com ([10.237.72.28])
 by FMSMGA003.fm.intel.com with ESMTP; 23 Apr 2021 09:34:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id BE7E941F; Fri, 23 Apr 2021 19:34:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v1 07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
Date: Fri, 23 Apr 2021 19:34:30 +0300
Message-Id: <20210423163437.89306-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
References: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
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

