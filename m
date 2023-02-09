Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42BFC05027
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Feb 2023 12:31:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9340A4F;
	Thu,  9 Feb 2023 13:30:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9340A4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675945867;
	bh=v6Ei/DGd8STPCLpkspoLjewoCE/cAzIfR+wVaXXJDnM=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=O2ZpHO8F48OynfFstqC7qLzAtttDj0RHe5Ncw7HO+lG6wMMRQIBsJLi/q0gVNRAH+
	 R4Csx63P3MM7rGJzWdyx5xCS0CMBVpi2tAPDyHWPt42/QZqulQl0VTj4xuZrCP2pnh
	 ApF1FNl92EL6W7NccgfFsBGJP45zM3yc3SlhQn0s=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03E25F8051F;
	Thu,  9 Feb 2023 13:29:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59759F80534; Thu,  9 Feb 2023 13:28:43 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 376D2F800E4
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2023 13:28:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 376D2F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Ijtf7zQN
Received: by mail-wm1-x32d.google.com with SMTP id
 j32-20020a05600c1c2000b003dc4fd6e61dso3737218wms.5
        for <alsa-devel@alsa-project.org>;
 Thu, 09 Feb 2023 04:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3ujPUkgM6w68JhuQ2OFyntLPvFx3aPpntFnJGR14xI=;
        b=Ijtf7zQNxQutfacxe7HkX1oZwBtdY0P9UgLSO8dhkP1U65kpJZJY7R1MMUyp6Ct4cD
         GLrKvMf4G8iPDCfLMR3KxkIlon3eS1Xk3zCwH/xrQT4V7rasfXSqO1W9FkT8JEwYG5nd
         vP7HU4m5aPIf3u7g0VK2aJyRsrCAVSO4I+7yaTvQlY0tkYTo78Ug18ERnMuYx1t6mXeu
         oZSmmi80y0kP5uJ/f6Ek8Y6oJvaacva8e/X8jBsI6J64GMqPq05H2DDCLPvWcgtqAy3k
         aFstUecHk+zX1c8eISshFvZUTetRV1WcNNIufuMsAsWp1bBovtK8eJZpyD4YQlqFQtJO
         IJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3ujPUkgM6w68JhuQ2OFyntLPvFx3aPpntFnJGR14xI=;
        b=N3rdfkN6paWAzAABEs6mPYlNnyw67etesfofeByh71IRfmfRFSpQuB8Z11Y9buhdFV
         jdbmNKK+LVhrykEG/9my42Wm74EeBTwIghknv45xCWKV/Zugwn11GL9+kXPEXiuSo420
         813+XYrBtVGkFgpEYalkJ1V09zGL0JIjcdoIyzYo7tWHqYMpxHkj1K6sIAnbjp/WEOy/
         M983BRzi59xTrCJRbISUjYUMnxAhcbEbPn8sVJ2xtT23i3Hdx/nbXIPFhmCeKX5x9KXr
         bozIg+nfjOtuAwhtG74rZYqiQ+/ArgzoFXZ7Zb89pRgHGxCfHI83WdRe5+2T6j94V1iW
         jSeQ==
X-Gm-Message-State: AO0yUKUV9IrpMsV30fvqk2irCW/ZKw1RdFrNNi68IrscSIIpdj83LNVM
	oZBnxoKF165Sc3S062SGpV6i0c2Qw2YwDpYH
X-Google-Smtp-Source: 
 AK7set9AiscBQz9AMthG4OOWx2uMKBCI8kOz4peYLZo64rXsBho4JKZR0is3unV5v8eYp3JKFk2CzA==
X-Received: by 2002:a05:600c:511e:b0:3df:9858:c038 with SMTP id
 o30-20020a05600c511e00b003df9858c038mr5876254wms.13.1675945700377;
        Thu, 09 Feb 2023 04:28:20 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 o8-20020a5d58c8000000b002c3f0a4ce98sm1134763wrf.98.2023.02.09.04.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 04:28:19 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 4/8] ASoC: qcom: audioreach: fix ADSP ready check
Date: Thu,  9 Feb 2023 12:28:02 +0000
Message-Id: <20230209122806.18923-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
References: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MG5BY5UYZ6HED44RRIFB4ELVTDPIVKHM
X-Message-ID-Hash: MG5BY5UYZ6HED44RRIFB4ELVTDPIVKHM
X-MailFrom: srinivas.kandagatla@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: lgirdwood@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, steev@kali.org, johan+linaro@kernel.org,
 quic_bjorande@quicinc.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MG5BY5UYZ6HED44RRIFB4ELVTDPIVKHM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

currently q6apm_is_adsp_ready() will only return the cached value of
previous result. If we are unlucky and previous result is not-ready
then the caller will always get not-ready flag.

This is not correct, we should query the dsp of its current state in
irrespective of previous reported state.

Fixes: 47bc8cf60e92 ("ASoC: qdsp6: audioreach: Add ADSP ready check")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 8a7dfd27d3c5..994c9e823a88 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -145,14 +145,6 @@ static void q6apm_put_audioreach_graph(struct kref *ref)
 	kfree(graph);
 }
 
-bool q6apm_is_adsp_ready(void)
-{
-	if (g_apm && g_apm->state)
-		return true;
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(q6apm_is_adsp_ready);
 
 static int q6apm_get_apm_state(struct q6apm *apm)
 {
@@ -169,6 +161,15 @@ static int q6apm_get_apm_state(struct q6apm *apm)
 	return apm->state;
 }
 
+bool q6apm_is_adsp_ready(void)
+{
+	if (g_apm)
+		return q6apm_get_apm_state(g_apm);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(q6apm_is_adsp_ready);
+
 static struct audioreach_module *__q6apm_find_module_by_mid(struct q6apm *apm,
 						    struct audioreach_graph_info *info,
 						    uint32_t mid)
-- 
2.21.0

