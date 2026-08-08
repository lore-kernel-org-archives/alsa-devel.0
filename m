Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5211AC5AD5A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:25:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B8A860211;
	Wed, 12 Aug 2026 11:25:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B8A860211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526746;
	bh=Iw/SO0f27fGvCQ2SqWSzwS8tiT5/D2CQOBV1NeHrJTE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Xn05/JBYXm0bQmFkpjptWZMkdsZiIZOGwkMMkwC9YV/7RMbeizimG7hgxGnWa9V7z
	 u8qheg37w2ZTzZSsNAnlpo/ojSatXcgvW6rOMP/5pXAcW1jLSkeeE7hglgSlTlduio
	 oTJzqGV2/rKvUDsTraNp0BzpLU9JXgY6SSvMbb1M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 814DFF8067B; Wed, 12 Aug 2026 11:24:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D709DF80689;
	Wed, 12 Aug 2026 11:24:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 81C13F80571; Sat,  8 Aug 2026 20:20:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786213233;
	b=rRgEwIK1Ui9IV8qLHxgh4q8wZgOyxGGwgTWBkUiMtaPjYf9Amod8JsMI3MoxhvOdBxNn
	 RPYah83RTuR3Gpug3EurmR9skqj/eQHA5fLJnZlq3sVR3bD3jMRjdaOQ8euilqSYAJdi9
	 u+EXo/kuS4hM/bLVsKo5mW8VlxV5lsbAq+GwGitz9wly3eSsf3KdgyUBPQnK65RNinBty
	 wyltwF7UjUHHR4VAqoVaFd+WXv+6k6k4FEOEczsYxRkVAE5Y6Ma0eserBzDBHscr7Tck8
	 D9MU2O8kHPVpNWSoLQ7SsX7wup11Zi63/UFUd811J/q4ckn+l1Y4P4cpvsGZl+hOlIg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786213233;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Iw/SO0f27fGvCQ2SqWSzwS8tiT5/D2CQOBV1NeHrJTE=;
	b=Rf+diCeXfUu3qHyOda25pv+D1Q5wfSY32t8Lr3mkrAwJPHtT48UJUfsmjywYgjDzjaF0
	 HVRDov5v19iEzxQcVr52S1vXhuTF2g34TtqSYyQGVznKhgG1I6mxMhT2FfepzdvLmBfVc
	 OwyCbRLAj494E/XZUmle1KUiWMnP0HDuYMk+7NmtntyjthAyTsbCLhxoYqrcsQEd296aC
	 InfsFh+PLQ9A3OyZa5e4jTszHeGy13H4xTwJqS45eAzuJ63P9VHBpykfqjvApi9Yb86Tc
	 PWgrVEfpGVzqfPOPlbvmdIzymU7QzObPjryWYoNNK/cNytsQ4dk+YBwb/KOO8yPdjcw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=S6pt4ji0;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B5B26F8012B
	for <alsa-devel@alsa-project.org>; Sat,  8 Aug 2026 20:20:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5B26F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=S6pt4ji0
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so3387975e9.3
        for <alsa-devel@alsa-project.org>;
 Sat, 08 Aug 2026 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786213231; x=1786818031;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4J4OHmY1axHWzMn7GoP95L1uqOwx1KFpIRvjWuxu5QY=;
        b=S6pt4ji08owG7HzDPRjz1s1HnHT6iRoncoTd1QLCrZ07SUZ+kFxD351/ZygOxc4g1C
         VBGihuos6uN1nhhCZKh6xLw6SDK1kHQD0jNBSqeIMuOq/S3BI5ZVATncaJIgf+3YCSex
         3euHcOHM8bCTNd+VIJLlKp3UNputQykNvmSl7/Odb9YJTSKWLvdhEaJxKGKEyByFE7Kc
         7YHfxcPeo0CPXptp+24X6gQ+dKX25byOhMS2l7DASxjcKgEvMg6QkJYMDHhLLDaM3Htn
         B4+GbNcbkGWAmCFlp3NJKulAvvFMHSOo1cGcGj9isCklfqsydfxAM97vXJAw37+8sF6/
         xF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786213231; x=1786818031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4J4OHmY1axHWzMn7GoP95L1uqOwx1KFpIRvjWuxu5QY=;
        b=iTehdRlvJell8zaGR4IHIL+Xozg+pSFqU9NRXFSw+kD0vkToXSN/7o14VyuiZWOtEf
         8C9l21HBk33R0vL+E9v2yVgdVyegtBSAFnlUogCMI3XSEVzqhHcb5ZIqSmCl7iIk05fu
         ZDh0WqplYqvPwwNvEbTVTKRkexaXRGHC5Jv2P3WFxJe80kCxE0rfQRVJx0YYeutD/g8/
         u8QMeG3xRVo5ArrzTgm4yS75fzRGXW9qQWXvWIxTGpa9acwR1cLL7eIf74AInstV3/3f
         C7V9Z4JaoeDNw3Pnllc55vdgWOhvwYUjI2DoSGAKjn0inK1wyMoVm41vg0D8n46GYSpc
         S2Ng==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpr557KvtQQhebExPo0yT+3Cpkx0CvbmPKbj/fcMT2O8OGS8e7rX5WA9/Fn5PruAznsRj5PTPREo1ZE@alsa-project.org
