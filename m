Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D032CD8C89
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:48:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B67E8601A0;
	Sun,  7 Jun 2026 19:47:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B67E8601A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854476;
	bh=yMliidOc4SYTz6EjHiB+7OyjASAJYmS6YxyC7Dm3wpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KcMZY/N4UcSOc9MvCn8ZFaTmeM+jVlWYDDGFtB/6T/Azp6n3V/WeS+IO53TMEZVCt
	 JHZ8EJ1IfYb2HdwbjbHUA4KoLHu11PLoTCN9EmdlqXtAKVMivc9OCg8ZIQjxuIgd4p
	 OblaJJRpfrfTVUz529UZRQVCUSYkwk9YvxJGvTk4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51A84F80683; Sun,  7 Jun 2026 19:46:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1910F8067D;
	Sun,  7 Jun 2026 19:46:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E6FCF8055A; Sun,  7 Jun 2026 04:56:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780800987;
	b=LtsjXN0WCvBaPsNMVJ5N1LMIOl1m9N7P0hNonLGHO3w2g54mJ3GDa+17lfXMPL2Jf5sJ
	 DerbT1/c/hVp+GfbmAN4eysbtMxcvijRqIGHiuRlxVoqjqzIgqp4dKJlMJKamBzVfw+/X
	 eqDXtQEne95O7wvHABWzYBHRc3sp1eP7O3nmzrCN92P/LeZ9PzZQFPl7vrbvZRe6M1sKi
	 H9TXOzSkTAmgBzm0ZcUAG7DvimziJ7G7eLFj+D5TMYCFO909q2LAf1/vsXbx6uUmWIZbo
	 6Nrh3+1YgqANf8xLhOAmOoPKqZxx9b9f47TIL079Tz2EJn611/uRpGQkTsktrGMX0RQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780800987;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yMliidOc4SYTz6EjHiB+7OyjASAJYmS6YxyC7Dm3wpM=;
	b=O31m1ubleo4tGE1uz3JneffmGKm08Amh8kTfvHvktqUDt1sq7PN682hykiA27hIBWYH2
	 QET7PUsyCnrvDyNQthBKAkR9LYgudm9PI+ueh4FIDIXqR2Ptm1U++rjsKcdD/mVoq6P1B
	 BFiBSPmK5vhR9gHaAzuqtN0qwygPyxXotg882R3rUjvXZq3H13gx3AFoWm8ZM0T8ViDfC
	 DxQuyDYtjT7yQww3oItsWMbc/8cbsDTj4IMVJUKtIKfUBj1ybBscVf5KVf15cig6OJ/RN
	 6VK+VK4bgvVpoxk539HnuCzZDxa1BRyLXQc5jCMY8oYB8Te94MTaQVfYZ4zmcSMVBEw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QdUL2dvM;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AFA32F8055B
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 04:56:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFA32F8055B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QdUL2dvM
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c85893bce34so1232098a12.1
        for <alsa-devel@alsa-project.org>;
 Sat, 06 Jun 2026 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780800984; x=1781405784;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6+J7iafV32jkmL+iFuv++231asfPIESh8re4lrLcCI=;
        b=QdUL2dvMcv3yfSBtnc/KUCHkz8sa0nvOYBpL1+GGkW9Z6kJSkY11PcpT4zOcnvjVtp
         jjXzFeE1RSfObAPqO0qb9ue/PV966FnSp6VDC8vKVQuJ2bT98yZExREqdoKr4IHeBJXD
         clD+25bHl5cDtGGJWx9BXcKlaJ8uowxmyUEtHKRg9EL2XFA/qI12UD3KoGiGsv4rdWzU
         eGwrY34ZI/aOfGtbJQZdh46BP55mi6F4bUgrqLYhdCUyu1wbPfXwgmEXCW+mOUd4o8Pt
         ovbpVhv0Wkhv5TifhyWmBxANOYqakHIQhFGEGoCHps5tXVrSay0zR7ksy0hX2lqQwjnP
         QYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780800984; x=1781405784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6+J7iafV32jkmL+iFuv++231asfPIESh8re4lrLcCI=;
        b=MCgERY5OWMDf7y4+h29zOm2zT6fCUCyg5mA7DOtNnDEAjVgVIxPLcXlfWx3DnQ7WJO
         dNZPVtRhGuWOnzB4lI89HLjqsEGeSS1f/e18NIZRBbwTTagOO7H//EP3o87VzXuZtlve
         HdWbrrcKkgfmEIbsaV8MkYXazFtGA9G7bX8SLwMg1EQj3+n0cbakwR7qNVia+v/yDmcC
         i3z7ez6Xk2W2F8GYQd52XdzHkqoy9dxHNTEriC88aeZDv4B6rRkrUIn56axQ4VHYD34U
         OBnl65CQ244dVmd6vhq5ww915IK5g9UEg5u7aNM4WgFhcztBE7Qvhnx7TKyWzdBEcPV+
         ziXw==
