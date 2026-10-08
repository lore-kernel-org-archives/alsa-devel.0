Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CE4CA6017
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Oct 2026 19:42:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82E686025D;
	Sat, 10 Oct 2026 21:42:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82E686025D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791661360;
	bh=V0/16htqebB/8TM85S/qozxMSwXr5jIDRFTSzbN3uG8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HRofGocTKCXMDb2tXdqV29XWHx3iUAs5GMsNqm8YdiF7QZLz6zsUxSH9hkpAmBRXH
	 eA3L5DrI+5Q+n/qDbW4XOHxjum0g+Nxk69W6ZS54p48Mhb+mF1b5jHfmJiZXMJYuWW
	 GUV04ChVxIlx+3wD2aTwC6/rQysBug4LWgES0Gys=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70D9AF80607; Sat, 10 Oct 2026 21:41:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23DE1F8060A;
	Sat, 10 Oct 2026 21:41:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E003F80557; Fri,  9 Oct 2026 01:08:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791500929;
	b=OfaG13zdSrbb/p9fkyTQLWJmoeIdTwsvzYSSnuCJJBN6J1RuCWI8Jv/JwbgVAyu8JRzD
	 3jYxE5gx7R4+GXukyPMBBEpaIJ2nxjcuHwTnIRC6AzdnXU+6X74bMCqWOjcbe7EAiNy1a
	 krkxSBvqQaNmlcZVyZx2CuE8pfI2vp6VLYTZl6rcTE/k6wLPbXn13Oadi+E1rhVgyAFA7
	 PvcsukbY4uJddORCLWpGJhxsBov8FtniU9aIHDKFcYfxdNz19e5v1b+4MlTBhtV25JEv9
	 EajVR1O8aRSnMQIEnflcTXb3H1vDnXiCbpTwMdPVwX7dOrRvSsb1YOseVrMc9bfRRjg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791500929;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=V0/16htqebB/8TM85S/qozxMSwXr5jIDRFTSzbN3uG8=;
	b=HYYsC8q4YuXobQvCu+IKkkM+4RvLf72ZzFc/YrGDYHjdyprFtv68QeNBBw9/gCFxW2JR
	 JR/TlHqUb+YdSrKq55RE0jeLYXGvbGVQ/Eh8KVMTaEuQlXPazW4OcrlG/+R53OGXel1Zw
	 V/5KfBaJbMVD9mfnxJZRcQuuudjQtvWYYKDFLxBPgDrS+lYnnkAJiINSR2MokM+TEorG3
	 usDqebL7EOmLHXpZCxMza3mSi/sQ49kFr1Y7jvp43fGmCfBL+45i05b9Qk/PUvthSPWFa
	 fK2bLSTZIRTZwNXvA0zM98nnexbOjLpQtGQVHyM06RIrDuFHCt6JdCxx4lyeOGEeZ/A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KVZtkcgu;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 29BBBF8025A
	for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2026 01:08:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29BBBF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KVZtkcgu
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a02718da81so26932735e9.1
        for <alsa-devel@alsa-project.org>;
 Thu, 08 Oct 2026 16:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791500927; x=1792105727;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0IFuL9k0j9ydZbshhVfJaOod4wFMCM2kpIm/qPno78=;
        b=KVZtkcgubCQMTkKn7AfY15q0flYzy4Fv7XXF0H3aairzVJC9gGH5f0bCkoSnPB6bXV
         UjwyuAmwZaSaPtk1GdS9VwMeEoaIhc20NpF0ioDUldQk/uFyHULQ+eqb+vrFiJge/eqV
         TP4PBph9D9BNQPWU6aA8jSRVC6mDc/RroYIWwFp49rvNhAYeuHr4a1lARLQ7TZXNGtWd
         oqJXm90m4AU+ubrNXJJKOjk4InTDHlHlxtdqIBptZoZRRzvTF31tHEfsE+bYcfsRpsPI
         ijKQ7cgRbGdseXSn00PeZVv8mJBD5NiLYJ+11d26b/Q9KbLF7dM4dxCo/RuVxlGHpAfj
         GoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791500927; x=1792105727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H0IFuL9k0j9ydZbshhVfJaOod4wFMCM2kpIm/qPno78=;
        b=L0kLmnU3WSeywhSMUVEljnzzDxX4FG4TnjIZzpojM+X5JPwv0NpVyStdxMHDIelJm+
         SPlCACC0YuZLFyEn5jY6ZwcDpCpMED9IeIjWTCzaFDCXUasYlREdZVyIz7qyIe6wZ3xz
         lg/fyDITPpIj6DSfL9K5HfdhyPrK6LDYGxCiIExbRVC/KXb3eS2t+AQwgiIOJz/AzMJQ
         9FXPFBLqh50wZV+KodYjqG5hL5QNK1cgidzZ2yZhNyiAim71ylYvjoVCmJ+2J7psae1D
         aobHzU04Q9HdR7gPwgBnQ2Ku6aCdRruJ5LtpHBGJlqeZawTVxXaNxjsJT8w8Z0z9cXzc
         x4Gg==
