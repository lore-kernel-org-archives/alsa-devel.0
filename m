Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF63C5DF70
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:59:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83D0E6024F;
	Mon, 17 Aug 2026 18:59:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83D0E6024F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786985956;
	bh=iY48B6yIGmMWq2phMMQLEwrXIhbxvRbfTHOigLv51HA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=P7RdkCrr0E/OoST65SDuDDKQEwirKx0bXqhrUGe+bMqMHx6+vFWa9GLAE2x9t+zTq
	 Mp8M2KL4vvDWR3b73nbyFBYK4EI1TuBsI3ph1AI1gudwHGBEdQbDzUFlte3ekbSOk+
	 ip2wZwDyyTLBKLoD1DGCjZvos+2h9yTVAcWLEk74=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F02FAF80693; Mon, 17 Aug 2026 18:58:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 552BFF80694;
	Mon, 17 Aug 2026 18:58:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5BA9FF802BE; Sat, 15 Aug 2026 23:49:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786830588;
	b=jlRyckF5bEve6QiRqcAe9NL2ON1za3Xz7YBHgNKVNWv8wIKi67Zwzk7oNwK33UWbOBKW
	 blnJmR3qqFkzeV4b2nAPckQlfw9y/Pp6wCkAQKDFxgukDWxB4BqhxI3Sh4KYqfhLytaxx
	 AcxLkjIGv/6GO00v+ZX1zSH+6HpvdmkQOvqE4bfj6QhRZZMtJP6i9DGKWAbBhPOxSneqt
	 lJXhIw8aTbrNfvvaKdAQ+o6Ehf2uOw5aqzdh73WO72AS5rTtlCTQ/zcmXKjMCYh2t8p97
	 wYc09cmw8uduDcuFoUcjqCYKrOHymCuVrvjqRYJXm0RLQbGIwrua9KdMzwTK/lhXMhw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786830588;
	h=DKIM-Signature:From:MIME-Version:Date:Message-ID:Subject:To;
	bh=N+WRXIhPUlKUu+SHdjrtwe6h6JGKi0HIRB3pUT49APY=;
	b=r9YXeYIyhfiAZiEeIKjz/R3ilUHbig8eGaKhYk3HaDxGrBEDKrwwnz9yBfd2okO47o96
	 sLZ8t0tNUX7rIXVk7VMlSD37JdNNRbwAx/jORMlHqCrYLhN11zVprLkRsmYhmHltUCq7f
	 guX0oPd9Xiuo8WY1HfIR2IR0J4nrZxAQlMTfGll1VTm19lwtyFtWKJxFhrrxHSrjkF/wm
	 d1Hi0Cx868dlBzdSUxmIhlspRHQaQhnAe0G7D/u0qoU5QmSdzQfe/CMMU0vBAjlbHI9SP
	 OAqcinI6qfTSYRKJ9LGUKpHnN7iFmBn7thcU8Gsr65xHPyUW/LQR1/XR7sgkz7Ma6NQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VZOOTBgo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5291CF800C1
	for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2026 23:49:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5291CF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VZOOTBgo
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-66c70f05859so3393094d50.1
        for <alsa-devel@alsa-project.org>;
 Sat, 15 Aug 2026 14:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786830585; cv=none;
        d=google.com; s=arc-20260327;
        b=gFLdpo3EvwZsjZeUV3eunqEM6jndOA/zD5nLgDPfs16vWtAwk4zlRbx7/lZmM2vp9j
         +xltpUzFVwdWkDy688/61UoSm6MAxp/3r4cJ155AU+7paFy2kCYAG/uYUAWILAGNO797
         H+yyE0QD355H9HwP3thz/MfoTjNpFqJudTV2uA9abUft8dhBMZgwFhhNI+4ydZ/JO0SH
         tOiZKmRrezy7G0d9VgCSpLrwpFTuWAn4ORlKkdHlN+nU6u6RvAiL+GlXd7hfsxlXQPKw
         d5taeHQmXMDdgn+woSjeNFw/bb0z2PRb9RI9XFJV9ThZhBHmBW39F4EMCVfax1O9kxnY
         u0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=0BiwD8sPUqgXhAkIy+YMgazrRCdFHB5CWVQZDyDO1H8=;
        fh=1pSQP2iqoMBKp2TqnTlMe/WRCBxhNKATpMBFYotYgrs=;
        b=jAMlHWxtNPhjZyf1wDNj8Z4DVqLwWg5Mz6qwJ5Qeu2NDcIY7br2uoSbLUidp3bWAuf
         YOsRwDnWnOPWj34RyXmxldEJCCCodQO4/fA1ljpnxITTUk2bl70tOfKq5zreupt0uLrx
         PD5qqGu1dwmH6aqIyUA+ENjGLeNjkm/cy/D7J9+ghx47N6EACSTmGSwE3B2HMTi1NLzR
         //FWet6jBV+kEsZF5ZI0e4o9aqIDqlowqFK9rW0zs6OoVsxMUInxzJUL0AkfMeHJvAyi
         Vxr8dlPy56tfanh0Zuc1CoprQnRO40d8JMKF8HqgIxMSty5CTe1crfNiEhXASXaUUnad
         2ysQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786830585; x=1787435385;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BiwD8sPUqgXhAkIy+YMgazrRCdFHB5CWVQZDyDO1H8=;
        b=VZOOTBgoFNcNc69Vwvco1wMu3BMpb4y6IjhDEmyIK+ZpSUxPYE03zklgxzYwtDMEfD
         WsA5tiv0lCC1/C6Ag3T4iNamFh8wjyOykw/mvsDoGymDniusK3MBCu0x0lrUxCwWr1tG
         KSikvK0u8XPtvDYE4GLgblZOkE7IxNtMAUIZpntsMP/86bQwcAN0mwYe7LvVGV17OcHS
         r16VZ3kq3aTPBQfIqjZLEmOTCtyS9mLkyQm7bJWFmBHB7ORtwyHSC3z+NRiBzw2WsocP
         kemCpmH0mBLpIYJdyTD82YlWV7/frgLY6p97JVtNrG56gtqDdSZDEzmlOSh6y25Ymcdb
         n6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786830585; x=1787435385;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0BiwD8sPUqgXhAkIy+YMgazrRCdFHB5CWVQZDyDO1H8=;
        b=Y8JKCraJTDB3BNx0t+ltmM77Aq4SaszPfW4Tp8JKDP5ctB2W/sx/CqemfH+pOV+Jwj
         DwW2YsLmxx3SOE7MIyW9yshplJz8hyET9RPPnBZG4zC/1At2ceX0QE6YYTrInS5ZzeuK
         fc6AFlokKnjI7e66ucIXFWxG4Rz0Q5vDAmr/s6P1Hl4lx9QRIbXgsiKbNnej1opDx90M
         2dDo6unIRbnCavEf/32LyYkdr4/SxfEXpSOZLLgSeMGmRfelMUbJwNWYu55xMiWrqqhG
         ngQ5wLb4dDg85iVmAshrIQmUjddiYWVtNyH19a3LSoP7cFfYLtUqW1fCYfDn8eTanaLF
         wHAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLgnLBe98WRx+N3LCwjziu/K1egglNHUdwkMIp3PmmhtuhQFlcXWJnQfjiBqLN5jw4HCmFqkurkB0H@alsa-project.org
