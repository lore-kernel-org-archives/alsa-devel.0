Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B30AC5DF81
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:06:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E5006029D;
	Thu, 20 Aug 2026 17:06:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E5006029D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787238408;
	bh=7nknvJ/xUXSE60GpcenQl9s2AIQIuWk52w+RJgy+OjU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ldX1Bzby4MT0++hIv5VhRS9aDekZ56es0ZIqd6n6K/rCIbZYeY5KGf1xnWqmjev6n
	 XdsqqJKyzCZx0OiknSsHeDJHVf9H9JCMixFNxCby+4RdMm6tnDOkijGd7NUj7nTTUm
	 wPHu1qys6nX2HMXTbPK3YmttOpjul35m6x+NXcFY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BFD73F8061D; Thu, 20 Aug 2026 17:06:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 688E2F8061E;
	Thu, 20 Aug 2026 17:06:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D7F7F8026A; Wed, 19 Aug 2026 19:09:42 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787159381;
	b=XSo7ifMMN89UTk6/V4I2aYH6t95JuZPGVpOGAsoxKQMKsoRla9CKO2/K+z496sDX7YSi
	 g7hbTW8yv+V5qaqYe2+q/pTrkxRFvPPU0J0vR1XdKeg+7srg2lgXp2ThG8wEMjyssssnF
	 O3gKvhKWnokDeRY+G4lnj5iaQx0c/fRY6BRvXrikIYECfD2rACeY7rop3vM7MCA2HW2Ty
	 Xg4eY+ZG3aVR5dTHe3qSCuNCVjROb+ejK6yQvqBg7TRgG9mr8hic6UgsnHkmB9hIUrdUN
	 rVJ8YDfQx9w4sAvEuu33Njof7FC0RMcpeV5KDvsZyN1rSuk7JZcpsD33wllA0hEFQmQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787159381;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7nknvJ/xUXSE60GpcenQl9s2AIQIuWk52w+RJgy+OjU=;
	b=GlsktJ7pJLtz4ofJDNSJp72TkOj4gOIJxarPPI241iQHQc8KOrS+VaZTjpzOPiewq1RT
	 p8m3pUbbpmZrtiCu6RFklQGmoWndkyttw13SloKSgCSjpWzV8PfHvNQLeHP0uyc/3rChc
	 YW9oN+2AjjIpesXk96bJLKJhEPSImLLVKl/SFDNqy7K5M/TuLblBYqyAlmdXhipwwU4+b
	 ClCNZjkCcmw8v4EYwy2Vp4r9JewB0fy2oZu52MPMDIKAHdzfC2N7h03oUL+lsJMJKLWWf
	 Hbu51D12v6xnz1NzrsCCFzdD1yl2HEUeq7pc4DOICxN2IOAj5XmyaWK4d0zU8FHIhVg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q++XobHB;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7A4F6F800AC
	for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2026 19:09:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A4F6F800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q++XobHB
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4815bce4652so831018f8f.1
        for <alsa-devel@alsa-project.org>;
 Wed, 19 Aug 2026 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787159378; x=1787764178;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=38UQ8rx9LeWPslgc2rqqK8U5OMGcZldfdaZuu//2MjE=;
        b=q++XobHBGLrcQ7Ir2Nsu/F5le3Xy2Glzvm5HXtXzm2Ij1ZOqXjPYE1X+WxnLPb7FI9
         /OgGdvsPNmcAAumm+lFXmnry1c2rOmc6htPzuu9WPCGuirpoPxnPZzYG+HL6q+PDGwoi
         eM3hodQBsQtU+9nH0hlfjj6+OBJQW2Pvkm3sihi+gXRCxrj/Yys48KU/Kh0FibTkr3jB
         Iy/1YahdTbyJwN8j35+fGe6BSEe+vy3mc8bOfdmzVnkLgk+VUOhzj+VfyAv3nELpdyCw
         VAy3fgSPegcWqegk7ynxFE0anOh4gl1clAhnP1qbrR+t3HYQeQzSbqWG67Lt+d2B6wql
         HJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159378; x=1787764178;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=38UQ8rx9LeWPslgc2rqqK8U5OMGcZldfdaZuu//2MjE=;
        b=EJ7UuGUgi85kxybw0E+ElXzBCrpkcdLjBr3bL8AjK4xwE+iB6vHkzlxAxRJOOgvcxk
         KSW1Gb7d+4lol5vKZ3Lvf8LAnF8OMmXE9GdCH2uhtdmy1+mK4mWf7B6y7bRuiNr/tLX9
         lT/6F44wYAdnd+iAVEAH3cKydYAv6XDVj+X51OW8619dz/BJ8RU72gCST27jLHQnuaf8
         vIQ5Q3GZ51eNKF3hWrHfInAMbOo4MahDb6UMyppRSvX2NZTeDnxJp8wIKfysdoTd/MJY
         znWneoD7Gp91mmz61cq2CmPuVAKK4wJuLklbitu9D4TmaIoGpi0Li7xroF1xPN9R9Hag
         6vcA==
