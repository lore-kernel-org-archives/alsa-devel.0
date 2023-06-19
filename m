Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63618EB64DA
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jun 2023 10:18:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5842C847;
	Mon, 19 Jun 2023 12:18:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5842C847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687169934;
	bh=M5axpCjK33Fn3CcfUaLMnRUeOfa39HCLUL3Umj+/2mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pytEUp5EI5LwOB25hzV5P3pFe54j2oeC+LYilFns6EVb4MMOWr/YE+gAoMni8vI5y
	 k8VXuTlaRIiIAPX380PvCasbhP8TtsvRaX0UQl55CzquogUg04hKvwvBZxyhUwSN9z
	 EtlyRtcC4EiMlYvPlTToHOF4UpmPZhjItNQ3AJl8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC0E8F8057C; Mon, 19 Jun 2023 12:17:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D8FB8F8057A;
	Mon, 19 Jun 2023 12:17:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4DCC3F8052D; Mon, 19 Jun 2023 12:17:05 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 68EB5F80301
	for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2023 12:17:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68EB5F80301
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AzTtw+9+
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31122c346f4so3660216f8f.3
        for <alsa-devel@alsa-project.org>;
 Mon, 19 Jun 2023 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687169820; x=1689761820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CabZ5vNQt3fVXdlNPDIEC+PWoUnQG/H1hmXckZrPM8=;
        b=AzTtw+9+OUva2zMO/PcC0xBcgizEGMiUVI50VujU1VYB05v5Dzq4eRlkcJ2dIYv2k+
         /1/lMRyuYR/k90XvAXTO/D3k25ZQpKbI5hn7FCRBak847FNQKM935eES7MRVL2xT79lx
         2sFr3cLMDPGm6h2cWg+NVwKTD6xhxK22ri2OzYlG0xMvaWtpkV70IqmMY0gXzkoGfWTH
         X9JkKTxDwEcuicg5w8bv4yQQ4FiZbCUsQjKrfKf/4ZCBlBloXtrZef0DQObhJTbH5EkO
         EtWMttc5hc6CJJeDgzzJrsWy9qhQJyOndYeEVO8Assi0bxvD7FrgrlO3Q27TeWFDXZx3
         si1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169820; x=1689761820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CabZ5vNQt3fVXdlNPDIEC+PWoUnQG/H1hmXckZrPM8=;
        b=XCxLT8ZIu6eLK/8KkiRoEuwVFtaCYspdZHMIb7+LV0P6GM5Ezc6dYNItAta69oboi1
         heNkU5h0oY/OXLtDepMyEAu2FT+WDt7SwuIfUUpgOb/so71w3MSJMfE/1IrZCZ/2MZQn
         /FEeac22Ko/mEWa9mV5BTkkSD0eab+ps3swUfDbX7IvZKD+6DD2a1LHspNd3HX2bJUNn
         gd1PabPnlee11c07wCNBWSwgIYt2kk5WAEKN1rHEHl6gSaUblpHUlP2GqAWJ0jskX+Kz
         xFeSSAeA1cBNas7BhA6A0M/3vzKHr23dlpucbPOarINM4iXFvI4ijQ4NxeBA+1Uwvzo1
         eucA==
X-Gm-Message-State: AC+VfDwmEqKlMuxmxdz7BIQslIydxHodDWWij/ke/0/8Pfyhv9biqSbP
	koH0wStMwqaN8F8/NkmPJ/Pv1w==
X-Google-Smtp-Source: 
 ACHHUZ6KsV55NlY81gGBGHo2bEA1KQrWMXPjeGpRaR//1XJ+7ISXhnxwMCwVtTf6VOzqvIsOWMG9ww==
X-Received: by 2002:a5d:58d1:0:b0:30f:bcfd:c690 with SMTP id
 o17-20020a5d58d1000000b0030fbcfdc690mr8514768wrf.38.1687169820608;
        Mon, 19 Jun 2023 03:17:00 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 c2-20020a5d5282000000b002fae7408544sm31146922wrv.108.2023.06.19.03.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:16:59 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	ckeepax@opensource.cirrus.com,
	kuninori.morimoto.gx@renesas.com,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v3 04/11] ASoC: q6dsp: audioreach: Add placeholder decoder for
 compress playback
Date: Mon, 19 Jun 2023 11:16:46 +0100
Message-Id: <20230619101653.9750-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
References: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 63DB5GOXVM3LY22TPCBRQZH2JKSDY3XQ
X-Message-ID-Hash: 63DB5GOXVM3LY22TPCBRQZH2JKSDY3XQ
X-MailFrom: srinivas.kandagatla@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/63DB5GOXVM3LY22TPCBRQZH2JKSDY3XQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add placeholder decoder graph module for compressed playback feature.

Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c |  2 +
 sound/soc/qcom/qdsp6/audioreach.h | 14 +++++++
 sound/soc/qcom/qdsp6/q6apm.c      | 65 +++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6apm.h      |  4 ++
 4 files changed, 85 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 0acd4a75d5cd..34cbc4d05918 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -1140,6 +1140,8 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
 	case MODULE_ID_PCM_DEC:
 	case MODULE_ID_PCM_ENC:
 	case MODULE_ID_PCM_CNV:
