Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FABF8A14D
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:24:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3F076020B;
	Thu, 16 Apr 2026 11:23:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3F076020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776331446;
	bh=5c2CTBsa56ggTruyu34zlgPQIqCG/hoOHwFpZzV3lqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Mky0bmGKBKMHr/KU8rl6Sgyx0IT5Dvb0n4Uyp3DugKphQ0s0X1XTbkctNDji5dm2h
	 XScFe3vJSh/rzuaD8MEqGEDqwqZxsRfM+n11jDS0J5AI2RkrNHAOxbGJGjj7lzBOyB
	 2XBLE54ohRy26i51IXAGoDPG9zbW1m933jEsPfQ4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED905F805ED; Thu, 16 Apr 2026 11:23:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B3152F805F2;
	Thu, 16 Apr 2026 11:23:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 35104F80537; Mon, 13 Apr 2026 23:28:36 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F375F8011B
	for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2026 23:28:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F375F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gYXo9ZJL
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-82cebbdab08so3669617b3a.2
        for <alsa-devel@alsa-project.org>;
 Mon, 13 Apr 2026 14:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776115712; x=1776720512;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONnEdVE3o8eW7nuVWY1dGeZByLtYI03IG6ccjXhCWCo=;
        b=gYXo9ZJLPVygsXjAFbrgwa8/wksyFKAfDTNPHr4hM7kD0jRZ00fo5riEIVSThQvk5F
         l1HY0LHCxVOQcwOfuDjkWNoiliVLyP0DVwDT7te+FYuWc40rPvwL4MKKP4qvXiEcypQ3
         VSvSw1Hd/InlG+Mhry5hKfjn/zFg0xeR7Ikdh93uYFZAaWcmmeFsAZjbvq1QANxBk1u/
         w+FulXcpgxsm1ll/OojeKLF0cJSdWJCJwv0bt5hDkrxNZr8Srw9EwoxZC0bmAXzlgxGH
         KATMJhl+7U/+q4n8OlR1MMOSlcYu1jvK6uZjvJuqRDNPxwIN/pCS8tybjs349w/IUDnV
         St8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776115712; x=1776720512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ONnEdVE3o8eW7nuVWY1dGeZByLtYI03IG6ccjXhCWCo=;
        b=rJAMVLV2gHGgbns7QSoe7DSpjvaoXOatVLtmIPyMe67y0xoLumaTLUvacEE93Vbzpa
         63S8EOIQ18zfA2amlfU/KEJ+ebIGPh97cphAEx+wKjN5PrBl9+5vj8I6pixI7f0E0Zp9
         U06/pfoWPebaa3BUaj1rz7bs7Vtk9iGQI7ytIQ3rE2cMNIkAjp++AxruiTJ/6S1FYQC7
         sbOg9CIOUmL89tu4I8+e2WieHCz5rfr9x5uBSq75b3Z3sjdyczwNb2PfjsEzNhgwtdMK
         WFS18JmA6iHI29vqkqar5TQgaPj6Fa9j9GyUVndlLUIXoosUMMmvP/SbfFNkygF/348K
         xdLg==
X-Gm-Message-State: AOJu0YygU8KpGGfwidlWetqPGvMY14+uTQdG3IikbKa94ILBz7thABKX
	JVL+dlH6FeirWq4dxsMy0xNAeoKGGx58ez28taGFXDBDU3NdmDJbigG2SfMF7hDHCZ4=
X-Gm-Gg: AeBDietCnAeg6ZyNlTm3w48arvQ0BFnQtshOXns9FdafvuojXQ5JksBGxcAClN28uNL
	1uQLk7c4DueHOiBDT8rS9ohSBedD64PW0ice5HL7s/htTyvn0Ket87OvwIyrP1MJh6L/7uL/aKq
	trQxI87YeabCqquLOHvN1/auA88UnEZjOJeplcECqYa/N496Vq+DwDmzZDHNp99dvGhSOmot8Q5
	qWqPQVOxaaDuRDE3nAkwz0rfueXx1Vc7neJVSxuO9THhAm8TnfaeojtbuNiub1F1gV+GcAAiV60
	jv6mmWTGAIpUBX8Ex5aMi1Gkm283wFLYDrGNCpjSKApXq952f9iTF39Foj77M02TfFtA/fCjVkQ
	fv0PhaI/Iat36xTS0XAx4jd7K2f2pe/o55Tjuz0vfhZxExwyRvlG2xLcGaDZ7jvorI/d7QA6ENS
	hSf/xxPRWv7Qwu8Eb0LsQaEcte20tm1ISHW9YvHVJJH/X0EoN6ZDqkP/L/o8jVGSBR/7ZNzmrBj
	1dgzt4VabYp
X-Received: by 2002:a05:6a00:35c8:b0:827:2a07:231d with SMTP id
 d2e1a72fcca58-82f0c21a67dmr15179437b3a.17.1776115712114;
        Mon, 13 Apr 2026 14:28:32 -0700 (PDT)
Received: from FoxArch.wyvern-exponential.ts.net
 (184-155-120-110.cpe.sparklight.net. [184.155.120.110])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4b2455sm12398165b3a.35.2026.04.13.14.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:28:31 -0700 (PDT)
From: Faye <faye.opensource@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Faye Nichols <faye.opensource@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Acer PT316-51S headset mic
Date: Mon, 13 Apr 2026 15:20:25 -0600
Message-ID: <20260413212645.117119-1-faye.opensource@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87lderwhfi.wl-tiwai@suse.de>
References: <87lderwhfi.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: faye.opensource@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: R3XXHH4GKJXPACUS7MME64GBOYZQSA3A
X-Message-ID-Hash: R3XXHH4GKJXPACUS7MME64GBOYZQSA3A
X-Mailman-Approved-At: Thu, 16 Apr 2026 09:23:22 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R3XXHH4GKJXPACUS7MME64GBOYZQSA3A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Faye Nichols <faye.opensource@gmail.com>

The Acer PT316-51S (PCI SSID 1025:160e) with ALC287 codec does not
detect the headset microphone due to missing BIOS pin configuration
for pin 0x19. Apply ALC2XX_FIXUP_HEADSET_MIC to enable it.

Signed-off-by: Faye Nichols <faye.opensource@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index cb39054..a8dbb0b 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6690,6 +6690,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1539, "Acer Nitro 5 AN515-57", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x159c, "Acer Nitro 5 AN515-58", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1597, "Acer Nitro 5 AN517-55", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x160e, "Acer PT316-51S", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x169a, "Acer Swift SFG16", ALC256_FIXUP_ACER_SFG16_MICMUTE_LED),
 	SND_PCI_QUIRK(0x1025, 0x171e, "Acer Nitro ANV15-51", ALC245_FIXUP_ACER_MICMUTE_LED),
 	SND_PCI_QUIRK(0x1025, 0x173a, "Acer Swift SFG14-73", ALC245_FIXUP_ACER_MICMUTE_LED),
-- 
2.53.0

