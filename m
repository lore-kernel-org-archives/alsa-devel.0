Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FB6C88E5C
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:29:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA5E66021A;
	Wed, 16 Sep 2026 08:28:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA5E66021A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789540143;
	bh=+begMGMuX6wapIUXJ+/wvyRffcEI6jV5c9hgs33aP6Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=BYSlop/YFy1KP0c5icIhOTsOVVOIzX7iMcAb8+0DbzUQCLy2ALem9/rpJ86FIn4bG
	 5C6OfRyn0iFjGJfzeeYsr4wVtGAK1kv+cUHqScmYa4d0ioNcLnO/5wH4tISVydOIKL
	 8iW5KYlxqAk2QGz2Ef0nbzv4PrRdy/sr9ha/XdUU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0939CF80649; Wed, 16 Sep 2026 08:28:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BD6DF80638;
	Wed, 16 Sep 2026 08:28:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9678FF8051D; Thu, 10 Sep 2026 19:42:56 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.225.76
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789062175;
	b=AFWoz0ONe7SG05VvRP/bOLdjZ89f85TRff1IATqdypSrrUACGRG9RXow0uv4wvOcM+3i
	 dpFmc5c2x6JV3yEPzPEBmYO50kdcTLYhqwVVES3qmqOTUBfE7mldqKhY8fnCC9bcGwQkZ
	 egsvLG//fRiP14vKjugWzJL6UE444fwn/jAqbGEd3PvHsKiYoZPAhW1Bi1m7lpJek/yGj
	 HdcGsOTwEAg1QijmzO8A++tTZDd3HpCKtG1SFTA75EHBr0kIWG8oUmF2+n+5ZNWG2Dwd8
	 998GCr22pK7v6Yl9C8yOPL+SV0CiD7OvIlt1FQIUCNJ6C0Aqmghk2AGJPaTwdnHIhhA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789062175;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+begMGMuX6wapIUXJ+/wvyRffcEI6jV5c9hgs33aP6Q=;
	b=XENDZsE27eTlKIplOTbWT6AAX+ZptA/bKPHjO4NztHfbgKrb26bu+5s+Uokc/+9U2eC2
	 3wr83naIcsRMkPDXt9KGcx+Y4kc8JrjZtsAfonYO3M/uQi64pP3r6PgV3ZLbH04pIe5q9
	 2xYuzUfZR+yeTsJqddqxL0v+bLVugsZVQjT2bIG65Dz3aqko1zHc2Vbre0Wi0uZW1vbwv
	 S96lgFo6x++/4BDhDeD0qwqUCRJAo+Kz6fad8IijG+XBQdxbGiyiiv7gjS5VgiwGhZsHB
	 WQwSgZWTamgsCN3kOCbdt/Boa3WCbzioK7moWXUJFVvGr0EDxXt4dZflhcjOGCpmwqw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sAdRZwG6;
	arc=none smtp.remote-ip=74.125.225.76
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F519F801F7
	for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2026 19:42:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F519F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sAdRZwG6
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843172bff4so4931f8f.0
        for <alsa-devel@alsa-project.org>;
 Thu, 10 Sep 2026 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062173; x=1789666973;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lrAOUFVmnYnE4uOatSz6X9x2GKFe6/CTdkNVYaI1tsU=;
        b=sAdRZwG6I+ZgZJtQdi6F8K7LH7dEzmjjLqD2UkOFk7GKAmTSyKCBbAno71eEQTaBvj
         Cg++21St2ueAISgP2KNdB7CzHdiZ+6AN33fGHd2kPazDYp6m9ATMNdk3A7+e6yVW3kAH
         ZQfmo2kTcis4W+4JlB1DJFpPi5jckILexrcZzATCgsxqaSLDvo2m56mfNqq15CH1qFgP
         VhqL8fGWIrzJvQJHVkHJ2cxlGjTfR4Y0ya/qxp2cWAh76ctFMmC2bgIyP3H9mVJtNSdC
         b6XmFwpejQSkfi/HFMWoD0FCsPmzQKyNA+fB6vYR1y+iKeMn34Cgk2usbm94/ick5Ev4
         ZAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062173; x=1789666973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrAOUFVmnYnE4uOatSz6X9x2GKFe6/CTdkNVYaI1tsU=;
        b=de9SpeYY91Rbkh1MbR/wIm1pxsZlfIijfpvyvi+5B7+5OL6QRk5Auf5RiO7dNsB7zP
         OfgHKIMABG/zoNcGgqb9a/8mo0BYI2AlORBLAoK0/POOdfTGqieZBKkTGrPWYaZuLI8S
         NhISvMjwbMMGXwYarofcm5wQUyt4E1BtKVa+9zGaRy5534/ZnjpKEzp+S6TkKE4oR1HQ
         CbskKRS40uWT2X/v2pnnQoaF1z9I8Pf7GtaAie4GnHnx/Dq1Fos8X8E2i/uyuqr6KSse
         PW6YcV8u8NkpB+YafvBOMWLvp997oNvd8GA925dFV6aS9GJdwqVBFWQ4QYvsTnnj7bSy
         1XFQ==
