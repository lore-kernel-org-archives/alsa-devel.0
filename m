Return-Path: <SRS0=BIVw=Y7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BBBFC6194
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 02:05:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC4121929
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 02:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GOPybJGV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IItUhaU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC4121929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 442D31692;
	Thu,  7 Nov 2019 03:04:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 442D31692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573092317;
	bh=VPQvOEwA4aY94mIspSrtwIL4RPmocLGuqX0gHPqKcVU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GOPybJGV/1lloOMsBLQlO7ggxrxzLW69ycufMP3dpm0Z6jyO/5jWZe0NxB2QYSvbE
	 fdSSW8Cjry6/gYH5y0+qjeITBVlUO/ePbTN0aC82D0633QGGOqeIV0O6UivIjoV+I4
	 wAANj92ZRsJ5G3bKAlBF3SoEYAdCxg6iSMCiz1TQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08851F806E5;
	Thu,  7 Nov 2019 02:58:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C42C9F80638; Thu,  7 Nov 2019 02:58:44 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E618AF80611
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2019 02:58:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E618AF80611
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="IItUhaU5"
Received: by mail-pg1-x543.google.com with SMTP id 15so727048pgh.5
 for <alsa-devel@alsa-project.org>; Wed, 06 Nov 2019 17:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/zwKQRbo1F48WVQ7FiEqpiQ2fwE9RtcyH/wIl6nBH4A=;
 b=IItUhaU54zH+plhqUBmQDT5GKaTmya5m0b86avtOUKwo9Kpz6bwVfLwJYbmA+CrKQq
 J3s5fLvLfxqUtZhQ7rFOzMJPYtWdutZ0+eVgYLWzjrg8ml9iYtRR3vISNOCKF1Bit6iV
 cpygVobu+BazlmHoKea5pimPn6m3ZCJyrjgn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/zwKQRbo1F48WVQ7FiEqpiQ2fwE9RtcyH/wIl6nBH4A=;
 b=leJSszJd61joNvZG2GtwB24VBkXr39xprU0kD4lBHljKT6Kakofh6E1w+M62rcgt2K
 SnX9mFpPDxGRQ+tdk/6VvbhnDYB/SR8Lu/hsp7a060QcQqNV5FbDB4r/wVUcJI8dOVQC
 xiu0QRciyHzROEOxiX32ZIivhNBGXc8CeUGGQ7e6wpMi4rWgA/4VCPT0f27XJwpgI1F8
 ovwvXw8KN5k5eS/EKL3TPUvSdMrU6axFus+4axdgTq+wAWdw5QdX//IKKcuAjLtdRBja
 45dVF20aicOrfXA6/tUKGh0+HxtxwM00D/V2d3Ms6ajKUBYnG/z8HnE7WPtZGb8UaG1i
 wxmw==
X-Gm-Message-State: APjAAAWJpnG5MFJIGmcT6vj6URCPEP7XR50UerqiWKEIiP8jVphXkhbw
 wGkTfxsQM7WX/FXeSwiHcHvGLEOrOloV
X-Google-Smtp-Source: APXvYqw4Q9nLzmqctEemzvkV0Tr0v8FtvhxuxkR2+cQEis0LFdZIfRtqWPB87rZvbTTAmqf69yp3NA==
X-Received: by 2002:a17:90a:bd01:: with SMTP id
 y1mr1501082pjr.108.1573091919693; 
 Wed, 06 Nov 2019 17:58:39 -0800 (PST)
Received: from localhost ([2620:15c:202:201:c87a:31ae:9107:f63d])
 by smtp.gmail.com with ESMTPSA id e5sm295824pfa.110.2019.11.06.17.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2019 17:58:39 -0800 (PST)
From: Curtis Malainey <cujomalainey@chromium.org>
To: alsa-devel@alsa-project.org
Date: Wed,  6 Nov 2019 17:58:06 -0800
Message-Id: <20191107015808.26844-9-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191107015808.26844-1-cujomalainey@chromium.org>
References: <20191107015808.26844-1-cujomalainey@chromium.org>
MIME-Version: 1.0
Cc: Curtis Malainey <cujomalainey@chromium.org>, broonie@kernel.org
Subject: [alsa-devel] [PATCH 09/11] ucm: docs: Add EchoReferenceDev
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

Sometimes userspace may want to use a reference channel to cancel echos
when using video chat, this value identifies the device which carries
that channel.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 include/use-case.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/use-case.h b/include/use-case.h
index 9a10f390..e84f3f8f 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -308,6 +308,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *   - CoupledMixers
  *      - Mixer controls that should be changed together.
  *        E.g. "Left Master,Right Master".
+ *   - EchoReferenceDev
+ *      - If userspace wants an echo refence channel this value identifies the
+ *        device to be used.
  *   - EDIDFile
  *      - Path to EDID file for HDMI devices
  *   - JackControl, JackDev, JackHWMute
-- 
2.24.0.432.g9d3f5f5b63-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
