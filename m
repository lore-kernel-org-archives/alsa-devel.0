Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DC6C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:44:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927BE206D7
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DGivTj75";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZE1QZI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927BE206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BBE6168D;
	Mon, 27 Jul 2020 11:43:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BBE6168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595843052;
	bh=MTLLUd32NECJx91aflyQLc47HKgHUluG/g4E7uouLVE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DGivTj75+R7QZyhZUJjTvp9cqnCwRpXLaN1LyOyvWkZGPl33ZLIqStNMlXqklxm28
	 JLwrqNTKkPLz7osYZE2PoIUa3WsC6290mjooC+GASx/OiEi3FshghdFR/8y33EtK+8
	 MbAPmqckwoIjj6DJQz6Q/Jjnfw3m3jzsNEYi+hvA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8F0BF80304;
	Mon, 27 Jul 2020 11:38:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32A2FF802E7; Mon, 27 Jul 2020 11:38:34 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9842CF801D9
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 11:38:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9842CF801D9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ZZE1QZI9"
Received: by mail-wr1-x442.google.com with SMTP id a14so14177360wra.5
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xZFlP2hftW/OVEfLVzTfnKdTkSZtyEnkGEH1R6ufs8I=;
 b=ZZE1QZI99xBLfbuCo9jH5jJHtr6OG63gQKMJQyq//NnYbb1/3yPOseqwhr9mQxPm5U
 ue2F04iceQpIHIWfBuy3Rh3+onBqRbDhO6ViFq8wxn2fLTvP8KX/bdbiH57DG58JZwbP
 llutMB5lv0mc02o5j8YqiwFerDMJpDn457gecbXgk9MtjSUO/HiwspVzfW3fvTJyiVzL
 eADN0rGUHys0/hJhqjSWyxsB4sXAZ6X4RQM2AcxcWY2GEv/fI/9KrXwnPFeD6l0AeSiU
 sVWWZu7vAEo6jqtSWKE2fL4KAVw3Du+2HwTbZm+klSEMPvXKTtz3TDnleEgAJcyvlksn
 CaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xZFlP2hftW/OVEfLVzTfnKdTkSZtyEnkGEH1R6ufs8I=;
 b=I10Dm8ewzNJ305sdf3x0jlfe8weD8mp/mpDNztfLQN4qMZaKJb/B1rx+zLnm+Vc444
 EMcWixn5wRYkGLQH/e4h9GGzbXsyX1UMaj327Dz4IGmBxIedNxmzLLhr10hO9K/Uxbku
 LGuM/UeiQMr7l3pxpMCYPYv3Jpy3Fglw0PdnrJWgs9xHdTHX7Wqf9Y7WmUPE6L8QEa4M
 AMO98KdEj2+KesXhwjjw02FoOdOe2py0NPFcjM1X3bpQE0mpvV/W4ZlxNAJz3R6rlPRa
 cwtNFJCcgpu+3ueeS3hVPa3fu5wVkvnhr2sIXAaZb2yv6sn7IKLt4vterJCsedq2NT+7
 Npjg==
X-Gm-Message-State: AOAM532X9MhEtehAcKSk3oMgtNIuPfjQQvUjgFx2KCQG68nWUp8IKwmZ
 EYd98W3+izR6t0aZ9dAUuEZbKg==
X-Google-Smtp-Source: ABdhPJwdYJ0QYsLGadsdE2PzGJ+Pm2WGAupMBwzneDIJXFuCcXa1HslNogSVyOAUXTLBa35lLm1gvA==
X-Received: by 2002:adf:ab05:: with SMTP id q5mr461098wrc.46.1595842699989;
 Mon, 27 Jul 2020 02:38:19 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id y189sm20566099wmd.27.2020.07.27.02.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 02:38:19 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v3 05/10] ASoC: q6asm: add support to remove intial and
 trailing silence
Date: Mon, 27 Jul 2020 10:38:01 +0100
Message-Id: <20200727093806.17089-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 ckeepax@opensource.cirrus.com, tiwai@suse.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, vkoul@kernel.org,
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

