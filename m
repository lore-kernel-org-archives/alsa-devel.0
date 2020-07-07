Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1DEC433E3
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:54:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B22F207D0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i0Y2vPWi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vs9u6fko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B22F207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DDC5168A;
	Tue,  7 Jul 2020 16:53:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DDC5168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594133687;
	bh=EM4xc4zuTfNJJOw9xsPbDmQgs87yP6MPx3rgM1fs9FM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i0Y2vPWiLYarQ+Me1ds9HzEl8VzjiFWUlv6nHLH4kUo1zBhTEYHUuNwLXDRk8awXb
	 p6b1tJ8V1zdv+AXgh5rRJ1NzVBGerBRbba2ZONVOLla+PeLgK3D4jT2wVe6ezRtwG0
	 EALYkn0ezUfV0wbGFP8OeMe9lj5eB0S7XMJote7w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5831AF803D5;
	Tue,  7 Jul 2020 16:38:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EE16F8038C; Tue,  7 Jul 2020 16:38:40 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86AE4F80346
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 16:38:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86AE4F80346
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="vs9u6fko"
Received: by mail-wr1-x443.google.com with SMTP id q5so45372689wru.6
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GL1MoJKxnZtWyOmgkHZ5ZdLcj+7xXQIgEe9rUvPd4fk=;
 b=vs9u6fkoHdTRsoIwOztyIF1QFyoLJ+DBOn61usrEsJa8M/xEsFz6ccynCe3suiWI+J
 wagk06+451E7C2zn0WCt74jl5nlJqEhHDLkhajDlwKLxfpgSxC4M4q4fF1Q89wvwVBUF
 jve/9coueBoszftEXEflGjtwcIhdarMn+tFbiQqJa1GudAy6ev1furWHGgRHcCaBbtTp
 a9h83mDRjxnTvBYqShL8PaEm5hnvsF7stpAChgwzB5D+lYGb60bstU9/BdCOh0Q4cPe9
 ZPndxE4hZWNAzb19+hWUfepNHF69vsrqN4F+8PHwo6Tu5C17wHLumK19fX/OA7tz/FOS
 QctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GL1MoJKxnZtWyOmgkHZ5ZdLcj+7xXQIgEe9rUvPd4fk=;
 b=GtMc4zj+zBryW/X1EbUz6xg4DuNccPOSLq41g/PdF6xO0ZbVbqodQHR84Pe43jNgTa
 ZnZXy2fhltZr9wuRKk/+rJeokOAGEbRciID58qyEqXVRiAIm6889Q3gtp9D6MMMD+e+A
 EKVTRIlUZOWlTMdvbRp2Y83GQclGP6HmdT5xS7Oer1JDl/7XkSYaY4eiUXEYZACl9XBX
 V6+rz6Wy1azqGYenz/dni2Uy6ux4njq+uHGZ6L4NKpiQQGuKY6eNBt3ho49JAUOlgJqi
 SJTY8lxf1wDcGDDWMGTXpdIA4MukPALvnLnu7vQzm+roix0kGQxSbWLrInufkJz7f1KA
 pUjw==
X-Gm-Message-State: AOAM530C1/EgKwI5rKZ9ZdImezzZi8I7T/bgcq0NRoYcf5B6dI2JAFi3
 XCOOHOrmYYBcVb+bpGoV1fhvKbsBbsA=
X-Google-Smtp-Source: ABdhPJzd2FTv80CNQ/tL+xGiVbCx50HF+5XZshFx4c6WGmM6f7LoU39lGcsU04vGFOfZUWMHOWSnlw==
X-Received: by 2002:a5d:5341:: with SMTP id t1mr57527312wrv.207.1594132704004; 
 Tue, 07 Jul 2020 07:38:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 07:38:23 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH v2 27/28] ASoC: codecs: tlv320aic26: Demote seemingly
 unintentional kerneldoc header
Date: Tue,  7 Jul 2020 15:37:41 +0100
Message-Id: <20200707143742.2959960-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>,
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

This is the only use of kerneldoc in the sourcefile and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 sound/soc/codecs/tlv320aic26.c:138: warning: Function parameter or member 'dai' not described in 'aic26_mute'
 sound/soc/codecs/tlv320aic26.c:138: warning: Function parameter or member 'mute' not described in 'aic26_mute'

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/tlv320aic26.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 032b397356438..4569bbc08acb3 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -131,7 +131,7 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/**
+/*
  * aic26_mute - Mute control to reduce noise when changing audio format
  */
 static int aic26_mute(struct snd_soc_dai *dai, int mute)
-- 
2.25.1