X-Gm-Message-State: AFuF++nPzl1apHx9JLjDaEbEKhogjD5NKA5KP0bw7TUWENWQYv6vmuXI
	mTYURjCLmjxaulf8EmciaDlEbMtfUdn1i58xwNZ0qdRx6/7kBnFNUFW7bZF7Vt0O
X-Gm-Gg: AYBFou2I3690/l3EAMK/5m+xehTSmAXS0Grpgi1Z5xfRPavJBuLzt4i3WyIXR50YceH
	ZBdlr6lYnEuIcXaYSbZJeZeBJen8C0Iq3mH3XovDWBECZAlFeHl3B70ja1eQ4bmdLLDw/lYlxxU
	rhZ6zl78DFQiFOSrXYHlfMwAReNsu1Dh3c5bIqhCeqwbvrU0NKEvIJr/qJgR4V8fNJxogW+/kLn
	eR/UFSl3as1SLiPwhJT7dAZdM1NRynVqS8lgizISeI6tISC6jPH29tGQei7khIQ2exSy1uFNqcD
	ae79r37Xpv9WVu6bDmPWObDpHJLESZPmQMWlgtWHPFOsup4JykV/WXJaaSHElIMMTPgB8Dgn6Gi
	gt4YcXYfgG2B+mMWjjeveE/M/GLE0Iw9Mc8eAe1G+mJXY9Yu2FXFXkQyG8zgNiuxy44U5exCrn4
	ihmJaC/OnTUptu3YZPf7rZBznSAvwYiY08dx8EFL0OCK9hH6s7JGbXWUIW4NhAQdh+5pO2at6Qa
	qt//7M2nexmiFzwqgnqihNf4jc/91lvjGa/hBJNs9GZGu2421pUtnHfwEY7Orq+QV9I1YBgIlQY
	kUz/0vQyYS6/9F6eUe6xLRok7dd0uRbzv2SpzlHI3OvnEqVFdfolurZKDS3Tps2gOUMZHZRHlrd
	RXKeIAR9+peMP6EYyTd7k3GKrS7oupHwlIe0sJLerRmqjVcmF8bgh6Cw/vvOcv8ZRSZZPluxvyf
	1aHylmzL+uJ5RMdNpUgmrFaMM0Mw==
X-Received: by 2002:a05:600c:4ecc:b0:49e:7a10:1b71 with SMTP id
 5b1f17b1804b1-4a1802e95d7mr127375585e9.11.1791500927140;
        Thu, 08 Oct 2026 16:08:47 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:415e:bf71:e574:69b7:f11e:4204])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bead84esm14244115e9.13.2026.10.08.16.08.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 16:08:46 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-usb@vger.kernel.org,
	Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam
 C200
Date: Fri,  9 Oct 2026 01:08:44 +0200
Message-ID: <20261008230844.11246-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: olivier.kaloudoff@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 5X52X2YDM35NEFDP5NSGJBPH2MG2COAN
X-Message-ID-Hash: 5X52X2YDM35NEFDP5NSGJBPH2MG2COAN
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:41:35 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5X52X2YDM35NEFDP5NSGJBPH2MG2COAN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The C200 (046d:0802) reports a mic capture volume range of
1536..7680 with a resolution of 1 (6144 steps), triggering
"Warning! Unlikely big volume step count (=6144), linear volume or
wrong cval->res?" at probe and exposing a uselessly fine-grained
mixer control.  This is the same firmware behavior as the other
UVC-era Logitech webcams already carrying QUIRK_FLAG_MIC_RES_384
(C500, C600, C210, C270, C310, C510, C525, ...), so apply the same
quirk: CTL_MSG_DELAY_1M (which the Logitech VENDOR_FLG would provide
if the device-specific entry did not short-circuit the lookup) plus
MIC_RES_384.

Verified on real hardware: with the quirk the warning disappears and
the driver logs "set resolution quirk: cval->res = 384".

Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: stable@vger.kernel.org
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index c5870901a..16cb57f2c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2249,6 +2249,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
 	DEVICE_FLG(0x045e, 0x070f, /* MS LifeChat LX-3000 Headset */
 		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
+	DEVICE_FLG(0x046d, 0x0802, /* Logitech Webcam C200 */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x0807, /* Logitech Webcam C500 */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x0808, /* Logitech Webcam C600 */
-- 
2.47.3

