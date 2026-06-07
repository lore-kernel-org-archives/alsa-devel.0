Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC2ECD8C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:48:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DDEA6021A;
	Sun,  7 Jun 2026 19:48:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DDEA6021A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854506;
	bh=h4D1p5n2M2aVtJ5FucynXrOgzWmf8Z0296oAicUsHO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VVgCJMKLldCbFXiyHRv4jE3icT/eATZfF/r8H/+sMoq7ZnVXdlo/Q2b2zqgWDfScT
	 kq4gZi/rz3M/BwFeSTgI5fxcLNIEDs96EMCVCKqIjbmb12Punu4vyBcJtUpoi95w0A
	 j5z1deylO8f1uRSShAEyyDRfb2GDzlpQiCP+C4ms=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED34DF806B8; Sun,  7 Jun 2026 19:46:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AA91F806C3;
	Sun,  7 Jun 2026 19:46:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B92FF80087; Sun,  7 Jun 2026 04:56:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780800991;
	b=nBaye2IKXA3d2DLUjIVKAivdlDgVEGhP4OshJN3by6URZ9klVnIDH31lVRcSOsFW2OMN
	 wSsLwhWwOaQdyWauLcHxYRS31kCOBQolbuOwuAkZp4iBjunmUQRsWi1h4BKZZN8Oa3QTw
	 f6x9wDR6JPXM7jCqzfrcppiS/rQoPmbrBSsShwpiABaetwV1Mi2+444HlJ1W+wfNtvCUA
	 mtAS20SK9G0EEZRLvKL+bmrYZkVVzd9SAbfuPZLkv/NYKiyeT4h7YjkL0DU8E107cz9Sj
	 SWIAyPH7XhiBg21gBrkfH3T95AanAFBXreNCkl3IE7ymxl6DnaGvkhzJeyBFVzcfJ/Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780800991;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=h4D1p5n2M2aVtJ5FucynXrOgzWmf8Z0296oAicUsHO8=;
	b=cx2IISZyr0/b/JLS4l3lJgqV92gOxN9xCPPurhqnBrwnitUMOd703kX4ZZ/+2aKk/jiS
	 o2X2Ryqwn5adKicbE/gQamX2LLHzmhcv3F90FtQ/Fpdet7Mz3L2H2ulP1z561Mh5lyioa
	 LuPIMXKXu4x7Len2QQCjFcIh3bTTO9Ets4723cwO5sKeUOkEDJQEOkLXvK8lIPDoWCnFf
	 D2NuCfAvwPCkzGRit43dW1LcdZk9VMVr2i+JqjPnZHELOwV/F0o/aKO6ZUzPPd9sEaeqc
	 Ocfuv9j9rT5cx1PSYDIMeZWhL/lkYvFrigGvlkoBZ47UGkBZ1dTQ+8TUwIh0vq8WNag==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VPegHkEq;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 664D9F8051D
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 04:56:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 664D9F8051D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VPegHkEq
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-842cd900ee0so245253b3a.2
        for <alsa-devel@alsa-project.org>;
 Sat, 06 Jun 2026 19:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780800988; x=1781405788;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNgrTQjhmrCkcd6OOoTKxY6nLRLb3JmG0yUB0AfnPpw=;
        b=VPegHkEqNHszkib5KoedVKyY3QFI0dlsd1M99dM6wCn3s9ixFv5/Gg9TicFWFubKAQ
         wiRbvghmmb7fSAZLVZjwwZtQFwG5fqdP4JZUqrL5cyCz7tVJMJMsEEaGwckM4cVYWC7v
         QK9L9zoUjT6ArVDvbPKqQrzNYCSgGIKkks1bugwB7XJNqu/XgAwX4Vv88OztDVuk1B8y
         Cm5D04pcde/9+chTGihCAJFrxQfC2KNhmSDShPFR7f0/Mi8RjNqARaUTLVWfwXdpcTBz
         xL7To5t63gtoYoypFPOBK8UB1dnDRm9ow8MbrabvIv0zg5UH/DhBsBYFbvk3EgB2RCFK
         cL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780800988; x=1781405788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sNgrTQjhmrCkcd6OOoTKxY6nLRLb3JmG0yUB0AfnPpw=;
        b=MfkUKXQHeS1ayc4wTwvce7S3unClcCprb9MvPQdP05T5ckpQsBFQGU8phgmWwdpVSX
         Ef+mFjuXgn7L4P2Bk1cDgWsoMzWIocZ1K+CrFIk3HaB8uzKLnUQ4asfMRU4ULY6LlRps
         6Syx27rBBZd/4zixMlNdUaa8+49rUaQo903tRSY5pyQFlTzdWWoWFXLQkpC86K3V4v+B
         kpekbhYQm8kS4kL1WaXyL1hUGMSHkJKaZVK9UpYxhIXblhRC0j96VArnPyrzWNLZ0S8b
         bElGYUVHSFz10MRRhnriGCZdAKXbP2LzeF1RurqHGXmepj4esTpr5vYp9/JVKk7BP35D
         IUiA==
