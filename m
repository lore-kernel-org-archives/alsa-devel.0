Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3174EEF8FFC
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:26:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7482C602B4;
	Wed,  4 Mar 2026 17:26:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7482C602B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772641596;
	bh=Ufx2LQuVsPemONElURIztMjbQMMbf+4gtqztqAWWexA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=odvhy93S0MYtXImUzY727PYgrFU33vyPN5/vdVoVdjmHfJ0m7dSk/RsPUVJfB+HLy
	 8xj5e9iPrrwys0BgydPD74wS2CfSJ7tDKfXYFo+lmZibll4XTAU4pCB/VFTx75usog
	 17oJXwTeshSkkcqOPuUpgYjy+LAgzwr7IEAPuRD8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 449C8F80699; Wed,  4 Mar 2026 17:25:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CD741F80693;
	Wed,  4 Mar 2026 17:25:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7010F80224; Fri, 13 Feb 2026 15:13:19 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E9598F800D0
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2026 15:13:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9598F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=RhGz/iT/
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2a929245b6aso10395905ad.0
        for <alsa-devel@alsa-project.org>;
 Fri, 13 Feb 2026 06:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770991994; x=1771596794;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUN5m9KdWt5VPnYVJOX/YZHFeP0Re4SEll9bpIlXeb0=;
        b=RhGz/iT/la563anebBcAImwxh0MN8UT3rqt9TwH+K3zG9OBSfvOT/mw7kaFKDF3U0V
         Ce4pjaSpbn0jX787XBoLayEDfb5119uF2WAkLy5R9BFUE/o6OGKJ8bflhLGHTAvVc5W8
         ltBcEiva+0Evk+dj3Z2zNW/kUWU3ql+yLqVKoJbdhDsKwDcTlezQ4BJ/8O//W9POdb7A
         3roSOxUOvhsxHNTaGNUl9oFUQUjaqxWKSBzG/dY+/NSClqujA6si4AYSADYFHwMlfqbT
         IewT0XmH+6RU0jnCE33du/SwiZeQKn3IMclJ/RUPJdD+IuOF6LmYgL6zBTOdKfFtKai5
         wm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770991994; x=1771596794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUN5m9KdWt5VPnYVJOX/YZHFeP0Re4SEll9bpIlXeb0=;
        b=X1k5KOCqMgc2O1ViVxy50zWViMlk8Sm0zlk5KlZp5IaEgJoEzBnat3+LXmz14JziSS
         X/cqzm4x+utbjxcOqX6eyJX/vRPVHKz5MVDadCklrybm8HZbBTE64sj6C/i5XOw4pMFW
         FTQWXCI1la02tbaQiu634bKehQz48PNVMijLDDzzvJwIDtTSI92eThEZXpdNk2N+jc4w
         ZxymV10yoKCk0uA5YX1Dy7nfOymhnBfO1cmKvEC0YvsM+AS25XSTtY9j9g/jSk46vU/v
         8JAqtqT9WNgwXNs3R/4OpQcK3cMZMkI5ddk2kMK9aYhwEYTYLOOZpZd6mv04zgkGlbVf
         NHQg==
X-Gm-Message-State: AOJu0Yx9fh7HE/aNY9CR83GxHYwt3otzVCVFTqkiQbv5p1PFek8c6XKi
	GYXwmCu7bpdPC7Flbb+dCrNReODjnEZGHZ4q8jwb7Ky8PeenMQUGDN4irurRzCCQ
