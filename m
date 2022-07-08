Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B68C43334
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jul 2022 10:48:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F34B4857;
	Fri,  8 Jul 2022 12:48:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F34B4857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657277336;
	bh=QSfQMxJsNACBIsEJ4z8tYVL/f1v5Nh5d8QzOTfERDKc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qX0l01v6LVywtmIjaU2bosEI0MTmmZeEW3uFRkI4MwWS7JYrQ2coe8Ro950+L+phs
	 omTXWUl01uIEwrsXH/aqKT5tDhiZx6nWaQUBqO48L04zrPvR5jmHSlwwLM4kqogR0s
	 v8Cy7+c9oigbraz0WGihd8fYh9J0f79Xt6Hr54mw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A10B3F80166;
	Fri,  8 Jul 2022 12:48:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABB29F80167; Fri,  8 Jul 2022 12:48:03 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7597DF800C5
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2022 12:47:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7597DF800C5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="JPtEmO4t"
Received: by mail-wr1-x430.google.com with SMTP id q9so29989803wrd.8
 for <alsa-devel@alsa-project.org>; Fri, 08 Jul 2022 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xluwZ9y3zdmAPfcT1yYXDD9KZroOpceJIZ4q+RRr1oU=;
 b=JPtEmO4trG7s6aC0J9ygjQlOCrt7aZxW4zQWOL3LYOBjAeYpBRPDb6+tO3McP54lf9
 iKP27VpYJP9FFXqEVGefhLGNOEVZcXePzkp5qaytOID3uUF3nTsPzw/NjZ6p06b8PovV
 joEjnoJ0qcQ5BMlZk006adTqPyp7TYLSNO6LX6jllBGN7bg5rccHpoF/Pk198DrTtkN3
 /WeVTPniOizjNDT04kTwZIwCv7//GRyefmpP6im3meVPzUaR1XC4U4msgdm1YPJ8z1bc
 Cm6YMjj0N4pPIeOUhP3VsiOnyKYEivqNkGkclUlN3cBTtPNkztWhwRH7Mfn2Xvyw7uUh
 8ZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xluwZ9y3zdmAPfcT1yYXDD9KZroOpceJIZ4q+RRr1oU=;
 b=i7OPQe3VPiQKzYwz149yEY18uiid/Pp3qQJM8voOKMn2Ib9juDW/wx0q03Id1um6zF
 3E4zawcMWiKbZKLfLd3FFE94/AmKLZtbeIp6DveyycXOOmCKwGU6AuDWHNY47Cgzgxne
 dCx9YQMY/VhglbPEK4tq1LjHkJEFWv7952OV9O3c0qwVEnbVcbQHXZzrR7/UoVTLsqRG
 SFT8QLQTNbuicK8QhABWKYQXdRSjlq41dJYtGMV9y+RwYuV7jnU1mV8oi+C/iivHKUsM
 uBkm9yeMr8Rq4mrm3Jwcll0cwcBlnXlYzbv16ClhYyZo6CzYzWC4zLZRiHgTdiIXy1L8
 /PTg==
X-Gm-Message-State: AJIora/qoyRW1mL3B3amCrJzEhlI3aAqTcuPa/7KC2JRoDqZWs9iYDuS
 Qfuf00AlxIVMZDm4OZ2ZvHnwjg==
X-Google-Smtp-Source: AGRyM1tT9rQIlM4HXj5Tbwcts2dErI6OHFaa52hqrQ9CstIDKYjsLpQenpYPtpMOAPh6+QIHiep/6g==
X-Received: by 2002:a05:6000:15c1:b0:21b:ad5e:2798 with SMTP id
 y1-20020a05600015c100b0021bad5e2798mr2636491wry.237.1657277275444; 
 Fri, 08 Jul 2022 03:47:55 -0700 (PDT)
Received: from srini-hackbase.lan
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a1c4c13000000b003a2da6b2cbesm1251621wmf.33.2022.07.08.03.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jul 2022 03:47:54 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH v2] soundwire: qcom: fix device status array range
Date: Fri,  8 Jul 2022 11:47:47 +0100
Message-Id: <20220708104747.8722-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 yung-chuan.liao@linux.intel.com, dan.carpenter@oracle.com
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

This patch updates device status array range from 11 to 12 as we will
be reading status from device number 0 to device number 11 inclusive.

Without this patch we can potentially access status array out of range
during auto-enumeration.

Fixes: aa1262ca6695 ("soundwire: qcom: Check device status before reading devid")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 9df970eeca45..16a4a51978ca 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -169,7 +169,7 @@ struct qcom_swrm_ctrl {
 	u8 wcmd_id;
 	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
 	struct sdw_stream_runtime *sruntime[SWRM_MAX_DAIS];
-	enum sdw_slave_status status[SDW_MAX_DEVICES];
+	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	int (*reg_read)(struct qcom_swrm_ctrl *ctrl, int reg, u32 *val);
 	int (*reg_write)(struct qcom_swrm_ctrl *ctrl, int reg, int val);
 	u32 slave_status;
@@ -420,7 +420,7 @@ static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
 
 	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
 
-	for (dev_num = 0; dev_num < SDW_MAX_DEVICES; dev_num++) {
+	for (dev_num = 0; dev_num <= SDW_MAX_DEVICES; dev_num++) {
 		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
 
 		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
@@ -440,7 +440,7 @@ static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
 	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
 	ctrl->slave_status = val;
 
-	for (i = 0; i < SDW_MAX_DEVICES; i++) {
+	for (i = 0; i <= SDW_MAX_DEVICES; i++) {
 		u32 s;
 
 		s = (val >> (i * 2));
-- 
2.25.1

