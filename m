Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A67CD8C89
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:48:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E415B601DF;
	Sun,  7 Jun 2026 19:48:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E415B601DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854538;
	bh=wpKaZKrWe013sifb0QNoDnl4CTs0LqjAAk1K8fio8S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FwlX8Wz6I/qLGzfU/uZZxc50cJqvJWC32YsqlJUtXjsgL3dQ22/BeXOatBjbYznJP
	 FEtrhmOzwhF77vLLYkaImgXBmq9TEESKa+0MIqhAHq1AJQqBaJPMW14+VTUl/j5qAM
	 +IEQSuEPLYGq9i0RHKcWVN2ZIM2WlHJcVUZxpcCc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23546F8070B; Sun,  7 Jun 2026 19:46:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC201F80707;
	Sun,  7 Jun 2026 19:46:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34819F805C5; Sun,  7 Jun 2026 04:56:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780800995;
	b=SF8KWzDv8/NKiQpXkvFQCxiKeAcl2iaPqrh2xGcMxYiw2/TTb8kS0wxv39OmeCj3fuAk
	 z+xkr9C06TmYa4rFt43Lf0tiyXKxwojdzxawlYMwufVcdqhJvsDIoI1LqQOPXbyDjLa/r
	 ph1LPjPwDjlpr4V6kOkaoBOpNlh21BWTzS5ElksCI0+IoUDAtZzBaRgln6Wv8UMc4PYpJ
	 zKrlZ5Xmk92v3htlEuTzoIZ/WQFPwnE5BSL8WFFZ5nVaT6OhbLsIuL33gHKf41MrbOz5F
	 kO724Y8yPcO1ll9tZTpL98zMprJbku6ZPL7oM0NAeHn4NKG7bTi/gKhz13TRimuPVSg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780800995;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wpKaZKrWe013sifb0QNoDnl4CTs0LqjAAk1K8fio8S0=;
	b=Rasoe/6fWCE9LwgC5+wj9wLTXrH8zw0mTgDZGEp8xVJuPImrtKQGhZSlx8TH6pVMhDBl
	 Qw1bOBTxkDdvX1THUfkAmb7WqjUwv4AqT2MLokvfIWpSMQyANu7fMMytL3BV4nEu0TZ38
	 cPh/KiKxkmUa0yfJpVDOppVRt61umvxsbAk4XP85ZL5pJv4vwr/1sGmm50OQEa+sbUv0W
	 R5r9xjCp530WfzxinC+aOVwpQT0ep1okiSoE/LiS1GVP/V8uJtG3n19pK66M//f6zR4MR
	 0/3jCLdaglIaXKB/xMVuYZOtnDz4StVn9UyUIiy7n/lsk4CwV40bg2+NlkeXt9KtS3A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=s61cKWdI;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A401EF8051D
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 04:56:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A401EF8051D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=s61cKWdI
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-84275887a3fso2665943b3a.1
        for <alsa-devel@alsa-project.org>;
 Sat, 06 Jun 2026 19:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780800993; x=1781405793;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuEYuS/RHcQ1IGpUO+X/TlJgzFLm8ttQziKlSNGRsH8=;
        b=s61cKWdIF3veMSnK0zyz19CsG/+H4QQl54N+zQ0dZQahPpcnazBK/4DWeUl056GP49
         tfz15oCFxRdAFMo2x6xg9YG83SinpMshzFyU6XO5xLoKcGjcmrqpRX0da2f8fo4ZknJI
         XarXsqaSxSCCZmReZHUEdt+Fxw3Km8CPERwjkRU4h8/deB7pOve70OLL0DjwMrkVhHbi
         +16CdL+DWtP9xSqAGBhCB+feJmZyngaEx8FbBQRPWjRjLssMynGD63XBy8T3okTeSgPK
         M3htKwTf9EfbZA0OPw59iMOrlhLXamFoLTsk0zLPeODXUHh1oyBvQ2JU7fHYfsHtzo65
         EnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780800993; x=1781405793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fuEYuS/RHcQ1IGpUO+X/TlJgzFLm8ttQziKlSNGRsH8=;
        b=Zz9CPixpSkKVT00ElseIYNXi/uoTTsSRO1FMaYxi/aVjhnI7YiO5zjBcbOKl0TYJNT
         Cnx3Zwu5nIn2lPTDC3vGbvpF6gUH7+SH+/nV9WSAkEhjEjoRqL1J8lUyhfXGb9+vPViR
         r/FzZOz1pN9pJ3fKTeQAkJpHNyXBwv7HFj3lIsUJbCs7VPm5EUmSRfNPFSqhA6OhjocW
         VsBbfxMPsilKRSg/k1Boz7WrA8vUH657soP/NVrJywUBhyCpRpRz4UTcT8Q+GkgvSOEW
         BJ7PFR58rr5n/GL+zhQVofVBjrZ4Vkjsvo7PYZ9oFVJ5q9DQXoOl12IYjRRyQQh+3MTh
         0/kQ==
