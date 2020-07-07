Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33A4C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:43:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2402064C
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Lrf/Km8B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjrxz6Uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2402064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01AD642;
	Tue,  7 Jul 2020 18:42:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01AD642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594140181;
	bh=wwZ1+Af5AzoawhR5pfe91dBZlzvQXaefJTGclnC3v6U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lrf/Km8BwvDAnGFO4ksxVmAGhKdr1xcJEbhE6D2K7fzZYmR9DT/Hou/KOrATl1MWU
	 AX5xDsmOohUS1wGVQvRi2L9qAe2h8go3KCLF0svzZtsYhDRfmuT+irJNmMK3EtjBOG
	 Tdw+H1TDuMQnsSL/SkReJeYhqL/kJoC5Gzv0ltg4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FD06F80308;
	Tue,  7 Jul 2020 18:37:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 505B7F802E3; Tue,  7 Jul 2020 18:37:20 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E494F80274
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 18:37:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E494F80274
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="xjrxz6Uk"
Received: by mail-wm1-x343.google.com with SMTP id j18so43980466wmi.3
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mXSLR7iMnpm45taqbFAGKqh/zslkXOWYUH4mPXBbrmE=;
 b=xjrxz6Uk2oTPsp6LJHb0UktwlKqpwA6oFl732jwtKfnQe7iRFeOtBlMeMQnisK6dzj
 NAMySLMsz5bWIw+adQAUosrYGdtjHw0g2H9RcboNEe0cNP/265BIw72THqoQEInuD4lH
 G0SBrwZpXNANRIZkz6peQo4gwEFi/ecCeDIPuqfjlxu5pQ8f6ZMzovuGPeuuUVsl9eWA
 RWiFTXiAAtFvJQJ679aqIw6jdvkftUljGXraEqfO3PuCUtsOdw/G8ol+XWmT285GXt/N
 p/ugv17CeLSOqHMVP1Vbbph2p6C7RzZ23GPBpGnf/+gUWjaxy23DFLJ4EdnnfTb7ncQz
 dkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mXSLR7iMnpm45taqbFAGKqh/zslkXOWYUH4mPXBbrmE=;
 b=BWUdMqQYkwgefgvRgGoYlBKm+P2/9oeETTMk/OMX8Qn2tE/k9LC/338EldNxkfj+1e
 9Pe29b5FHp4gkot01pMJb3SBuZ/w85lQqyP+L7OeT9lBX9fr1ZcMHfSs04X+x/+nKvP/
 YLF3jT+7996e9sIfC+GgLSbbRWPChSrwRJ9zhtuHcH5ZH5SQtl26OGsrneHFXDCmxt9h
 sMWblOuVc65lmjVk1JLyLcC4bqTQ7sirjt2qvWOl4kNFA+qwQacbM8I2AlnubVOm/FU+
 mBX7bYpG/26q+xujfKWSSA7MRbzQ27KUrF9JFhqCjDnPbrCEeBlvgbUXyQax9an9l/ze
 2/lA==
X-Gm-Message-State: AOAM531SRiMRUQsH5ft7ba6Y+r75PWPgPcb41/Z18lJKhYw/GFlMxkFr
 HDp0R62pvldKjwtFdEUGJzlNXQ==
X-Google-Smtp-Source: ABdhPJzbGGjMFukQ72dWUXtYlcMgBGenzO2ViNFSXsTUM2cUiDwQIOAtRPmdkAA17cOf/qT9z7OZeQ==
X-Received: by 2002:a05:600c:414f:: with SMTP id
 h15mr5429140wmm.82.1594139821236; 
 Tue, 07 Jul 2020 09:37:01 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id p14sm1925874wrj.14.2020.07.07.09.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 09:37:00 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 09/11] ASoC: qdsp6: use dev_err instead of pr_err
Date: Tue,  7 Jul 2020 17:36:39 +0100
Message-Id: <20200707163641.17113-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, tiwai@suse.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org,
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

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index c0e1e84267bf..c4b4684b7824 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -222,6 +222,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
 	struct q6asm_dai_data *pdata;
