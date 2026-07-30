Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C4BC55167
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:27:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 654BA60213;
	Fri, 31 Jul 2026 09:26:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 654BA60213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785482828;
	bh=W+yqcwq0zff+HAKrCQbRx8KF/mvjP0Kp/J1fb4ikRTU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=d0cPXDgHR9VWw3Zkf9ptqggzbftoZ4M8/qIoPs6/U4333omH037cw1P4QbFraeM2b
	 /gOtAcufHye16v3vh+SzYbOVrS1UWtBQ2636Hf9Cg6PqwdFNGGkKGeWy0TAj2i5uLG
	 8f7KiV0odYsoXIjHzOSITdcbREckCJTCSsSoPpn4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB5FCF8061E; Fri, 31 Jul 2026 09:26:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 116E2F8061D;
	Fri, 31 Jul 2026 09:26:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6F35F80496; Thu, 30 Jul 2026 06:20:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785385214;
	b=hKZuk32NqMMFoBXapaCYFbfuQ8HkB9TXtvB4MG9UQcdd1d96C0zeFR0F+zzEtUaPXYwP
	 niaEzq+VicT/JJrEQiWuR6OknvWk1016AjSfUbf0Pfm6IFApiLD3VTUCjD0fxDK/yidp9
	 DVCDn4U+QL5HEbUiGL2NFg1MkF4Wvs6uOJHpl+DNYconQVv2crtFqHjzz2DnxpXJC1hbx
	 QSr2TjXRcajOG9d+ejdhE1U63WdwpC2zKdyCC81bn3DLuN9eXH0t5kIhUJqDisEnxcuZv
	 zYJ+6Jh6DAfqN1PJCuYeQIGJn1frKa5z57dhfS02+woHyBogyjn+dZIv+C++irwvLAA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785385214;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=W+yqcwq0zff+HAKrCQbRx8KF/mvjP0Kp/J1fb4ikRTU=;
	b=H73RXIpmBWSC2eC7gH87i7hXGuu4H8QnBia0VdwT7AY478Dh2GuMQYVU+NaqTQjZnTh4
	 w3MaIfJ8jtxPXkYr8jiiiOaIe9+I9lHcxygyfCwU+7ECuQ9JNempA0C3hNQL++FWg/xk3
	 GKSFzBWvc1HiP1TcPPo/tLNnVWCpSD+RW/K6iRN3acyKxBNSv5b4xwLHAeTXIXLDerhXC
	 MX7i8uto7nr3JYbowdevIJk31dFKLzwW7AqMlaHW93+iU5G4AYb1JJDvPsAV+5uzWLZtx
	 xF9K37XotwWUPWtkE+gb5vvQhE3IAopSITfVF+keMF/vnY6syyIl7MNC46qptaa8eiQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gAlG2rCp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1D80F800FE
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2026 06:20:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1D80F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gAlG2rCp
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-37f9e2642deso184603a91.1
        for <alsa-devel@alsa-project.org>;
 Wed, 29 Jul 2026 21:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785385210; cv=none;
        d=google.com; s=arc-20260327;
        b=lnDUAM3dKOiyJBv4UmrL6k/dpAsXtthh742NADVfhwGbOV0xlZfYtso4hElFJ6Zv0w
         c0I0CUwse8GXwkUG9QlXpMHpQikg88eXtREc0EG1LEkuuf798uRRdq6tPcVErmPCXr/s
         gaUiotY/OmwCwAMb21DiYCvYi1RJm8g7CheN0qWfSFwMPjFAIVFhDa+iKMLOEu5e2UEJ
         +ZldXe0gTKEbXYD8y6t2MmmLOd1TwkrUFIT9cPC9XlCRFUQZ9jFxKY72Yg+pZDZoN7L4
         LY0bozkgJ2sgzyhJcqnOEBjR6i7ULyrBR7w1qPfW/kCw9PldELmMT+AWZlCQ2MPHofDY
         8jWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=azv2+HA7vkhRDpwslh4d7gUmm4xOpVdOQXO9Gfi01QQ=;
        fh=6CZO5OMxTItbgp7OxQjGlnZ5yXOzbBENbOICod2LA7I=;
        b=kC477/N/YLAZoumVD+t4h+aS6vsnwFRICEhzO39CIcL4nq6Swso+XXmkctR+w6Cpa2
         DZ+7PNe7FOyI2KxtmTf1WRsOBBi5zyYdkGUxNFcy1zCKjUGxc1p0ravJGVFIYRyzyzdu
         Zw16X0bV/KBw7EzKPhGF0pRSH5RBi6TSYNly3FK7XxjgwXD/wysfDKMOAFSDUJHojlxd
         2qaFzll6M0dvjXdtebOgrnuquxHt9+1mWePpFj+OxP16PZQqmRWk3cu7XCVfM/mku8+c
         y0azmoSYjkg1WIVfAkQlrSyf4/2s5bubKU/EN4y8OS9a+bcjHrxwCAdKYaL+7cAlLdKI
         5PJQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785385210; x=1785990010;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=azv2+HA7vkhRDpwslh4d7gUmm4xOpVdOQXO9Gfi01QQ=;
        b=gAlG2rCpRofRyAZgAmKzZ9gbOHo8y+nHIOVeNC3ShKi3QW5W1VLayEf8CXEUorESs9
         rz3CjGM94jKX6DGwBd0IxQwEfHtydwgaw/4aN+R4ol6lgLGptmHpmauyTVDi9hFBatji
         D8d0MHFOMX5XBHldJKUxj26+TgaRH8i+RYljnyzsrk2sr1hhGGXWmhZTqXWKZGlEdPN6
         X/vXMsCD/7jr9acJPp9AG4GFvG2rLlHTQWtM63vDwu83/7br/2tMn2Ib/oDsk8kSphDC
         Tv7tLos1QSMzR3kkbRGlEfL/D01VqYreA8zu2IjsDdBKDHsNwC3+RGX5wO3jr9r8I0ht
         qxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785385210; x=1785990010;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=azv2+HA7vkhRDpwslh4d7gUmm4xOpVdOQXO9Gfi01QQ=;
        b=UN0joOp+64YgLyxHsRf7fNJLdYUB8BLs4aaUAHHIE6So77h6pYiepe8j7rTzRV9U1l
         c+yV3lNwBhkbSr/Cfsksmgz5wawa02kfsDOGF+Veu2ZFYFS5gnOCgz9WyNxBWDBy2M0x
         7RBIOLSiXrnQGTdjfKzU+ANQVK526QMZcs8Rw6CcYDbShRtlY+ICLg8yyskWn43FN0KR
         D3msXMbjmTMH6UtdT8ZUxhMOYNXF+gz3t1TVgwDvDmurwC7cEBPuTXyhKp+pyrb/htRR
         PvkL2KjhlV1/I9AaHPDNqwFbgXctiqKTvNncpr1XzwhY9QQZh3zx0X85jb0RGp9U9b8M
         /YHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXF+/CkXYmSd/GbTIVPq4qdDGo37Ix+MJdQdUuqBthxAHpbfSgDu2oVYQTTMXDbMDjEJJA22UuC459@alsa-project.org
