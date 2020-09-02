Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898FCC433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 04:09:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106FA2068E
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 04:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WgsZ09VT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THZ95p1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106FA2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9527D1795;
	Wed,  2 Sep 2020 06:08:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9527D1795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599019774;
	bh=0LrA13Z6D3tRAXhxLQMEKRQfMerLWSkbtsdtl2pj+JA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WgsZ09VTsiOC7AGaj4RR6ZLAiY1NJ3y1Ljpwm9T1yn1B5BIIyX+UhbkFqCR/Swroq
	 ew/1J4a7J0/+8kqkAevDUGV9c3m77++7jcHt1bir/vFcHDq4ABbKMSgq0uopSIxmFR
	 PUxFYQYoGJHeO8YW55HGOf5mv/+VkdR8bpOQYr98=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50A6EF80334;
	Wed,  2 Sep 2020 06:03:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0589F80335; Wed,  2 Sep 2020 06:03:21 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B47BFF8032A
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 06:03:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B47BFF8032A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="THZ95p1B"
Received: by mail-pl1-x642.google.com with SMTP id y6so1648578plk.10
 for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2020 21:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AOJMlWBC7Fo6+79XuvkGFq5GSjsDSAjFTpzZO2SYEwc=;
 b=THZ95p1BwgDmC3u7AqLFD9/UwdkbDRfadtwJf2kPikYI04v//MQLk7nzTCc8dsTBkM
 JwjkcJ/ZIhsDCBJufazxDXtYGTXHrNkBrM8sPvE+6jbDn2a4DOpC4nZwLM/bVFz9PxPz
 PMo53mtYOP1el/HZ46R6b4xr6HZXmt3utGaTHNmmLXjy8BGkAQARf9kspP6MJM2+zkdK
 /IbG+R+A7k8PFa+iv6QoEH53arCIgiCFxcyrkaTSE/qZPUqI13BpgyJZZUyaeUZP/8KT
 LZXz2lbPVrJ3YJhWjy1j9SJfcisHtIDOkJKN6UVBhGkNPlxrsfPuZ4n4lrqla6u1ttco
 ZN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AOJMlWBC7Fo6+79XuvkGFq5GSjsDSAjFTpzZO2SYEwc=;
 b=QZ+bXzrrtKHZflpBnNEc5oITPl3WpAW6JtAKNPQnZiR6vQ23E9+MJ+yxcJJUj6ZYPF
 JXPYlgFnAxtSZYqEgIATYCHcLpSMbtXdzbvSFK7Hfr8nr/Nl9PeHoGCPUVnuIOMwIIqT
 vSm48FWfbshdem3xW/r6f+eWHst1YLHsIBsuCE81UYh1GYpOvlR3l9KiqCmD/6NLvw43
 BPXX3o/eY8LY30GVU/aSrreCClqzjyVu9wgHNRAOrOp8sePc6+kvbQfBDQpYIb6oAGoY
 3fpGDMvAgUlcRicDczUXbcxGWk6XM4LrdaavGbmKvqRejmJo6gFqWKKGXZVUjsJ0U6AG
 kngQ==
X-Gm-Message-State: AOAM532z7v4/7GhfTSRZmI3XTdGlrl8OZPfDS1/Tnq49dilsizWQ3ZF/
 rlUISxRPNxvpqM68olwt0Tk=
X-Google-Smtp-Source: ABdhPJzxxbfPWUt/EUSMNVa84o6WVx4mR2bcH1WBUNt85OWbyUl8v6snpqdbxafiT6SdhJ21McP+kg==
X-Received: by 2002:a17:902:ee0b:: with SMTP id
 z11mr438497plb.268.1599019389111; 
 Tue, 01 Sep 2020 21:03:09 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.170])
 by smtp.gmail.com with ESMTPSA id q71sm3058350pjq.7.2020.09.01.21.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 21:03:08 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org
Subject: [PATCH v2 10/10] ALSA: ua101: convert tasklets to use new
 tasklet_setup() API
Date: Wed,  2 Sep 2020 09:32:21 +0530
Message-Id: <20200902040221.354941-11-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902040221.354941-1-allen.lkml@gmail.com>
References: <20200902040221.354941-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 clemens@ladisch.de, Allen Pais <allen.lkml@gmail.com>, nicoleotsuka@gmail.com,
 Romain Perier <romain.perier@gmail.com>
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

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 sound/usb/misc/ua101.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 884e740a785c..3b2dce1043f5 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -247,9 +247,9 @@ static inline void add_with_wraparound(struct ua101 *ua,
 		*value -= ua->playback.queue_length;
 }
 
-static void playback_tasklet(unsigned long data)
+static void playback_tasklet(struct tasklet_struct *t)
 {
-	struct ua101 *ua = (void *)data;
+	struct ua101 *ua = from_tasklet(ua, t, playback_tasklet);
 	unsigned long flags;
 	unsigned int frames;
 	struct ua101_urb *urb;
@@ -1218,8 +1218,7 @@ static int ua101_probe(struct usb_interface *interface,
 	spin_lock_init(&ua->lock);
 	mutex_init(&ua->mutex);
 	INIT_LIST_HEAD(&ua->ready_playback_urbs);
-	tasklet_init(&ua->playback_tasklet,
-		     playback_tasklet, (unsigned long)ua);
+	tasklet_setup(&ua->playback_tasklet, playback_tasklet);
 	init_waitqueue_head(&ua->alsa_capture_wait);
 	init_waitqueue_head(&ua->rate_feedback_wait);
 	init_waitqueue_head(&ua->alsa_playback_wait);
-- 
2.25.1

