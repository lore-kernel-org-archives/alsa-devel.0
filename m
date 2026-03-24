Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2956FEA835
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:58:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39558601C2;
	Wed, 25 Mar 2026 09:58:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39558601C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774429121;
	bh=cVVW2ha6HCIT46QsTAfIiwKEzYzXDEkzFSaX5xyMGIA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=NMkuOzSMKvGx2aJNURwednVKZPd281W9i1ZqvCUdwOm1vkzmGohNDmHFzYRkV/nNo
	 xsr8ktu31WgUOO6bpJKy/UNpDahZmDIwGBqlbb0ECeSIRDfzKRApIQCEOFjWa/KJfk
	 Y6OTpxdWmv1hw3Q2VA0gvdg8i2EybwzUx1HpOVjg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 264CCF805F3; Wed, 25 Mar 2026 09:57:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A09DFF805F3;
	Wed, 25 Mar 2026 09:57:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C117FF805BA; Tue, 24 Mar 2026 23:25:17 +0100 (CET)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D3DC0F800C1
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2026 23:25:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3DC0F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=c46QMp7R
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso1931057d50.2
        for <alsa-devel@alsa-project.org>;
 Tue, 24 Mar 2026 15:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774391114; cv=none;
        d=google.com; s=arc-20240605;
        b=lRyjCL0G3XWEHGfflJw9sLDvSjqTTYsvAplNv4mtLApniiO0V4zCrUF6CntZ01YhRf
         DuQGRksvKVn/ZVfdVEDAH8sGZOYfO5Wp5I+o+4RV21WC7JmErG9LL6geX/ezOaTbrdfx
         ASnI/IfvpFAcXWie+vBGm++e36t0eZ0EKtPZ8qGo8/wawnrGUfXB16H3jAOh7pRLsrRG
         9NH8v+xL1bLH3TxMCpWt8D4FVtp8LqHKSJxIWzTynPEeYmhfNsEYv81wsKd9HR0ZiTse
         thj2mDDNjwGPoHzVBhp7RTrUBotj2FE2DeMq0WOUsb5qKH8bLkpL8R8M7NZm+G9H5Nj9
         xH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hBubRKOxFa8+TUhQB9IiR2ogwU1UNo++A0f2JpOj1ds=;
        fh=G+wz6Nf3PYVi20xMdUXwsNj1VcA1xA7EXY94tHSufYE=;
        b=ALKQutk3TwauQ35+dxbaKA9pNY5FULJsG1jzIDZXUxqraUgruLsT8cJcNCuTOJ2LJU
         VNOHhMKhX4DWcxaD9iJgdrZNt/jkRQ6r94BjNsXzr98HA5nT6SXr5HTdqtcrf2f8OukQ
         mSFkkJQaQzr32zq3f+FQ3bpNp+929no4gGI7cjD48wr6ZRsr4HqRfxeILsskmk2Pu5XH
         wEf8SiGHN544eDq32xBcVE8Np/Rphi7i5QCFnloN/RTNPDbPU8sy1/mHylPRkO8B16vc
         m6Z6jpwWvmPbWB9P2EiAf6e6dXP34MoA15dckeB7ZI1tjsdPwNtB62fjc+xM8YFB+JS0
         vDsw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774391114; x=1774995914;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hBubRKOxFa8+TUhQB9IiR2ogwU1UNo++A0f2JpOj1ds=;
        b=c46QMp7RXJNT+5EWwyOWoXbFkwjMnoTxjSo3qmuM+YsQBfltr0q9RhCNSVW6y0bwcW
         G2pkVmTSQx2WNr39n/okdXXVE8Dn26gXYvDA/SZFHIDydaCQnm7ngiUnYTbwRCvsbem6
         ui7ZfxYjG5WHmy8+fgwzIqUyNfuNPxRzJBDBySNwoO6LdNoLEfOcJ9HIeBbmWBBHOlzo
         vBF7fVSDV6azwfbYupHQVP5UL2sXclCfarFg4lIOr1cUzFiAP9/NKr7yIykjnAWD6gLQ
         ocibVi5oOzCLBqHxrGZkuTsees7RYZoFV3KKj70w2JPdWc66aDb07g243Q36BUjRvru+
         +wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774391114; x=1774995914;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBubRKOxFa8+TUhQB9IiR2ogwU1UNo++A0f2JpOj1ds=;
        b=L4oAZDPn6qbLwMne+JWlE2aUPOqA49EFGQUis3VZOHH/JNa5eQxbuF6KN7C8Tc9Cny
         TUYgRjg2h8o8+B5wzGNppGGjrWSwvRKSE3Hwzjg9TrliccxuARV9b6C8v8rkKxf9CerB
         lTwrTaVz9VXsvx7WDRPOkg/HKzpfNVXmvmSaW/UjGWj4DwWAf+9sObIzl46UpAPhrPJ9
         Bk6qwzJymkHuVZulko6vAwCYwxrxY8ILLAPalBa5yuHnCS1a8dmsOkMucNLy3e7iTGhZ
         HKXTjVKdHvztZFlP4Bh+OoYFLwMWeDBJrjI70+OHjPZE6lwiiPiFtazrL7x9Crf5noAL
         XadQ==