X-Gm-Message-State: AOJu0YyiVyMJguF0xcD48gcqdGoWdBV5tTpjc5s8OhP0BSkIjmVCDlbG
	orHYCuH6e9Ms1cfoDG4tYIGK95tc/We8n7/V6GrVeA4SnOvvL6RQrXgHiJ5J/YkXlm3g9+afdGc
	mPM0H9AGX+ZulLTIutHtGlb+W32J1MEw=
X-Gm-Gg: AR+sD11FTgPBvfeve6isXwhKgnsAfxpqIIQVQm88ETbfIefv3vzQyACPmV3l52wCGQH
	58xHHql22FPG8TT+PecxnDL4EPtLWQ5QPDvQ7WHSOqyQgkquU/a3LOt0Bln8oCy0vHnbLoytSsf
	OJZ+CRnJV0/PJaNaXJN85RVJSG84xyNoqAjxJsm5kIkRT/CukIFNM/29795REp2JOX701C5dZsm
	kSSHECTa3I3j7X3BVQCsZyhBFiwA9DB18kvxihb+VtmFYLQhX8/7qAUX876nXVzcHrYq/k6L660
	QI1+T/MHisgPbggMn955G2UQkaArITJ1zII+LG5vXgWj2YzYwNgbd+tMZ4pBtJ3f1/C9bd2Nu6O
	dgQqqAZWy8Y8IhLoFmmVyWZ9rQF0LhZIrEQ==
X-Received: by 2002:a05:690e:1919:b0:667:b503:4d2c with SMTP id
 956f58d0204a3-66c72c7b4c7mr6047858d50.34.1786830585153; Sat, 15 Aug 2026
 14:49:45 -0700 (PDT)
Received: from 595171893313 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Aug 2026 16:49:44 -0500
Received: from 595171893313 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Aug 2026 16:49:44 -0500
From: Gemayel Lira <gemayellira@gmail.com>
In-Reply-To: 
 <CAD96ZT+SnRnGr4Xd+NJkkVNpj8XrzL3Ete=pRgz05mqxAzbU2w@mail.gmail.com>
References: 
 <CAD96ZT+SnRnGr4Xd+NJkkVNpj8XrzL3Ete=pRgz05mqxAzbU2w@mail.gmail.com>
MIME-Version: 1.0
Date: Sat, 15 Aug 2026 16:49:44 -0500
X-Gm-Features: AcwNN1Vh1UXUffNE20WOQlk8rrHfVo8m9exbmMInY5AKJlHtitvNy9tQg65hqjE
Message-ID: 
 <CAD96ZTJzEwiNwJm4ujLS4+X_KChi4+_sD0j-m+aE+_9i+eUGcA@mail.gmail.com>
Subject: [PATCH v2] ALSA: hda: cs35l41: Enable VSPK on UX3405CA when ACPI
 leaves GPIO1 unused
