Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2622EC433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 10:15:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFDC61421
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 10:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFDC61421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D51716AC;
	Mon, 10 May 2021 12:14:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D51716AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620641721;
	bh=UuNjd4Aun0I5ZwLHTfi60btQs4j2cHqaqe4SHIvqrGM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CswcW2FSbNVxtyAYVZoRgfV8iATInfwzIvZW6NdclzpptdJ3hP6B2Ocv9LmrYwSCD
	 GExPJRxNCkb5dj+L6L+wOGsZPCH4IqazedCeTuEd0mMdY3/hac+8SYlPr6gEIfsANW
	 mY9hO+NjbaxckHMXliF0mbcQlDSmwDGwF7UclcpE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5F86F8026F;
	Mon, 10 May 2021 12:13:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25334F804B4; Mon, 10 May 2021 12:13:19 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C4AEF80272
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 12:12:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C4AEF80272
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Ia2f0k5b"
Received: by mail-wr1-x42e.google.com with SMTP id s8so15998615wrw.10
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 03:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1RUP68I3HwNhuXkqx8NfMcQ+Gf4uaCrCeHBt2iSVUE0=;
 b=Ia2f0k5b0Vf6TsMPCzwMZHwwp+JOEI/DGNgUINsuRemHW0a0PU3R4PaTCjICwWAnju
 VJs2s5jBI0XyJrHwF4lho8YSz5CTYRWNGWd5wJHqr+zExfcmUJuhG6/F2fnu5zf2jWQ7
 jLXD1tG6UVVopdAXa325epwi9P5F7ZEp3MpWIxvOEsrWYYRFnZmiCrkUWf9gp9RQNBaV
 MLi9hlvIgh42uZGNXnM414RW+twhQf2bNzsT6dFCcLQN0LoqgG3RcXQUUXIJDHsfGt0H
 X7trKfRGlnF9bRtJIaPlnqrCT1hMUPyF6vhnk2+wjeO50ZF2HhaxtrhRybCxZv4O1bAN
 /QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1RUP68I3HwNhuXkqx8NfMcQ+Gf4uaCrCeHBt2iSVUE0=;
 b=H9WeEl3tpv8s7AQgOcq26WqAgMHyf3fnytwJcrGd3GuSgZWuwz7MJ4pEL2etOqRn9r
 QM0U8FKX8fRwbtItC18CuaIl2JYxkDSYMmsHtDRY0Zw0rH3BerjydJryO166VUB9BEBN
 1zXb1xB4FF76leYrVFlnLJ23z7pIKulg/g0kDZIQkX+KJVFvjdbvALjeXIUZV1Y9a8yu
 R+r5M27cRb7/UlrOpC90w4MxFD7SQBlpIvgroX5/qgqtho3rWERaHGKjbdBaXFWQ4cKg
 wS+nPAm6T6JBVe3IJVLJPMxehS9d08AZNT0agMnxhh2exlokFHwB91iYf3te8nk0I9Uc
 ZkXw==
X-Gm-Message-State: AOAM532IR6WxhmwtAshEz6aspVP8w+3brP2DVFshaDYtZ6j0Jf5Bibdk
 i58e9RtZ9EHKNSldruMx+yDQBQ==
X-Google-Smtp-Source: ABdhPJy1zZnboxYwU59hy7FUd2GyKCZNULHvX4RQWWp+fstvZEyAyCkHKdPtDLe5i77CJgMopibHDA==
X-Received: by 2002:adf:d1c6:: with SMTP id b6mr26190938wrd.110.1620641537371; 
 Mon, 10 May 2021 03:12:17 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id b7sm22072109wri.83.2021.05.10.03.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 03:12:16 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 4/4] ASoC: qcom: sdm845: add jack support for WCD934x
Date: Mon, 10 May 2021 11:12:01 +0100
Message-Id: <20210510101201.7281-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210510101201.7281-1-srinivas.kandagatla@linaro.org>
References: <20210510101201.7281-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org
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

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sdm845.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 153e9b2de0b5..0adfc5708949 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -288,6 +288,14 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 			snd_soc_dai_set_sysclk(codec_dai, 0,
 					       WCD934X_DEFAULT_MCLK_RATE,
 					       SNDRV_PCM_STREAM_PLAYBACK);
+
+			rval = snd_soc_component_set_jack(codec_dai->component,
+							  &pdata->jack, NULL);
+			if (rval != 0 && rval != -ENOTSUPP) {
+				dev_warn(card->dev, "Failed to set jack: %d\n", rval);
+				return rval;
+			}
+
 		}
 		break;
 	default:
-- 
2.21.0

