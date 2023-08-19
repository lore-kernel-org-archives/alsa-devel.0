Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334DFEE4993
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Aug 2023 11:15:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46B5C84A;
	Mon, 21 Aug 2023 13:14:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46B5C84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692616520;
	bh=LGz2FcocDvhOKlUY4JP8PPna6u7bJbm6hCMGI1SG12I=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=LA3KFRSj2ph4rPG7+dTE3soDEGtaIUS4fA+thzPFS5TCheD7I7P18Yo/eo1dg6zz+
	 o/+YoyjOZ51zWWPzbp0GnR6LOGunMOdzuIGEs1nQWipNdE8Eqt7sC86fxPFE+uRP3x
	 PokL5+47GHuBKaKkHeJevPOESHWZA3KBSIAbrxQk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C244F805F9; Mon, 21 Aug 2023 13:11:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 958A7F805F7;
	Mon, 21 Aug 2023 13:11:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89C56F801EB; Sat, 19 Aug 2023 12:19:12 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 328D1F8016A
	for <alsa-devel@alsa-project.org>; Sat, 19 Aug 2023 12:19:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 328D1F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=SLFEh3RR
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fe85fd3d27so2725270e87.0
        for <alsa-devel@alsa-project.org>;
 Sat, 19 Aug 2023 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692440340; x=1693045140;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Ay2n2Z0MF3oR/B7emCwNMj1iVoT61lmY5foMH4tZYM=;
        b=SLFEh3RRa43i+YZJjJTE6ttMJl9FF+QHg0OzCKHpdeuezv24lF66xLrykgBJfABIwz
         rads8ZOdmFNDFBAFFIaXwQyqNMnImNsZkleQVMChqM6X0/Cg0gcbjugZdnmMnSdT+4X3
         Kksaw1gE8XjWkjdfOWDE19CHOv4BcRKeuhs0oQ3N/cfsBGiu2PkRs4xfcU0siirWXzJm
         xZlsOKm4fCdSn5QUi1vy7BnaMrk3L6Qm9POm0tell8TSkUgiHlBtWCozkOeX7Qu0UoIq
         5K+PAYXJC1vxW6KeQMgo/VD5WJ+UJ6adTpM5r4uU9kG2gPT5haBbzWhaGZbU+THQzj6M
         gRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692440340; x=1693045140;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ay2n2Z0MF3oR/B7emCwNMj1iVoT61lmY5foMH4tZYM=;
        b=kW0X/If7SwH4ZR9CbKbiWIO2y/JmmTJTzeW51PY5Nhkuh+kg8RAL1Dqmq8ioYsmmv0
         DPWgnXM9XSoA8EKZEh+MCaDnWiYpObojBv2cO6Nk3iQ1QNiq4+Q6fcYf823I2+VIUYRE
         zqXmkD/ajDRRhMpTL/Ktwhj+c+rlD5gqa918krtYNP7fF1Dap4PlQUm0uci0e8I6kV4N
         qC1kftelRaMOpSiYpGcEXEv0tsHK2zS5Ojjj5wcsoJ1ENBNzWgL5WvtKR8uQMpF1H353
         4x5r6cQL0M1QNGCUxZLluNXWxRI9UXuBfrJgEgC/S+kRQ5jXyac+vP0z+yhbtXJ1NsoD
         2evg==
X-Gm-Message-State: AOJu0YyKdon6HY9WkIw7vQ1aA3+04jj6dfNtGiR7bLHyrfgTk2meaJzt
	bzlKn8eJAAQg+Jfu5jDJYWdl8WoeACAGFa31cLQaIH2evs6w0Q==
X-Google-Smtp-Source: 
 AGHT+IEfCNH80w/gtwLHYuZxwOspsbA229W+1LY9insIFjrIvZjOkP3//c2YPWN8UpvgwijdAlRyIKVrVvHkjW3879g=
X-Received: by 2002:a05:6512:32cc:b0:4fe:629:9265 with SMTP id
 f12-20020a05651232cc00b004fe06299265mr1104117lfg.20.1692440340019; Sat, 19
 Aug 2023 03:19:00 -0700 (PDT)
MIME-Version: 1.0
From: Rohit Pidaparthi <rohitpid@gmail.com>
Date: Sat, 19 Aug 2023 03:18:48 -0700
Message-ID: 
 <CAGmPKz5OeC6UVBif6ySevZEvaY_XwKh7A29K7k_Yq_D0CQJkCA@mail.gmail.com>
Subject: [PATCH] fix: Add quirk for Asus Zenbook Pro 14 UX6404 laptop
To: alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com,
	luke@ljones.dev, sbinding@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: rohitpid@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: NSQK6VU7U6JLVTWGHGRWLMVNXIQJY2IW
X-Message-ID-Hash: NSQK6VU7U6JLVTWGHGRWLMVNXIQJY2IW
X-Mailman-Approved-At: Mon, 21 Aug 2023 11:11:53 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NSQK6VU7U6JLVTWGHGRWLMVNXIQJY2IW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

>From 4f14cdad4f526f45747c4f0b71e24a46ebe3885c Mon Sep 17 00:00:00 2001
From: Rohit Pidaparthi <rohitpid@gmail.com>
Date: Sat, 19 Aug 2023 02:15:16 -0700
Subject: [PATCH] fix: Add quirk for Asus Zenbook Pro 14 UX6404 laptop

The Asus Zenbook Pro 14 UX6404 (1043:1863) needs binding to the
CS35L41 codec over spi1 rather than spi0. This is similar to
existing quirks for many ASUS Laptops.

Signed-off-by: Rohit Pidaparthi <rohitpid@gmail.com>
---
sound/pci/hda/patch_realtek.c | 1 +
1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dc7b7a407638..c44464b1619f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9681,6 +9681,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
       SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022",
ALC289_FIXUP_ASUS_GA401),
       SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
       SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402", ALC245_FIXUP_CS35L41_SPI_2),
+     SND_PCI_QUIRK(0x1043, 0x1863, "ASUS UX6404", ALC245_FIXUP_CS35L41_SPI_2),
       SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15",
ALC289_FIXUP_ASUS_GA502),
       SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
       SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15",
ALC294_FIXUP_ASUS_GU502_PINS),
--
2.39.2