X-Gm-Message-State: AOJu0YxbnU76gcMJzXxKWLTWADBZ6CigyafsQ1nGHcGM6J6Nn6cjTp+C
	Koc722Wb8mkE7Fgrc0b3iSEesTlNTeF3N/kS7pjrUw4I6fyrgXDqE+BH
X-Gm-Gg: AR+sD13vmlQuhhfN3bk4Her7djtC5t3JQEESb0NWakgoFGd7b0heqHfgUreMz4MTs8Q
	k1b6VW42zs7GOlrtkCWzQlI+2KB+F9wiSLkIYgqVkDiPoeJ/QWbjjEysOTKtHCo/h8kvWVp/HIv
	8S0bNmzKj6c7z0dLoYBFJ/hSgRbHPKH7PG+jWsS4E5DgAGXBEhHyn2K4ocBnbDAbjMe3E4yfYif
	XHxMoSVxj5tz2VeBbe7pMzuJCxrmR+r/63PhhBnIvhUDz2oa8pjV3y6pf6vOZukmccIOHCHjlx5
	t0ddPP1m71zKzovWM2QEL8PfWgcHdIp1FztvxXTCoxTmuKqWW589WwRY5XXRcipJ5+0RkgHQ881
	Swdb82DQjtXLjduz5LuvO6znQkJvYd9DPuPc/5LZ/sUhMfeNIIquOV1NQ3jKHM7XEE51OgDfvJ/
	SV9ojH8roInKxMMoNB/pe8+wTD5p9Hnirvj8mcRQ41n7PwGm/Nb97k3T4y318tkJ7f2KGswO/C5
	hZhuhJgSmpYHg==
X-Received: by 2002:a05:600c:3ba2:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-4994e794edamr404557765e9.2.1786213230580;
        Sat, 08 Aug 2026 11:20:30 -0700 (PDT)
Received: from fedora.jkuat.ac.ke ([41.204.187.5])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995420c68fsm232814285e9.1.2026.08.08.11.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 11:20:30 -0700 (PDT)
From: Bramwel Barack <bramwelbarack89@gmail.com>
To: tiwai@suse.de
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	Bramwel Barack <bramwelbarack89@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add mute LED quirk for HP 250 G8 (0x85f3)
Date: Sat,  8 Aug 2026 21:20:18 +0300
Message-ID: <20260808182018.5148-1-bramwelbarack89@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: bramwelbarack89@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 3XGHIKLPRTZYABTQDMU3LII27DPBY2TI
X-Message-ID-Hash: 3XGHIKLPRTZYABTQDMU3LII27DPBY2TI
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:24:34 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3XGHIKLPRTZYABTQDMU3LII27DPBY2TI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Signed-off-by: Bramwel Barack <bramwelbarack89@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 379e1458f4ac..d4194ab284e9 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7153,6 +7153,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x8812, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
+	SND_PCI_QUIRK(0x103c, 0x85f3,"HP  250 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x881d, "HP 250 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x881e, "HP Laptop 15s-du3xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
-- 
2.55.0

