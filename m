Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3741DC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:59:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A2E207BB
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JELSEuwT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkPHg0Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A2E207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 341711612;
	Tue, 21 Jul 2020 18:58:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 341711612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595350763;
	bh=3seh+4fhRJPbZlKGKl1jkFGpAOxVQjP9zzH0LPjpTwk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JELSEuwTFhTnOyP/mWsfKTxP2hkCMX0jV4iDri3FEmDyhHuiwN7/2yKMCG6yukSHs
	 5/P8/w58Wuwq5ZL0PUwn2aaT7gt2a9abTEZoeGzH2q9fAaYL9wSkwB/odrE8rDBNRY
	 ABsSi5qEDa6/Tzqza3xiZPutvUq0aW9UFDrdZekM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04710F80304;
	Tue, 21 Jul 2020 18:53:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3DC7EF802E8; Tue, 21 Jul 2020 18:53:44 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 505F4F80290
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 18:53:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 505F4F80290
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="YkPHg0Mx"
Received: by mail-wm1-x333.google.com with SMTP id 22so3512629wmg.1
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NwtppsTcVvcZ5TZNh7CjWprzGgIi6+BwsTgR08pkjwY=;
 b=YkPHg0MxyTyKTlPpIXza+hR1qRXWrYvubKsDsrdNbwnZxNPihEQmkgXkuKD1Cn2PXO
 qDrEcklBJjkleM0dZOqAW1tHoiDjabYteyDFDBJwOxGswvVfvwcgkRjp58XKxawf0EFP
 H018noIhx9M2ntKeM1XWTYeTfb7FIvwbirUuvjpXGOs6h0oTmchpNK9LsP+WvVlN7jkE
 nvPDIflTK70gxnTrKR8U4POBc1mmwVUkkvNVXDCsFvHY3NIjkEiLdM0+0YUKUgp7Ons/
 LiEMiij97V2m5Uu0K6AWuLxBvWud58YHphre0bWgHLqzx6TJlYqffgvHGU1ekQaXWgbo
 4f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NwtppsTcVvcZ5TZNh7CjWprzGgIi6+BwsTgR08pkjwY=;
 b=VKrVwxvoyE8BtUpj4VOjvPS+9dZo60AqSLh81bWXFq5KFUBsGO+5lk/kjaa+1ZWKHz
 jttAzZvQJZL6NfeqIQDzyO6qQkDtVjqfGYuA7rh/MFvqv1/wWbwzSXZM0Bw/jwfO268U
 JZ+RRMwIGN3fh9QGl9ZfB+aImLtu0cfX1vhH1VTCiYX6+34vWPtoHJ5xkvIS0MTr/qda
 Uhs2/Eu7a8+nbBvaZxM+2vRkSL/owWvfmY3vy7CnQDJyTRl3GeoVa0EXCPNHr8ZWNyTo
 Fvk92GaTl/UTBM3z7zxaHwUAhkG9uVX4o8Y+XbmVrYFmSW/5EUAsDfkJRVyknNyBN352
 1GkQ==
X-Gm-Message-State: AOAM533A/xwLunDw9gmNoNekJo8bNA3bAcfLiWcuDBnMI82cwifZ241H
 lxKW8hn1W6JtTMElGPlRYvmfNw==
X-Google-Smtp-Source: ABdhPJz06SmuoOdh4tYpRVa5G9rtDS6HPN94BzXs9IQnMA84PpQ2veD0gjkBTx+kuHRfcHY4/U/BhA==
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr4849059wmz.124.1595350410173; 
 Tue, 21 Jul 2020 09:53:30 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id c25sm4058648wml.18.2020.07.21.09.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 09:53:29 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 6/9] ASoC: q6asm: add support to gapless flag in q6asm open
Date: Tue, 21 Jul 2020 17:53:03 +0100
Message-Id: <20200721165306.29082-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
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

This patch adds support to gapless flag to q6asm_open_write().

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 4 ++--
 sound/soc/qcom/qdsp6/q6asm.c     | 4 +++-
 sound/soc/qcom/qdsp6/q6asm.h     | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 6b9ceac2ceb2..a493350c8cc2 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -259,7 +259,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
 				       FORMAT_LINEAR_PCM,
-				       0, prtd->bits_per_sample);
+				       0, prtd->bits_per_sample, false);
 	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		ret = q6asm_open_read(prtd->audio_client, prtd->stream_id,
 				      FORMAT_LINEAR_PCM,
@@ -686,7 +686,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 	if (dir == SND_COMPRESS_PLAYBACK) {
 		ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
 				       params->codec.id, params->codec.profile,
-				       prtd->bits_per_sample);
+				       prtd->bits_per_sample, true);
 
 		if (ret < 0) {
 			dev_err(dev, "q6asm_open_write failed\n");
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 14ec7dad5b65..22ac99029e56 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -923,7 +923,7 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
  */
 int q6asm_open_write(struct audio_client *ac, uint32_t stream_id,
 		     uint32_t format, u32 codec_profile,
-		     uint16_t bits_per_sample)
+		     uint16_t bits_per_sample, bool is_gapless)
 {
 	struct asm_stream_cmd_open_write_v3 *open;
 	struct apr_pkt *pkt;
@@ -943,6 +943,8 @@ int q6asm_open_write(struct audio_client *ac, uint32_t stream_id,
 	pkt->hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
 	open->mode_flags = 0x00;
 	open->mode_flags |= ASM_LEGACY_STREAM_SESSION;
+	if (is_gapless)
+		open->mode_flags |= BIT(ASM_SHIFT_GAPLESS_MODE_FLAG);
 
 	/* source endpoint : matrix */
 	open->sink_endpointype = ASM_END_POINT_DEVICE_MATRIX;
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index e315f7ff5e54..69513ac1fa55 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -100,7 +100,7 @@ int q6asm_write_async(struct audio_client *ac, uint32_t stream_id, uint32_t len,
 		      uint32_t msw_ts, uint32_t lsw_ts, uint32_t flags);
 int q6asm_open_write(struct audio_client *ac, uint32_t stream_id,
 		     uint32_t format, u32 codec_profile,
-		     uint16_t bits_per_sample);
+		     uint16_t bits_per_sample, bool is_gapless);
 
 int q6asm_open_read(struct audio_client *ac, uint32_t stream_id,
 		    uint32_t format, uint16_t bits_per_sample);
-- 
2.21.0

