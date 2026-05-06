Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A3ACD37BE
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:42:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C8C260210;
	Mon, 11 May 2026 16:42:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C8C260210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778510561;
	bh=GKXFyi8sG59XrsallnDQAzi2aDFAv94wBGr3KN82iY8=;
	h=Date:From:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=YSS6eS5Fa78sZaq/TEhRBiU+RB91Zexm+84mVH1OX1ysUnKD5HGyRO7K0IZusyxiN
	 tXBc+YhCF/bMhNNEzspTXU3VU9/ooUJ/qVU7kKwIGs9QFbf02fmDEA4gGOu0cbwvyc
	 iiNFkxUm5PACZOT/FDvpWm3IkeYle7zWg6rHer8g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ABCF2F80607; Mon, 11 May 2026 16:42:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C424F8060B;
	Mon, 11 May 2026 16:42:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25415F80217; Wed,  6 May 2026 21:11:11 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7F3D4F8003C
	for <alsa-devel@alsa-project.org>; Wed,  6 May 2026 21:11:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F3D4F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cbFzxMne
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so58134eec.1
        for <alsa-devel@alsa-project.org>;
 Wed, 06 May 2026 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778094667; x=1778699467;
 darn=alsa-project.org;
        h=subject:to:from:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R6VM68AcW4eFw7DqhsWyoBsiuGM9UfSQsn7JxEUFTfQ=;
        b=cbFzxMneto9Q1myjYI96/bz5CtIQrs+QAhdkq0BrJ216dGQf14DjfXAeGuG1Wtit9Y
         T4NJY+Lr4Eu0VdZC8rB/hkwOboebW/v8CIhgtJAA45NH4TwFeX/TevTCoY9nrmu1/Npu
         USVzc6yvUylpR/vb8CtiAklYwLNMMXEy2zjbXIL4JPbSyTNrItztuvd9K26Xe0OyrSuD
         fxIVpd43bx0bfNKqINghgouefccZabm49e6iBBSfmFcNMRMN/Vzzg4DqqG0Bn1lzjayD
         6GysQ4sqZhRqKYwvnSpGUqROH5H+RO0YapdGThn+KQVOGEEuo4d3XpNtE/TvLqXP1idn
         QU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778094667; x=1778699467;
        h=subject:to:from:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6VM68AcW4eFw7DqhsWyoBsiuGM9UfSQsn7JxEUFTfQ=;
        b=RSpxZG/vkmJmeF3n5047jV/UmBuTeQ/liHk4HW8GhqLioGvsuLBCCD78j7wVXUpzI8
         TC5B9x1OW1k1ahn5rNBGbN3nbzRXhMI4i8vxMPOLwv38VcGBENZaZScekcYXcTQAI/nf
         BFCNUC6XJpdtlyWdmdjmQ7lDoBKhA95vY3JUeTRDdpifTQuBFJd+JPeqvpTiGlXbdV3B
         1zdPB7wvZaQL/mnApJOL4ukRzJfG/t0FUd0ECnulmmANUYKz13J0DD7egSasiJlfueaX
         eJQdyqJ270rzHp5rXV+yQvtD0bGtW8n7KuEzgvgX4SNIGIe+/0G3nI2/8UTLRDXFHHjy
         fSww==
X-Gm-Message-State: AOJu0YxLuiFdHdW4DvrBR9Dv5wX2bcXT0ettae9T3ZRjVNYIyJh4SSCP
	VPLw7S7ILx1rO9ZbBYwyRbNmUcuEzP9xXvxlYNY683c6uAW0M2Fr+41G/3741DWt
X-Gm-Gg: AeBDietkaPRaGUnOy57pm6k1sJILP5/RxSBbLanTWpkIlUh2B1r5cTi/XDVd/h25Mp4
	icZWveFQbBoFmyNMOdaUqloQR0WSaYxh7wT8xXD4ziJbGDR2ehHAs1Swb6FkD7Lfesp2EHa4Sik
	iUYDhkTD700CZY3P7e6xNwxXW4ZLLioZBSzoHnuda9ATd02k1TzDMz8hh/HFwz0FIaUOLyTWz/F
	WYRn7JmWTFUVTvCUvQfRRbw9EO/dV0G9JX0oc4M2c1vRbcthEWk6h3w0hLP8/2ULG0GvkUWn2AZ
	9xeiiDlJaNTtoDwVfzS6UXRHI+CZ9ySq5GSNvZWPDHrxOrPA1hWPnpTCpboM2cGlZT7zI1l8IWq
	Sxrxfv7Wb88Z8AWIzmAd6nIEypiiMplclr6/xbzucuufuE52juH1fcp6BJAFOV9xiKEfvXzgCER
	2w1nlcLya1Yb2uglQChU/xsda1MO0mvGZf6XDZnOlExzhaO+970LES7m4y171Zrpn3Cqwwv1dTw
	L/x33O36SKsmDL0xlwvQHZGnjD5FEEexpSRO/jtsAuAyt1DVyzAyUCPzkKZkgqzJjI=
X-Received: by 2002:a05:7300:8623:b0:2e2:4979:eb5 with SMTP id
 5a478bee46e88-2f548e95b4bmr2385337eec.10.1778094666202;
        Wed, 06 May 2026 12:11:06 -0700 (PDT)
