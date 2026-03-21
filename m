Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB63D58CA1
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Mar 2026 21:31:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07DDD601F8;
	Sun, 22 Mar 2026 22:31:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07DDD601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774215098;
	bh=I47fNIklow1R22OzWXG7zJUguEyBMyon9PJ0ftXnP+s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Om/TjU1k/XoJKDmrdTudRdskElgCWRJ0I+npcXiH2CK/TZpo9I8CcPuLYSmJQSYU+
	 jNccw+/eC2CGUgMT0NCAbqoKMWDUAH+AZRMp4ItruJFac/RX/AnsHtA0aKTtxLFHLH
	 LBF+QTrj8BK8Dw0J1SoJH6ha/iwn6glDswcceIGQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1789F805F3; Sun, 22 Mar 2026 22:30:50 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B99CF80624;
	Sun, 22 Mar 2026 22:30:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45773F80549; Sat, 21 Mar 2026 16:36:13 +0100 (CET)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5EAADF8047D
	for <alsa-devel@alsa-project.org>; Sat, 21 Mar 2026 16:36:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EAADF8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=HFvtWE6L
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-56b7e5dfd25so2679951e0c.1
        for <alsa-devel@alsa-project.org>;
 Sat, 21 Mar 2026 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774107368; x=1774712168;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SgF/I5iB9hLoj3qCco9z69zVh5++Id1frdkWyNApFZk=;
        b=HFvtWE6LDcvJKlY2NNQvj7UN/Z/LXi3H6HlOoKaR4tF9rz86Byh8YuxdbGpQ7QnIYL
         71yDqZ2ijLftqjuUSGr4gFqinENOgikcUb9JBHRPnuwtbk0C8/xGz8jcrIbdwuWNshxa
         yeJCsOcbZTnC5Hv2f2N/prIPZf1u3smHC93nAGZ9m0mYRnzMq/Nd+x+JNvjOjAWqSE5K
         CChwSp8Sb993KrSNbVP94+X3WL0VOgPtkC8KlAfVoKSljhOhTjiSw1aBE46gpjCzDdj5
         VkouFA7BdNLDrBeC937/2NFZxthM2bLLcmoeyLPsmGGBf8zh7Qfvr/ZMbaxOQBtwRFKS
         584A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774107368; x=1774712168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgF/I5iB9hLoj3qCco9z69zVh5++Id1frdkWyNApFZk=;
        b=SPeS3KJ7gqqHtZax/k3cl461momPYy3r7BPt2x2/AsDnWxEbHiDeo8Kpb/oaDhgUmg
         LbGYRTBtumm5lOmao6NoPi+SjqKbwCZwu5+eesnuX4RE+7MnKPrX/IP7PmHn/4eOQ5MR
         KHf0LdWGpMICurVvU6AS0XomvCCVd0qQQqGbhI7V+2G/WXSzl3DYYdJwA7iImS8MQLex
         zSJeLp+CCkA6H4w5N/rJuoJHxQRohGQAGe2bRiQoFHfa1ur5Q0ChJ2K1iqae5KE7jwzN
         1tACG3oXUvO+pNnCHBhd3q9LQIbvF0Ka17J9Jo4eSKGB2zDgDhHgekXh/Yzn/5pncDhk
         vWGQ==
X-Gm-Message-State: AOJu0YyMVJRnyQTDqvN6Z39WWxnL678MM0+TMOjleIoDcadhlpsGkrRX
	6dL0FQ25eCZ+cO1EF4a4mZh0uvTLrz2CTl7gg05jIjG+qTh/9WBXrO9qT/4xJih+EC0=
X-Gm-Gg: ATEYQzzSn7YMnk6yX0w///+HVdyN5DqwCyCwJuFK8WWfL4MmBYgW/XQ4bmLdxsujRSx
	/Co6CG4xdIor7QO0GB9hbF9jT/A1dWrdSRJMVqAFnZ26whac3vtWJPogV+cORKgAOs9/frVrXXJ
	oKH+SnyFaQ67XGtzKCYJxANygsnKGMzhKuTAveL7Oi2okaQD0eVwhhy3TsOCrnUcdCtZXhsrAHV
	HMhHIEBIqdfCywB2mkq1FHAeGpWXeZCgrbT0Rv2DKW+nZPOyOKb0U57hkaXD3j1lqYz58fbHZK3
	h65aRJRX7EmIsCqyUK+kJTyqGkdgxshDj7AaG6R/KqZMtSmuRwHOipWLtONCE2PtxJyBM0LdUkh
	0prac6K6yddGxJO+3VvWm8I4jwMafIA/7IBc/1GwiYGx2OctDyoi4KwWU/M2kM7jWk8yIS6cTtG
	+XuW4uo2+pvhX5b128uWfz1B0itNjCgIs=
X-Received: by 2002:a05:6102:508d:b0:601:f6ef:af8 with SMTP id
 ada2fe7eead31-60295c27029mr5021228137.10.1774107368129;
        Sat, 21 Mar 2026 08:36:08 -0700 (PDT)
Received: from pavilion-cesar ([2800:e2:1e80:1899:2c1a:3d86:f378:77cd])
        by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95136c4e2a3sm3560106241.7.2026.03.21.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 08:36:07 -0700 (PDT)
From: =?UTF-8?q?C=C3=A9sar=20Montoya?= <sprit152009@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	=?UTF-8?q?C=C3=A9sar=20Montoya?= <sprit152009@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion
 15-eg0xxx
Date: Sat, 21 Mar 2026 10:36:03 -0500
Message-ID: <20260321153603.12771-1-sprit152009@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: sprit152009@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: NEHE2DJHVSZYVKAJJPIP2UMW7XCRIO3O
X-Message-ID-Hash: NEHE2DJHVSZYVKAJJPIP2UMW7XCRIO3O
X-Mailman-Approved-At: Sun, 22 Mar 2026 21:30:42 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NEHE2DJHVSZYVKAJJPIP2UMW7XCRIO3O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The HP Pavilion 15-eg0xxx with subsystem ID 0x103c87cb uses a Realtek
ALC287 codec with a mute LED wired to GPIO pin 4 (mask 0x10). The
existing ALC287_FIXUP_HP_GPIO_LED fixup already handles this correctly,
but the subsystem ID was missing from the quirk table.

GPIO pin confirmed via manual hda-verb testing:
  hda-verb SET_GPIO_MASK 0x10
  hda-verb SET_GPIO_DIRECTION 0x10
  hda-verb SET_GPIO_DATA 0x10

Signed-off-by: César Montoya <sprit152009@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 327f4dc1b..cb5f0d209 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6894,6 +6894,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87cb, "HP Pavilion 15-eg0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87cc, "HP Pavilion 15-eg0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87df, "HP ProBook 430 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.53.0

