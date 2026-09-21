Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C824CA5FA7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:05:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDFB2601D8;
	Tue, 29 Sep 2026 21:05:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDFB2601D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708720;
	bh=Y69RwffOn9KNZAZjPFQU1GSb4tAjui2olJi1vZA48rM=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=KAf4LFEEYtntdwpWhQJjD4WTt8SV9E2rUDw8gA7mLmn8IeRxfyECF/RGV7XqXmXTY
	 qtgUF2YFjtsdQQwqRH7fumyfU/2zLcnWSr4bF8CXCV6SAHspViIHbSwrhMuY24hXaz
	 sobcdGJw3G2BlYcJ/OIe6Lpp4PcT5Gqw4oj5QLdA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2AE56F805FF; Tue, 29 Sep 2026 21:04:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D449FF80600;
	Tue, 29 Sep 2026 21:04:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0130F804F3; Mon, 21 Sep 2026 10:06:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789978014;
	b=pSsV8phxGXOo86u2EWhaHFU34n2i6vJ4HnfqcAyHPzOTKgQ+j0HshOscCK/bEX9EdTMz
	 0VrGNRtiOtzhmJGVxE+/h5hy4PqwX0COHwWpcfBYzeTHl2NGMwsRxhXYri2145BQ8pRty
	 Ah2zLWsghSB9VzjesNL+KPoTgObRBb5+wdeLtQmwY8JfVpNj4FYEt/CpD9EH6IDieH/WQ
	 iUVbLMfskI1nk54Oq4PYuLpU6QXPWzI4mWYd1RBwcPsoZXDfWbS/XvSIa6CvLT0p1ty2e
	 XgI6LjgG5MEOPCjQ3V8XXzpm5pNpL5HL36mHH8dc/BefepOQUJAXzZBTcfCbwvqvupw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789978014;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Y69RwffOn9KNZAZjPFQU1GSb4tAjui2olJi1vZA48rM=;
	b=hZ/Ll0dG1uCaf+nHF/2mK/WTMBuVD/MvZwH/iwNhyXlkmueDQuspWffp3+ig2U/e/YJ0
	 OBha92+Fb2j4+a5W2kOHzgtY9HrB2DlYVLyULcvJEssi3JgxfreWrnxPsF9h4YhWUrA0+
	 JQHofA/M7rhTJQieoMX4B/k9VTaThWO010fOzkH7byiQ4vYv5jBCKmNLse4vNF+h6xAW4
	 DzomfPkO0Rlgu8Ic+WqMoNsooW9y9AHixVKbyWLq5R82i0wtOopTOCqW4V+gBhNnMcqXy
	 On1jABxNEXcn3hCCxtRIDaoVY3yf4B6bd5VIsjtoL74EKMOXuTmQJeKlzLVpHCl5SSQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=lXlnMOrM;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A47B0F801F7
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 10:06:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A47B0F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=lXlnMOrM
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68L86haeE2377552,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1789978003; bh=K6MtUsrmNqqOsl1rJ+tHIyc6VCM5E/r3UbgnmSfCbKs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=lXlnMOrMIQxfchgeNz97YAZdJlfGBK0Vc09RXcMSK4RrSWuLuneNKlBfNoaTHEYNY
	 19Q2KaiJc9WyyMXlHX82R/W2mv1TbM7hzB4ATVJR3HbNAJsEcTIg3xwUWM8cVwCGOQ
	 VG+nfL6dHYB+glntpvL1G6XdxdZTabcnSItMQmIQqlBMhYgfL4AxxNHyjgjMZu92pz
	 Z7kW9B6oO2pPE/5BE/ATCjRjKs54CvSbnvpwdM5bSyP9PXkGPpsMCL06Pve8ba6FlK
	 mi68n6QHrzt91r/QKASsZKDweGIT/WKG5zAIFcOU8sKm1/7+kD3MMIbe3zHoGHKGs/
	 7OUbL0WGxb4SA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68L86haeE2377552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Sep 2026 16:06:43 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 16:06:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 16:06:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 21 Sep 2026 16:06:43 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "
 (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
Subject: Add headset mode
Thread-Topic: Add headset mode
Thread-Index: Ad1JnuWo01sb9K2iR927d1ldAIFgCw==
Date: Mon, 21 Sep 2026 08:06:42 +0000
Message-ID: <3c251e40a2944ae4ae479e4c2e4e63a4@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-originating-ip: [172.21.6.42]
Content-Type: multipart/mixed;
	boundary="_002_3c251e40a2944ae4ae479e4c2e4e63a4realtekcom_"
MIME-Version: 1.0
X-MailFrom: kailang@realtek.com
X-Mailman-Rule-Hits: implicit-dest
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: 7SJWR5ABR7YDC53I2ANDE4ZFF4KPN6CH
X-Message-ID-Hash: 7SJWR5ABR7YDC53I2ANDE4ZFF4KPN6CH
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:04:42 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7SJWR5ABR7YDC53I2ANDE4ZFF4KPN6CH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_002_3c251e40a2944ae4ae479e4c2e4e63a4realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Prior patch will lose headset Mic function, and this patch will restore it.

BR,
Kailang

--_002_3c251e40a2944ae4ae479e4c2e4e63a4realtekcom_
Content-Type: application/octet-stream;
	name="0001-dell-QCDT-add-hsmode.patch"
Content-Description: 0001-dell-QCDT-add-hsmode.patch
Content-Disposition: attachment; filename="0001-dell-QCDT-add-hsmode.patch";
	size=963; creation-date="Mon, 21 Sep 2026 08:02:59 GMT";
	modification-date="Mon, 21 Sep 2026 07:55:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3MWQ5OGVmZDdkYzVkNGQ3ODlmZmQ2MzEwYTE5MjkwM2IzNGZiNTVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFRodSwgMTcgU2VwIDIwMjYgMTQ6NTM6MjYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEFkZCBoZWFkc2V0IG1vZGUgZm9yIERlbGwgUHJvIFFDMTI1NQoKSXQg
bG9zdCBpdHMgaGVhZHNldCBtaWNyb3Bob25lIGZ1bmN0aW9uYWxpdHksIGFuZCB0aGlzIHBhdGNo
IHdpbGwgcmVzdG9yZSBpdC4KCkZpeGVzOiA5NzI3MmE1NzA0YmYgKCJBTFNBOiBoZGEvcmVhbHRl
ayAtIEZpeGVkIEhlYWRwaG9uZSBub2lzZSBpc3N1ZSBmb3IgRGVsbCBRQ00xMjU1IikKU2lnbmVk
LW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgpkaWZmIC0tZ2l0IGEv
c291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jIGIvc291bmQvaGRhL2NvZGVjcy9yZWFs
dGVrL2FsYzI2OS5jCmluZGV4IDYxOGZmMjVlZmYxOC4uMzExY2Q1MmU4MmYxIDEwMDY0NAotLS0g
YS9zb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxjMjY5LmMKKysrIGIvc291bmQvaGRhL2NvZGVj
cy9yZWFsdGVrL2FsYzI2OS5jCkBAIC03MTM0LDYgKzcxMzQsOCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGhkYV9maXh1cCBhbGMyNjlfZml4dXBzW10gPSB7CiAJW0FMQzIzNl9GSVhVUF9ERUxMX0hQ
X1BPUF9OT0lTRV0gPSB7CiAJCS50eXBlID0gSERBX0ZJWFVQX0ZVTkMsCiAJCS52LmZ1bmMgPSBh
bGMyODVfZml4dXBfaW52YWxpZGF0ZV9kYWNzLAorCQkuY2hhaW5lZCA9IHRydWUsCisJCS5jaGFp
bl9pZCA9IEFMQzI1NV9GSVhVUF9ERUxMMV9NSUNfTk9fUFJFU0VOQ0UKIAl9LAogCVtBTEMyNzRf
RklYVVBfSFBfODlFOV9HUElPXSA9IHsKIAkJLnR5cGUgPSBIREFfRklYVVBfRlVOQywK

--_002_3c251e40a2944ae4ae479e4c2e4e63a4realtekcom_--
