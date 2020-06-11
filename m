Return-Path: <SRS0=5dB9=7Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074B3C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:43:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A55F207ED
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZkG+r+Nh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PB6ee25/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A55F207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F008168A;
	Thu, 11 Jun 2020 14:43:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F008168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591879432;
	bh=yp7je3hLtkFLS3YUdaEsc+vRw5X72+EXatX4tN2ty38=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZkG+r+NhfMXv84J3PeedaqhPCpGDoUu/cYfpOOCWlmdurEXy2Az/WY9hHLqXUNd77
	 aMzA8LV29usrfKZbuzu0HRma7EyWABeEEDLPe7g3gmDb0APkz81N6zvuZ1IoTV4SdN
	 Ccv2ezq1V9C5ezeTW/XL+7RPG37SjQoQ3CD4hyCA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69FF0F80149;
	Thu, 11 Jun 2020 14:42:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7BB4F802A2; Thu, 11 Jun 2020 14:42:10 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83448F80149
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2020 14:42:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83448F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="PB6ee25/"
Received: by mail-wm1-x344.google.com with SMTP id u13so4847016wml.1
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2020 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/5Sa2AQrDHSWdZzqpjBH4h//ceIVQSzjk3tUp3KsmEE=;
 b=PB6ee25/CV55OHayB5k+7ASePj+owVMvtkgsE2VDkdvUpOUbyRJl9UG/kB0wDm8ual
 F7z/5IVqwgELP4SvmbZT8UOA8MQoNOetza6/cMBUsUDN64GPM/f5lP2N8V9aqwafrl4J
 GbF0quLVQiVzYIoDlreB4S37o25i8xHGmRzKMrBWaMCQy0XuA4chrDkx/c37SjLTDrMJ
 /AdEgYhxK6DSWuixce/P63zqDrtGxzU6GhmwTOi/pZsyDGMlKB7UUJw+LTsL41XyEGYB
 coczXH5fThZ2G13m8uW7OHo8VYF9aOUGC/h8yVZDtY0es4PO0vqAFDaOEMkijmEC8fxz
 tbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/5Sa2AQrDHSWdZzqpjBH4h//ceIVQSzjk3tUp3KsmEE=;
 b=sfHaY62EBBTrUJESN9DKnxSA8V79U6LITN36SgPy86wBRaPjcpEfMiRa+jU7XhLWNy
 NwrECj/mVD2fpd7cekfgUO8HVwX4bvipKSyxcSpYEZcxF7azgtWaj476Y91RfCtp13HW
 cLjiElvTevo3ezGygPjEX6tqS7MGwxel6smmKRl7cejDeES8YlkQFz5hbqXtjiKTfA61
 rAbpetne3x+zI01cqv+zWq+LeEnD1E3vmMv4UreFm7ySTINF/RjAKsbc2FS7rY7I1IkI
 67Jyk4e8c/sdUe0d15ku2alLYkgrr5O/2zavsraGwpqjb/GtYa+yXVPSRT5sC/FJG3JF
 82Hg==
X-Gm-Message-State: AOAM531TWDNLw7OdZX5Cg33dhcnt6ER3lo+6ZWfhOFQUvJi0gipZ7D00
 BN0fKmLBI9AZV39HUVtcwuxXrg==
X-Google-Smtp-Source: ABdhPJy8MbdIYkW8OpzVcUydBi2O4mW62kazC5GR9AyPxfefygPOSzJ5Xs3AmjkHlnXxBfdmU+dL2w==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr7894520wmi.0.1591879324065;
 Thu, 11 Jun 2020 05:42:04 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id q13sm4810355wrn.84.2020.06.11.05.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 05:42:03 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 1/8] ASoC: q6asm: add command opcode to timeout error report
Date: Thu, 11 Jun 2020 13:41:52 +0100
Message-Id: <20200611124159.20742-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
References: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com,
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

Make the error reporting more useful by adding opcode to it.
Without this its almost impossible to say which command actually
timed out.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 0e0e8f7a460a..0ce70a5c7d9e 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -310,7 +310,7 @@ static int q6asm_apr_send_session_pkt(struct q6asm *a, struct audio_client *ac,
 					5 * HZ);
 
 	if (!rc) {
-		dev_err(a->dev, "CMD timeout\n");
+		dev_err(a->dev, "CMD %x timeout\n", hdr->opcode);
 		rc = -ETIMEDOUT;
 	} else if (ac->result.status > 0) {
 		dev_err(a->dev, "DSP returned error[%x]\n",
@@ -890,7 +890,7 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
 	rc = wait_event_timeout(ac->cmd_wait,
 				(ac->result.opcode == hdr->opcode), 5 * HZ);
 	if (!rc) {
-		dev_err(ac->dev, "CMD timeout\n");
+		dev_err(ac->dev, "CMD %x timeout\n", hdr->opcode);
 		rc =  -ETIMEDOUT;
 		goto err;
 	}
-- 
2.21.0

