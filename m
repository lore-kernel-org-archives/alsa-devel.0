Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF684C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 11:49:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6240F6142A
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 11:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6240F6142A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6AF7169E;
	Tue, 16 Nov 2021 12:49:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6AF7169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637063397;
	bh=H67XaiQ92nR9K2s4RM0Xsaq7JU7jKZkbJuUWOugU23Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EKRIi/2IWhRm878Mo2UQkSWfGUwnu+6+r9wrsMlA2IfyErB0Jpz8hyIP8ixwJlnRk
	 VICEPJOsnqdMRIogNBkjzUkmxCtqqL7FEnHHxJ98/kU97xDPdo6ZxyS/DDCa0JxDKC
	 GxQNqx5tThhCCVvlTEQfDWJ1rKGeTwmPSZ8PyfDU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B485AF80516;
	Tue, 16 Nov 2021 12:47:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF646F80517; Tue, 16 Nov 2021 12:47:52 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6814BF80134
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 12:47:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6814BF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="h58ZjGHK"
Received: by mail-wm1-x331.google.com with SMTP id z200so16655415wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 03:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BreePb5GENJp3mJic8QydE3AcREz91hseAFIh0zQTP8=;
 b=h58ZjGHK8mUkiEOmFRLQ13XAaJmcPc0DZ+2L2pt3TAVqlZUp9Aeh+QnbXaRF/kmDDS
 CeO6ZCmO2Uk1a8eYLiPojv8Q+SCHcQnnB+9u5z0rqABl12codsgDiQEBwq7Vmvue4KQe
 sJSn/jMaDVPIsI3dvVyOTPR+mvmKJ8v5xKTBxhbV5EsW/E4MIqnwvfNt2gYBUrOz7Rdr
 xV2HtkVUnLh5yU5B3fTgHGzNpamr1Dnddm6CH/C6T7TjjIAbQ+LujDKXRL1qT3CZs6XV
 r54yjF5hwXIUivFJ7qqFFAVsrvEIRv6DwzFu+6bRpY22eq+urLjN3v+qf5qucELxcxmU
 KyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BreePb5GENJp3mJic8QydE3AcREz91hseAFIh0zQTP8=;
 b=36Gd3zh8eYaM0vun80Tmh5DGeqK0pK8fAD2UNX0K/k/utxg9ZkkUj7g7R5Lg3BUjG+
 mBVd6aEa7dOoeUdoK5l32Dy0JAVNgDLY0j5iWe2NR7tEhn7k4DaB/gyddEm6ryDSpEQi
 WY/RXSZ9/G4oOFXefDwvSNZOQh/nwJaaB64CJcF9TaTnMJH38vPlFwXL6u2DdIS8IuQ4
 Rcejy/l5nzVrJHretYVnd4ntRMOeHbCekGdXhb4hiUvcvALIzUPKYK9U4soAiw3Sa05+
 L1FN/dfPwGIiQXJCwtSZYln+cUWtI3A1XUXiBcRRykKQ8qC76W+eYWFW+YS7mN+N/iSR
 bo2g==
X-Gm-Message-State: AOAM531DJ9Si2n2KBJKHmYmANaioc6r4nlnKuoGslx5gW0PEFq590bmv
 nGiFbDZ/d2liK+gMtN7luTqlbHaXjgz5iQ==
X-Google-Smtp-Source: ABdhPJz1Og9ErHvhqbGGcLvGNuby/ITMs3yp4XsutAa8tHnOO8MFr3kYznP+4PwAubYNC430akC2wg==
X-Received: by 2002:a05:600c:4104:: with SMTP id
 j4mr7047632wmi.178.1637063262636; 
 Tue, 16 Nov 2021 03:47:42 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id l8sm2260523wmc.40.2021.11.16.03.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 03:47:42 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 3/5] ASoC: qdsp6: q6asm: fix q6asm_dai_prepare error handling
Date: Tue, 16 Nov 2021 11:47:19 +0000
Message-Id: <20211116114721.12517-4-srinivas.kandagatla@linaro.org>
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

Error handling in q6asm_dai_prepare() seems to be completely broken,
Fix this by handling it properly.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 46f365528d50..b74b67720ef4 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -269,9 +269,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 
 	if (ret < 0) {
 		dev_err(dev, "%s: q6asm_open_write failed\n", __func__);
-		q6asm_audio_client_free(prtd->audio_client);
-		prtd->audio_client = NULL;
-		return -ENOMEM;
+		goto open_err;
 	}
 
 	prtd->session_id = q6asm_get_session_id(prtd->audio_client);
@@ -279,7 +277,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 			      prtd->session_id, substream->stream);
 	if (ret) {
 		dev_err(dev, "%s: stream reg failed ret:%d\n", __func__, ret);
-		return ret;
+		goto routing_err;
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -301,10 +299,19 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	}
 	if (ret < 0)
 		dev_info(dev, "%s: CMD Format block failed\n", __func__);
+	else
+		prtd->state = Q6ASM_STREAM_RUNNING;
 
-	prtd->state = Q6ASM_STREAM_RUNNING;
+	return ret;
 
-	return 0;
+routing_err:
+	q6asm_cmd(prtd->audio_client, prtd->stream_id,  CMD_CLOSE);
+open_err:
+	q6asm_unmap_memory_regions(substream->stream, prtd->audio_client);
+	q6asm_audio_client_free(prtd->audio_client);
+	prtd->audio_client = NULL;
+
+	return ret;
 }
 
 static int q6asm_dai_trigger(struct snd_soc_component *component,
-- 
2.21.0