X-Gm-Gg: AZuq6aKEdxpgy25qIFo49VuXhcmjCb4kFnA5vOL2cifIvwn4ACatT1807urGk5OgInx
	ZFRTEsM7X59YueaWxOUcYpnK8pJRRdQOQ2ZdcIxn8pt/oVXvgHA1pvKYpm0PTtSBvz0XIpJ/8/p
	VnwCfBI4U2rgT7o2ABx26L5PGQYAV2o4lWw2vZ7YQNZYTs/JBEgHctfDOfiMhEyVG4ReJyfJrWs
	AiBgkYAavkEEzmsTmrPWIblTrU6rCmoN6Lh7g9SkKIMzlOuND+Z2zxmGzUKWVZpqsV5OqKrSV38
	Aw8mmM8T16wzJ6xicyL5QVEZgSO+ZbkCFXSc7swWu7TzMcRI3nY2aTvOcSa0fnZQcHhkDz8Knb8
	95llaeHSLwn6cB1mGmIpOKS122yqtPwDenQqfZS/u1a5ZbSlrL+CbUktvVcEAhJMZTEV2CcIIoZ
	f8jMfowhGkPwBVHEIzZVhsbIahXdlKoeTQekyTpPuAbB+bKOmEJycKFKx+hi8peaFDaL7aBxU5C
	G4QYuzjoZd2yhfoHdIlfItHx23CSb0cpoDA8EI=
X-Received: by 2002:a17:902:d48d:b0:2a7:9592:210a with SMTP id
 d9443c01a7336-2ab505b1c60mr18630785ad.33.1770991994090;
        Fri, 13 Feb 2026 06:13:14 -0800 (PST)
Received: from localhost.localdomain
 (wnpgmb016qw-ds01-160-103-199.dynamic.bellmts.net. [142.160.103.199])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29998b2esm85046215ad.83.2026.02.13.06.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 06:13:13 -0800 (PST)
From: Rob Hermann <supgeek@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	kailang@realtek.com,
	supgeek@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Fix speaker output on ASUS ROG Strix G512
Date: Fri, 13 Feb 2026 08:13:11 -0600
Message-ID: <20260213141311.29199-1-supgeek@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: supgeek@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: XHRGDBUSZ6TOWXUFBJ3KTMS4UIS7HXXH
X-Message-ID-Hash: XHRGDBUSZ6TOWXUFBJ3KTMS4UIS7HXXH
X-Mailman-Approved-At: Wed, 04 Mar 2026 16:24:48 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XHRGDBUSZ6TOWXUFBJ3KTMS4UIS7HXXH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The ASUS ROG Strix G512LW (subsystem ID 0x10431f21) with ALC294 codec
has no speaker output on Linux. The internal speaker amplifier requires
specific codec coefficient writes that differ from the existing
ALC294_FIXUP_ASUS_SPK quirk values.

The required coefficients were identified by comparing codec register
dumps with and without working speaker output:
  - Coefficient index 0x0f needs value 0x7778 (vs 0x7774 in existing quirk)
  - Coefficient index 0x40 needs value 0x0800 (vs 0x8800 in existing quirk)

Without this patch, speakers are completely silent. Headphones and HDMI
audio work correctly.

This affects at least the following models:
  - ASUS ROG Strix G512LW (i7-10750H, RTX 2070)
  - ASUS ROG Strix G512LV (reported on Fedora forums)

Link: https://discussion.fedoraproject.org/t/asus-rog-strix-g512lv-speakers-do-not-work-headset-works-fine/74918
Link: https://forum.endeavouros.com/t/asus-rog-strix-g15-g512lw-no-audio-through-the-speakers-alc294/72857
Signed-off-by: Rob Hermann <supgeek@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index XXXXXXX..XXXXXXX 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7859,6 +7859,7 @@ enum {
 	ALC294_FIXUP_ASUS_MIC,
 	ALC294_FIXUP_ASUS_HEADSET_MIC,
 	ALC294_FIXUP_ASUS_SPK,
+	ALC294_FIXUP_ASUS_G512_SPK,
 	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 	ALC255_FIXUP_ACER_HEADSET_MIC,
@@ -9166,6 +9167,19 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
 	},
+	[ALC294_FIXUP_ASUS_G512_SPK] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Enable speaker amp on ASUS ROG Strix G512 */
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x0f },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x7778 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0800 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
+	},
 	[ALC295_FIXUP_CHROME_BOOK] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc295_fixup_chromebook,
@@ -10977,6 +10991,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f12, "ASUS UM5302", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1f1f, "ASUS H7604JI/JV/J3D", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1f21, "ASUS ROG Strix G512", ALC294_FIXUP_ASUS_G512_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
--
2.47.0
