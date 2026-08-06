Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B1EC56207
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:41:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3549360238;
	Thu,  6 Aug 2026 16:40:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3549360238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786027258;
	bh=5IB3apJ5mTNG78JxnYAc4Vhd50d2SAHpTuIVYKEGMME=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pydxG9Gk9wI582QkIhWv68dQbNxUzjIxZmHQmUuqdwqMs3W9BKszgPQJXkcA8++lQ
	 ekjsZrOu/DqUuBCjkmYNWxu8TsBZyuOd5JrGQOipPth6mpnv5YajjZ0LRk/59TkhcB
	 3IdrN3+MwIvDmGDUgRBwo6uVjw1qtdkER3K08WbY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D10FAF80686; Thu,  6 Aug 2026 16:39:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C08E7F8067D;
	Thu,  6 Aug 2026 16:39:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B12CF8055A; Thu,  6 Aug 2026 16:18:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786025911;
	b=F5Yq0Cqgq6iZ+rzbQTXLaR1yl2gc7xIEqd3yz1dSHBQyWFGOGeedwSdDTMN+1s1LCx8N
	 7BQWLRRG780HOqhHNsP58nBu3AUTdypJT4jX2tvazbvTjyVtENmK9jVzmOw45to2a1KLD
	 DYnRMLjiW5JHM2yPDPNLaxpjwupAjp1Uv1yxMwNQJLEyMNpQXabx1ZUT2es+oBSuW/7ne
	 0xC1qY57qNz5qZ6oBQFpcTzK/RRFLwDCzqmr8lbkbiilZT0VI6a+4wQAAFYNiSDtOH9ER
	 JxqP+MRuZIAXaxLwYlZE2Ub+jpxL6eH/1hHbt8x8y3vwx/WDt2ViTXZKbPwkJ4J5GNA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786025911;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5IB3apJ5mTNG78JxnYAc4Vhd50d2SAHpTuIVYKEGMME=;
	b=Ifi4HfXmCmVzsxvhdH97kCB90JEw4PH+9md+gGgA0++2ArAm5jqQHNC9dtB2kIO+Am6J
	 V2B3U71A2jGN28/OmxgynzmHtFVWw03P4Fu44M68JTVs/xVn2nXcAUIqsB4H30igOSZld
	 WVl0LCLZYes7GwTsU9e/GLr9rWSkvV2hi/lwslgNRRXxg8Wpfp+n1BqlQIDGHW4DRsScp
	 nxMGWdYFZD9NRtsKf/EVTjPPvd6xkhPNgWk26HCWn8+IXhla+KQtGONwO7j9imcNaBWjs
	 Rcy3oUyEKBlHbsyXLivIWgpAp1A94c0XscFYslZjSgqjepzAXuJWABeTWeBjVJ3tDNw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="M/0TgQlt";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E61D3F800B5
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 16:18:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E61D3F800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=M/0TgQlt
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so2207637a91.3
        for <alsa-devel@alsa-project.org>;
 Thu, 06 Aug 2026 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786025906; x=1786630706;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/J94ndUcSa8/fzWrR5UWTi8+iEtkdEMZkZiFQhYOhk=;
        b=M/0TgQltWdsJwndLAhE/Fua6IeeVr8klmF8EaagwVI3ATRhOP171L+1iw0IYgTLLxN
         CgAOETqql3EmPlHtRqZGXTS9x84JGBSujzYQf4sGwHqhwZsXTs03qLLOQa7O18MoR2Jv
         ZrYs7VJkv2HgJQ0Lz8uv4Yr8umW1409D3KQT9sDFdto9AO9Z7QN4Ac5a4I49qO00CBhu
         /7PYe3uNkPFSuBR0SayL9CQ8h32s7t3hYnpJ6a3qFi/WQIsyAJyLmC/WYkAanjkp/7Gk
         sEmjcP8UE4BLNQYyxb9KXglrSNS1byitQii+mBQXjawb3KOhadMgvzERcAgoLJvfZQWz
         GrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025906; x=1786630706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/J94ndUcSa8/fzWrR5UWTi8+iEtkdEMZkZiFQhYOhk=;
        b=fqEAY6TT0jxVAcmYdwYO3r2e1W0hbJ2Fud2wbTs8Qq9u2lPJUcJkXtGphBMrlcelC6
         uEnyKSMrjLZuJAc3GG5Hw+B5tts5MQ649kEjIMjxXa1ut3Cos49oLrsnOQeGBtwTQq5A
         UlomuK2oXV4ImjYgta5o4e/xdP76AU015krXWg2FlwkwPrf3Ki7Jian5OuhBSegpzbw/
         NMCvrUjc2v4MY2trFYRAMO6xwt32dDD4YpYrhSyM3V1N/i/RCduTHdLLgaFGCHcUxURq
         j0Am6Dw2fzTCzjlmL5pnf7Lm85DTGOxmSEl1iyMSJJBgTI77Qpta2mRpzO90ds/fN3UG
         8fjg==
