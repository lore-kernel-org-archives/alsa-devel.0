Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C316C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:52:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B04E20771
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PbTmT/Vg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="feeerbFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B04E20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F7341683;
	Tue,  7 Jul 2020 16:51:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F7341683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594133543;
	bh=eIjc6K4C6AG0CP+nO7f716vsFKUAonS1/pXfGr1bI5E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PbTmT/VgmzzHj0V5JqOYVyYtAiLgm8wqvs1kTbJ2lga2tT7twYR5VeJF57BNT0Bek
	 kb4fGnDJP6RuhYqL7gqszZjcqrV9BYCuRITtwDyLMKpVGqv+zJet1NRjNX3q72r0Fd
	 iUUHGAqqnDXMWAzKhiQQ0qgVyZHNatOESlMmlPUw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44615F80390;
	Tue,  7 Jul 2020 16:38:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0195DF80361; Tue,  7 Jul 2020 16:38:31 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0FA0F802F8
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 16:38:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0FA0F802F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="feeerbFq"
Received: by mail-wr1-x444.google.com with SMTP id z13so45410291wrw.5
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GMUYidfrIwBoQwr04cGElMGH9ZhgIrwlDOw4is85pEg=;
 b=feeerbFqAir1V0Q6gG7sN9/sctNzOhjRzVnjuEbvAbmdsIlIDD56silJ+KDXeR/Jq9
 8jR1hCIT+WFN9UFvLDuUyUJVDogu1pHStNdyZIOThNEwp5zhx10W+YtTfYWblWhPARnL
 vxcY8UD8Q+wOuvAsctslvZW2g4yufz+FsjXe5lz5AoHEfe0v6Vl31z17ULBKIdl5VnHf
 NFgf6ZG9C6kQHLGTFIYhptX5/o/IQS3yshXcvSC0a+FjA1CKqyVJw4TBbqHn6BKNK8mC
 Nc9Jyj9vUMD7j4Z7Ve633OrgtQAlOJsmxJywmtvnOXIOpMCZR77AZYcVWKaZHTlUOxm+
 Iqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GMUYidfrIwBoQwr04cGElMGH9ZhgIrwlDOw4is85pEg=;
 b=tluDKTHoehUeC72TBqOEJIUGC6iYCo0dcBKOutzRAxo6sWnaSoI0YuJqBtLiF9tY4I
 QD1aH/eZZFoPOcZ5qxzcpYI4CQGfVzkTjj9YLE7RsMXbB3IdRJY6ag3ZSeD9xHp+XDTO
 dp5GybhEBRcfgFn2yJ7NjPWc2hSvbfI/fotkUkH7e7mRK52D6IBiJwmh9n8iNCa6WNLU
 X7t77kgOoWAyTHsP1HCtoyVXz3XaMaNTPm0BMRNq3Q49A3GgrriaTjIZlcshmJ5QXHiA
 3akxFDdHIVDQ04sDWubfuLvXdEyVWo7yIKjixCWPjDfxVr8RwFFgY9yr7d2HiS4+ObJF
 VY6w==
X-Gm-Message-State: AOAM533wH5uAgOnN92In28KiK5Qp6agl8wKIpKW2HftENsJzBfZ0mxqu
 2+LrZl4UzH1GvurnEqdOmlR2Cw==
X-Google-Smtp-Source: ABdhPJwecod/4foCMnzh1J6sMuZQ6V/g4S44h0ZZWS70jZc4P0QOoxlkw+3CGKD1KX4PYHqecVMChg==
X-Received: by 2002:adf:8444:: with SMTP id 62mr51773190wrf.278.1594132695426; 
 Tue, 07 Jul 2020 07:38:15 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 07:38:14 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH v2 20/28] ASoC: sti: uniperif: Mark 'uni_tdm_hw' as
 __maybe_unused
Date: Tue,  7 Jul 2020 15:37:34 +0100
Message-Id: <20200707143742.2959960-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org,
 Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Only 2 of the 3 source files which include this headerfile actually
reference 'uni_tdm_hw'.  The other source file 'sti_uniperif.c' sees
as it as being unused.  Mark it as __maybe_unused to show that this
behaviour is not only known, it's intentional.

Fixes the following W=1 kernel build warning(s):

 sound/soc/sti/uniperif.h:1351:38: warning: ‘uni_tdm_hw’ defined but not used [-Wunused-const-variable=]
 1351 | static const struct snd_pcm_hardware uni_tdm_hw = {
 | ^~~~~~~~~~

Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/sti/uniperif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 2dc2da5d458bd..e22d045d5cd99 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1348,7 +1348,7 @@ struct sti_uniperiph_data {
 	struct sti_uniperiph_dai dai_data;
 };
 
-static const struct snd_pcm_hardware uni_tdm_hw = {
+static const struct snd_pcm_hardware __maybe_unused uni_tdm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_MMAP_VALID,
-- 
2.25.1