X-Gm-Message-State: AOJu0YwDV/WizlZV7OG2R69kX0CVmjmEH3hazK/fKfWNPlpbvj/EBsT/
	ISWBCdnRJ3JXPA5NRj2YoSuO/arC83LDy569fY2+XdtFBgVzipfCQ6aU5vZVpsuMgEpUXaPzxEN
	k9w4XIr6RGql2T6n4rWhsTl94aZFEdAc=
X-Gm-Gg: AR+sD1058VOeFAPALxZ4SbtgKYe2YCUl2ZJaPlZjx9R2uCBbbwZ6BM+tjY64lXaVaLe
	li+p608fw8+ruLEi9T4VTSdaN73SdBSLb9O5rIYW5LyG8xarYv1C+Re7lqJ/LcFOFrtbXGCZ5O2
	ko8++IM7MIrH8ItBdOLhpp5xIm+3KnwPYmswHXTP1sKWs7ffEvHeJz5tDdK8DvdFvZc7dqi4aCA
	BX1yQzmFdNY6IIth4O12ptMVeip5pP2b/OiALGFxk2Siu1eOWg9+45jKUN0uJAOMTf9LSMnpc1a
	1bz782TyKWOplCYHD6vp+tPl3ykNxukKItp3/pNkdpDd
X-Received: by 2002:a17:90b:2e04:b0:38e:55ec:e436 with SMTP id
 98e67ed59e1d1-38f9bb23ecdmr1365956a91.0.1785385209772; Wed, 29 Jul 2026
 21:20:09 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 29 Jul 2026 21:20:09 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 29 Jul 2026 21:18:16 -0700
MIME-Version: 1.0
From: =?UTF-8?B?67mb64KY64qU7Zmp7IaM?= <safenine@gmail.com>
Date: Wed, 29 Jul 2026 21:20:09 -0700
X-Gm-Features: AUfX_my_2cSJP_W0LxyEvwFDN5YpJmJ7RkwiALrPM0irGvGVciJFCjmk9aUmTgg
Message-ID: 
 <CAJ79ZrGy5F0LwQ=xZBmZi+MnTybiATPg2FGbS-7NaMWvb_6syQ@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for LG Gram 17ZD90R-EX79K
To: tiwai@suse.de
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: safenine@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: QLD7UU2SBAI5DDUT2CLEJHOF2W7XM2GL
X-Message-ID-Hash: QLD7UU2SBAI5DDUT2CLEJHOF2W7XM2GL
X-Mailman-Approved-At: Fri, 31 Jul 2026 07:26:11 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QLD7UU2SBAI5DDUT2CLEJHOF2W7XM2GL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jabong Koo <safenine@gmail.com>

The internal speakers on the LG Gram 17ZD90R-EX79K remain silent,
while headphone output works normally.

The machine uses a Realtek ALC298 codec with PCI subsystem ID
1854:048b. Existing LG Gram subsystem IDs 1854:0488, 1854:0489 and
1854:048a use ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS, but 1854:048b is
missing from the quirk table.

Add the matching quirk for subsystem ID 1854:048b.

Tested successfully on Ubuntu HWE kernels 6.17.0-41-generic and
7.0.0-28-generic.

Signed-off-by: Jabong Koo <safenine@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c
b/sound/hda/codecs/realtek/alc269.c
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7752,6 +7752,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1854, 0x0488, "LG gram 16 (16Z90R)",
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x1854, 0x0489, "LG gram 16 (16Z90R-A)",
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x1854, 0x048a, "LG gram 17 (17ZD90R)",
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
+	SND_PCI_QUIRK(0x1854, 0x048b, "LG gram 17 (17ZD90R-EX79K)",
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x1854, 0x05bf, "LG gram 17ZD90S",
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x1854, 0x05c0, "LG gram 16Z90S",
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x1854, 0x05c1, "LG gram 14Z90S",
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
-- 
2.43.0