This patch adds support to ASM_DATA_CMD_REMOVE_INITIAL_SILENCE
and ASM_DATA_CMD_REMOVE_TRAILING_SILENCE q6asm command to support
compressed metadata for gapless playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 53 ++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h |  6 ++++
 2 files changed, 59 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 205453d1c1fc..14ec7dad5b65 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -51,6 +51,8 @@
 #define ASM_STREAM_CMD_OPEN_READWRITE_V2        0x00010D8D
 #define ASM_MEDIA_FMT_ALAC			0x00012f31
 #define ASM_MEDIA_FMT_APE			0x00012f32
+#define ASM_DATA_CMD_REMOVE_INITIAL_SILENCE	0x00010D67
+#define ASM_DATA_CMD_REMOVE_TRAILING_SILENCE	0x00010D68
 
 
 #define ASM_LEGACY_STREAM_SESSION	0
@@ -639,6 +641,8 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 		case ASM_STREAM_CMD_OPEN_READWRITE_V2:
 		case ASM_STREAM_CMD_SET_ENCDEC_PARAM:
 		case ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2:
+		case ASM_DATA_CMD_REMOVE_INITIAL_SILENCE:
+		case ASM_DATA_CMD_REMOVE_TRAILING_SILENCE:
 			if (result->status != 0) {
 				dev_err(ac->dev,
 					"cmd = 0x%x returned error = 0x%x\n",
@@ -1324,6 +1328,55 @@ int q6asm_stream_media_format_block_ape(struct audio_client *ac,
 }
 EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_ape);
 
+static int q6asm_stream_remove_silence(struct audio_client *ac, uint32_t stream_id,
+				       uint32_t cmd,
+				       uint32_t num_samples)
+{
+	uint32_t *samples;
+	struct apr_pkt *pkt;
+	void *p;
+	int rc, pkt_size;
+
+	pkt_size = APR_HDR_SIZE + sizeof(uint32_t);
+	p = kzalloc(pkt_size, GFP_ATOMIC);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	samples = p + APR_HDR_SIZE;
+
+	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, true, stream_id);
+
+	pkt->hdr.opcode = cmd;
+	*samples = num_samples;
+	rc = apr_send_pkt(ac->adev, pkt);
+	if (rc == pkt_size)
+		rc = 0;
+
+	kfree(pkt);
+
+	return rc;
+}
+
+int q6asm_stream_remove_initial_silence(struct audio_client *ac,
+					uint32_t stream_id,
+					uint32_t initial_samples)
+{
+	return q6asm_stream_remove_silence(ac, stream_id,
+					   ASM_DATA_CMD_REMOVE_INITIAL_SILENCE,
+					   initial_samples);
+}
+EXPORT_SYMBOL_GPL(q6asm_stream_remove_initial_silence);
+
+int q6asm_stream_remove_trailing_silence(struct audio_client *ac, uint32_t stream_id,
+					 uint32_t trailing_samples)
+{
+	return q6asm_stream_remove_silence(ac, stream_id,
+				   ASM_DATA_CMD_REMOVE_TRAILING_SILENCE,
+				   trailing_samples);
+}
+EXPORT_SYMBOL_GPL(q6asm_stream_remove_trailing_silence);
+
 /**
  * q6asm_enc_cfg_blk_pcm_format_support() - setup pcm configuration for capture
  *
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index 312a0452dcdf..2acfc2274069 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -134,6 +134,12 @@ int q6asm_run(struct audio_client *ac, uint32_t stream_id, uint32_t flags,
 	      uint32_t msw_ts, uint32_t lsw_ts);
 int q6asm_run_nowait(struct audio_client *ac, uint32_t stream_id,
 		     uint32_t flags, uint32_t msw_ts, uint32_t lsw_ts);
+int q6asm_stream_remove_initial_silence(struct audio_client *ac,
+					uint32_t stream_id,
+					uint32_t initial_samples);
+int q6asm_stream_remove_trailing_silence(struct audio_client *ac,
+					 uint32_t stream_id,
+					 uint32_t trailing_samples);
 int q6asm_cmd(struct audio_client *ac, uint32_t stream_id,  int cmd);
 int q6asm_cmd_nowait(struct audio_client *ac, uint32_t stream_id,  int cmd);
 int q6asm_get_session_id(struct audio_client *ac);
-- 
2.21.0

