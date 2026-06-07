Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ADACD8C89
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:48:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 566B760218;
	Sun,  7 Jun 2026 19:48:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 566B760218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854526;
	bh=k7NdeuAQWcfjZE0LHweTpNpdLyKKvH3vhpStX+9uyvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nu0bX7z8M8LUwBmY133vpleg6tEXsZx6q4q9yZW4UryrbheYpmBF8CYpPpXrCG+gx
	 93ycyBWKG0+0ghmEObNlVtWcG2DSwbJbO3NDtIbB9gG85YGtjzxJ99JQQg3bepZQn3
	 bqdA0DS6afQtn5FefJKVPqKQ0qMvGnL/fIsvVA7g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6282F806DA; Sun,  7 Jun 2026 19:46:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 690D6F806DA;
	Sun,  7 Jun 2026 19:46:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3525F805BD; Sun,  7 Jun 2026 04:56:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780800993;
	b=PeWH4e+I4l0ZLkFA8nR4mic7GLwSeRX8Lu9ZU0Y2HlZ5c0EiqtChc3oyur2WPGQD17U1
	 PHqQwkxcFXWZXIY2EgSRsfsaAlXXAz9SMgcmkdGNuuxZ34L9g0fetBHQ49MvRuaV1BAXX
	 LVm1wTRA3+8GeC7moF9j6Js0wLoMDW22Zx4Q5wB1aMqx/JI/s+guFa8H54jOivVvwTIyt
	 SBSF0DCaQn1DGAXpCZtzQEN9y9Gl6xi/RgRTmw28EPoT65K5NvyO7moAQSi6xe5qz9/G/
	 jlwZJm5P2IdgXMK0zvJujVCUO6VV2Y273LPsILkVoLyqySIXHFFFdGWS7cOE5QqvQpQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780800993;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=k7NdeuAQWcfjZE0LHweTpNpdLyKKvH3vhpStX+9uyvc=;
	b=DGmU0l2SolSjuoJ0gwVSQ0yoqFId49bpYaBXFM5RCUxsUOOrEziFzOut8tThLZ1GZ3z9
	 oKxdQzG7n5bPviqPrLWx4fquZEivJgP5jskXnA68YV2OyjCr2VlFEgWnFUprDENhWoQIJ
	 nTvMqWnYuoBOMB5nwWM3+7Kz4MFhCPqtrxFFXoGYRoJGGUXrHrZbwDJmFJP5vWzuxGKHa
	 s7bQZfg9B5WxSE4BU9nTeruxBlFJAy7FeijqTC6DCKgbdKJEhEGy/JgnDChSLFAiQAj83
	 rVfTSxbGMm2BFTSlAapsN5twH095qhZpeTrYUnXHG2tC2Zg5N2OQcsszncDrnOLAVDA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZTPCLUIN;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 35E51F8051D
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 04:56:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35E51F8051D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZTPCLUIN
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8421f0e9c5bso1393222b3a.3
        for <alsa-devel@alsa-project.org>;
 Sat, 06 Jun 2026 19:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780800990; x=1781405790;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XVvrCmwCCXXTu+yhPQlmdSChdplym7xShaJO8RVAac=;
        b=ZTPCLUINLMYLS3heZ+Sy825waHZfkzVGS5Xm5qDRvjc7AGuwG7ZTT8yJ4Mv8EyaCjL
         Aw5lKTqE86vtDIT+MTtVxoTjqMW0fwLzIpFfcz0h+KCsuz4nLyl7ikJr6Emj8vsoYpBL
         s0ry0OSZor3oHCN1oUpjSWBdXgVoOMUdYC+TQtzX0GLzCj0nA7/1pQwG1Jt362MQopex
         5TjyciRev1otJIidh5eGwdmLzUQ4u00/3KVx2UvRU5UKSKpVXM8JiZOwQaszBHm5sagu
         LSzklJcGJMAIEvqI60+6hA6qdlE3in8DpQN+0P6IzNHbnQVUtOVqGR8PzSltKICwI50d
         zTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780800990; x=1781405790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/XVvrCmwCCXXTu+yhPQlmdSChdplym7xShaJO8RVAac=;
        b=aYfexvc8xUD+m8JhzGK0ipoP3mSU9ZJ8kJYRlGhU5/dIwTC3pkrRK3zujxTSbv3XiW
         dpNJoKdHwRWEdE92nxLjlwHI+IVlkXNvDWHzk3BoH4UkCUjECPKlCY+cQHIw7KlvPyVy
         2uoOLZMn6v8WHxLlr08QiH+rC2HjpmmA5B4cVP2ColY7ZvB4xMsS1eFSKOcAPppAyRpg
         SROI/4olFGucMXgFSm1WaaRe8BebID9M90O3ZRcdVolqUvlu3qF/YQSZqdGyIPFuMWuQ
         Dgpbxu2B4JvnTHSlbPxCWCMX8l8FrS5INm7wozsQE0/1mvrynWZOWm2qL5bq0lTJMDl6
         /NbA==
