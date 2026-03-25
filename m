Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515CF10F284C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:06:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A4F2601F6;
	Fri, 27 Mar 2026 17:06:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A4F2601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774627574;
	bh=F9V/eMp4M8BziA52Mpx4HG3b+LtSlVb0qprLtUzCKYA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ldLIn9o3qoJgnl/5a6BW5z+xCFQCs1DD5BkuhpQR+syxQbF0hfHeEuj+f4TPcrjui
	 oyxXtPC5IGMNEQQSJqkX6krnRLwKM009lB+jWuxf8+DnkpFxNT+icqcszTyqg6qwe2
	 aE6tbxf3Vj6otZUqW9Do5eIFzG12yjj9Ox30wanQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56692F805E8; Fri, 27 Mar 2026 17:05:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 41193F805E8;
	Fri, 27 Mar 2026 17:05:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59496F8059F; Wed, 25 Mar 2026 13:27:09 +0100 (CET)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A933FF800E2
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2026 13:27:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A933FF800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iSuDoEat
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-66f3e7d9eccso1410871eaf.1
        for <alsa-devel@alsa-project.org>;
 Wed, 25 Mar 2026 05:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774441625; cv=none;
        d=google.com; s=arc-20240605;
        b=Xifm/7lU6eTcCmBVjAu8lFJUMiUOMx+nrs7gHD5qBqXbCb1OFDOoZFUXwkA4ETK1NU
         6IjR8s+Hi/cD+SLlXqz2P5ldXcOxSZsJXWhLyaexuIprZcObZGKQPfUE9uIcYmTBKMrY
         Q04AhpNwes/SX200rt1EafktNVgR0qaeSitYsrcwReJyeQK/ayRHVfpXzrK22qEtZwhE
         qZnNCKbVdujBt9C08bqOVufADVZO6o8sl8Ct6p3MqqoNLVvvKAE8JVjQk/N9T03WEsZz
         Nc4Zw+EyjvIcKFJC58uzmVs96n+tno6YmRZA2Do0pG6ZWn5TY109Kw0KenbYSslLZwv4
         UsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HFvoVvwvCpoSrZvfDIYva3ZmHvLmFaGJxwwa8F0Vrpk=;
        fh=tZHr7/D0TldToTXCjYTt3t0FeLwUO/++2yJWvjcnx/g=;
        b=ITtiHHbpeapZIQdR0RZEv79qDjBxRadsrpADNR0OqyWmcJz3BJVlFiXMfkgkuBPhZA
         KB1InAvIn1+nfMY6eNhYLgDasnH44owVd5hWHEUKWpwjaq8OfAROcFktg8t7dUXBj3vP
         Rn22qc9IOLiecSBp24ggpXDCVa+83udOsbQFbl9nzejffnqKFbY6XOrmWkXucxW2BjQS
         Dp/bGV5JbgLMk/nn5jEuGvU4jShhN644TgxOh0bOk5KBBCLMEfXtbqo97EJeMItdlHr3
         /6xw6Q8Lh5PJwOruYCY4yIoQ5KawQX0l/oQngeJZ9qNYzKrnue7t9NXpVjm7CVHLcEMs
         FoFw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774441625; x=1775046425;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HFvoVvwvCpoSrZvfDIYva3ZmHvLmFaGJxwwa8F0Vrpk=;
        b=iSuDoEatudgL/+fbRTSRbDQGn6i13bfcTrso87Hk5VlowmvswQS7Zhi4zP8qPaAN/6
         pVTr1L1haCHMJMJT78HTIUUBSwjKQM5rpCOASQHjtJBXr4rlHB6hU4Ko3hZr9+zmzUzM
         QS8Hl+sS04IFRzlsnBBJux/WDczSQ14AFWEyEuRAxEleILPRS8zWDGgJc+dNUqLCjlMS
         kNSY6Lm9KuCjvrNqg6lsZ9jmMc06jTQIu2uDjV2A2T2VIStwZn3zMpf1ZilMZFLMYFU7
         qAXSYtM6cV1Z+lP0ampsxrFJzSNyHpThoZO/X61X2TpXk6lZlj2o9NysvdNcnGvnheZ5
         eOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774441625; x=1775046425;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFvoVvwvCpoSrZvfDIYva3ZmHvLmFaGJxwwa8F0Vrpk=;
        b=askwA5k2l2UkLHSI2A8znkNWi7/rWXoLPcSLMA/xH0+OulxQwQlI1USLm0VMq1Kd/i
         pv5NnyosyQGyKk1yDJrhfQAvQarnGBumgEzLEizQf3dMAnauMRMRf8dtvZa1OLK47nxG
         GTjUmts78coLygwOJwbP4TDiCGG1tsLN/0iXpZwuhkbRKmPOLlZ7iDCTA9bV+9vLHdB0
         OUMFExVaaA5jxgOlBS+MoguPeYzwz4Qa3gbwxBEga5DsClQNqT7QgsmGeVJfGPIstB5m
         a8j2kkTijbCwmnkMGUHdFPFSjKJfzWCVPoDH9DOcp6V6pv+bDQBNusK4GvZ+hRnlDw0i
         SobQ==
