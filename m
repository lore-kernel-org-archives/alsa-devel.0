Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B37C5DF85
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:35:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F54C602A9;
	Thu, 20 Aug 2026 16:35:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F54C602A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787236552;
	bh=X5wlPFwzdG3Ji5FSu+8Qkg3NrdVjpDWyr+r6s94mIjU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=nkkGLNMEBwVwAJK9jsfU5LcrpJ2ncISpZOn2t/tBHULjm+LIKMJJrN+KCI9026Ctg
	 r445YTA2s+AtoZZwZaLLse9IC0+23jCGxCcTN0q73qF3jZi8aLmW1ha+Q3J32gtRWQ
	 T9R3MOjifJB4h2QTKh3oH1tHTsUbzZiyRmrEeaoM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A69DDF8063C; Thu, 20 Aug 2026 16:34:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C102F8063B;
	Thu, 20 Aug 2026 16:34:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5368F8055C; Tue, 18 Aug 2026 15:33:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787060002;
	b=pnYmbaby5mMpE5TwON6hx39UxTOA7j6tSdFKgbg5UgDteVOCxHtOVqK7RHc46FVNDg9M
	 KuHuKJfbHcIKb8Vs7c6BWmq0WRumZFR1ndAQaESWtFu23BOwiWtOZHhXF7huAW/Z6DWCy
	 WXyUjOK2jzKjK4tICtZfOvt87c5Ms86LeCBofirS/LBa2xu5rFj2OI6On3HhCbjSkbVW1
	 EWUOjb8xYU8jGWCbxHIOqNNQ8OzxSrE2zlq9230e2bCGhQo053CkssDDqcb8yJNmtvnQf
	 BY4rtoKRovHGyIAGw1GTFttc29JAAC4TFKBCHxHz3atJLorc2LR0ERU1X9iFsFKHa4A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787060002;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=X5wlPFwzdG3Ji5FSu+8Qkg3NrdVjpDWyr+r6s94mIjU=;
	b=rs+yqClDmTrMOoE2xvLGPsj68weZF1zSDr64w86Iwv3WpV4W5ufgRnahAylSnZKB5vyw
	 46fOiTmRtD4+jPJ/tLLiU5zArjlLJRVaO8BNih5Hxar+162wPCLtmZXd6ZtSMNTbwthIJ
	 VNPCx1KAoUf31e5ppteaM17pKtD4ibFSULAPnfWeeLYIezPwKQ3MukzsCMLMMKM+U27ns
	 V3+PxWMr1q18DPYGWe/DikTRozzKaiJ4of/WbCrwMzLCnoab82OqneQKqOHNUe8U1X+Vo
	 csG/7KAAxYoCrQsPK3i2S8SZLVWyyy1ABh+wUmxNo+BwJWEcNAX4SdYCoSYGGAUZiUg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KuXoAUfR;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BACB5F800AC
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2026 15:33:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BACB5F800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KuXoAUfR
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so4628943f8f.1
        for <alsa-devel@alsa-project.org>;
 Tue, 18 Aug 2026 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787060000; x=1787664800;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1rsB/OaZSnozAXTvZj8e3dKV8TKlmbxAyc0wzvWiNI=;
        b=KuXoAUfRuH2lg9Tp4hk0jtJJZS2dsX0vUa39ulH6n+SPZ1qKvE0RNZAiIW6WlFe75u
         17L/cc0iRfJgHbqb72hVmctfLy6N4ILdTbdB/twMDlUEXRPPjP79oXzCZVh+IQBhjIOD
         ptjvph42HqSVrx0EV1j3X5t+qzo0DZQifTnLwpaxwHIlqNIjtNhiaFwaPy2TV44VoNAP
         BkpPPxcXLOCsHuYXPnNM+iAW1DtHdjczt+axpx2nVQAWOJzakIFkG17TYrxMSSopdUGV
         dMA4NocyAHsOKtY41lqI/EE4rzHl2MmcFylv/Y3CNK34RwtxL74mdXfd0MyjKUTn3+j0
         53Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787060000; x=1787664800;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U1rsB/OaZSnozAXTvZj8e3dKV8TKlmbxAyc0wzvWiNI=;
        b=mBH6kfjfwFQ7Ia/LoYGbWBoeCTdyY8nTuMYVeu6AjGlCqV3LyQ+mAG7jnBOLoIfkAb
         40UBQYfSwinuILX9IN21c0SIrLmR/w4OnoooKgX7byjUyeup/XMbwUIJPdbh59Ve+Lvg
         HTD1Y/+HcAxMED1KVocrcqQGRYfgkWs/OdKCUa6mwfJ2dCpkqSAwwKh4FmTuWK3U8ZpO
         hS5n7dEuV9Y5Y0+/dzSi8w9Co4kayvOGrAA4mWgSFQ2ZMVF/XROa0wSWtxxOu9GVQz4/
         1NFpa5o5JAqyNb8y0MP76OajYLZV9YGuyT7SjYBX/F1ITvbQyJN1H7yuQA1bVu3nyFys
         fswA==
