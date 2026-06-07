Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C19ECD8C89
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:47:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A971C601D3;
	Sun,  7 Jun 2026 19:47:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A971C601D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854438;
	bh=5FNcs3NDeL/k1dkL9t4e6Eufvj+YEVBpECCujAHf7wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jNHKZJgwu6D2RRsbQo/0F25TANkoLV1bEDKJ49xxPyJmkO8uYF81oA8LmFsfHVHiK
	 Qv3urYxkAOQkiSHsTOJsjzDgItASuM/ISJE4EQxsCetYuOqshvTAC/RlOCpIRLAbD5
	 CcRTPL5zGWnlb2M+/4edq9PFNfxn6mQU/H+2ihe0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24344F8061A; Sun,  7 Jun 2026 19:46:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BA77DF8061F;
	Sun,  7 Jun 2026 19:46:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49EBBF80589; Sun,  7 Jun 2026 04:56:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780800983;
	b=IT3nzKAcEFbHHvzLpm1fbC+JtSNiVcaiI9BsxyySfpqcGbRu3+eN+xIUz5zPvy/U79vZ
	 JS/Unm40fJTWqWHH67SO4OuUJNtyN0FYZ3lw41qutdpJfTANfvFH7hYoncnyF2XuTAjuN
	 Mw280uwxTKwqKsOlLKg2MGJB55bFhWKgzC4+6T+MlDVnrLqEAH76CEL7wCMwvIzCiBoQP
	 wEZZ6GT+dxqiJI2EVwP0g36weiUDX5npf2FrpthWbv6ibYMVSYwER/GhpaMATj9qkomQb
	 dj87Ww8ZrzUtEphnyeagonVvNIY8VRPcETrMjRzCHEbJnbTp1p2qDcJco539IUxHYCA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780800983;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5FNcs3NDeL/k1dkL9t4e6Eufvj+YEVBpECCujAHf7wI=;
	b=DqCAdve9bg+Jkovbtb/9gbO2cWU0QlAuibROFE8Nl/mOt5NJU9LOyblyNGo83ESck9Pl
	 WJjlVrLrOSe0vAHvhrdldzNQgK5Cbb94lkQoacOW96JBa04QcQYcjhl0t/reNGOVbywrw
	 M4WuhNNSCgKXgyBHVEWVtnXBR8db5XoCcaut1Liu5KbS6qyoPMl6fin2759dnMhx9UXI6
	 FkGqyBTEc+yf4VKVLgX92sA/wz1+9VEItNNo0Yr1KP2C1UxIqAa0lymUFoA3JaLy5Aw8+
	 BCHrPdD8FyAJucf/6QtHrm1n0CLLE0yrAZikFgR/fn1hnZopnYDS7+D6PhotiKEZV7g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RBRGJeIL;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4EF1FF80087
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 04:56:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4EF1FF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RBRGJeIL
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-842338c18e0so2280110b3a.1
        for <alsa-devel@alsa-project.org>;
 Sat, 06 Jun 2026 19:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780800980; x=1781405780;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zsXRaOf5IDmLbzd8Q02XPNAH+WfbkuUGmBr77tfIe4=;
        b=RBRGJeILYPcRSHRIWyDCjzbif23KCsAN6hl152smpiGxpaVoCRNZjKE5m1p6rd3Xlm
         phiuSCoi7FYzZF3gSn8C7IT5zmO8f28V6mnjv270NmL0SLaVjPcyxkS8pxh42/PGWa1M
         zIzGrZaS3DmUP5fpnyeaQazGs1+G4GKjJSTXhPdU5I7OZnlKX4V7Wcr1LTNmClKx4OgX
         u+F8iTOAqvA2H5xYnQPHAV18VlGmsz3LzU6cECFpv5ENVY/oKSVVtDn0mwgDEPqSl3ay
         mauL4JZpW/n6+kVvWoiYP8LjNh8Qj3ZckaZ4J8n5Y/2i5ctyhQGoCo46Eaud3976nqI+
         mZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780800980; x=1781405780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1zsXRaOf5IDmLbzd8Q02XPNAH+WfbkuUGmBr77tfIe4=;
        b=qsCvOqoYwl5yBcXdeG8eXaL1/RkWl1z4veCrUGQRqvVewnMbmatBfWcvJ9Q5+qVMDo
         xb2JMdq5A+gg5w+K2m8fUXT0wgXug09H+2Lt7Dvn4GJhl38ukl8xW68628JytjZyCJkH
         Hs3Q8FkLZuP0wQJ22AjA1xnqCroIUGShhLZV80vAikpDXXIvfo9zvWsT/bNTEw57FbtK
         1ZV2pRKwt7ViJM2lBYivdIIsFhj8WmjNs1Sq4eHNT2CfYauMQutclk74V7jgsCQATLVT
         NRXhWjfF8Fd+zKDjT4uoiZoLY3w3M8BhmMDFxnA2T+yOcSkcx2yiKq+tmEYWkIPn7e7V
         0vVw==
