Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11C2C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:28:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A42E2065F
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mbWscdUz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1XcyxDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A42E2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE55E1670;
	Tue,  7 Jul 2020 12:27:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE55E1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594117688;
	bh=gH+7b8pc8fTbQo4a4WaVQHnRVG2QJ13h76m+aIGA31E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mbWscdUzP+izbZlnO65+ADIVuODnvRu0Kr5pkbK0oar6ZZnoPxgIPdSeR+DxcAPmi
	 7KH5OWjvwTxkcnkqi74cHRDeKdD3GvRRYsR5EuCPEKUzdiDloyLld6eX3fuWlJ6DBh
	 MA4cZmcL1vKg9iwF4fMCZmwt6p9c3FPge686xp6Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65F27F80363;
	Tue,  7 Jul 2020 12:17:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08211F80335; Tue,  7 Jul 2020 12:17:27 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C578F802F8
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 12:17:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C578F802F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="J1XcyxDn"
Received: by mail-wm1-x342.google.com with SMTP id l17so42691100wmj.0
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tfKAHOC4Bqa/g3TTN2zyTgayqsyKLptRGMeCLeLAzGA=;
 b=J1XcyxDnRmpZz0W4IPrMVJKymtJ07od5/Ui2uKeAXQgpc0qotceonG0/oloTEdbH7s
 h9+dfh0LSbVUcJW+pc/XyHocqcTsyqzJb8LmBvxq6MpxjTnaT9VZNdirDOfgB5bWoWDq
 niIIONlBk6sA9+rBm5/Zf0rtNPutp2de6yaHctV6VNL88YoptrE7bzN9P2c95z9yX8TU
 WwB1XVGi9t17KxFLcrnyiAgHFMMynYQSuE2RBzJTnvTVRfnVq3tEgvIXuDERBUvrzOkJ
 JpljX451HY8DEy3VySwa2mAmhxKDg2TS61UqmnWH5Dn1LD8i/9kIhADrwvWC7PFYhZae
 S8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tfKAHOC4Bqa/g3TTN2zyTgayqsyKLptRGMeCLeLAzGA=;
 b=IWkmE3MuylJrijelrrQMIRVcWa0hS9iNb0la0sWegmI9irJadGGPYo0MJ8e1KHc0LT
 d8zBQwr6bzgi9DinK4BeuPlRQLjy60NZrR9htkYrFEY5NjUPtc+Ym/t0fLid5p6tvboA
 5Vky8EsmFaQ+ubuQ8KtnxcO1GqRQ3GKTNhgkUb667fQ1yU6O4BysJnE9ENurzE9qQLhk
 aQdwX7vTwDP+4VUlPRYTzSiO/2jJkcKle/GMjkfk0X4VF4ZoE27wnl7NUdfJ9eEawz1w
 Bet+QccB5wMquBpmzEmdVIUQfqzoOuErKwmn73yPAlLyvDEckv5T35ZoxdTjTlvwe5M0
 XALQ==
X-Gm-Message-State: AOAM533l5PQUSbZS86VRLbfKbfw0lsEXquEOSNa2MUpbmsPMq/ddMXRC
 v7MX7kF/jJF9OMKu3HRr65BJtw==
X-Google-Smtp-Source: ABdhPJzZOEjZmejJdYRsgb4UUUE3sZTs8G1LEoJTOp7Viz61ZnkIYUsK9D/hnCyJv8g4p3iI/k5fcQ==
X-Received: by 2002:a05:600c:2249:: with SMTP id
 a9mr3274840wmm.163.1594117024429; 
 Tue, 07 Jul 2020 03:17:04 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 03:17:03 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH 13/28] ASoC: qcom: qdsp6: q6asm: Provide documentation for WMA
 'codec_profile'
Date: Tue,  7 Jul 2020 11:16:27 +0100
Message-Id: <20200707101642.1747944-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
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

Fixes the following W=1 kernel build warning(s):

 sound/soc/qcom/qdsp6/q6asm.c:924: warning: Function parameter or member 'codec_profile' not described in 'q6asm_open_write'

Cc: Patrick Lai <plai@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index ae4b2cabdf2d6..58720b18fc8c8 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -915,6 +915,7 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
  *
  * @ac: audio client pointer
  * @format: audio sample format
+ * @codec_profile: profile to use when WMA
  * @bits_per_sample: bits per sample
  *
  * Return: Will be an negative value on error or zero on success
-- 
2.25.1

