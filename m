Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7ADC43458
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:31:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 726A260214;
	Tue,  7 Jul 2026 16:30:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 726A260214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783434661;
	bh=Z3RxoperNdBvFo/Z9szqMg8aNuRa881ymVxlMy0tiMY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HaN7URSpc2PMEDMI0ufxfSBqZnXrPBjCnyl4uoCATMhi+4IINnbg7bLWjAuRFLDYk
	 WQJ7ezr0VFkzFVo79fltw3gtJyCmIgZSVu/liAjohTlTo2sG+p+md/bZXV6Au9t1bK
	 /FYioMgs95YbbQqMi9FHMXoc141PyShq7GmCOvYE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4BFE6F80636; Tue,  7 Jul 2026 16:29:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B1F2DF80637;
	Tue,  7 Jul 2026 16:29:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E3CAF80524; Mon,  6 Jul 2026 23:18:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783372728;
	b=qIpxPVC1MxYx9w4Anp3Pm6Dz9t/c01yDGftTsG4hqgRX+Ig9ekJhEuK6Jc5LMiB7uzDZ
	 b2YI7+Jd6RAR7wyno8qxq3tLcX07XgGijbHzgHJfH4MZJooZAVvfTkamRpSccsBxKnd3e
	 2zmJTrYQ0S+Du799LXVPwA/zbyfm0nPuST7lPF0aTJqCpZp2HCOCJ7uZO+GPMRg1OOmd9
	 h+Q3t00ksQzYipme0Vliu0KGLgxzkDSYnpR/P/EUEdYERJPXdJC9XiltWfl47ssEJUq7h
	 TKUfDJi4yydhRZFjzdA5nJX1G1vuX7nlswBt9BBm4cqy1/AzDK45kQ22cGyB8vSrDNA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783372728;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Z3RxoperNdBvFo/Z9szqMg8aNuRa881ymVxlMy0tiMY=;
	b=d2ssT+95BaC1cxVaYhDdm05QBeK2j41ZTwaQdNsjbvtQamCbb1/CHIPhFpOOSXViUvby
	 YB0H8plZRtdWmn09ycCnmPi1nSm+Q/Q6WviWRpfxzAsSuva51NrKqAmA5WPtBBvpV+pSN
	 O19u4dFImcj7QQOCDMt3ARZzoFWS+hpCzg5dTS+V2SHU7XiMQL5bsMDkBs31hoqArUWjA
	 rboyNz8ejeRNr5W+dRRrWcaGfndz08naM2oag/yt35EcLd96zNoSJF/AjsrH7DSQlTc2l
	 weUjGRVizDmIAE658eENfmvZWOie9Uy4G4gNuB8vig7VWs5mDiiUMsfCMdj+/4q1rSA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=em6ASjHu;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 25F6BF801F7
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 23:18:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25F6BF801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=em6ASjHu
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-380a02c71e2so1355411a91.3
        for <alsa-devel@alsa-project.org>;
 Mon, 06 Jul 2026 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783372725; x=1783977525;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6CLy6k5pSwueaI0bt2iX3ENHsgJ1xutHqQ8jk7xDiEU=;
        b=em6ASjHuqukF1jfRBppqTza3q9AZT57bIzbqrWn3/oyn1R1wKPWXqCkvfupaG6BMqF
         GfB4sMp1cwX3juNIXjEbNH8490Mz3EGix8Sw57CoSM0EQtWymwKj6ORtOjIc+6GXFVEg
         hQCTD362HPSs9FEhT086YdDTCtiTy9JxnPVlt8lsWNsaNpaPKLBbifQHLM+zgFVwz5/u
         jcZtNWyoAlpjTgoKmKudm78wivMrwaksrx+eG7dnk7Hf1GdTa8EELerqRx7iG9e/1Wgg
         iBdxXKTC8nip0DiVGsW2CB6lhoYfYdhtZLIjYW/Cojw6tOBuqpBISXBhkAaPSYQcRNnI
         TYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783372725; x=1783977525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6CLy6k5pSwueaI0bt2iX3ENHsgJ1xutHqQ8jk7xDiEU=;
        b=PzdYuMTlAu9ZPSF5j3HfHLRnCDSr2C7rnjZwuuCNQXvH/8THulAN2dMg/NnRXHS4gc
         0FYxuMN9Kvp9mDkFpzi7r5weqFTJL70NLc67oLcjdNvR2Cgx/qg3bNlN/W+iOIB3zAuQ
         HynCW579bETplcWonLIEehc4gxT1NbcyngItVw3oJ3yDkcXRFIwzHbsJ5yuONsO1cn4S
         yfJPLtLnfUwCHRKEoydrNGTboI5tDROBUcOQopMizx0hRBilve8NXvejuIokapWZ6ItF
         ysk38gY5NPOQDBh6r3FIf09dyRIdHFlyHodf6RDkORuw9z3YBvW0rwBAxZFwBGyQtj0j
         7N1w==
