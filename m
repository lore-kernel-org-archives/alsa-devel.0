Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F77CD5BC9
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 10:45:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A133360252;
	Wed, 27 May 2026 12:45:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A133360252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779878731;
	bh=phXjiygwzxrUfXKjy4nZFgGmD0AYvuS49NQqH3mE/Jo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hwJfPSiQ1xbiD1i4NGmRZqWQJvd9KnyywZg+EXEkVY3RXdp2isUW4vcsS5m8Ly1Xk
	 7eh01ApO+gUSzCtxTqm84vcf2aicfzcESpx7+SL2Cac4iLXWTNclHsetzMVFktGFBj
	 1zYruIuQ52rUacTN96shAwjsizWCJ1LrbPnynu3M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C1D8CF805F7; Wed, 27 May 2026 12:44:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DF164F805F4;
	Wed, 27 May 2026 12:44:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9F8CF80217; Tue, 26 May 2026 22:18:50 +0200 (CEST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5EA4F800BD
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2026 22:18:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5EA4F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cmI+egk3
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so1990569466b.0
        for <alsa-devel@alsa-project.org>;
 Tue, 26 May 2026 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779826728; x=1780431528;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUfnNQvUVMjHZKa95qvpUQYyrVa4EVsdQKSmSYhctPQ=;
        b=cmI+egk3TnWIhJYQ3qj54BlA1J/W2MPkSfXlAuE3ytDNjZsnF+XnAvZL7D/mRYj2ZY
         U9kycWu3V8u+kUfV7UwODE5at65z9eio0byz7rU0LwbxieMwsS7kZp5Xf279ralKE6uH
         IrV1/eeRBJ/zwnLDiFlGZ7l3RQ+s0cyn7RxfMVuEeRpQx8R+GT8w8f7WfaXjPP8cYz6b
         BoTo9hahopgkD0YVRMQwpNtpADtwirWuuUxHKp0w/5W9oz6We+sPMJPDHVW+ND4+xwgv
         rxNIKj6PCQgoyK9VSxO9XPS8EXBzg19igmxpv91d/6s+MwbI1OO3ZzzsxHIw5dNADm9g
         38PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779826728; x=1780431528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUfnNQvUVMjHZKa95qvpUQYyrVa4EVsdQKSmSYhctPQ=;
        b=mLIDkriF5Df6tSvSedJXh/q4Botj70j2i5Hpwdl8b7e02ILGI+scX8oVjKArGXouwi
         PkIYGLVDUydcqv9shDuEPix9fIFg4339gmn4uZa4iak1zjZhBibb9t3h03kyPIvI31FL
         Fa3Y5CejMiccn8/+DA4prg7HAjQcvFcDniZc/OrBrn5F+QAjAUsj+rnK5A0O3bDEo/XS
         W2gTv4NuCdrzohquyq+j/8HJNIGHQ8RGEmHcNhxUAOaXSOeScLh0XQg8v2UZHD8O7PyZ
         bjNHJng5RiM3oOTwkg+22RquQFMgvOOaAKzuOn+rLIxKjl9wA59/NK/fM7PeUsFwvlws
         lj9Q==
X-Gm-Message-State: AOJu0YzF6O43zfaYrLoBvVnATizwPBOAGOB8NlP3Pyyulyczp7Sp+qr9
	ZhKaGnbqrLyi5UYTWf0yfoNoSv/w+YxJO98+bwnL0K/EsAPmeAN7FI/LC1bETwI/
X-Gm-Gg: Acq92OFd4IOKmB9ju9kkk0nGyOMhhxV5K+LjyeHVrkJ/1Y/8kMgK9sdnOGdbQr4/jvk
	U/dRVs8RjphHARwTGlxAhJPgZpP8GxP9rORR1BztXsBoBhcM1yRMUWpyBj+Lu/0tqmy0dcJ+klG
	qE1qJtql4Cc2yFbclTYGpXDM0FIkcXYruvEebkpdzFU2wt0yRoai8glwsxSlUqhfBoILOnnI9iO
	OOxtXAJxPT9NAeaC7gCUZwGV4TS75gc38i4DAFpM/9j6ShkWIHCw/7sgTf4Iah7JDksmRsSxdSN
	3BsBG/A5OvBI10p6WLo4eliWW0wKooboYkVKF+059u5muba+zfHhviReA5V90bTuNhkGbiESeP9
	akq5aMP/Y38WFleJL3EHjnKstTQi2F1+mC0G53A2kWZhWFNgnBqNTDiquwe3a8oCStBLy547g81
	pBcVY9OlLoH7EIEhuKafMJhoP/eA+XJN2CJaRjHZQE6PXCBayyEcZK/i5OpwvPRzsDlUXJbMqwN
	KhIzCtUWr3IvXv50gbV
X-Received: by 2002:a17:907:94c3:b0:bc6:7238:bd57 with SMTP id
 a640c23a62f3a-bdd25136b3bmr727799566b.7.1779826727880;
        Tue, 26 May 2026 13:18:47 -0700 (PDT)
Received: from localhost.localdomain (85-222-116-222.dynamic.play.pl.
 [85.222.116.222])
        by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68a6fb2f1f0sm74488a12.20.2026.05.26.13.18.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 13:18:46 -0700 (PDT)
From: Jakub Pisarczyk <pisarz77@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/cs420x: Add CS4208 fixup for iMac16,1
Date: Tue, 26 May 2026 22:18:30 +0200
Message-ID: <20260526201830.34097-1-pisarz77@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: pisarz77@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 57774T2N3HTQICBIOMDWJKUWTYPALPOW
X-Message-ID-Hash: 57774T2N3HTQICBIOMDWJKUWTYPALPOW
X-Mailman-Approved-At: Wed, 27 May 2026 10:44:53 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/57774T2N3HTQICBIOMDWJKUWTYPALPOW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The 21.5" Retina 4K iMac (Late 2015, DMI product name "iMac16,1") ships
with a Cirrus Logic CS4208 codec wired to an external speaker amplifier
enabled through codec GPIO0 -- the same arrangement as the late-2013
MacBookPro 11,x. Without a matching entry in cs4208_mac_fixup_tbl[] the
fixup picker logs:

    snd_hda_codec_cs420x hdaudioC1D0: CS4208: picked fixup  for codec SSID 106b:0000

i.e. an empty fixup name, GPIO0 stays low, the external amp is never
powered up, and the internal speakers are silent on a stock kernel.

The codec SSID reported by hardware is 0x106b:0x7f00. Reusing CS4208_MBP11
(GPIO0 + SPDIF switch fixup) makes the internal speakers and S/PDIF
output work out of the box, removing the need for users to set
`options snd_hda_intel model=mbp11` via /etc/modprobe.d/.

Tested on iMac16,1 (kernel 6.17.0): four internal drivers
(Left tweeter, Left woofer, Right tweeter, Right woofer, exposed as the
4 channels of the analog-surround-40 ALSA profile) produce audio after
the fixup is applied.

Signed-off-by: Jakub Pisarczyk <pisarz77@gmail.com>
---
 sound/hda/codecs/cirrus/cs420x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/cirrus/cs420x.c b/sound/hda/codecs/cirrus/cs420x.c
--- a/sound/hda/codecs/cirrus/cs420x.c
+++ b/sound/hda/codecs/cirrus/cs420x.c
@@ -582,6 +582,7 @@ static const struct hda_quirk cs4208_mac_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x7200, "MacBookAir 6,2", CS4208_MBA6),
 	SND_PCI_QUIRK(0x106b, 0x7800, "MacPro 6,1", CS4208_MACMINI),
 	SND_PCI_QUIRK(0x106b, 0x7b00, "MacBookPro 12,1", CS4208_MBP11),
+	SND_PCI_QUIRK(0x106b, 0x7f00, "iMac 16,1", CS4208_MBP11),
 	{} /* terminator */
 };

--
2.43.0
