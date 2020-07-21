Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D6EC433E2
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:57:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F622073A
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lDFFP8Lk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RndzQRQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F622073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 618921676;
	Tue, 21 Jul 2020 18:56:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 618921676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595350619;
	bh=JSBlqvChngzlhhlA0eZ91rjOxiku5YrK8rEcbOzrso4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lDFFP8LkHTJNZOHzW6q91wuD+Jeo2Xc4S/CkS0gk5nKvbEhMHfBcFW1BspD/2Ff1G
	 8SbSlYGyWYn9Sn5phS31qzZJDjRR5qBEPhMbczUcA1HAF1kfvI68uXk6oMI7muaBk0
	 ofIMbuZjkNNnj+MC+xnj8a3pG65aswe4pqAb6K6s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA1FEF802E3;
	Tue, 21 Jul 2020 18:53:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94F9FF802DB; Tue, 21 Jul 2020 18:53:37 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41756F80087
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 18:53:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41756F80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="RndzQRQy"
Received: by mail-wr1-x441.google.com with SMTP id y3so4531063wrl.4
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D0KBLJSyHUDczll9CUzFZybPDYUhXLgXfcuwU2vCfU0=;
 b=RndzQRQyjYHb4zvkO44hxq5eAO6FQW9kx/uS7ttfQ40NAgTl+MUvGZ3C0jksTKPvuk
 MYs431lGl/W90YWtUVqoOmVnLNM5jjOIIDVLORVFC5T/cFkl7rorNxihKg9CZwMM9ba7
 DuRYunowy3/b9x7a6IYhCywKAX1VJ907bQOi57Z5Nsak0ee2WbFXNTG1NYMGT93mHaoN
 DBplYGdtYCrs0kOzk74PgLbaBdLYiGKHTQuSgFJyJ634pOYcpYL1uIF3BGgU7aoVRHwr
 /0iv1z60Gefi6hNqH7MtB+Cx/kCz8a0X34qf6KyFkH1wDEy7U9UrEP6659GkjC3HrRbR
 ddzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D0KBLJSyHUDczll9CUzFZybPDYUhXLgXfcuwU2vCfU0=;
 b=m79lEnLRenbOVuNXzUdEFI3zK08j5edE2gb7bk2ilepf57Fqm+TraowLSUq04rgJHB
 VVsHhZ0p/o1eMSbx6BqL3/ThiJ31ZzRTJ0pVgZllDsIOp6w2aKvxZrLgD7Sfw2iS8msd
 PgLGDc5wLZP9Ucae9dZ+PWQkGd10VE8R+5BAGLV76fwSEmdtmBB3Yke6cW994GUVfvWz
 710mwB/qivssbjQZZM6BfyfIWZA5uSXF4M9AI+3rIdo3RPRU9/BE7hgyLcZKW5+u95RV
 XeYx7M8ke0PD6w8yN+ntoDT+khUPSql4Ak0RFvBCU/5dBHuxP208v4fwd8pafex8vHyo
 P7pw==
X-Gm-Message-State: AOAM532r6cXV77o+uzRTwQ7gjdTmzGFStLsqHjWRRPAqdmweNYwvDMkc
 8O2ufoI+1ZSXqzrTG4IURnkHkg==
X-Google-Smtp-Source: ABdhPJwvV9uzLIZ74GTl/g1snxyu/7bH0n2O3i09nImUvb2cFpUvrRvDqEmgGWGpfCBCPCqMBUT9Rg==
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr27262664wrm.193.1595350406849; 
 Tue, 21 Jul 2020 09:53:26 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id c25sm4058648wml.18.2020.07.21.09.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 09:53:25 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 4/9] ASoC: q6asm: add length to write command token
Date: Tue, 21 Jul 2020 17:53:01 +0100
Message-Id: <20200721165306.29082-5-srinivas.kandagatla@linaro.org>
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

Add length to write command packet token so that we can track exactly
how many bytes are consumed by DSP in the command reply.

This is useful in some use-cases where the end of the file/stream
is not aligned with period size.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 4 +++-
 sound/soc/qcom/qdsp6/q6asm.c     | 7 ++++---
 sound/soc/qcom/qdsp6/q6asm.h     | 3 +++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index fb0488e7beb9..6b9ceac2ceb2 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -510,6 +510,7 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 	struct snd_compr_stream *substream = prtd->cstream;
 	unsigned long flags;
 	uint64_t avail;
+	uint32_t bytes_written;
 
 	switch (opcode) {
 	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
@@ -530,7 +531,8 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 	case ASM_CLIENT_EVENT_DATA_WRITE_DONE:
 		spin_lock_irqsave(&prtd->lock, flags);
 
-		prtd->copied_total += prtd->pcm_count;
+		bytes_written = token >> ASM_WRITE_TOKEN_LEN_SHIFT;
+		prtd->copied_total += bytes_written;
 		snd_compr_fragment_elapsed(substream);
 
 		if (prtd->state != Q6ASM_STREAM_RUNNING) {
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index d6728304ce6a..205453d1c1fc 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -670,6 +670,7 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 		if (ac->io_mode & ASM_SYNC_IO_MODE) {
 			phys_addr_t phys;
 			unsigned long flags;
+			int token = hdr->token & ASM_WRITE_TOKEN_MASK;
 
 			spin_lock_irqsave(&ac->lock, flags);
 
@@ -681,12 +682,12 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 				goto done;
 			}
 
-			phys = port->buf[hdr->token].phys;
+			phys = port->buf[token].phys;
 
 			if (lower_32_bits(phys) != result->opcode ||
 			    upper_32_bits(phys) != result->status) {
 				dev_err(ac->dev, "Expected addr %pa\n",
-					&port->buf[hdr->token].phys);
+					&port->buf[token].phys);
 				spin_unlock_irqrestore(&ac->lock, flags);
 				ret = -EINVAL;
 				goto done;
@@ -1535,7 +1536,7 @@ int q6asm_write_async(struct audio_client *ac, uint32_t stream_id, uint32_t len,
 	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, false, stream_id);
 
 	ab = &port->buf[port->dsp_buf];
-	pkt->hdr.token = port->dsp_buf;
+	pkt->hdr.token = port->dsp_buf | (len << ASM_WRITE_TOKEN_LEN_SHIFT);
 	pkt->hdr.opcode = ASM_DATA_CMD_WRITE_V2;
 	write->buf_addr_lsw = lower_32_bits(ab->phys);
 	write->buf_addr_msw = upper_32_bits(ab->phys);
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index ceece124dd3d..0379580f0742 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -20,6 +20,9 @@
 #define ASM_CLIENT_EVENT_CMD_RUN_DONE		0x1008
 #define ASM_CLIENT_EVENT_DATA_WRITE_DONE	0x1009
 #define ASM_CLIENT_EVENT_DATA_READ_DONE		0x100a
+#define ASM_WRITE_TOKEN_MASK			GENMASK(15, 0)
+#define ASM_WRITE_TOKEN_LEN_MASK		GENMASK(31, 16)
+#define ASM_WRITE_TOKEN_LEN_SHIFT		16
 
 enum {
 	LEGACY_PCM_MODE = 0,
-- 
2.21.0