X-Gm-Message-State: AOJu0YzVVSTVmnFfKIOejeE9K1rKvv+ugfzDvg36N3/pohpW0HmbFpfJ
	wAT3rAJQDITkDs2P8P39fS5yiWLuX/M3whOGZtGKPt11ZUCCioH6WHQ=
X-Gm-Gg: AR+sD107llFUF3vmOcWVP7VaJzbL9IbIRlI7d8agZt3hmDD4XBxYFbrIReU+bHi8zRV
	tnIlGdGVErZgWqHTOwlv6nbVQb083n0L1B62a2LdZ7517sjtJR2DY9xn7c4icUWWp5VAy5OPmLm
	SUf53XBr4nKkIuom8vxMBoriz/o50F8agdykIGRb3x52MZQNctldp2qCVEY5zFtZDI5ZZG8dMAy
	slMIO7FipkniViuIRE8IXTiw9pjt1YbKGXK5yK6ZG4F9zIpv7+kAqvJlxfmK4BCCLY4zQRTXqnI
	FEJ/QtpXJnOceN0U611/c25HtwJ7po027ySGJIffy3bopwtI32IKL69pOoN9BqJBp+cI+zOaJkd
	6eoyRqALyCiFtt9RqUXWgMd6aMbcuixm+NRjWxKx3YIB10PD/qyGfT3Scgdjp1I1felfClxQtdY
	hdT4iw0rvczkgOagoJj0ZnjYHKRNlb5/1hZ5jztPGRRKOnsmIugbMB413M050+6ZLqSwqroMw1F
	PqVIOEnv5sKdfQQ8go=
X-Received: by 2002:a05:600c:c16d:b0:499:8ff5:8ecc with SMTP id
 5b1f17b1804b1-4998ff590a6mr469337905e9.15.1787060000273;
        Tue, 18 Aug 2026 06:33:20 -0700 (PDT)
Received: from localhost.localdomain ([31.223.84.189])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996100184sm298460495e9.1.2026.08.18.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:33:19 -0700 (PDT)
From: "=?UTF-8?q?Habil=20Eren=20T=C3=BCrker?=" <habilerenturker@gmail.com>
X-Google-Original-From: =?UTF-8?q?Habil=20Eren=20T=C3=BCrker?=
 <habilerenturker@hotmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?Habil=20Eren=20T=C3=BCrker?= <habilerenturker@hotmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP Laptop 15-fd0039nt
Date: Tue, 18 Aug 2026 16:32:43 +0300
Message-ID: <20260818133303.5102-1-habilerenturker@hotmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: habilerenturker@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 5MZTKLVJPLIILXNHGOZHX3HDUMSJSDUE
X-Message-ID-Hash: 5MZTKLVJPLIILXNHGOZHX3HDUMSJSDUE
X-Mailman-Approved-At: Thu, 20 Aug 2026 14:34:53 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5MZTKLVJPLIILXNHGOZHX3HDUMSJSDUE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch adds a quirk for the HP Laptop 15-fd0039nt (SSID 103c:8bb6)
to fix the micmute LED functionality.

The micmute LED is controlled via GPIO 0 with active-low polarity.

Tested-by: Habil Eren Türker <habilerenturker@hotmail.com>
Signed-off-by: Habil Eren Türker <habilerenturker@hotmail.com>
---
 sound/pci/hda/patch_realtek.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b0ee9b58e..1045bb3dc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4577,6 +4577,18 @@ static void alc236_fixup_hp_gpio_led(struct hda_codec *codec,
 	alc_fixup_hp_gpio_led(codec, action, 0x02, 0x01);
 }
 
+static void alc236_fixup_hp_micmute_led_only(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		/* Micmute LED = GPIO 0 */
+		spec->micmute_led_polarity = 1;
+	}
+	alc_fixup_hp_gpio_led(codec, action, 0x00, 0x01);
+}
+
 static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -8138,6 +8150,7 @@ enum {
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
+	ALC236_FIXUP_HP_MICMUTE_LED_ONLY,
 	ALC236_FIXUP_LENOVO_INV_DMIC,
 	ALC298_FIXUP_SAMSUNG_AMP,
 	ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS,
@@ -9772,6 +9785,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc236_fixup_hp_mute_led_micmute_vref,
 	},
+	[ALC236_FIXUP_HP_MICMUTE_LED_ONLY] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc236_fixup_hp_micmute_led_only,
+	},
 	[ALC236_FIXUP_LENOVO_INV_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic,
@@ -11034,6 +11051,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bb3, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8bb6, "HP Laptop 15-fd0039nt", ALC236_FIXUP_HP_MICMUTE_LED_ONLY),
 	SND_PCI_QUIRK(0x103c, 0x8bbe, "HP Victus 16-r0xxx (MB 8BBE)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
-- 
2.47.3