X-Gm-Message-State: AOJu0Yw7J6VgSQQV+JRnuBmDrOATSyRe6rKKrYFKQEY9uLSfT0A1qrow
	/EXCGnhoqDbGI8z0r4zH5GdxELiP5klFBz1EkdZmCeqZH6tUunUP1k36BW2SHuYyS6GUmDW2EmT
	oLi+z5psF6dZEaer3d9VwQHDO4HiuVaBL51k7
X-Gm-Gg: ATEYQzyLFWyKb3xn4e0BU/0h4YUeQ4wUjs4gGGAMIfMwX+hoCt2lS4WMfxE33nNC4sQ
	yoDKFu4CtrZIuJ0bckP64Op5geSjtwPgx2bLc+lAvK7uuNk2Ft2a9kPX0NPPp5PweGwTR8Fqwbi
	707ihN1V95dGYWoehFUoz2feSz9hk3+cyXKziGYxg1JXB5Nmb2+OU9FESeKODwS0GHCZosE6szW
	0kD/xJ1UEmLVjSt8rgIErFXSHesN0/z7/foEdZuYlcBp+AKupYK/VP5yQCtEQFTzWL42Iox2tA/
	ORBCtKxyruRkTbKnBw==
X-Received: by 2002:a05:6820:61a:b0:67d:f465:77d2 with SMTP id
 006d021491bc7-67dff54b558mr1876414eaf.65.1774441625496; Wed, 25 Mar 2026
 05:27:05 -0700 (PDT)
MIME-Version: 1.0
From: Rocket Raccoon <rakketje1@gmail.com>
Date: Wed, 25 Mar 2026 13:26:54 +0100
X-Gm-Features: AQROBzDZV83c5Fx9TiPkJ3gyuFfpbuJmfa9paqaY2BZjAw6BS0Vq6i6bxEVX8Cw
Message-ID: 
 <CAL76xbU81CKcbAD436djDbJ8P+xsj0r24i7phFG1YcSVr2n2JQ@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Yoga 7 2-in-1 14AKP10
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: rakketje1@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 7MQYOYMU47PX3MQXY3X6F46CD7XDLSRO
X-Message-ID-Hash: 7MQYOYMU47PX3MQXY3X6F46CD7XDLSRO
X-Mailman-Approved-At: Fri, 27 Mar 2026 16:05:29 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7MQYOYMU47PX3MQXY3X6F46CD7XDLSRO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Lenovo Yoga 7 2-in-1 14AKP10 (PCI subsystem ID 0x17aa:0x391c) uses
an ALC287 HDA codec paired with a TAS2781 amplifier connected via I2C.
Without this quirk the amplifier is not initialised and internal speaker
output lacks amplification.

Signed-off-by: Lucas <rakketje1@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index XXXXXXX..XXXXXXX 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -XXXXX,6 +XXXXX,7 @@ static const struct snd_pci_quirk alc287_fixup_tbl[] = {
  SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo Yoga Pro 9 14IRP8",
ALC287_FIXUP_TAS2781_I2C),
+ SND_PCI_QUIRK(0x17aa, 0x391c, "Lenovo Yoga 7 2-in-1 14AKP10",
ALC287_FIXUP_TAS2781_I2C),
  SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL",
ALC287_FIXUP_13S_GEN2_SPEAKERS),
