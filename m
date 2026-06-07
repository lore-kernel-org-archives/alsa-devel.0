Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CFBCD8C89
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:47:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07C49601F6;
	Sun,  7 Jun 2026 19:47:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07C49601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854454;
	bh=3FY6//6vtzqAsSgqvpCX2ErIfWKrgV1zgXUi9lFNflM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GQ//+0SSIFOPgprFk9Jicid2Cnqun9h2/fsgfnAwva3YNsXa4eQDv/iMYNgRwV9DS
	 zo39heKsZmH7uS4EHVrJn2hDC4BlJogkF4aCDICYH1W+SqcsYLHe98PnmWchQBvlIQ
	 S4sCD15pnNvYDilu/rbEukhOcP3mqnrGJNwEBjTM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A063F80642; Sun,  7 Jun 2026 19:46:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DA536F80634;
	Sun,  7 Jun 2026 19:46:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DDEEDF805C3; Sun,  7 Jun 2026 04:56:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780800985;
	b=iq4XWuY89c5fL54qoLGBKpRzwC2HZHeRll1EgOd7cHzOB59yXkb93jBk4BYBLbsTYnM7
	 SH/syFD0wYPgSrI//kYMungHrEhSKyYQpvm8AYZjfTO+c4K1/UFbKk/159qIcIjnJOgpV
	 hh2C9Jp6AWTt32PqZozksSZTlJBR+QCsKmKqrmrDK2UO+UjoNGQ1TJGobItxAOxhjqC1g
	 oU254ZqHp8EJ7eRjhoflz0wbClCpBkdXuXay9P/k8t2WdYIdA8JnaJi3A62wwi+hL8CAj
	 M+YRcRtW+TdV2yjyFAWyzYkGxVmylg2mD2j3arwG+7lKf3gS/64zNTJdgi1u5WIn8Gg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780800985;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3FY6//6vtzqAsSgqvpCX2ErIfWKrgV1zgXUi9lFNflM=;
	b=lWICjg1gDSOFS7ggacLP/6Y2n2obCO0+kgNEnCO2nSC7DUeaWGG83AzDx87aEZ6mxUPR
	 hzh/K4sMnrUAOhLl3Ohp6NsfFH4HX/DjasLXPg+XuduqZK612qbbcXhtjgpYIbTK0qDD+
	 Pe9BVfYtny0Hn9xBpw0TkbybgKUE3wg2rWPK7KaD4DHSsom1mVm05zz/nvQ/vnDv9Kqp6
	 eeI7EZEYjjnT8WTuR8T+PAV33dvURc1YKkG2Y0DRMQ7EAW0KMCriM17IXT0cpeAIW7GcV
	 pPZ54BZX0c4/3nx83PsA4CbQ1SYE4WbBxXemWfNo2t5AIXvTQmJVQ0iwS/XZTvg2MTA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=G2r+6cJ1;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3C8CFF80087
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 04:56:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C8CFF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=G2r+6cJ1
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84236f9b638so1409983b3a.2
        for <alsa-devel@alsa-project.org>;
 Sat, 06 Jun 2026 19:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780800982; x=1781405782;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RK1DXif8zlv9vjcnsmYHU0gqic48XFb34G5wZ3YmXvY=;
        b=G2r+6cJ1MTNZYYStHxHjC51YEZ7H6ptT7Ef2aKGtLEB1Y4Qr+QiJ1ZciN2jQMKr1gF
         V/mnn3gB1EApqEDlYUnA4LECDE/lwrUuxcvaXzjEhDAt/msWNCjvbsWcYPP1XQ+CzNid
         Re3SE4x8kXqjG+b1aYM7YmL45ibcOVhqCavwM56e1nMpzoLdDyh6HAvFGxFdqwcJ0Fz6
         rI9XAcDYJqBj0mJy5pyR9oyO+UfDLkXVfID18Cymi8Ewjdp+JWpvW3TyKDf57o7FX+sG
         Dje4E8kczG4FMQBrvWkFjip7i2ZhtN1qaFYUsee0jtsMcuiZ9rnkNZDY1YxPtfoRpJ3y
         8MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780800982; x=1781405782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RK1DXif8zlv9vjcnsmYHU0gqic48XFb34G5wZ3YmXvY=;
        b=ADmfvMWrEZBO/rSJv4vdoXrpGFHKDQcSdF45id0KyfkWnRiZVPv3rDRk98C0Ufrkf6
         s5DiqAjvLVOVrEBaF4nfwQmpV5fGWo2Arnt0vL5zvrsUTMWN0eu3RGwPGhu1oIPjfpJx
         h1tdqzTkACWwRjfbospgVWNlgPt3Gnz+Bk52H1qaS5V/vXBABuJneX8w5+Br9RNL/EKN
         hlP56UFhI/z5QJa1Afr309Bq2cMmifBj7S8aE2ygh++OZR69fomgjH0fxzAux4Nnet3j
         ziUom/xCxE4w+O/EJK8xefRGrQiSx06finThU+2xAPoy44inJFMCZ+wGzea3hE8cxL6b
         Qtlw==
