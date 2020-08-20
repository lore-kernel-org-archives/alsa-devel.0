Return-Path: <SRS0=2rKR=B6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC5AC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:34:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553682072D
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TlcUCeoV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n0OpmzaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553682072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D207168B;
	Fri, 21 Aug 2020 01:33:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D207168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597966454;
	bh=LB7KLnCW/f+QuSvL44ykIEwDv2XPD6yO7+DY2wFZTQI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TlcUCeoV0zSjU5+p5BRKrdxe7gegOpt8pyaRrbwrrmPjBqod+Lb0dT9ieCp7QL65O
	 PvONUnok1NYXsLVjgepwKtj2wwBjdUhgqZ8gy6tzTH9JJMbafij85OW3WOIsg0+gTL
	 Ijlc1mOcEEYSvkmtrEbY5hfO2PGhUHUvTLlKRpIc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B6DEF8023F;
	Fri, 21 Aug 2020 01:32:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 940FBF80228; Fri, 21 Aug 2020 01:32:29 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 333ECF800C0
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 01:32:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 333ECF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="n0OpmzaD"
Received: by mail-pf1-x443.google.com with SMTP id r11so129842pfl.11
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2020 16:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GrxfLeGvsSt1Wqcy3iA/GakyPdRtEsONZ+QrOlebZzc=;
 b=n0OpmzaD5VpgeV7vXdSP8/pkwN21AxSsJSSwXTLCZ+8FuIhSC2FcU/2Ou/ckTA6hy+
 2rTIcCxeJvFC1EH1MWojiauV0ZdLqm/1DHgDQFJaQUlHKRPhJP7x1pdS61YCqKA9xPUu
 xz4pAIFycqUdtv0sH8rx9RUxq/7sQVbxQGNzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GrxfLeGvsSt1Wqcy3iA/GakyPdRtEsONZ+QrOlebZzc=;
 b=MHEAJatFr3Y1H6QTLZiVDmtQ+o3YRBWCNtrOLLLo0g2AJO29avKozwbbs6avf93ox6
 UcaIMgOqs4IVbm7OfZLr//FZRNIQ3gtESNDMvXvE11OjxeOVFjVryRrYiwZ83F55NRKV
 h5lKGErB5CJChu+D8KhCp9ptFqgjlICFCvE80fqIlEPhVeTFVXLPV3FP2BVQrcq6RBjd
 dI5ulF4QVc7t1KfPD8KXL5UhW3fuzKdIGsh1Zxxitl7+sJKyWRRyjuJQ+pGAh/ltAam3
 cluvfocp4xUuesk1OHL/zzn6OMX6sOUGhFp3XoF1IILNYfr8ltJxJihsHRvfOf5FSN9L
 OFOQ==
X-Gm-Message-State: AOAM532fY0Yuegut/raLQFE1cseMqD9gkLDqo0oEBODfp4fRGbeMSiNu
 /7GgUJ7QgYEjh/PB70/C1BQNHNyR6z7nfPY=
X-Google-Smtp-Source: ABdhPJyl2WXL+6InH7+b7YW1IndvMgKQb9g46+3Wjago0n3lbxlZW+6RXYgBG0/tj+bCdzBWMzFODQ==
X-Received: by 2002:a62:1b81:: with SMTP id b123mr173927pfb.149.1597966340328; 
 Thu, 20 Aug 2020 16:32:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:2f18])
 by smtp.gmail.com with ESMTPSA id x23sm174471pfi.60.2020.08.20.16.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 16:32:19 -0700 (PDT)
From: Curtis Malainey <cujomalainey@chromium.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ucm: add DmaPeriodMicrosecs
Date: Thu, 20 Aug 2020 16:32:05 -0700
Message-Id: <20200820233205.505925-2-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200820233205.505925-1-cujomalainey@chromium.org>
References: <20200820233205.505925-1-cujomalainey@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Curtis Malainey <cujomalainey@chromium.org>
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

Add ucm value to allow userspace to set sane values for platforms that
default to be configs.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 include/use-case.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/use-case.h b/include/use-case.h
index 80148a7b..94992cd4 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -358,6 +358,10 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *   - CaptureMasterType
  *      - type of the master volume control
  *      - Valid values: "soft" (software attenuation)
+ *   - DmaPeriodMicrosecs
+ *      - Set DMA period us. Used to correct when system defaults to values too
+ *        large which cause initial noise. Value is passed to
+ *        snd_pcm_hw_params_set_period_time_near.
  *   - EDIDFile
  *      - Path to EDID file for HDMI devices
  *   - JackCTL
-- 
2.28.0.297.g1956fa8f8d-goog

