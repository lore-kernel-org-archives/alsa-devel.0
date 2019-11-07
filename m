Return-Path: <SRS0=BIVw=Y7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400F9FA372C
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 02:03:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22292187F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 02:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l5127AY6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RiEPm5W8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22292187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F09211696;
	Thu,  7 Nov 2019 03:02:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F09211696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573092228;
	bh=uBA27krKJiVOw8Fx+GDNLYhjOtwQ8gLZB3JeVJShtwY=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l5127AY6YTtBCDxcAYrRZqLQpgy57FMMeLw9L0zeQVW3m0+eX/qjBKvL0bv6A+9+h
	 4ZkctArymbBrO+6mofXX4WZv0TdIJHXwQNv/5iYige//EgHjo8Zut2u6jl1vYP4HFe
	 UyleyU3n+ghF5ZC/9roNDbZuMNVg97xQRkcdnF24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC3D3F80672;
	Thu,  7 Nov 2019 02:58:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38331F80633; Thu,  7 Nov 2019 02:58:42 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13ACFF805FB
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2019 02:58:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13ACFF805FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="RiEPm5W8"
Received: by mail-pg1-x544.google.com with SMTP id 29so721529pgm.6
 for <alsa-devel@alsa-project.org>; Wed, 06 Nov 2019 17:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ief1CCT8yjZqBnBQabI8UHJHSOQuYxegwucZ7pBxEn4=;
 b=RiEPm5W8zCGASeTAlkiKlD5eEmAFZlw/RAPZcaKZBqP9hDelsfjdx702xej6ADm9+u
 mfs2Z5g2hLfn8rVh7NGX8jpoiRKTAOZIgzhp80Jzpmzu6Q1NXr39+kajGttKVC1LQVeF
 rJhQG89ZArwF2Q9/v7GDM5X+FXuPTlHC+Qii4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ief1CCT8yjZqBnBQabI8UHJHSOQuYxegwucZ7pBxEn4=;
 b=G9nwJIyocTUCfVvuuYsiv+LBPhQKnbwYWDNgmv8SoxC+2sbzcVFU0XSYCU5DV7tDH6
 pOPtwyMJzpOk9TvELphtCFjkAO0/02KwrPkii3jlxtLAvblI59yaVbbl1nAI4HyEbidx
 ZfdsdX1cp8i0htrEeSMWeCUyjrhptcWdtUU/YCyRuGU3GnjdQYe5xpeoYLk5dTCgMue4
 hDcl5x2zKgV+/wa28UMiQ43RVuDa+X0AwQMNWQVX3X6ml+7aPYo0o1lRRjLtyN44ERhB
 E0Syj5DL3afqcxbm4xRoCG3/rmp9O2sJ4qH71D+XiNNhiqSah6yYKDAjvz+RZ0tJGH4c
 WKzg==
X-Gm-Message-State: APjAAAXJf8S8hxMf26UL9PGos/8wPRzOzxkvvN5SrS2iDgV6icj5JqjC
 Q1QeLVEVo3krtNk15KSNuEVbmlML8Gys
X-Google-Smtp-Source: APXvYqw/rKRnjDz9H3waLABidn8n0TI9kFRGH2e0HSadqKKLfrvGu1XTKGRcuREMRinr7xCitNnwJA==
X-Received: by 2002:a62:be0e:: with SMTP id l14mr668621pff.126.1573091917101; 
 Wed, 06 Nov 2019 17:58:37 -0800 (PST)
Received: from localhost ([2620:15c:202:201:c87a:31ae:9107:f63d])
 by smtp.gmail.com with ESMTPSA id x12sm275349pfm.130.2019.11.06.17.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2019 17:58:36 -0800 (PST)
From: Curtis Malainey <cujomalainey@chromium.org>
To: alsa-devel@alsa-project.org
Date: Wed,  6 Nov 2019 17:58:04 -0800
Message-Id: <20191107015808.26844-7-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191107015808.26844-1-cujomalainey@chromium.org>
References: <20191107015808.26844-1-cujomalainey@chromium.org>
MIME-Version: 1.0
Cc: Curtis Malainey <cujomalainey@chromium.org>, broonie@kernel.org
Subject: [alsa-devel] [PATCH 07/11] ucm: docs: Add CaptureChannelMap
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add ucm value to tell userspace to remap channels. This is useful for
systems with DMICs where there may be more channels than active
channels.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 include/use-case.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/use-case.h b/include/use-case.h
index 1aeaf9d4..31f9e4be 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -301,6 +301,10 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *      - name of capture mixer
  *   - CaptureMixerID
  *      - mixer capture ID
+ *   - CaptureChannelMap
+ *      - Remap channels using ALSA PCM channel mapping API notation
+ *        E.g. "2 3 0 1 -1 -1 -1 -1 -1 -1 -1" means, FL takes channel 2,
+ *        FR takes channel 3, RL takes channel 0, RL takes channel 1.
  *   - EDIDFile
  *      - Path to EDID file for HDMI devices
  *   - JackControl, JackDev, JackHWMute
-- 
2.24.0.432.g9d3f5f5b63-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