To: linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
 alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: gemayellira@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4VRHBSGOSTJMAUIR4TJXEWJO3R7IZDJE
X-Message-ID-Hash: 4VRHBSGOSTJMAUIR4TJXEWJO3R7IZDJE
X-Mailman-Approved-At: Mon, 17 Aug 2026 16:58:01 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4VRHBSGOSTJMAUIR4TJXEWJO3R7IZDJE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

v1 mapped 10431A63 to generic_dsd_config and INTERNAL boost. Stefan Binding
rejected that: this laptop is external boost, and overriding the ACPI _DSD
as internal can damage the amplifiers. Takashi agreed not to take v1.

v1 also loaded fallback firmware (SPKID: -19). After some S3 resumes the
right amp failed with PM resume -110, then SPI -16 (EBUSY) until reboot.

This v2 keeps Binding's missing_speaker_id_gpio2 parse of the existing
_DSD (external boost, shared reset, gpio2 = IRQ, speaker-id at CRS index
2). ACPI sets cirrus,gpio1-func to VSPK (1) on the left amp and unused (0)
on the right, so the right channel binds with VSPK: 0 and volume drops
about one second after playback. After parse_acpi, enable VSPK on GPIO1
only when ACPI left it unused. Boost type is unchanged.

Tested: ASUS Zenbook 14 UX3405CA, Ubuntu kernel 7.0.0-27-generic.
Both amps: VSPK: 1, SPKID: 1, firmware
spk-prot-10431a63-spkid1-{l,r}0.bin. One S3 (deep): both amps reloaded
firmware, no -110/-16.

ACPI _DSD (SSDT SPKRAMPS), excerpt:

  cirrus,gpio1-func:  1, 0
  cirrus,gpio2-func:  2, 2
  cirrus,boost-type:  1, 1
  reset-gpios:        shared CRS index 1
  spk-id-gpios:       missing (CRS index 2)

dmesg after this quirk:

  CS35L41 Bound - SSID: 10431A63, BST: 1, VSPK: 1, CH: L, FW EN: 1, SPKID: 1
  CS35L41 Bound - SSID: 10431A63, BST: 1, VSPK: 1, CH: R, FW EN: 1, SPKID: 1

v1: https://lore.kernel.org/linux-sound/CAD96ZT+SnRnGr4Xd+NJkkVNpj8XrzL3Ete=pRgz05mqxAzbU2w@mail.gmail.com/

>From c325bb06bb37fd658f0250dc8571b5bb6b2c7dbf Mon Sep 17 00:00:00 2001
From: Gemayel Lira <gemayellira@gmail.com>
Date: Sat, 15 Aug 2026 17:16:18 -0300
Subject: [PATCH v2] ALSA: hda: cs35l41: Enable VSPK on UX3405CA when ACPI leaves
 GPIO1 unused

The ASUS Zenbook 14 UX3405CA (SSID 1043:1A63) already has a valid _DSD
and uses missing_speaker_id_gpio2. ACPI sets cirrus,gpio1-func to VSPK
on the left amplifier and unused on the right, so the right channel
binds with VSPK: 0 and volume drops shortly after playback starts.

After parsing ACPI, enable VSPK on GPIO1 when it was left unused.

Signed-off-by: Gemayel Lira <gemayellira@gmail.com>
---
Changes in v2:
- Do not map 10431A63 to generic_dsd_config / INTERNAL boost. Stefan
  Binding rejected v1: this laptop is external boost, and that override
  can damage the amplifiers.
- Keep missing_speaker_id_gpio2 and enable VSPK only when ACPI left
  GPIO1 unused. Boost type is unchanged.
- v1 loaded fallback firmware (SPKID: -19) and, after some S3 resumes,
  hit PM -110 then SPI -16 (EBUSY) on the right amp. This v2 binds
  SPKID: 1 and official spk-prot-10431a63 firmware.

v1: Message-ID:
<CAD96ZT+SnRnGr4Xd+NJkkVNpj8XrzL3Ete=pRgz05mqxAzbU2w@mail.gmail.com>

 .../hda/codecs/side-codecs/cs35l41_hda_property.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
index 416d7bf..0c09094 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
@@ -450,7 +450,20 @@ static int missing_speaker_id_gpio2(struct
cs35l41_hda *cs35l41, struct device *
 		return ret;
 	}

-	return cs35l41_hda_parse_acpi(cs35l41, physdev, id);
+	ret = cs35l41_hda_parse_acpi(cs35l41, physdev, id);
+	if (ret)
+		return ret;
+
+	/*
+	 * ACPI on 10431A63 sets gpio1 to VSPK on the left amp and unused
+	 * on the right, so the right channel binds with VSPK: 0.
+	 */
+	if (cs35l41->hw_cfg.gpio1.func == CS35L41_NOT_USED) {
+		cs35l41->hw_cfg.gpio1.func = CS35l41_VSPK_SWITCH;
+		cs35l41->hw_cfg.gpio1.valid = true;
+	}
+
+	return 0;
 }

 struct cs35l41_prop_model {
-- 
2.53.0