X-Gm-Message-State: AOJu0YzcO359KQ6XSLHZYX8Ha+YtR4+UfWzraqSMghe+4YhSfDuAXoOM
	1iAWcBOqUcZhhE9WLPkTrJFVjLgkeqBcp0oPLTooV5aciPAJSVS5fado
X-Gm-Gg: Acq92OHf78wg3FKcl3ACTwv2ALnq+A2BkIPWS3ZzT3pEWLN/ccfX1uNBycjuOUbJq/U
	yivF2dhDOH3JOs0GqCGEBZGFvM2yK/5dN//UgWYwxe5Gdc4PEOHCmYAE6n6vaBIvY7lZwlmeu5G
	mQ1JDrAF2H1dSXGn+gayQnTpx7o+6stD1EWTCvZz1B1wL+ByDxY5kGJFrATPTNHNqPLmjCBjXdg
	awHc0iXOdL0kCxiuE0okZBqj6haAzPoKZI7aDk3ROTiUpl5VvNOyPO3azKaKWrDqlx7hKWoV/20
	O9QpmLPM0XVUFHyxF6ds9nKqcc+DLsFZj2D7lZTSSdMkKbzjEC6Tfd+J310oqNfFQ+NCgwg/0xq
	LHJ2ULx8FmnddamewRO2Gjg/che3di66/ZseaCAnFTpP057urbrcYL5cLcxKaXQifFQLULlioTI
	y68KqOp9kxo/Nagi2WiZxydLbFuP+PKt0JjrdKBXoQBni4VBlWAP3TTOAZBhDoUFNo
X-Received: by 2002:a05:6a00:a226:b0:842:1be8:f9d3 with SMTP id
 d2e1a72fcca58-842b68229e8mr7446642b3a.23.1780800992505;
        Sat, 06 Jun 2026 19:56:32 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282918b8csm13034210b3a.57.2026.06.06.19.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:56:32 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] ALSA: ice1724: check S/PDIF control allocations
Date: Sun,  7 Jun 2026 10:56:12 +0800
Message-ID: <20260607025613.3604194-8-ruoyuw560@gmail.com>
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
Message-ID-Hash: K2ADVO2SQLEFJW2JXQWCUJ7YQK7CZBGP
X-Message-ID-Hash: K2ADVO2SQLEFJW2JXQWCUJ7YQK7CZBGP
X-Mailman-Approved-At: Sun, 07 Jun 2026 17:46:23 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K2ADVO2SQLEFJW2JXQWCUJ7YQK7CZBGP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_vt1724_spdif_build_controls() creates S/PDIF controls and then sets
kctl->id.device before calling snd_ctl_add(). snd_ctl_new1() can return
NULL on allocation failure, so these device-id writes can dereference
NULL.

Check each live control allocation before using the returned pointer.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 sound/pci/ice1712/ice1724.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 65bf48647d089..b16c84983b81a 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2379,16 +2379,22 @@ static int snd_vt1724_spdif_build_controls(struct snd_ice1712 *ice)
 		return err;
 
 	kctl = snd_ctl_new1(&snd_vt1724_spdif_default, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_vt1724_spdif_maskc, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_vt1724_spdif_maskp, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
-- 
2.34.1