X-Gm-Message-State: AOJu0YwL/kbYJB7yj0o5t5uhhWFLKH88Cuq08UOaEACPs1E62ZD3LC/K
	nI6LHX4cswKz/SIznZOISKWOvq7yfwgLq1PG47nVd84sFA3YOBVV8yBp
X-Gm-Gg: Acq92OHYQTTFt+m6Zbsav4evZoG6Z4Sa7tsnOMc1bEoUQ8bWIIeSR7keU1yipULw5C9
	hnH6GblwzPktIXO2VSfsDgOHzARn2/XKGj58WYkSRmzsGdpbjIVxIQA/VkR1ygK2iul5CpeNo+Q
	MOm6/cIcOY4L9xrnDpEwEYn4+Q9h07mk6fsK4/FHEOidDDRbI4rQu+u3tS9qrj2Z6PBRsiRTr1O
	6hDldd3zV12W6m2cYvMA+aE7I4JJy1SvyPIlxQ+6ghc0jrMFu4KbvPneYXDd8EQ9VDJCKZuUOUQ
	AWnG3BTCBQymVwK+U3X9cF2kRmD7n1ULbBEIXa/ieUJHP03vCoFib4Ux+4rGbSdXEpBHjbSM9IN
	V+l1OiHQsUcrgr3HmWbA4dhWtg2OxeRY3jAz64eRaX4aIORrYL/7wCgWaQ03TJ69Hs/RgMRFcky
	8AFnEYOxsDINVrkYzBsy1Afdo0yPE1YPfeTz8U1BVqydd91lZpAGlRyQ==
X-Received: by 2002:aa7:88c6:0:b0:841:dc85:1638 with SMTP id
 d2e1a72fcca58-842b1095767mr10394171b3a.42.1780800988402;
        Sat, 06 Jun 2026 19:56:28 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282918b8csm13034210b3a.57.2026.06.06.19.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:56:28 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] ALSA: ice1712: aureon: check CS8415 control allocation
Date: Sun,  7 Jun 2026 10:56:10 +0800
Message-ID: <20260607025613.3604194-6-ruoyuw560@gmail.com>
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
Message-ID-Hash: JQDNRJEMRWTU2QKRVCW5QRBRI42EALSL
X-Message-ID-Hash: JQDNRJEMRWTU2QKRVCW5QRBRI42EALSL
X-Mailman-Approved-At: Sun, 07 Jun 2026 17:46:23 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JQDNRJEMRWTU2QKRVCW5QRBRI42EALSL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

aureon_add_controls() creates CS8415 controls and, for later entries,
adjusts kctl->id.device before adding the control. snd_ctl_new1() can
return NULL, so the device-id update can dereference NULL before the
control core sees the pointer.

Return -ENOMEM when the control allocation fails.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 sound/pci/ice1712/aureon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/ice1712/aureon.c b/sound/pci/ice1712/aureon.c
index 1191a2686dfd2..d6abff2978f3d 100644
--- a/sound/pci/ice1712/aureon.c
+++ b/sound/pci/ice1712/aureon.c
@@ -1891,6 +1891,8 @@ static int aureon_add_controls(struct snd_ice1712 *ice)
 			for (i = 0; i < ARRAY_SIZE(cs8415_controls); i++) {
 				struct snd_kcontrol *kctl;
 				kctl = snd_ctl_new1(&cs8415_controls[i], ice);
+				if (!kctl)
+					return -ENOMEM;
 				if (i > 1)
 					kctl->id.device = ice->pcm->device;
 				err = snd_ctl_add(ice->card, kctl);
-- 
2.34.1

