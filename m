Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AC1C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:33:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE5920818
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rkfEwfXX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xo8QS0SV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE5920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A78B165F;
	Tue, 12 Nov 2019 19:32:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A78B165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573583591;
	bh=vszFPoV4sncCcBCK/wAnYvm9iIvCk8a85ls1r+csfgk=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rkfEwfXX4ezllmfbdRPf/4pDQl80EO0KKh92zrRrgB5x3zAC/SVPMNAh54nScwEeT
	 +vTfz8PC5oRGThTZAQQ2h7EYHSN5LWU7WmpH0mHyP0OdhpN8aBAWnjTlz944MImUJ4
	 3O7DEaU2AhxGb80zViycS3fiMBeA+G2oHs2eLKdM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73D2CF804CF;
	Tue, 12 Nov 2019 19:31:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13288F806FA; Tue, 12 Nov 2019 18:17:32 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33550F805FC
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2019 18:17:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33550F805FC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="Xo8QS0SV"
Received: by mail-pg1-x543.google.com with SMTP id q22so12298887pgk.2
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2019 09:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4xxRHw6/3z9e2nyAGWJzoGw1p/LSUOxTCybLFFSHdxw=;
 b=Xo8QS0SVtI4s+qaYHPpfI6h/nZGf1AlXbz0BoZb5ocvmRZg5XXoB5+wcMAyVAIAT4Z
 6mOUpWbWGIxouNJip901iGjMT/tYzksw+PDPsnhrNCTR4JdUmFaXIM8BlOPBvAcYlydI
 6L0cTwTfHYVxSDbY8oDzkzZ8Md+upvqGK6Gag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4xxRHw6/3z9e2nyAGWJzoGw1p/LSUOxTCybLFFSHdxw=;
 b=tp1LuxZ8cAOVy48s1v7M0ed5eHOAoUg2utleX3NLp/Jv71WhsJJD91MA+3u/qi9u4f
 GOBz0ZJS0aeG8CBjnMKJ13o3emEzM24y/kxBQnYcY58pchCOWIpr/2wpBJsnorgqlEwI
 J1Eglhv6L4WHxIH5oYA1CfwFJ+Pvg8wlB9llyt4P2dzXqkbOB+bpQXmGVNpqZkErZ5K5
 jaKOOdYujgFyFpq9bI4tvD6i5LytNGfYNKTDMIffTVU8FR5HuiCuGz6m65/sxRRS65Bp
 WfYi1GnNtXvADphkE7cWtrVxj6DUfDq4PumuzmBFq7yk9Ajjad6dTwXo7iZCyDZSegXo
 5lMQ==
X-Gm-Message-State: APjAAAXxQ1DuBEBowHyg5ysBkwe9tapMMpg5j8Ao1MVYi/H6ow8V3JUm
 MXFZJcSadLue1Bbvl3hpq0bgnsYs/Ug=
X-Google-Smtp-Source: APXvYqzcgPkS4O6FeQTFiG7nNrQjhKqrGzeupyYwb4ad78uCvoMVN7a8JupAU0W1pAEsMoCbCdlhqQ==
X-Received: by 2002:a17:90a:9604:: with SMTP id
 v4mr7820912pjo.105.1573579047795; 
 Tue, 12 Nov 2019 09:17:27 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:521e:3469:803b:9ad6])
 by smtp.gmail.com with ESMTPSA id h195sm3262634pfe.88.2019.11.12.09.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2019 09:17:27 -0800 (PST)
From: paulhsia <paulhsia@chromium.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 13 Nov 2019 01:17:14 +0800
Message-Id: <20191112171715.128727-2-paulhsia@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112171715.128727-1-paulhsia@chromium.org>
References: <20191112171715.128727-1-paulhsia@chromium.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 12 Nov 2019 19:31:23 +0100
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 paulhsia <paulhsia@chromium.org>, Takashi Iwai <tiwai@suse.com>
Subject: [alsa-devel] [PATCH 1/2] ALSA: pcm: Fix stream lock usage in
	snd_pcm_period_elapsed()
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

If the nullity check for `substream->runtime` is outside of the lock
region, it is possible to have a null runtime in the critical section
if snd_pcm_detach_substream is called right before the lock.

Signed-off-by: paulhsia <paulhsia@chromium.org>
---
 sound/core/pcm_lib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index d80041ea4e01..2236b5e0c1f2 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1782,11 +1782,14 @@ void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime;
 	unsigned long flags;
 
-	if (PCM_RUNTIME_CHECK(substream))
+	if (snd_BUG_ON(!substream))
 		return;
-	runtime = substream->runtime;
 
 	snd_pcm_stream_lock_irqsave(substream, flags);
+	if (PCM_RUNTIME_CHECK(substream))
+		goto _unlock;
+	runtime = substream->runtime;
+
 	if (!snd_pcm_running(substream) ||
 	    snd_pcm_update_hw_ptr0(substream, 1) < 0)
 		goto _end;
@@ -1797,6 +1800,7 @@ void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
 #endif
  _end:
 	kill_fasync(&runtime->fasync, SIGIO, POLL_IN);
+ _unlock:
 	snd_pcm_stream_unlock_irqrestore(substream, flags);
 }
 EXPORT_SYMBOL(snd_pcm_period_elapsed);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