Received: from [127.0.1.1] ([186.158.234.150])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57028b991sm4269157eec.25.2026.05.06.12.11.04
        for <alsa-devel@alsa-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:11:05 -0700 (PDT)
Message-ID: <69fb9249.050a0220.22167c.da67@mx.google.com>
Date: Wed, 06 May 2026 12:11:05 -0700 (PDT)
MIME-Version: 1.0
From: sboglione.fis.utn@gmail.com
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP 250 G10 (103c:8b34)
X-MailFrom: sboglione.fis.utn@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: GKHGTTMWKO3ULL42UNYT6LH7BMF3UBEF
X-Message-ID-Hash: GKHGTTMWKO3ULL42UNYT6LH7BMF3UBEF
X-Mailman-Approved-At: Mon, 11 May 2026 14:42:02 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GKHGTTMWKO3ULL42UNYT6LH7BMF3UBEF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

IyBWZXIgZWwgY29udGVuaWRvIGRlbCBwYXRjaApjYXQgfi9rZXJuZWwtcGF0Y2gvbGludXgtbWFp
bmxpbmUvMDAwMS1BTFNBLWhkYS1yZWFsdGVrLUFkZC1xdWlyay1mb3ItSFAtMjUwLUcxMC0xMDNj
LThiMzQucGF0Y2gKRnJvbSA5NmMyZjEzMDRjZjM0MzdhNWU5MjVhYTJmZjNlOWQ4ZTg1ZDA4YTAz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gPHNib2dsaW9uZUBnbWFpbC5j
b20+CkRhdGU6IFdlZCwgNiBNYXkgMjAyNiAxNjowMzozNCAtMDMwMApTdWJqZWN0OiBbUEFUQ0hd
IEFMU0E6IGhkYS9yZWFsdGVrOiBBZGQgcXVpcmsgZm9yIEhQIDI1MCBHMTAgKDEwM2M6OGIzNCkK
CkhQIDI1MCAxNS42IGluY2ggRzEwIE5vdGVib29rIFBDIHVzZXMgdGhlIHNhbWUgQUxDMjM2IGNv
ZGVjCmFzIHRoZSBIUCAyNTUgMTUuNiBpbmNoIEcxMCAoMTAzYzo4YjJmKSBhbmQgcmVxdWlyZXMg
dGhlIHNhbWUKZml4dXAgdG8gZW5hYmxlIHRoZSBpbnRlcm5hbCBzcGVha2VyIEVBUEQgYW5kIG1p
Y3JvcGhvbmUgcm91dGluZy4KClNpZ25lZC1vZmYtYnk6IFNlcmdpbyBCb2dsaW9uZSA8c2JvZ2xp
b25lQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU2VyZ2lvIDxzYm9nbGlvbmVAZ21haWwuY29t
PgotLS0KIHNvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYyB8IDEgKwogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc291bmQvaGRhL2NvZGVjcy9yZWFs
dGVrL2FsYzI2OS5jIGIvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jCmluZGV4IGE5
Y2QwM2JiNy4uMTFiY2MyZWY4IDEwMDY0NAotLS0gYS9zb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsv
YWxjMjY5LmMKKysrIGIvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jCkBAIC03MDUw
LDYgKzcwNTAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9xdWlyayBhbGMyNjlfZml4dXBf
dGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4OGFkOCwgIkhQIDgwMCBHOSIsIEFM
QzI0NV9GSVhVUF9DUzM1TDQxX1NQSV8yX0hQX0dQSU9fTEVEKSwKIAlTTkRfUENJX1FVSVJLKDB4
MTAzYywgMHg4YjBmLCAiSFAgRWxpdGUgbXQ2NDUgRzcgTW9iaWxlIFRoaW4gQ2xpZW50IFU4MSIs
IEFMQzIzNl9GSVhVUF9IUF9NVVRFX0xFRF9NSUNNVVRFX1ZSRUYpLAogCVNORF9QQ0lfUVVJUkso
MHgxMDNjLCAweDhiMmYsICJIUCAyNTUgMTUuNiBpbmNoIEcxMCBOb3RlYm9vayBQQyIsIEFMQzIz
Nl9GSVhVUF9IUF9NVVRFX0xFRF9DT0VGQklUMiksCisJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4
OGIzNCwgIkhQIDI1MCAxNS42IGluY2ggRzEwIE5vdGVib29rIFBDIiwgQUxDMjM2X0ZJWFVQX0hQ
X01VVEVfTEVEX0NPRUZCSVQyKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4YjNhLCAiSFAg
RW52eSAxNSIsIEFMQzI4N19GSVhVUF9DUzM1TDQxX0kyQ18yKSwKIAlTTkRfUENJX1FVSVJLKDB4
MTAzYywgMHg4YjNmLCAiSFAgbXQ0NDAgTW9iaWxlIFRoaW4gQ2xpZW50IFU5MSIsIEFMQzIzNl9G
SVhVUF9IUF9HUElPX0xFRCksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4OGI0MiwgIkhQIiwg
QUxDMjQ1X0ZJWFVQX0NTMzVMNDFfU1BJXzJfSFBfR1BJT19MRUQpLAotLSAKMi40My4wCg==
