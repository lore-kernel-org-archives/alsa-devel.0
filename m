Return-Path: <SRS0=Xr4r=MB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA4CC07E99
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jul 2021 08:54:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C190613CA
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jul 2021 08:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C190613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC454886;
	Fri,  9 Jul 2021 10:53:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC454886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625820881;
	bh=dvjkq90cvYjC5DLC/6PNEgzJm777gm55fPGR6m/vxtM=;
	h=From:Subject:To:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ly9+42ThjQ3e9N3D1FMcH9N4C+bVgRfwm7cDwyyx1bxW8g/d94O4+CeU3h0xTihC5
	 SO33AmxlWvq1Bj+B2aWQcrGW0hHXdKO2aYoBcw2vIEGBwciEo+JkKIXCfoQ5OgsfcP
	 xEOU5nEkGvxwDPBCnLDXd4FPNx7EW7i0Gdj4IMHY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D443F80059;
	Fri,  9 Jul 2021 10:53:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3795BF80224; Fri,  9 Jul 2021 10:53:48 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D40D3F8012A
 for <alsa-devel@alsa-project.org>; Fri,  9 Jul 2021 10:53:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D40D3F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="i1W92Bd6"
Received: by mail-wm1-x32a.google.com with SMTP id
 t14-20020a05600c198eb029020c8aac53d4so24109259wmq.1
 for <alsa-devel@alsa-project.org>; Fri, 09 Jul 2021 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:message-id:date:user-agent:mime-version
 :content-transfer-encoding:content-language;
 bh=gq1gmd+zjXY9bMevbeK9OJpZMcDyOphwUReo6AtT860=;
 b=i1W92Bd6US3AMxiOchNhl9aPwqiT3eFIOsrn44fhuU8s/bANXS1CNFx0CjAd0ooCov
 kO3o8b5arHebeqc/sw0lTjXKuqrXlmtv0TqbBzg64NyAloDitpQ6EW81PFx99jtYag64
 NVTbazh/lZ+FnKKqz9ICuLk7ANqGGMSb4do+QeQKocO/vVNlIafFtP89jy3SYBzpiyUR
 UBoYo0CMkhJkrAJUjSQO2Foelv73VrlUkVPMHJ+zI2ND8xTSZV72vX8/FZrpxdjLNL6o
 MxZyowSbBAz4MIdIm424tH8W5gCzOnt3cepm6au5TPRuABGuDlKUdS5mGkSTOozFhvQF
 ncaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=gq1gmd+zjXY9bMevbeK9OJpZMcDyOphwUReo6AtT860=;
 b=ArMeyev1sQoybkbpJorOlJz3jEfqfzkKSm0Dzz4JgsMNax/UXBNJRzL+j6btl8m22S
 jusj4g8oDlzDN7JY9Ss7akHjTjx7q3nEvDVCoIJFU4rsuuCqgiSvjl7ozCJylxAMAp/v
 6wBZCU1m29JfhqnxHkxWHLqDUbh/SwGnkk83RAr8CZ+U6LY1FBL2xB5hKvlDBVfOTaYN
 1r1qfvuZBjoU5LEzw0u7qKunWkLUSUmetNneCgdOspQyMy62qKGlJ4HiSlifrjZfE6eP
 Cza3YvaapMGiGWHdiHXeED75uqzJYqQx1c2opGhbHP6AZGVeO+t93y3C9Gbi5UEpChqj
 Mg6A==
X-Gm-Message-State: AOAM533XsbZ/GGIU4fpan9e+F4bKw9bCKBtr92NumjSimic07+6qJGzq
 LO+Vjcs2SPkx/5PxkOMMCl4=
X-Google-Smtp-Source: ABdhPJx/wixioE+vAcWNJHeh45/kqpYsFVFMoFyVKkSHZ63blTafY+4P7vwLWr6i8k8RHnmFf0A0IA==
X-Received: by 2002:a05:600c:22cc:: with SMTP id
 12mr37101530wmg.182.1625820823495; 
 Fri, 09 Jul 2021 01:53:43 -0700 (PDT)
Received: from [192.168.11.11] (78.160.159.143.dyn.plus.net. [143.159.160.78])
 by smtp.googlemail.com with ESMTPSA id
 k5sm4538012wmk.11.2021.07.09.01.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jul 2021 01:53:43 -0700 (PDT)
From: Alan Young <consult.awy@gmail.com>
Subject: [PATCH] ALSA: core: Call substream ack() method upon compat mmap,
 commit
To: alsa-devel@alsa-project.org, tiwai@suse.de
Message-ID: <d786c278-c5df-7ab3-2d1c-e0bbc6e5300c@gmail.com>
Date: Fri, 9 Jul 2021 09:53:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
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

If a 32-bit application is being used with a 64-bit kernel and is using
the mmap mechanism to write data, then the SNDRV_PCM_IOCTL_SYNC_PTR
ioctl results in calling snd_pcm_ioctl_sync_ptr_compat(). Make this use
pcm_lib_apply_appl_ptr() so that the substream's ack() method, if
defined, is called.

The snd_pcm_sync_ptr() function, used in the 64-bit ioctl case, already
uses snd_pcm_ioctl_sync_ptr_compat().

Signed-off-by: Alan Young <consult.awy@gmail.com>
---
  sound/core/pcm_native.c | 11 ++++++++---
  1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 17a85f4815d5..91a749835ca1 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3057,9 +3057,14 @@ static int snd_pcm_ioctl_sync_ptr_compat(struct 
snd_pcm_substream *substream,
          boundary = 0x7fffffff;
      snd_pcm_stream_lock_irq(substream);
      /* FIXME: we should consider the boundary for the sync from app */
-    if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL))
-        control->appl_ptr = scontrol.appl_ptr;
-    else
+    if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL)) {
+        err = pcm_lib_apply_appl_ptr(substream,
+                scontrol.appl_ptr);
+        if (err < 0) {
+            snd_pcm_stream_unlock_irq(substream);
+            return err;
+        }
+    } else
          scontrol.appl_ptr = control->appl_ptr % boundary;
      if (!(sflags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
          control->avail_min = scontrol.avail_min;
-- 
2.31.1