X-Gm-Message-State: AOJu0Yzed33gxZx6Qdyv0BlnmKTtrtd7Bt3UMO2nAALOmQWYiIqpSKTz
	q5PYo4igtkNI2OZ60QnkBKOIRYnYcTZGMt5urrlOS9QjGvNdj3itS6II
X-Gm-Gg: Acq92OGToulNZ6Ovyytied7Y751qHOPy2cHUDhII43xAoihUgxudrMgeNp9uiJN4qfB
	S3tF9AVgGNmzAR0Ro79Ljt4q9+MdRmYgBHj5V1Mc3QeonH9DL3yBfrX0mrpK7+5/V9i2Blmsz37
	SVWZ6UBxRdoyomKhdp6Q+NIIY4SfcfvLOzF4cZ8e7Nr7FVhUCaSdIiCRLxIt694dPAkgitYaCmk
	GuUUmVTT4zFWYwCyGMEhR9A6muJN6LD9zOSrVaLTZI8uBNIF8bU0I6kpqiYrN0GqPJUrMDyS9sZ
	TIJKrzeMvWjGUgI+5810CkWBuqyMuw6uY7YSAzb1vXCn0cH5S5NbLrKL3KALZVf4GwCxY85X92g
	S2NRjRdOat1Z9TJ3ws1JPrYMWUHtSxR1WYOZRrt7sJA8JuKNjkhonKKguzcLqw5W0vRdc3clo5G
	AEagZOpMZRcfsD7sv5aTUIJcrUdRyx8v/NnagHwGCg2dd1qLYYF8PW5dFw51GC1nZa
X-Received: by 2002:a05:6a00:9093:b0:827:3d52:5d1a with SMTP id
 d2e1a72fcca58-842b0a880f2mr10018534b3a.0.1780800980283;
        Sat, 06 Jun 2026 19:56:20 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282918b8csm13034210b3a.57.2026.06.06.19.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:56:20 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] ALSA: es18xx: check control allocation before private data
 setup
Date: Sun,  7 Jun 2026 10:56:06 +0800
Message-ID: <20260607025613.3604194-2-ruoyuw560@gmail.com>
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
Message-ID-Hash: W3NACYONAQLIPWLWS6D2LU4HQF5OWSPR
X-Message-ID-Hash: W3NACYONAQLIPWLWS6D2LU4HQF5OWSPR
X-Mailman-Approved-At: Sun, 07 Jun 2026 17:46:23 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W3NACYONAQLIPWLWS6D2LU4HQF5OWSPR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_es18xx_mixer() creates controls with snd_ctl_new1() and then stores
hardware-volume bookkeeping in the returned control before calling
snd_ctl_add(). snd_ctl_new1() can return NULL on allocation failure, so
those private_free writes can dereference NULL before snd_ctl_add() gets a
chance to reject the missing control.

Check the returned control pointers before using them and return -ENOMEM
on allocation failure.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 sound/isa/es18xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 1da7b400a17b6..2f454f7797ce2 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1762,6 +1762,8 @@ static int snd_es18xx_mixer(struct snd_card *card)
 	for (idx = 0; idx < ARRAY_SIZE(snd_es18xx_base_controls); idx++) {
 		struct snd_kcontrol *kctl;
 		kctl = snd_ctl_new1(&snd_es18xx_base_controls[idx], chip);
+		if (!kctl)
+			return -ENOMEM;
 		if (chip->caps & ES18XX_HWV) {
 			switch (idx) {
 			case 0:
@@ -1823,6 +1825,8 @@ static int snd_es18xx_mixer(struct snd_card *card)
 		for (idx = 0; idx < ARRAY_SIZE(snd_es18xx_hw_volume_controls); idx++) {
 			struct snd_kcontrol *kctl;
 			kctl = snd_ctl_new1(&snd_es18xx_hw_volume_controls[idx], chip);
+			if (!kctl)
+				return -ENOMEM;
 			if (idx == 0)
 				chip->hw_volume = kctl;
 			else
-- 
2.34.1

