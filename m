Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D547C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:22:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7272D2078E
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bAWO0/iX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1mK1tGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7272D2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4EF0168E;
	Thu, 10 Sep 2020 12:21:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4EF0168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599733367;
	bh=Vn55p+LxvWnEzCqPjPCX6b8ldD6yS/hw5WG+ODDACjY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bAWO0/iXCsCRou/KxIqkJa/cdqAwhRWuLY3Y3OcbLqZhRzy1aCWrNlw8bB5rX/jtL
	 XQz5dtN7YFMe83uB2WUpCniqCE7IXcGE03zyge3EykEbnFXaT5V8iFISigOh1dcoSk
	 eB/uFKvgGZNw4eXPtI+0OvAhNDvOCNtS3RManWWQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94959F802FD;
	Thu, 10 Sep 2020 12:18:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C90E6F802DD; Thu, 10 Sep 2020 12:18:09 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7DAAF80272
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 12:17:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7DAAF80272
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="e1mK1tGz"
Received: by mail-wr1-x442.google.com with SMTP id x14so6034676wrl.12
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5EKdqRsK8wVtz9cHR3wKpVYkVxvCf4OgD26PR6bDVFQ=;
 b=e1mK1tGz6rZaNFFeQOtX2dk9yd8gvcj3TmaGXRNp1rqBIffPapTSViWj1tmPT/i0Sj
 bX6Jdr3LpJclFl1JAq2XVIrK5Fj5nxWBUryo1a71BZFL9dDYC8G3E6JOLlfUj2oj9x1g
 masAqBHlE0yWtextn4dI95Lwgv0cAvBdVvap5r9e3ezZEd1URr5OsAetuaNMmIKA5T1m
 n+A0dkvgFOX9FJQTn+CZ2b64lGGja+5QvtGMspVRwzDBfYq4n1nrTjFTXschjs/lO141
 Kzxqz9wSjXJmESJR+8zWXkjkN0VTyTAyWQiow+omrnDjuzbQoicZHVUpsGL59+FvvW3d
 w/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5EKdqRsK8wVtz9cHR3wKpVYkVxvCf4OgD26PR6bDVFQ=;
 b=hWif4ym9OZWwLPk3uitZ43+6qWchWEdTGf0pVIJjsalLubzusPvefF7dDDcMd6BLeg
 d1tbwOlO0rJEwI2RZsqK9gxkSP4MbZgJyhAAQ1TAuIYBCHffxoyPBSKBzPF+L0OO3ITI
 Jr/SAMT7CxkX1EibipGPstLgWoEz33BSgtmGlragIKt0LHMaiav6BHPZgrBkV+8R4gWj
 KKX2G5hoSjl16JKilpVdTWJSKNRwTJnAkt5Ds+jmTLBRZZ4KPxeG8NP3EXPx9GoZd99y
 FRqAP10wIo0w0I49IhkcKzKY2d5PR9J9XTKpm5/nHGGhK+zojMdc7qm/z16nEmzpd2K1
 iJQQ==
X-Gm-Message-State: AOAM532BvtKWuxqsPWjLTnCYeY1HWRbrg3TWJM/o5wPdCuH7N8q5+ZUg
 kcBCEUu+rB/xvD15+apIjHfXmw==
X-Google-Smtp-Source: ABdhPJz6Gm1hlVXhAPmoOB7PYf2rx5xu/cRrmqQk65gftmzu7Hm5sDaEbywIRTAXQiAz5cAbxcYRRg==
X-Received: by 2002:adf:94c1:: with SMTP id 59mr8856155wrr.29.1599733072447;
 Thu, 10 Sep 2020 03:17:52 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id m4sm8851731wro.18.2020.09.10.03.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:17:51 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 4/8] ASoC: q6dsp: q6afe: add global q6afe waitqueue
Date: Thu, 10 Sep 2020 11:17:28 +0100
Message-Id: <20200910101732.23484-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
References: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

In some cases like clocks q6afe would have to process commands
without an associated q6afe port, in such cases waitqueue is
required at global level to wait for the command to finish.
This patch also adds the command result to go with this waitqueue.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index f934c69f0a14..2a8e3c3acb10 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -362,6 +362,8 @@ struct q6afe {
 	struct device *dev;
 	struct q6core_svc_api_info ainfo;
 	struct mutex lock;
+	struct aprv2_ibasic_rsp_result_t result;
+	wait_queue_head_t wait;
 	struct list_head port_list;
 	spinlock_t port_list_lock;
 };
@@ -905,11 +907,20 @@ static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
 			    struct q6afe_port *port, uint32_t rsp_opcode)
 {
 	wait_queue_head_t *wait = &port->wait;
+	struct aprv2_ibasic_rsp_result_t *result;
 	int ret;
 
 	mutex_lock(&afe->lock);
-	port->result.opcode = 0;
-	port->result.status = 0;
+	if (port) {
+		wait = &port->wait;
+		result = &port->result;
+	} else {
+		result = &afe->result;
+		wait = &afe->wait;
+	}
+
+	result->opcode = 0;
+	result->status = 0;
 
 	ret = apr_send_pkt(afe->apr, pkt);
 	if (ret < 0) {
@@ -918,13 +929,13 @@ static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
 		goto err;
 	}
 
-	ret = wait_event_timeout(*wait, (port->result.opcode == rsp_opcode),
+	ret = wait_event_timeout(*wait, (result->opcode == rsp_opcode),
 				 msecs_to_jiffies(TIMEOUT_MS));
 	if (!ret) {
 		ret = -ETIMEDOUT;
-	} else if (port->result.status > 0) {
+	} else if (result->status > 0) {
 		dev_err(afe->dev, "DSP returned error[%x]\n",
-			port->result.status);
+			result->status);
 		ret = -EINVAL;
 	} else {
 		ret = 0;
@@ -1594,6 +1605,7 @@ static int q6afe_probe(struct apr_device *adev)
 	q6core_get_svc_api_info(adev->svc_id, &afe->ainfo);
 	afe->apr = adev;
 	mutex_init(&afe->lock);
+	init_waitqueue_head(&afe->wait);
 	afe->dev = dev;
 	INIT_LIST_HEAD(&afe->port_list);
 	spin_lock_init(&afe->port_list_lock);
-- 
2.21.0