X-Gm-Message-State: AOJu0YzczEvE0Or6uv5WDGQVqVhr7D0fiFOJ21XXjkPPceJu3K3HNu4R
	YVeuPqfVIGWKl616plVCo6Vx82UkWGMBlVfc+SkvZw3TAVDCNR/pLamwvDll2w==
X-Gm-Gg: AfdE7clDRVuBNeGm6ZzQj00Bmvvq+1zd1ejel5sPm559b4zwFBAdkL89xExxcFVjYLX
	BT0gl+N4ue+jMwNaLOn7Mj2JXu/0NbZwjxtwszRN5MfiFgvNsX8ELpQub/7CYYDeemR/DcjPTds
	AvGDrQ3he4tOqjR1WW2hIXOZ/VwqpDg0emLSOA/0lwoFU3VwXy6yjU2fg+q91llk1hgjm3bJW9a
	epee1bcgRE1syrZKp7TLZtnfYeilgsT0L3znrK3fPtm9RLOxU+jKT1Jaag2ptfoMb7mujLQSIj3
	tYGSRl8EU1q8XAaTjsPJBx0XZUaSWTECagoUUTqMYWJGphuc9h5xv1/C4xNBjudfOZjX+COljel
	mHKKKTryMImwP/haIaeJK9bDQt+VTpAo19J3mogeIZWuA4XQ+igVfd67Znr3vfrr6WvZWP5PNkK
	qSNPbRd+KVnJuVixh00DI=
X-Received: by 2002:a17:90b:3805:b0:37f:eac0:18f6 with SMTP id
 98e67ed59e1d1-3829fcdaa07mr8066792a91.8.1783372724609;
        Mon, 06 Jul 2026 14:18:44 -0700 (PDT)
Received: from cachyos-x8664 ([2a09:bac5:3e0e:1a8c::2a5:d])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f598dsm538790eec.6.2026.07.06.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:18:43 -0700 (PDT)
From: Rohit Sinha <rohitsinha12043@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	Rohit Sinha <rohitsinha12043@gmail.com>
Subject: [PATCH] ALSA: hda/realtek - Add quirk for HP Victus 15-fa0xxx (MB
 8A50)
Date: Tue,  7 Jul 2026 02:48:34 +0530
Message-ID: <20260706211834.384022-1-rohitsinha12043@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: rohitsinha12043@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PLN55UK5GDLPJUWW5WEVSYPUYTXLG7XV
X-Message-ID-Hash: PLN55UK5GDLPJUWW5WEVSYPUYTXLG7XV
X-Mailman-Approved-At: Tue, 07 Jul 2026 14:29:50 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PLN55UK5GDLPJUWW5WEVSYPUYTXLG7XV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The mute LED on HP Victus 15-fa0xxx (board ID 8A50) uses ALC245 but
requires a quirk to work. This patch enables the existing
ALC245_FIXUP_HP_MUTE_LED_COEFBIT quirk for the device.

Tested on my HP Victus 15-fa0xxx. The LED behaviour works as intended.

Signed-off-by: Rohit Sinha <rohitsinha12043@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 4a704e8ee9f1..d30042e06b2c 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7153,6 +7153,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a3d, "HP Victus 15-fb0xxx (MB 8A3D)", ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a4f, "HP Victus 15-fa0xxx (MB 8A4F)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8a50, "HP Victus 15-fa0xxx (MB 8A50)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x103c, 0x8a74, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a75, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