X-Gm-Message-State: AFuF++nIgrH7KgoJn4zunX2KRwJMI1Rw0QzHYcM9T6r4R5oaSShC9PoL
	EFYc6zvwdbkhAaHVf4OkXzpsYcJv+lzaLNO7CLT3YQguqZ3oiN3luyr+
X-Gm-Gg: AYBFou1TXphTcczlMWWvoHj/Ofst46VhluBLln4XAo9C8sAA883flgFg+tqAcHnf0dV
	k+VBwPFRvWay6+onzyVKu5xSz4qA7MgVPJ7rxmCltgRcC/hDooaNC7DSB+gQF157rz1xEyfCEp8
	nzC7NvWaBmlM4QDkLxZls90v92de1zd7QtxPstVvZDvzLhqcQodyzJMy2IGiFvEPKtX00wR1MuQ
	fCT6C2UEo0y6BJznj7W3BiZmrXIdw74H719cJxljXB5ZqeqYfUnVaMiuXTJ2rQHSEwdK+UMyp8z
	a6IM/iQShMi3LfDdjY6ObHM6rRu2a9WwudNkAqiL0BNwNuDvv6FNZ2qUYOhrwpr5gsnQ0KhaCsV
	T8wp8xl7vNM7Okkc+1cs9XmXqd7MAiKH1ROblbaBc/HM3DlVArvSmPRFAgvdm8NdWy5//eIA+os
	SxFMntWium2RyuAobanp4FLZyq3iRf70ulpGt1cX8jd4fisfJP/dUXUjP5IeZq7EPmnLX4+aqmv
	/7lZnnGD9zsVPoTDceXWXmvZrnfabko9rQJkDnJsx5IB4U6KgSS45DbDl4Y9NbhL+8OpMXcwVAW
	tHNjFZaHrJiIA+yl3plbAsqqKg==
X-Received: by 2002:a05:6000:2501:b0:486:e5f7:89ca with SMTP id
 ffacd0b85a97d-486eb1d99c5mr96628f8f.8.1789062173016;
        Thu, 10 Sep 2026 10:42:53 -0700 (PDT)
Received: from cristian-v.. ([62.12.131.46])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm53693f8f.9.2026.09.10.10.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:42:52 -0700 (PDT)
From: Cristian Verde <verde.cristian2005@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add bass speaker quirk for Lenovo Yoga Pro
 7 14IRH8