+	case MODULE_ID_PLACEHOLDER_DECODER:
+	case MODULE_ID_PLACEHOLDER_ENCODER:
 		rc = audioreach_pcm_set_media_format(graph, module, cfg);
 		break;
 	case MODULE_ID_DISPLAY_PORT_SINK:
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 18d8d243b06b..c4e03a49ac82 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -15,6 +15,8 @@ struct q6apm_graph;
 #define MODULE_ID_PCM_CNV		0x07001003
 #define MODULE_ID_PCM_ENC		0x07001004
 #define MODULE_ID_PCM_DEC		0x07001005
+#define MODULE_ID_PLACEHOLDER_ENCODER	0x07001008
+#define MODULE_ID_PLACEHOLDER_DECODER	0x07001009
 #define MODULE_ID_SAL			0x07001010
 #define MODULE_ID_MFC			0x07001015
 #define MODULE_ID_CODEC_DMA_SINK	0x07001023
@@ -22,6 +24,9 @@ struct q6apm_graph;
 #define MODULE_ID_I2S_SINK		0x0700100A
 #define MODULE_ID_I2S_SOURCE		0x0700100B
 #define MODULE_ID_DATA_LOGGING		0x0700101A
+#define MODULE_ID_AAC_DEC		0x0700101F
+#define MODULE_ID_FLAC_DEC		0x0700102F
+#define MODULE_ID_MP3_DECODE		0x0700103B
 #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
 
 #define APM_CMD_GET_SPF_STATE		0x01001021
@@ -608,6 +613,15 @@ struct param_id_vol_ctrl_master_gain {
 } __packed;
 
 
+#define PARAM_ID_REMOVE_INITIAL_SILENCE		0x0800114B
+#define PARAM_ID_REMOVE_TRAILING_SILENCE	0x0800115D
+
+#define PARAM_ID_REAL_MODULE_ID	0x0800100B
+
+struct param_id_placeholder_real_module_id {
+	uint32_t real_module_id;
+} __packed;
+
 /* Graph */
 struct audioreach_connection {
 	/* Connections */
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index b07fee8ccac1..7bfac9492ab5 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -298,6 +298,71 @@ int q6apm_unmap_memory_regions(struct q6apm_graph *graph, unsigned int dir)
 }
 EXPORT_SYMBOL_GPL(q6apm_unmap_memory_regions);
 
+int q6apm_remove_initial_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples)
+{
+	struct audioreach_module *module;
+
+	module = q6apm_find_module_by_mid(graph, MODULE_ID_PLACEHOLDER_DECODER);
+	if (!module)
+		return -ENODEV;
+
+	return audioreach_send_u32_param(graph, module, PARAM_ID_REMOVE_INITIAL_SILENCE, samples);
+}
+EXPORT_SYMBOL_GPL(q6apm_remove_initial_silence);
+
+int q6apm_remove_trailing_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples)
+{
+	struct audioreach_module *module;
+
+	module = q6apm_find_module_by_mid(graph, MODULE_ID_PLACEHOLDER_DECODER);
+	if (!module)
+		return -ENODEV;
+
+	return audioreach_send_u32_param(graph, module, PARAM_ID_REMOVE_TRAILING_SILENCE, samples);
+}
+EXPORT_SYMBOL_GPL(q6apm_remove_trailing_silence);
+
+int q6apm_enable_compress_module(struct device *dev, struct q6apm_graph *graph, bool en)
+{
+	struct audioreach_module *module;
+
+	module = q6apm_find_module_by_mid(graph, MODULE_ID_PLACEHOLDER_DECODER);
+	if (!module)
+		return -ENODEV;
+
+	return audioreach_send_u32_param(graph, module, PARAM_ID_MODULE_ENABLE, en);
+}
+EXPORT_SYMBOL_GPL(q6apm_enable_compress_module);
+
+int q6apm_set_real_module_id(struct device *dev, struct q6apm_graph *graph,
+			     uint32_t codec_id)
+{
+	struct audioreach_module *module;
+	uint32_t module_id;
+
+	module = q6apm_find_module_by_mid(graph, MODULE_ID_PLACEHOLDER_DECODER);
+	if (!module)
+		return -ENODEV;
+
+	switch (codec_id) {
+	case SND_AUDIOCODEC_MP3:
+		module_id = MODULE_ID_MP3_DECODE;
+		break;
+	case SND_AUDIOCODEC_AAC:
+		module_id = MODULE_ID_AAC_DEC;
+		break;
+	case SND_AUDIOCODEC_FLAC:
+		module_id = MODULE_ID_FLAC_DEC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return audioreach_send_u32_param(graph, module, PARAM_ID_REAL_MODULE_ID,
+					 module_id);
+}
+EXPORT_SYMBOL_GPL(q6apm_set_real_module_id);
+
 int q6apm_graph_media_format_pcm(struct q6apm_graph *graph, struct audioreach_module_config *cfg)
 {
 	struct audioreach_graph_info *info = graph->info;
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 7005be9b63e3..87d67faf5f1a 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -147,4 +147,8 @@ int q6apm_graph_get_rx_shmem_module_iid(struct q6apm_graph *graph);
 
 bool q6apm_is_adsp_ready(void);
 
+int q6apm_enable_compress_module(struct device *dev, struct q6apm_graph *graph, bool en);
+int q6apm_remove_initial_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
+int q6apm_remove_trailing_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
+int q6apm_set_real_module_id(struct device *dev, struct q6apm_graph *graph, uint32_t codec_id);
 #endif /* __APM_GRAPH_ */
-- 
2.21.0