X-Gm-Message-State: AOJu0YxVy1ZR18WvcYbj/y+Wv+vHCLRfpgwu0In5EJ74DILVlbBc1Xdg
	rfubL2cuROS76fHCluLgHazdbWa4yKyiU1o+h3LXM2T1svon8lJKMZQ=
X-Gm-Gg: AR+sD13qHIwWBDL65j1C52CcAt1GP/TMA5Z8pmb6GjOLoG8RPNzt1hFnCqMK4w6SWxS
	CB56Gq8D1XWF3zJHETG5/9TksTAUBFhxgGfJbWubaH6/XbA3LvHp2u7fH26UfgtsrXgI0yvJ97B
	nXBYMqKTfkkH5Bjqi8oUmzzHmCuzR5GxEzzbUvTzkkjKMIaBoWtpzx7FF3c4xzcMVCnH5PsJ9L/
	rwMg88MZxax/Mu097qDcUV/U0oqMkQ97HQYlR9iT7r51HzeUkG/8R+kYnhhtj39uubthXok0DxE
	UGfJ1PzCiHwBJrPVCeceg8k6iyXovrMk58vtQd5s1/U+jD67UtO/bgniGWGUYiJnRpAvpDH+h7o
	tS2MijH3BEf1arVReBiqNK5hSvJpshnRn6hXU4EAN5VhCafVGe+mZdV+FSIAJ/pKZ89QYFetuJF
	1bxLIkqyaFyx5TVO8Oa129yMTZuildz0wVIhxVeieozArx1+aMS/adKDeVPSbRaM9rvlQxNRzRB
	/+qWfrI6w==
X-Received: by 2002:a05:600c:37c6:b0:499:858f:2653 with SMTP id
 5b1f17b1804b1-499aa14b457mr128814135e9.2.1787159378327;
        Wed, 19 Aug 2026 10:09:38 -0700 (PDT)
Received: from localhost.localdomain ([31.223.26.199])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1947c6sm68769985e9.15.2026.08.19.10.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:09:37 -0700 (PDT)
From: "=?UTF-8?q?Habil=20Eren=20T=C3=BCrker?=" <habilerenturker@gmail.com>
X-Google-Original-From: =?UTF-8?q?Habil=20Eren=20T=C3=BCrker?=
 <habilerenturker@hotmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?Habil=20Eren=20T=C3=BCrker?= <habilerenturker@hotmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP Laptop 15-fd0039nt
Date: Wed, 19 Aug 2026 20:08:59 +0300
Message-ID: <20260819170919.3172-1-habilerenturker@hotmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: habilerenturker@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: GVM7NBIYBK4IPGPDPU6LTZP66MRHBSHX
X-Message-ID-Hash: GVM7NBIYBK4IPGPDPU6LTZP66MRHBSHX
X-Mailman-Approved-At: Thu, 20 Aug 2026 15:05:58 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GVM7NBIYBK4IPGPDPU6LTZP66MRHBSHX/>
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
 sound/hda/codecs/realtek/alc269.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 48a2e7f2e..01b87267f 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -1364,6 +1364,16 @@ static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
 	alc_fixup_hp_gpio_led(codec, action, 0x08, 0x10);
 }
 
+static void alc236_fixup_hp_micmute_led_only(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->micmute_led_polarity = 1;
+	alc_fixup_hp_gpio_led(codec, action, 0x00, 0x01);
+}
+
 static void alc285_fixup_hp_gpio_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -4086,6 +4096,7 @@ enum {
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
+	ALC236_FIXUP_HP_MICMUTE_LED_ONLY,
 	ALC236_FIXUP_LENOVO_INV_DMIC,
 	ALC298_FIXUP_SAMSUNG_AMP,
 	ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS,
@@ -5828,6 +5839,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc236_fixup_hp_mute_led_micmute_gpio,
 	},
+	[ALC236_FIXUP_HP_MICMUTE_LED_ONLY] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc236_fixup_hp_micmute_led_only,
+	},
 	[ALC236_FIXUP_LENOVO_INV_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic,
@@ -7330,6 +7345,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bb3, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8bb6, "HP Laptop 15-fd0039nt", ALC236_FIXUP_HP_MICMUTE_LED_ONLY),
 	SND_PCI_QUIRK(0x103c, 0x8bbe, "HP Victus 16-r0xxx (MB 8BBE)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
-- 
2.47.3