X-Gm-Message-State: AOJu0YyChLJX/JMXAcaGR2DgXUm3aj7CDVl4VXkXE762Hw43Y6UZjUxr
	VDZaqyWC3Nv99nBpwP/3olUq75v0ZTUaOz1ygyg4XReKISzQPU2lAkRN
X-Gm-Gg: AR+sD12yrTK6o+l71g5VMXIk68rS0j8q9bzMgX/HE0PY/uyP48Q2hXTySI9pv4CLO8b
	JVpBOKJFUJmDgy222vPRi66q3qS/HgWPhr2hVGZXBPsFpsZjkcWlaMubjh36Clut1khw+ASKI0r
	uhoEu9DDiX7c2uMOOyrKJpWAqdc/3lOaEqbpznhDLg3M2Sc3l+z+vFiWlfuhlYVLvg42MXX6zZ0
	3wbbtR6wbjPbKqnrhcfhm1qaQ0ZodQMdAB+ybXoqFRT2Nw+1dCOXRnZrgeyzx8DNdt9fdg2l+bz
	vayaqh0UUhcGgMw321YfssievUlmJMJGQiBaNLqYPEINg/VqSICkXVkb7YMoXKOnGDI1U9yZmUP
	uFzgVdb/8DQ1OM5lWQ2bu9FHrX2HxlEuZGKdsA0qypRQxTdV/1AgsGcJmqtTnbTfv6KMVZ17Cut
	fbOnN7/Ypvw6jdjsSYWdqRNaOyZm8YL7Ku+/HPtW+6oPDRzc1Q4t9e
X-Received: by 2002:a17:90b:4b87:b0:38e:7a05:9c0a with SMTP id
 98e67ed59e1d1-3903c5c0fedmr13075467a91.18.1786025906278;
        Thu, 06 Aug 2026 07:18:26 -0700 (PDT)
Received: from ankirin ([112.47.201.67])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3903f5ab5d3sm2712467a91.2.2026.08.06.07.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:18:25 -0700 (PDT)
From: ankirin <ankirin4@gmail.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	ankirin <ankirin4@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Enable speaker on Xiaomi Notebook Pro 15
 (1d72:1709)
Date: Thu,  6 Aug 2026 22:18:15 +0800
Message-ID: <20260806141815.40527-1-ankirin4@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: ankirin4@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: YHOHV62P6IRJP7QCCFM3YSR7BN2L77DZ
X-Message-ID-Hash: YHOHV62P6IRJP7QCCFM3YSR7BN2L77DZ
X-Mailman-Approved-At: Thu, 06 Aug 2026 14:39:31 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YHOHV62P6IRJP7QCCFM3YSR7BN2L77DZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Xiaomi Notebook Pro 15 (subsystem 1d72:1709, Realtek ALC256)
silences its internal speaker on Linux: the codec sets coefficient
register 0x10 to 0x0220 (bit 9 set) on boot and after S3 resume.

This is the same mechanism already supported for the Xiaomi Mi
Laptop Pro 15 (1d72:1905) via ALC256_FIXUP_XIAOMI_PRO15_RESUME,
which clears the stuck coef bit on every codec init. Add the
missing 1d72:1709 SSID entry to the quirk table.

Verified on this board: with bit 9 cleared (coef 0x10 = 0x0020),
the internal speaker outputs normally, including across
suspend/resume.

Signed-off-by: ankirin <ankirin4@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index bd53507..084e814 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -8168,6 +8168,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1d72, 0x1709, "Xiaomi Notebook Pro 15", ALC256_FIXUP_XIAOMI_PRO15_RESUME),
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1905, "Xiaomi Mi Laptop Pro 15", ALC256_FIXUP_XIAOMI_PRO15_RESUME),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
-- 
2.55.0