Date: Thu, 10 Sep 2026 19:42:51 +0200
Message-ID: <20260910174251.22302-1-verde.cristian2005@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: verde.cristian2005@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 67ACR6KZIECXI2WM5YNH2AUOBAR5S6SA
X-Message-ID-Hash: 67ACR6KZIECXI2WM5YNH2AUOBAR5S6SA
X-Mailman-Approved-At: Wed, 16 Sep 2026 06:28:06 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/67ACR6KZIECXI2WM5YNH2AUOBAR5S6SA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Lenovo Yoga Pro 7 14IRH8 suffers from missing bass speaker output and
broken volume scaling (5% volume plays as loud as 100%). The system shares
the PCI SSID 0x17aa:0x3852 with the older Lenovo Yoga 7 14ITL5, causing the
ALSA driver to mistakenly match on the PCI subsystem ID and apply
ALC287_FIXUP_YOGA7_14ITL_SPEAKERS. That quirk only powers on the amplifier
without routing the 4-speaker DAC pins.

Add a fixup helper that disambiguates models by checking the HDA codec
subsystem ID (codec->core.subsystem_id). When the Yoga Pro 7 14IRH8's codec
SSID (0x17aa:0x38b1) is detected, apply ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
which properly configures pin 0x17 as a speaker output and hooks it to the DAC
volume controls. Fall back to ALC287_FIXUP_YOGA7_14ITL_SPEAKERS for older
hardware sharing 0x3852.

Signed-off-by: Cristian Verde <verde.cristian2005@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 5b385a82e..e469b45ac 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4077,6 +4077,7 @@ enum {
 	ALC298_FIXUP_LENOVO_C940_DUET7,
 	ALC287_FIXUP_LENOVO_YOGA_BOOK_9I,
 	ALC287_FIXUP_LENOVO_YOGA_PRO7,
+	ALC287_FIXUP_YOGA7_14ITL_PRO7,
 	ALC287_FIXUP_13S_GEN2_SPEAKERS,
 	ALC256_FIXUP_SET_COEF_DEFAULTS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
@@ -4192,6 +4193,25 @@ static void alc287_fixup_lenovo_yoga_book_9i(struct hda_codec *codec,
 	__snd_hda_apply_fixup(codec, id, action, 0);
 }
 
+/* A special fixup for Lenovo Yoga Pro 7 14IRH8 and Yoga 7 14ITL5
+ * both have the very same PCI SSID and vendor ID, so we need to
+ * apply different fixups depending on the subsystem ID
+ */
+static void alc287_fixup_lenovo_yoga7_pro7(struct hda_codec *codec,
+					   const struct hda_fixup *fix,
+					   int action)
+{
+	int id;
+
+	if (codec->core.subsystem_id == 0x17aa38b1)
+		id = ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN;
+	else
+		id = ALC287_FIXUP_YOGA7_14ITL_SPEAKERS;
+
+	__snd_hda_apply_fixup(codec, id, action, 0);
+}
+
+
 static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_GPIO2] = {
 		.type = HDA_FIXUP_FUNC,
@@ -6439,6 +6459,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC287_FIXUP_CS35L41_I2C_2,
 	},
+	[ALC287_FIXUP_YOGA7_14ITL_PRO7] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_lenovo_yoga7_pro7,
+	},
 	[ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc295_fixup_dell_inspiron_top_speakers,
@@ -7722,7 +7746,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	HDA_CODEC_QUIRK(0x17aa, 0x38cf, "Lenovo Yoga Pro 7 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3847, "Legion 7 16ACHG6", ALC287_FIXUP_LEGION_16ACHG6),
 	SND_PCI_QUIRK(0x17aa, 0x384a, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
-	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5 / Pro 7 14IRH8", ALC287_FIXUP_YOGA7_14ITL_PRO7),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3865, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
@@ -7750,6 +7774,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a9, "Thinkbook 16P", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38ab, "Thinkbook 16P", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x38b1, "Lenovo Yoga Pro 7 14IRH8", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	HDA_CODEC_QUIRK(0x17aa, 0x391c, "Lenovo Yoga 7 2-in-1 14AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	HDA_CODEC_QUIRK(0x17aa, 0x391d, "Lenovo Yoga 7 2-in-1 16AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
-- 
2.43.0

