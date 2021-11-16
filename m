Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2129C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 11:50:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670016142A
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 11:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 670016142A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0CEB169D;
	Tue, 16 Nov 2021 12:49:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0CEB169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637063432;
	bh=GdXTT8ii5KI60zsUJmnTOJOCGylpLh0KqQQ8EsiGj5Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KVTMi/UY0U13M4MNwSNUaCSt2hoZQFgJAOAcjJo4JX+Z8vVYtykgQeG5Tkhdj/lbt
	 tskUyw0ZHvo4o6xa+Jt4YP7pMWTv5zVJ3QNKPUtXCFQXByO5Xh6G04jTq75ETXidaz
	 pecVTNUWsHrfGqNzuUn72tooAhIti0W5wBYcaws8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4097F8051A;
	Tue, 16 Nov 2021 12:48:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E99BDF8051A; Tue, 16 Nov 2021 12:47:55 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6753AF804F3
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 12:47:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6753AF804F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="u6/Qx08y"
Received: by mail-wr1-x429.google.com with SMTP id t30so36915523wra.10
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 03:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QCyiK2qb1OjrBa7Q9ogzPGmxQZdO6zxp4f+nX7Gvr4E=;
 b=u6/Qx08ym6n6+0pUi+ZienjvfVY6wB8yIHLTbnMTgv7QVxP1X06PdXFX49aFXg7MsS
 AJ8edlpHH13EpEx9wHGZTcPgw2z7V0mLdKZxj7f45/axbn4TlfcSlH7tlvQf5IEATzvK
 9GyoBcLGAmfA+BbRUBQqCeHjLGYEUORtXVpMFCDGKC/k4SaDl3DAoMBd5mlwbPAPP2OV
 +y6N90ugvsOpv2HyWHT8F48vjTRXuTp6BVBScBDoMiP8lqHQcyu2MbCRmOKSmsarphR/
 K7onfMqMVg1Mf64/n09e73BbGTTU/ZkICTgwxD66ydERajc6G7tWjY+AKCMkCmf+ebrD
 AKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QCyiK2qb1OjrBa7Q9ogzPGmxQZdO6zxp4f+nX7Gvr4E=;
 b=5MuG5zDe0dshzBxb0ZojU++ZYWNVZpy9PgYUJXzp9RjYA72sfmFatXuTwA6K6NZ9Mr
 g4ZJDJzyOKF8d9uPBXk+RTmnVL8f7MlGTXFO+eK6eHXqh3S6bVM1+wDJAhmP3KkxnO5+
 3A6BFiu4XYqH6vraqvu9SlSWrB+kNA1lkfFMy3vZM5xgsgrfcbg+uy3+90iKPoPLGMBz
 JSRfwJ+PsCsqB4t/2svzAFTxxzTCa4VtEGOZNBRuyFEoAdyGBZMglCJy+vJ56YIKuann
 YaIrYj5ciD8enV05MDKuWcFSTHMf3NUBFQuOJ274S6evDL41gVHhNM0LyVhZllidKBwC
 +Geg==
X-Gm-Message-State: AOAM531aDzs+4sJv1nAHmdZE3H17at72inzlHkl1MeM6NKpTnFV52dOp
 6ABujhCDLPC1L+UcePvY38ic2g==
X-Google-Smtp-Source: ABdhPJx0GNuuzjNB7ahnQqiG73+rs0tCtV7xxD5YuCivQQd6CQJJj5Ln6VGpFzV7oqg7gSFeCeG0fg==
X-Received: by 2002:adf:aac5:: with SMTP id i5mr8737472wrc.67.1637063264689;
 Tue, 16 Nov 2021 03:47:44 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id l8sm2260523wmc.40.2021.11.16.03.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 03:47:44 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 5/5] ASoC: qdsp6: q6routing: validate port id before setting
 up route
Date: Tue, 16 Nov 2021 11:47:21 +0000
Message-Id: <20211116114721.12517-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
References: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com
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

Validate port id before it starts sending commands to dsp this would
make error handling simpler.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 243b8179e59d..cd74681e811e 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -372,6 +372,12 @@ int q6routing_stream_open(int fedai_id, int perf_mode,
 	}
 
 	session = &routing_data->sessions[stream_id - 1];
+	if (session->port_id < 0) {
+		dev_err(routing_data->dev, "Routing not setup for MultiMedia%d Session\n",
+			session->fedai_id);
+		return -EINVAL;
+	}
+
 	pdata = &routing_data->port_data[session->port_id];
 
 	mutex_lock(&routing_data->lock);
-- 
2.21.0

