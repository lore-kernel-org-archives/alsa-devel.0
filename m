Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EAACD37AC
	for <alsa-devel@archiver.kernel.org>; Sun, 17 May 2026 14:34:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACEE360210;
	Sun, 17 May 2026 16:34:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACEE360210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779028475;
	bh=XrzaJo4HWQdFxlW5p7D3E7trnt7CsF9FzaadFtFx7H0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HYjyJHkYiKGeSNEdxbnU77yq0pAczlCfkivxzshLtMLS+Ya93sokixyemWTkdSR0U
	 vqPdEN2DYRA8dZhArzdEzOoHRwZAytz3z5IvCXRcCtFBOc1pJLyYApLpVNyD6eJHe3
	 WrDZ3SLLmE+sIMZlTAsstEtI7/cFbxRZHQmsZfeE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50465F8060F; Sun, 17 May 2026 16:33:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 09E89F80610;
	Sun, 17 May 2026 16:33:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6955AF80217; Sat, 16 May 2026 21:08:03 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 10FA7F8014E
	for <alsa-devel@alsa-project.org>; Sat, 16 May 2026 21:08:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10FA7F8014E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DBAHDyr/
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3698e34a567so462143a91.2
        for <alsa-devel@alsa-project.org>;
 Sat, 16 May 2026 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778958478; x=1779563278;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJEppFNhUS0Xaa2w3V2HP8neaFUhqRuk85p9iAO9Rts=;
        b=DBAHDyr/DZcvs32txAu/QXqjMdXYmzjhgp4EdBDQjBj13bSqs/+JkHwhB2Y7N9umR2
         hMjR/MZoSBhz/A5vprq8HM2Gd6XhMlt/9aXeLacYutsB/kkK9F6IqFzEGA4gf4rOWfEp
         c/dqCnGeTBVxTlmBgpLMmH2/t7WdSnFAE60L9gtD6jZTYCZGHbwP3RWp9CR5VwtTNrav
         qgU98w8AvAS0esNInHrCjzgDX8v/YxR379RLIPDdyz43ua2e2MV0B/6bHucBR68oOCDW
         +Zm8AMW9tVShs6UBhvx7lTtwgGxyurHluXLnaIsZNvsW6KafooKK1i/EI3ffqHxT+Of7
         Ol7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778958478; x=1779563278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJEppFNhUS0Xaa2w3V2HP8neaFUhqRuk85p9iAO9Rts=;
        b=pdQUtBGq0zjWdRHo8hd+rW9miHg1hStdsz+O1B/YUh5X+6aAki/DxKKjODcNkj1FMc
         xcyoecwq2njVOLk36zAy2Zl/93oFD8DKOqyesRSDTw5qNeAkYxRYQtk4NtiveXw8aoOS
         ywC0MKVwtlDvJ3awngP+aoutvZiaXXpBVlZfJe+JV6zneCfe+5foGay7T2AkIyRH6rM2
         wS7fN7MVSlGeJcOYD+yzO3j7XO954xXQk4Jy2UKREg5wbi8KfQyQY/07TIe8FAbPhVQb
         xPq+5pGAfzQCsCIQZjX2W6rwtjuvdAVP5LDCNhEFuYIolsIeSl2YekZ5Qp4o410kVwtH
         N6OA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/e+E2QX+E0lL0Zt3jVKwtwdSSBRCO3vWij20aqwwbf5z1hbXbTFGYY6ChCJSIqgh+hq1z7p/XC3/pP@alsa-project.org
X-Gm-Message-State: AOJu0Yxwv2+JrictLn28y6eeLvcQqS9Dimu757nN84wDZunhbvwb8zUE
	zJgDJfq8arHF+QFxwqy2F8P/AUtSvoBdPvtYNZ7CkBs6sVcAb1ut+pMH
X-Gm-Gg: Acq92OEOPjAzbtNvAzVE25qQRifGqvOkSlqk0greZPi8KIckoVaLkS6L3feteuQgA/d
	i2KGMTkXYU6p2fMm9sgqYrvXij92ESU6f5u4tvyfVwPF/0PP5fCT4FZP3l7vZVpUC7nsam+99Ju
	fOr3ZfWIp4hDvc1ZlmeNaKZAAZ+Uv7nl12t9RwLFZrHbl73t3TfWpsE0Pd8sR+UCQf61zDRw8zB
	limoNi1eou6sZNr59VLYnN4D3WMt8OFHPQS+j5jwAV/zfxmKX4wNU84v0YaXnA4VrKpOAsjBzhI
	5ADvplf2QDRgojU+EAmSrb8bbmpVxGqUcyuNK89/k8oVmK5JlvMODUW8N2zHuBcbztO+RD/WBrq
	M3halnmv15QGI2HioNN1LjXTUj7PLIYIO+IRtPPyzRxOJYeCF5Pt/RsbpXxZcxMaREk27aE9bZq
	WvNgEFIo9KLDsOL2ZJDOqQP7aYz3oY1A==
X-Received: by 2002:a17:90b:544c:b0:369:7ef6:2874 with SMTP id
 98e67ed59e1d1-3697ef62f88mr2681528a91.4.1778958478279;
        Sat, 16 May 2026 12:07:58 -0700 (PDT)
Received: from localhost ([188.253.121.112])
        by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-369515895d2sm6145557a91.8.2026.05.16.12.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 12:07:57 -0700 (PDT)
From: grxp <grxp323@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	grxp <grxp323@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add HP OMEN 16-n0000 mute LED quirk
Date: Sun, 17 May 2026 03:07:34 +0800
Message-ID: <20260516190734.34721-1-grxp323@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: grxp323@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IDUZOIRL3Z4OE6SWINCT2JK7ZVXRFUA7
X-Message-ID-Hash: IDUZOIRL3Z4OE6SWINCT2JK7ZVXRFUA7
X-Mailman-Approved-At: Sun, 17 May 2026 14:33:42 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IDUZOIRL3Z4OE6SWINCT2JK7ZVXRFUA7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The HP OMEN 16-n0000 laptop uses an 
ALC245 codec with a mute LED controlled by a coef register.
Add the corresponding quirk to enable the mute LED.
After testing, the LED brightness is consistent with Windows.

Signed-off-by: grxp <grxp323@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 11d0ea8ed..2ac400353 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7079,6 +7079,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a34, "HP Pavilion x360 2-in-1 Laptop 14-ek0xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a3d, "HP Victus 15-fb0xxx (MB 8A3D)", ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8a43, "HP OMEN 16-n0000", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a4f, "HP Victus 15-fa0xxx (MB 8A4F)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x103c, 0x8a74, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a75, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.53.0