X-Gm-Message-State: AOJu0YyjBB3njYUYMduDS6Rl9PgnpEobYbn26txoZ6zt0CzSrMynKGlL
	oJsdPPJRFjSVGVj/IkkjJsWwUk/lwp3ADMnC+U8uwEfRgYvPj9FtLcsNV7rkcKFSuqUnDxMMld6
	12jc3e93OX4CwuEybslhw8s3S0M+HAgWi00P0
X-Gm-Gg: ATEYQzzBeV0EqvooluXPWH+xctmb3KjJ5VRkwkjUClPo+B6JcrKqpk0lfWLrKmn1Vh1
	toQN0W5gL+2MGzxfGYz6QOt8BS5nvBcc4Sy3Rzx9Ic55NfV2LELP5xoY4EpSq1svtRwB4H1UOYe
	lpC4STF41/+flvP+zSI6mt1AnnHE5/1GsKQ5/7F5c7m5m2vRvLIaxn83ZfAOPHmT5lb56FuJ85J
	HsaI0MTCgevR/fBwhaXdad/HydDtk1AYcS7CA94C5gDnt8mLB1rqWP/jXc97UVGUqrjUk9G8zzK
	Nbh8gzNvmPzrc1a6QOcFGXCQgi5BuGFMho/ClqmYVw==
X-Received: by 2002:a05:690e:d50:b0:64e:db50:37fa with SMTP id
 956f58d0204a3-64ee61202ccmr1255436d50.47.1774391113892; Tue, 24 Mar 2026
 15:25:13 -0700 (PDT)
MIME-Version: 1.0
From: Dima Art <artdima93@gmail.com>
Date: Tue, 24 Mar 2026 22:25:03 +0000
X-Gm-Features: AaiRm51CLy4vtH5S4-6GasknCYNqe_7K8c1FGm-ZCj3NGZ-dWqwhIHUS6kiYQto
Message-ID: 
 <CACHgFRk+WSTAhhm4BbWwfqUMVCTJL4uTLK9+=8D6odKMq8BxAQ@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP Victus 15-fa2xxx
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: artdima93@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IJFHWSFUGX3D6MVYEXC75LJ4G3URSOGH
X-Message-ID-Hash: IJFHWSFUGX3D6MVYEXC75LJ4G3URSOGH
X-Mailman-Approved-At: Wed, 25 Mar 2026 08:57:37 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IJFHWSFUGX3D6MVYEXC75LJ4G3URSOGH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The HP Victus 15-fa2xxx (subsystem ID 103c:8dcd) uses two TAS2781
amplifiers connected via I2C bus at addresses 0x36 and 0x37.
Without this quirk, the amplifiers remain uninitialized causing
mono audio output with no bass.

Tested on HP Victus 15-fa2xxx (HP-VictusbyHPGamingLaptop15_fa2xxx--8DCD)
with kernel 6.19.0-9-generic on Ubuntu 26.04.

Signed-off-by: ardima93@gmail.com
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ alc269_fixup_tbl[] @@
+    SND_PCI_QUIRK(0x103c, 0x8dcd, "HP Victus 15-fa2xxx",
ALC245_FIXUP_TAS2781_I2C),
