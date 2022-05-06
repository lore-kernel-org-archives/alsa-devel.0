Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB1BC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  6 May 2022 08:48:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33BA21708;
	Fri,  6 May 2022 10:47:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33BA21708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651826895;
	bh=s/u0tZSe/yWSdBaOwaYYvxnafqZCurxUicPttcZw//Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OS5vil0nrVZTlrEMvkm7edApSzHiXlC6GFYrlxfyvkt7AFtC16bNjPgZbH+SqNuAv
	 PoWW8Uy/Xj6ExCcJoK7Ygcls69Guu+H0u+ahOPOWHu1uHSYpVjFQZSIkDPPJlXoK4e
	 NZ86T5zs0hNgvjwT0hkim9a8a0rBqsNLb2r65cMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2DC5F8012F;
	Fri,  6 May 2022 10:47:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E260CF8014B; Fri,  6 May 2022 10:47:21 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20C8EF800F0
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2022 10:47:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20C8EF800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="IMscpR8P"
Received: by mail-wr1-x42a.google.com with SMTP id e2so9082374wrh.7
 for <alsa-devel@alsa-project.org>; Fri, 06 May 2022 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7LQd7iQdqQi625fScqqUgHbyBnZ+6vFhX41p9tiKGP0=;
 b=IMscpR8PfJpHILzYcvylriVA5ovdlSmxZrGEyN8QyRyGkOIt2J2TgzSLvmKypmI5NW
 ro/p3Mou7emqGjRj/MS2mserpj9t5GFyhxt3wz6C0usU9tF9ynFSS5gcILBENYBIG4V3
 pjukkVG2qOCKx7MLAtwcgew8GJF+xHexsU2B9QRja11CqGmRCiUF+DmN7jljGh0uimSF
 pDBctRlBEpWvlKE6JDMsbNO+MsSCimMP3nsQVWIe7JzmUHgCgQRf2HA1igkX1zKOprQt
 j+adMdy+mNLIPOijwOxn6jIgfBDKWIamR7pPW+8iq0vQyh2HQXo959bVD9QDWDMVSSMx
 i9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7LQd7iQdqQi625fScqqUgHbyBnZ+6vFhX41p9tiKGP0=;
 b=wC2Kx9gppzjFWdVhFqXT+FPed0fxcZPzIY+hxdwgrMAdVXspyJUMMVOFghGQ7S++Y0
 KzRe6+sjdtmlYyLmS8wDX1vdUU81n6q8K9ZVV2KjNTJ4Rf6s+ktoKu+f6mpCDozI6fkv
 38JXL9FP5K7Qim7lYn5WeciDMYS0RMrYqkKa9Gk2HUV+M84lR9eM3W1UdziMXEOCkJWk
 PybVZR6d20VvdH5KCgH+DMxcDdXH4yQKTe6c2thFi165J2rs+8AoYN5QFJudR99zHQux
 +DpD+KwBWXm6aC5wtPcQST5Vlkrm57Cs2fhhXx5ydk5euGbJcnjOgo/3xJ/5NMbnLzO/
 3ImQ==
X-Gm-Message-State: AOAM530+kC6QTnHZ1E6UGVPWUA91ahp3I8eyfFAfkrX6iHeiKkBwnBgh
 JNOnI+M2vqkVECH7wib/0kKw3g==
X-Google-Smtp-Source: ABdhPJx4WNtOGpGgOD2ShjcgQm2jF+xPxTjiXdlFjdV8rdMqU7AYWO6RI//SkfzYV9xgRDf/GROpyQ==
X-Received: by 2002:a5d:6345:0:b0:20a:d69f:8126 with SMTP id
 b5-20020a5d6345000000b0020ad69f8126mr1775273wrw.276.1651826833431; 
 Fri, 06 May 2022 01:47:13 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a5d62c9000000b0020c5253d903sm3071349wrv.79.2022.05.06.01.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 01:47:12 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH v2] soundwire: qcom: adjust autoenumeration timeout
Date: Fri,  6 May 2022 09:47:05 +0100
Message-Id: <20220506084705.18525-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, bard.liao@intel.com,
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
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

Currently timeout for autoenumeration during probe and bus reset is set to
2 secs which is really a big value. This can have an adverse effect on
boot time if the slave device is not ready/reset.
This was the case with wcd938x which was not reset yet but we spent 2
secs waiting in the soundwire controller probe. Reduce this time to
1/10 of Hz which should be good enough time to finish autoenumeration
if any slaves are available on the bus.

Reported-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v1:
	replaced HZ/10 with 100 as suggested by Pierre

 drivers/soundwire/qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 7367aa88b8ac..d6111f69d320 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -105,7 +105,7 @@
 
 #define SWRM_SPECIAL_CMD_ID	0xF
 #define MAX_FREQ_NUM		1
-#define TIMEOUT_MS		(2 * HZ)
+#define TIMEOUT_MS		100
 #define QCOM_SWRM_MAX_RD_LEN	0x1
 #define QCOM_SDW_MAX_PORTS	14
 #define DEFAULT_CLK_FREQ	9600000
-- 
2.21.0

