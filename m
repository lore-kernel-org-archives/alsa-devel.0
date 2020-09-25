Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A0CC4363D
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:37:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4CC206BE
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fXT+ABmi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QftbfSRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4CC206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B35B18CC;
	Fri, 25 Sep 2020 18:36:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B35B18CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601051868;
	bh=DYZHGee6JflFh5i59WU+G5RDa2yQ80VdjNCocW/mIxs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fXT+ABmiqBBpBrmwmJ4jCxlPICFMWnJBaokYhF1NhUNT0zM5HwLUQnCwKmjCo+kb7
	 7vVlsfceWjFWjd7+2ps1/NK2Ig9F2gwYugKv80FTgVAvyZmX7J5WbjnwUR6oVk+vDI
	 Xwke2Ydierji6MvBaDxeV98Yhjrs3gmMZVePz8iw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC528F8021C;
	Fri, 25 Sep 2020 18:36:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB08FF8028F; Fri, 25 Sep 2020 18:36:08 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF449F80162
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 18:35:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF449F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="QftbfSRh"
Received: by mail-wr1-x442.google.com with SMTP id o5so4224696wrn.13
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kFHi/Lnlt8f1kQDKiGDd11Cptp9H00xnl26W3F/tZaI=;
 b=QftbfSRhc9RJbjqj2FGPZckdcjn/yMYTBEzTjgy3SeATCPxuZswj0/GK4vByczRtu7
 LwkStd+D2xxSr5/g7eU2P8ZDHTc67ZodPKerkMtkO5S3eMRDTdphXErY9xG+GJl9OWwd
 +T60/crKY5Q0DldxVYYyPnOwlIikybVQ7NCtYrsYKbQCugyG4z9dN5o0ZnvHtfTPoXTy
 s7QlaSQsIsx+DzkDS2L/FSPiqQJONOyovX8r47ve+nqSCpHNLHM9ujvSY7+Nqhv2cANL
 d4nj4UY42/ZtFin2Kx5qb3MlP0vgp35WIe8Ii8fr/0HxX8Gm6ksnELcmN/tL6trt7ekZ
 qtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kFHi/Lnlt8f1kQDKiGDd11Cptp9H00xnl26W3F/tZaI=;
 b=lEz2jKKxftDzl9sFOUmquc7t7+74uoRcv+9bF3xpWfJeRzSqgqoWEFml2YRZZlxsLO
 iPRctUcGy3a+5HXk0UWfx+JOTjno84SCw+qQn5X5A80qRkKORZbsbgfMM3yrhCLTAVXi
 C67gIm1zI00rjCWnPh6lPwWYjRDbTdlwuusW6BKLkTpgI5B8OoLgFqS1Qc0YaI3uap6D
 WzQ2gbRH/VbtrsHEXGLNExvQpP3e9souLRlwgAUEBPPgo3StNbxZ5vZJ4ccLpJ/LuVN8
 mUK94/qtDF0d2pFO70mC/6/lfHEFGjYJPXV5gjMww7CMlHQJe7KR5PpZNZl+ivZ5svNI
 Zljg==
X-Gm-Message-State: AOAM530bfnVcJj81Br1A2ix/b50ojMmlGh69CEovTwyrDylAk/l4swll
 xMR3ADcEeU4S+kvZl5WuwO0fcw==
X-Google-Smtp-Source: ABdhPJwDUNZy1TRZ9PrSR+BOSCCszXZM2mAcvg9nXER2+5EpX7pDXX6x3SrXpFgEaorXLaSXqG88bQ==
X-Received: by 2002:adf:8544:: with SMTP id 62mr5416564wrh.262.1601051757907; 
 Fri, 25 Sep 2020 09:35:57 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id m4sm3733883wro.18.2020.09.25.09.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:35:57 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 2/2] ASoC: q6asm: fix kernel doc warnings
Date: Fri, 25 Sep 2020 17:35:52 +0100
Message-Id: <20200925163552.20717-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925163552.20717-1-srinivas.kandagatla@linaro.org>
References: <20200925163552.20717-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, tiwai@suse.com
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

This patch fixes below kernel doc warnings on not describing all the parmeters

sound/soc/qcom/qdsp6/q6asm.c:927: warning: Function parameter or member
 'stream_id' not described in 'q6asm_open_write'
sound/soc/qcom/qdsp6/q6asm.c:927: warning: Function parameter or member
 'is_gapless' not described in 'q6asm_open_write'
sound/soc/qcom/qdsp6/q6asm.c:1053: warning: Function parameter or member
 'stream_id' not described in 'q6asm_run'

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 790abc135223..c547c560cb24 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -915,9 +915,11 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
 /**
  * q6asm_open_write() - Open audio client for writing
  * @ac: audio client pointer
+ * @stream_id: stream id of q6asm session
  * @format: audio sample format
  * @codec_profile: compressed format profile
  * @bits_per_sample: bits per sample
+ * @is_gapless: flag to indicate if this is a gapless stream
  *
  * Return: Will be an negative value on error or zero on success
  */
@@ -1042,6 +1044,7 @@ static int __q6asm_run(struct audio_client *ac, uint32_t stream_id,
  * q6asm_run() - start the audio client
  *
  * @ac: audio client pointer
+ * @stream_id: stream id of q6asm session
  * @flags: flags associated with write
  * @msw_ts: timestamp msw
  * @lsw_ts: timestamp lsw
-- 
2.21.0

