Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD2AC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 13:39:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660AE61151
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 13:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 660AE61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D26C71717;
	Fri, 15 Oct 2021 15:38:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D26C71717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634305151;
	bh=A9jXwTcFC8fTR0xb4gLeyx0y2KgMhHMSLCA0ho40cpM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M8RQ4fENtBs+9T12e2dpnY4Y9riqXASSvYVgEvwEBlKAa4wCnMh4g9bJ/wuNy6Xgl
	 eOD04g7N0jXnnWyxkTI8U+gRqsnIQukFyuJBmCCxtTZ5x16P10Nqzk2QUjBVt8aRfy
	 4Z2jyYSw7RWcWHORtSkBh6zSkmFX8PBv+fhOSenU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DCC4F80516;
	Fri, 15 Oct 2021 15:36:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4DDDF80430; Fri, 15 Oct 2021 15:36:43 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63071F80430
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 15:36:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63071F80430
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Q8kJMzQF"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F4c2t0023483; 
 Fri, 15 Oct 2021 08:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=mYpyM5k5iTck7jZ9mZU5Jk8Bn9rAW8lHbmdBtXkem3Q=;
 b=Q8kJMzQFzuvw7zTSERpZSIOW0JPw3Uebt5+kI4US2yJdk23ShLT+BVS9tp5+EyWmFcps
 bZ/jI55LoChlZILqdfRzj0i37mpzC+58V77pZ3rAPk/wWqWqiR/RPv9bNNZWUCb+UMWA
 JM4eOXehJlpB8yZvvTeDhraj6a8IGeLl/r+/uaYA5Q7ihNf4xL842wWD4UXOSL48yiSP
 kZ74TiZ0Qx6uktM7+8e3AW0nf1Jc/3uZuUfawz/n32rsajRXhJ9ZIfOPzKRtVUrIZPoq
 4NB25mUwLzjsqT2W8oR3caYTc5y7zTq6W6J5X+OkNHLj9Fu80DLISo+z+we3C+724dWp Ww== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5v-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 15 Oct 2021 08:36:25 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:23 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com
 [198.61.65.254])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2924A11D2;
 Fri, 15 Oct 2021 13:36:23 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 05/16] ASoC: cs42l42: Defer probe if request_threaded_irq()
 returns EPROBE_DEFER
Date: Fri, 15 Oct 2021 14:36:08 +0100
Message-ID: <20211015133619.4698-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bY2ytakBw6GEzcEmjJcndbZNwlZlg0xf
X-Proofpoint-GUID: bY2ytakBw6GEzcEmjJcndbZNwlZlg0xf
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org
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

The driver can run without an interrupt so if devm_request_threaded_irq()
failed, the probe() just carried on. But if this was EPROBE_DEFER the
driver would continue without an interrupt instead of deferring to wait
for the interrupt to become available.

Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index c4efdc8f5d24..0ecf2129ea45 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2053,8 +2053,9 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 			NULL, cs42l42_irq_thread,
 			IRQF_ONESHOT | IRQF_TRIGGER_LOW,
 			"cs42l42", cs42l42);
-
-	if (ret != 0)
+	if (ret == -EPROBE_DEFER)
+		goto err_disable;
+	else if (ret != 0)
 		dev_err(&i2c_client->dev,
 			"Failed to request IRQ: %d\n", ret);
 
-- 
2.11.0