+	struct device *dev = component->dev;
 	int ret, i;
 
 	pdata = snd_soc_component_get_drvdata(component);
@@ -229,7 +230,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 		return -EINVAL;
 
 	if (!prtd || !prtd->audio_client) {
-		pr_err("%s: private data null or audio client freed\n",
+		dev_err(dev, "%s: private data null or audio client freed\n",
 			__func__);
 		return -EINVAL;
 	}
@@ -252,7 +253,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 				       prtd->periods);
 
 	if (ret < 0) {
-		pr_err("Audio Start: Buffer Allocation failed rc = %d\n",
+		dev_err(dev, "Audio Start: Buffer Allocation failed rc = %d\n",
 							ret);
 		return -ENOMEM;
 	}
@@ -268,7 +269,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	}
 
 	if (ret < 0) {
-		pr_err("%s: q6asm_open_write failed\n", __func__);
+		dev_err(dev, "%s: q6asm_open_write failed\n", __func__);
 		q6asm_audio_client_free(prtd->audio_client);
 		prtd->audio_client = NULL;
 		return -ENOMEM;
@@ -278,7 +279,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	ret = q6routing_stream_open(soc_prtd->dai_link->id, LEGACY_PCM_MODE,
 			      prtd->session_id, substream->stream);
 	if (ret) {
-		pr_err("%s: stream reg failed ret:%d\n", __func__, ret);
+		dev_err(dev, "%s: stream reg failed ret:%d\n", __func__, ret);
 		return ret;
 	}
 
@@ -300,7 +301,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 
 	}
 	if (ret < 0)
-		pr_info("%s: CMD Format block failed\n", __func__);
+		dev_info(dev, "%s: CMD Format block failed\n", __func__);
 
 	prtd->state = Q6ASM_STREAM_RUNNING;
 
@@ -355,7 +356,7 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 
 	pdata = snd_soc_component_get_drvdata(component);
 	if (!pdata) {
-		pr_err("Drv data not found ..\n");
+		dev_err(dev, "Drv data not found ..\n");
 		return -EINVAL;
 	}
 
@@ -368,7 +369,7 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 				(q6asm_cb)event_handler, prtd, stream_id,
 				LEGACY_PCM_MODE);
 	if (IS_ERR(prtd->audio_client)) {
-		pr_info("%s: Could not allocate memory\n", __func__);
+		dev_info(dev, "%s: Could not allocate memory\n", __func__);
 		ret = PTR_ERR(prtd->audio_client);
 		kfree(prtd);
 		return ret;
@@ -386,12 +387,12 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 				SNDRV_PCM_HW_PARAM_RATE,
 				&constraints_sample_rates);
 	if (ret < 0)
-		pr_info("snd_pcm_hw_constraint_list failed\n");
+		dev_info(dev, "snd_pcm_hw_constraint_list failed\n");
 	/* Ensure that buffer size is a multiple of period size */
 	ret = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0)
-		pr_info("snd_pcm_hw_constraint_integer failed\n");
+		dev_info(dev, "snd_pcm_hw_constraint_integer failed\n");
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		ret = snd_pcm_hw_constraint_minmax(runtime,
@@ -399,21 +400,21 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 			PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE,
 			PLAYBACK_MAX_NUM_PERIODS * PLAYBACK_MAX_PERIOD_SIZE);
 		if (ret < 0) {
-			pr_err("constraint for buffer bytes min max ret = %d\n",
-									ret);
+			dev_err(dev, "constraint for buffer bytes min max ret = %d\n",
+				ret);
 		}
 	}
 
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
 		SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
 	if (ret < 0) {
-		pr_err("constraint for period bytes step ret = %d\n",
+		dev_err(dev, "constraint for period bytes step ret = %d\n",
 								ret);
 	}
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
 		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
 	if (ret < 0) {
-		pr_err("constraint for buffer bytes step ret = %d\n",
+		dev_err(dev, "constraint for buffer bytes step ret = %d\n",
 								ret);
 	}
 
-- 
2.21.0