X-Gm-Message-State: AOJu0YzDG3NHbwmqDQLjRhCEOb/YG7sR5iSJ5XGERZN8GoKusWE2U5Iw
	OKu2AWh4ax/mJqog8WiVNXN//+zfIZe0wlMisqYR4z3DsZwEg6OSYW9r
X-Gm-Gg: Acq92OEatcvEjzmxE1zjLsAY2NH+QnFNvknz/hU9WZwAlLLHPadqmP7uXg1yTFYzYAd
	bixkXt6SKLgjWFl7OPRzMz2ALGO1mgREUHKWEtZlxGrBY1MW80JTwt8bRNDtf9Er+CwlqTS7N8C
	N5k8WZCVKVHMtPXNhuvZVTaksgB3lC/WAHEsI8pEM7wIcMDkBlG0kbbKrxQ9bjhnOURzKNdtHWp
	zOb5h+bzF0myKVc2rYysN4hfXTwgX2yT8yl38RHU2MzHqTp4LUAtwIvQJDFhaLpPg16RFd15jSl
	HVKI2Zrolxa6dUCOEay8Z+a4P2qeW1onH3K9eoe+oAi/N9qhwm4xRlBCEahHj6wn3mZBK9VTOI7
	F/R2qV1UkPjOpCaGGc92V3oSje3ANbyPVyCfxu4NSlREuOoRfVON52HeiGabnXSgciVZgItOJbX
	aJ9fdx4fYbPxvya0IFHyAYDGtjH+Tb8baYfEPGvA/khsNIyohp96D1KYKIcFzpTR51
X-Received: by 2002:a05:6a00:bc93:b0:842:3ea1:5dd1 with SMTP id
 d2e1a72fcca58-842b0e65ae6mr10344606b3a.14.1780800982296;
        Sat, 06 Jun 2026 19:56:22 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282918b8csm13034210b3a.57.2026.06.06.19.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:56:22 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] ALSA: gus: check PCM volume control allocation
Date: Sun,  7 Jun 2026 10:56:07 +0800
Message-ID: <20260607025613.3604194-3-ruoyuw560@gmail.com>
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
Message-ID-Hash: VBWOIEU74KAHV5MM3OAEMR7KDP6N622T
X-Message-ID-Hash: VBWOIEU74KAHV5MM3OAEMR7KDP6N622T
X-Mailman-Approved-At: Sun, 07 Jun 2026 17:46:23 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VBWOIEU74KAHV5MM3OAEMR7KDP6N622T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_gf1_pcm_new() creates a PCM volume control and then updates
kctl->id.index before adding it to the card. snd_ctl_new1() can return
NULL on allocation failure, so the id update can dereference NULL before
snd_ctl_add() can handle the error.

Return -ENOMEM when the control allocation fails.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 sound/isa/gus/gus_pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index a0757e1ede465..08ccb4d80adeb 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -851,6 +851,8 @@ int snd_gf1_pcm_new(struct snd_gus_card *gus, int pcm_dev, int control_index)
 		kctl = snd_ctl_new1(&snd_gf1_pcm_volume_control1, gus);
 	else
 		kctl = snd_ctl_new1(&snd_gf1_pcm_volume_control, gus);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.index = control_index;
 	err = snd_ctl_add(card, kctl);
 	if (err < 0)
-- 
2.34.1

