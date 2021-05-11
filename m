Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0173FC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 14:19:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4E5611BE
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 14:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4E5611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A6D617DA;
	Tue, 11 May 2021 16:18:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A6D617DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620742744;
	bh=dIDB/SxoNJuLi21uZhvIvfviMOdE+PTg+ElYL4iInOI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jYZUeTgQ91rb3g6OPA+ejQxkUxruJEGqUXF04ySaFMnIoG446MPgOnGrWq7mprLxv
	 DUC8p+JytzvJ4aLbKP3DvcXQ0XGKgiGaRFotwTRDfGQ1mAp1a//w+kZ6uP41lqSIwu
	 dJgOXntXzyekgyl3gLxcqtp2yTPbm+RfEksoHjJI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9F71F80425;
	Tue, 11 May 2021 16:17:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B032BF8028D; Tue, 11 May 2021 16:17:21 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28000F80156
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 16:17:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28000F80156
IronPort-SDR: 2/bTtHcTIaXJPoAgIwMlpwnT+u3GH8S7F/aTn7G9d/NYi127/9u3zjvM1bBw/5P1hDb65stoJs
 WMbB4Ks2VErw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="196357513"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="196357513"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2021 07:17:09 -0700
IronPort-SDR: 9Zu80WNTtR5tRdR/cl13e9OY6XFpOh4Fp3QnE94la8+gJh9BCIhlHyoXanNzpRMN5DgHLVAKRP
 8PPX0xL6+M2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="537047522"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga001.fm.intel.com with ESMTP; 11 May 2021 07:17:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 59B3612F; Tue, 11 May 2021 17:17:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: [PATCH v3 1/8] spi: pxa2xx: Reuse int_error_stop() in
 pxa2xx_spi_slave_abort()
Date: Tue, 11 May 2021 17:17:18 +0300
Message-Id: <20210511141725.32097-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511141725.32097-1-andriy.shevchenko@linux.intel.com>
References: <20210511141725.32097-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
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

It appears that pxa2xx_spi_slave_abort()almost  repeats the functionality
of the int_error_stop(). Reuse int_error_stop() in pxa2xx_spi_slave_abort().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 5572eec68381..087c84e605b9 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -631,7 +631,7 @@ static void int_stop_and_reset(struct driver_data *drv_data)
 	pxa2xx_spi_write(drv_data, SSTO, 0);
 }
 
-static void int_error_stop(struct driver_data *drv_data, const char *msg)
+static void int_error_stop(struct driver_data *drv_data, const char *msg, int err)
 {
 	int_stop_and_reset(drv_data);
 	pxa2xx_spi_flush(drv_data);
@@ -639,7 +639,7 @@ static void int_error_stop(struct driver_data *drv_data, const char *msg)
 
 	dev_err(drv_data->ssp->dev, "%s\n", msg);
 
-	drv_data->controller->cur_msg->status = -EIO;
+	drv_data->controller->cur_msg->status = err;
 	spi_finalize_current_transfer(drv_data->controller);
 }
 
@@ -658,12 +658,12 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 	u32 irq_status = pxa2xx_spi_read(drv_data, SSSR) & irq_mask;
 
 	if (irq_status & SSSR_ROR) {
-		int_error_stop(drv_data, "interrupt_transfer: fifo overrun");
+		int_error_stop(drv_data, "interrupt_transfer: fifo overrun", -EIO);
 		return IRQ_HANDLED;
 	}
 
 	if (irq_status & SSSR_TUR) {
-		int_error_stop(drv_data, "interrupt_transfer: fifo underrun");
+		int_error_stop(drv_data, "interrupt_transfer: fifo underrun", -EIO);
 		return IRQ_HANDLED;
 	}
 
@@ -1154,14 +1154,7 @@ static int pxa2xx_spi_slave_abort(struct spi_controller *controller)
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
-	int_stop_and_reset(drv_data);
-	pxa2xx_spi_flush(drv_data);
-	pxa2xx_spi_off(drv_data);
-
-	dev_dbg(drv_data->ssp->dev, "transfer aborted\n");
-
-	drv_data->controller->cur_msg->status = -EINTR;
-	spi_finalize_current_transfer(drv_data->controller);
+	int_error_stop(drv_data, "transfer aborted", -EINTR);
 
 	return 0;
 }
-- 
2.30.2