X-Gm-Message-State: AOJu0YxTCjm2APIHbwH7oLAYcp7kxVNC33kG+8VSPvmvgMM3XGBXvyPM
	pmnejr63PJS60JZUY7+n85mhTQnoi8xE4nvLkVh9JYysoM6x05R6b83M
X-Gm-Gg: Acq92OEmu9u1LGN/9KmLKFrihPly70FHViVkncJBwbt/+Jd4qDvfGkPqqgvpCb09m1j
	JvNmG697TvptTDKy34rY5ArA/KI0uPZB2rfZ69rv8OEG/ZzXVyLtG6IbAUVDYg55QBHOQ5/LplU
	4BcbMrr2hsedRS4okL4xQ0dQ4lxBzfUakP4pZUEGq/P6StOACUbVsPQSmWPFyfOnu9GYP8sqXYS
	5ITr91W2crhTxc28yuD8RjYJVg6dSLlSiCGUdqk0rHZzS3SF/9Uozu0Zyvc4O9pM3laMyaF+HNq
	bC/jpJLWEu2PUKsAO8W2jh1bwXXLE812/Liyk8/w/48BvYXmec+JSd4/WXnXn+uofu5uV+2qu5N
	JMZIyJVl0RvpUgpNkaO4LMoXsNGOWChhraEpm5/fJjiUsKbXRZT1E+1xP6V7H8EOdLL4TlQHZ9l
	Aee/4jWLIyA0koXUrqf/A1gfL7/kbzCL5lxyF2UqSukhtWjXuTRJTpG/DnGMqacuwx
X-Received: by 2002:a05:6a00:2351:b0:842:569d:b105 with SMTP id
 d2e1a72fcca58-842b0f8bd8bmr11031999b3a.34.1780800984332;
        Sat, 06 Jun 2026 19:56:24 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282918b8csm13034210b3a.57.2026.06.06.19.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:56:24 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] ALSA: cmipci: check S/PDIF control allocations
Date: Sun,  7 Jun 2026 10:56:08 +0800
Message-ID: <20260607025613.3604194-4-ruoyuw560@gmail.com>
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
Message-ID-Hash: IETZJSKRJE6BL33C6SMWQR56YZACYPUF
X-Message-ID-Hash: IETZJSKRJE6BL33C6SMWQR56YZACYPUF
X-Mailman-Approved-At: Sun, 07 Jun 2026 17:46:23 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IETZJSKRJE6BL33C6SMWQR56YZACYPUF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_cmipci_mixer_new() creates several S/PDIF controls and adjusts
kctl->id.device before adding each control to the card. If snd_ctl_new1()
returns NULL, the id update dereferences NULL before snd_ctl_add() can
reject the missing control.

Check each S/PDIF control allocation before setting the device id.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 sound/pci/cmipci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index cd73b68336394..ff4bfbf94b81b 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -2637,16 +2637,22 @@ static int snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_device)
 		}
 		if (cm->can_ac3_hw) {
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_default, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				return err;
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_mask, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				return err;
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_stream, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
-- 
2.34.1