X-Gm-Message-State: AOJu0YzYpz9XkQ6ySyD8njc3f3GN9Q8gW+nRcfdu1fuTRJa+ZaR9crH6
	8UM48woetmdOeKcWojF3qjhdD83p3WKP8qXVLLYZ6z09JgTfCO69pSrK
X-Gm-Gg: Acq92OGdvK0Ds6RF/NAfCBVNeQkSiFUzmwwPrGTqE0m+Q5YKKSrvhV6tZ+nN/r4BlQo
	JQfkMdZ23yvlJ2IH3MmpoSkhwP/XRIGDKLoLHz0dyt8h3FQGDHXnZcO8P3K0CbzF0btwll/Clwx
	nDToYWVNSq+nG1rhEi1dCSYDYW2bG1ceD9oqP5cFPCVyGgvP79REvoQxSWupyvKv3UyboLwoF7J
	t6n9DXfHsJi4NfhUMgbAM8Z2WkfxvKQs4x98SfuSdt4K9gXU85ky2WCO+FMfflOscXkaiE/YkGC
	PX++ZboUW+q4GuohauhTnApYoVGEgUszO3QjZ9yXoryUi0OQJvjrNsgqPlDdekVA58BGqmURVFi
	cavb9CAyCTAq6M0xed7HKUf2WPLCqEotwiLj5yv8036wuOIv/sD/dtymqk74D8nkrLq70sGf0jS
	jK79QDUTW2DyjR18cWLW5lF/hT6dxWeQutB7VYdW3tTLJxyj0iXNiUk7iifqrHw4AB
X-Received: by 2002:a05:6a00:4b55:b0:842:4469:9202 with SMTP id
 d2e1a72fcca58-842b0e521c4mr10004582b3a.12.1780800990461;
        Sat, 06 Jun 2026 19:56:30 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282918b8csm13034210b3a.57.2026.06.06.19.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:56:30 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] ALSA: ice1712: check pro S/PDIF control allocations
Date: Sun,  7 Jun 2026 10:56:11 +0800
Message-ID: <20260607025613.3604194-7-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260607025613.3604194-1-ruoyuw560@gmail.com>
References: <20260607025613.3604194-1-ruoyuw560@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: ruoyuw560@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 434CFQXGGSYJHBVP2O3MSHTSI46XF5AJ
X-Message-ID-Hash: 434CFQXGGSYJHBVP2O3MSHTSI46XF5AJ
X-Mailman-Approved-At: Sun, 07 Jun 2026 17:46:23 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/434CFQXGGSYJHBVP2O3MSHTSI46XF5AJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_ice1712_spdif_build_controls() creates pro S/PDIF controls and then
sets kctl->id.device before calling snd_ctl_add(). snd_ctl_new1() can
return NULL on allocation failure, making the device-id write a NULL
pointer dereference.

Check each control allocation before using the returned pointer.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 sound/pci/ice1712/ice1712.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 1e39b985bef26..4cec56769c0f6 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2346,21 +2346,29 @@ int snd_ice1712_spdif_build_controls(struct snd_ice1712 *ice)
 	if (snd_BUG_ON(!ice->pcm_pro))
 		return -EIO;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_default, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_maskc, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_maskp, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_stream, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
-- 
2.34.1

