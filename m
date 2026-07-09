Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F5EC43458
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:28:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8485D60231;
	Thu,  9 Jul 2026 09:28:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8485D60231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783582097;
	bh=rTya/fpGKrIGgS30F1dSK0WMZhgSGTc1NkAk7i8HJD4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=J6+ipgaugByBddKlK78ddADl1+OBH+zZcPNUAZn10XnZBKZ9LXk9Id1vgx66B6ROM
	 I8yEbNNr+Pxh0YdVkSsuvxdFQF3rLiilmP7g5I9vRvXjPr5jh+jdYO9PnjUYoy3+9G
	 niU1VwvpFkQm9M5qCebt1tjttmqyO0b2XsXM+l0E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A517F80548; Thu,  9 Jul 2026 09:27:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C857F805F7;
	Thu,  9 Jul 2026 09:27:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31D88F80495; Thu,  9 Jul 2026 09:27:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783582048;
	b=JOqRZJy3oHcRUS4tiYJ3kMh9CueOWRkfZ+GfrSvhIEcLVz7gN3J+XA/Da9RvZKAcHpil
	 o4O8zF4UJYPSURowIR1tBF3puA22JEUZcMZ8KTR9gYLQm72xAxVlsX/+mytyeqG4KntF0
	 DZ+H1kbeeNaZM/+g8bIVHeqtE148g0yTpzOWrMFRMd3rUKWHhVIzfGddsxh52jSYh7Gca
	 QG1NZJXwd35fcA66kwgRNjhTdp4vLdwifgpgp6Bl3YKu10fLb0GtK6WMMyprr+Fe9oTy5
	 fXV8cbpHIqdMqiLYxW04AXPlVfkvEyOv7kH1oSjPTqFD7K8QUKDphxCO7+VQDtP3LEg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783582048;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rTya/fpGKrIGgS30F1dSK0WMZhgSGTc1NkAk7i8HJD4=;
	b=PzGU8GZKmaJ5C1Id216lkdi2i1QzUo9Ew7p8xF+Sz0SH1OCfLkbxgY0voYPzoP+q70+0
	 yai1rLgwDwD4c8YbKoKrSUqzo4IfExm8qNrupFr8gn+FwStv4tiMO+UDfgvHIf8Q5svgN
	 uNwGpdAEUJmD6l3radC4slHwI2ifwZOPgLJyvNu78mzlZKyaaIgMcM2LVGMnlFNIOwpJ5
	 ff1JjFd0IcKtoyFhkQo7SbvPo1mfZzj6YyiS4HJw1xiAdcl/ulbi40OyivdmJ2cKMQfIw
	 LjP4G818XMT2GU8raU/Mpq9UzQP7Cxb4JF8TqpD4/Esv39UM9QgC3CYLfOAA/k2TuQg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=h3H+rSON;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2910DF800C1
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 09:27:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2910DF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=h3H+rSON
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6697REEN02903496,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783582034; bh=f81aJAbRl0PxCU944JQB0HSTwJXSLdfp8ikW5U75v2U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=h3H+rSONxlewbrlcKS2P58MF5mhYcyYP5Arg3r4wmuWonOgJLGGpHGUHdHpfeMF9u
	 ga0Zuopcyj8Ywwv+MjHJvW3FSxQANvG4OHxDOAYQByBPXdzbc4tbZ4Y/0s7dzZt1Wx
	 +5LdGLzqwz9tKNr5BgTeFJKryAAVV86WOZnx2cFQOyaV3OPBIS1zOWTp1FTwtVwn45
	 20UsLJuAUOV5rrGceLUZlNMSnfasfJ+M7Vfjs0/NBFu7D/N+5SHmX/BSOYAhvdLYfG
	 lsJjtO/v45u/SI5Pxb9Q1d2KURog92PYIXUlqMsSNIQQYQrV4i1iYhYgk/sFMDTLba
	 8Kn5GVoX3mqgQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6697REEN02903496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jul 2026 15:27:14 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Jul 2026 15:27:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Jul 2026 15:27:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 9 Jul 2026 15:27:14 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
CC: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Fixed Headphone noise issue for Dell QCM1255
Thread-Topic: Fixed Headphone noise issue for Dell QCM1255
Thread-Index: Ad0Pc2V5/SNTDyoaQoGucr6gAJ7feA==
Date: Thu, 9 Jul 2026 07:27:14 +0000
Message-ID: <34b990cb56914148ba02fa8e9d176479@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-originating-ip: [172.21.6.42]
Content-Type: multipart/mixed;
	boundary="_002_34b990cb56914148ba02fa8e9d176479realtekcom_"
MIME-Version: 1.0
Message-ID-Hash: QGNEBUWZ653UKE4NZLAXSOWVJOM6BUDO
X-Message-ID-Hash: QGNEBUWZ653UKE4NZLAXSOWVJOM6BUDO
X-MailFrom: kailang@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QGNEBUWZ653UKE4NZLAXSOWVJOM6BUDO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_002_34b990cb56914148ba02fa8e9d176479realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

This platform booted with Ubuntu 24.04 with Pipewire audio server. So, it h=
as pop
noise with headphone. But it's normal with Pulseaudio server.
This patch was the workaround. Connect the headphones to DAC 0x2.
The popping sound will disappear.

This solution was approved by Dell.

Thanks.
Kailang

--_002_34b990cb56914148ba02fa8e9d176479realtekcom_
Content-Type: application/octet-stream;
	name="0000-alc236-dell-dt-hp-noise.patch"
Content-Description: 0000-alc236-dell-dt-hp-noise.patch
Content-Disposition: attachment;
	filename="0000-alc236-dell-dt-hp-noise.patch"; size=2027;
	creation-date="Thu, 09 Jul 2026 07:21:21 GMT";
	modification-date="Thu, 09 Jul 2026 07:18:21 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkYWI4YzE3MDk3ZWFjMzhlMGQ5YWFlNjNhMmY3ZTE4NjAyNTdlOGQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFRodSwgOSBKdWwgMjAyNiAxNDo1NzowNiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYS9yZWFsdGVrIC0gRml4ZWQgSGVhZHBob25lIG5vaXNlIGlzc3VlIGZvciBEZWxsIFFDTTEy
NTUKClRoaXMgcGxhdGZvcm0gYm9vdGVkIHdpdGggVWJ1bnR1IDI0LjA0IHdpdGggUGlwZXdpcmUg
YXVkaW8gc2VydmVyLiBTbywgaXQgaGFzIHBvcApub2lzZSB3aXRoIGhlYWRwaG9uZS4gQnV0IGl0
J3Mgbm9ybWFsIHdpdGggUHVsc2VhdWRpbyBzZXJ2ZXIuClRoaXMgcGF0Y2ggd2FzIHRoZSB3b3Jr
YXJvdW5kLiBDb25uZWN0IHRoZSBoZWFkcGhvbmVzIHRvIERBQyAweDIuClRoZSBwb3BwaW5nIHNv
dW5kIHdpbGwgZGlzYXBwZWFyLgoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5n
QHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMy
NjkuYyBiL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwppbmRleCA1YjIyY2Q5NDEw
MjYuLmE5NDVhOTU0NTBmYyAxMDA2NDQKLS0tIGEvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2Fs
YzI2OS5jCisrKyBiL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwpAQCAtNDE3Nyw2
ICs0MTc3LDcgQEAgZW51bSB7CiAJQUxDMjU2X0ZJWFVQX0hPTk9SX01SQl9YWFhfTTEwMjBfQVVE
SU8sCiAJQUxDMjQ1X0ZJWFVQX0hQX0VOVllfWDM2MF8xNV9GSDBYWFgsCiAJQUxDMjg3X0ZJWFVQ
X0FDRVJfTUlDTVVURV9MRUQsCisJQUxDMjM2X0ZJWFVQX0RFTExfSFBfUE9QX05PSVNFLAogfTsK
IAogLyogQSBzcGVjaWFsIGZpeHVwIGZvciBMZW5vdm8gQzk0MCBhbmQgWW9nYSBEdWV0IDc7CkBA
IC02Nzk4LDYgKzY3OTksMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBoZGFfZml4dXAgYWxjMjY5
X2ZpeHVwc1tdID0gewogCQkuY2hhaW5lZCA9IHRydWUsCiAJCS5jaGFpbl9pZCA9IEFMQzJYWF9G
SVhVUF9IRUFEU0VUX01JQywKIAl9LAorCVtBTEMyMzZfRklYVVBfREVMTF9IUF9QT1BfTk9JU0Vd
ID0geworCQkudHlwZSA9IEhEQV9GSVhVUF9GVU5DLAorCQkudi5mdW5jID0gYWxjMjg1X2ZpeHVw
X2ludmFsaWRhdGVfZGFjcywKKwl9LAogfTsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBoZGFfcXVp
cmsgYWxjMjY5X2ZpeHVwX3RibFtdID0gewpAQCAtNjk0OSw2ICs2OTU0LDggQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBoZGFfcXVpcmsgYWxjMjY5X2ZpeHVwX3RibFtdID0gewogCVNORF9QQ0lfUVVJ
UksoMHgxMDI4LCAweDBjYzMsICJEZWxsIE9hc2lzIDE0IExvdyBXZWlnaHQgTVRMLVUiLCBBTEMy
ODlfRklYVVBfREVMTF9DUzM1TDQxX1NQSV8yKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgw
Y2M0LCAiRGVsbCBPYXNpcyAxNiBNVEwtSC9VIiwgQUxDMjg5X0ZJWFVQX0RFTExfQ1MzNUw0MV9T
UElfMiksCiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MGNjNSwgIkRlbGwgT2FzaXMgMTQiLCBB
TEMyODlfRklYVVBfUlRLX0FNUF9EVUFMX1NQSyksCisJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4
MGU2YiwgIkRlbGwgUHJvIFFDTTEyNTUiLCBBTEMyMzZfRklYVVBfREVMTF9IUF9QT1BfTk9JU0Up
LAorCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDBlNmQsICJEZWxsIFBybyBNaWNybyBRQ00xMjU1
IiwgQUxDMjM2X0ZJWFVQX0RFTExfSFBfUE9QX05PSVNFKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAy
OCwgMHgxNjRhLCAiRGVsbCIsIEFMQzI5M19GSVhVUF9ERUxMMV9NSUNfTk9fUFJFU0VOQ0UpLAog
CVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDE2NGIsICJEZWxsIiwgQUxDMjkzX0ZJWFVQX0RFTEwx
X01JQ19OT19QUkVTRU5DRSksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MTU4NiwgIkhQIiwg
QUxDMjY5X0ZJWFVQX0hQX01VVEVfTEVEX01JQzIpLAo=

--_002_34b990cb56914148ba02fa8e9d176479realtekcom_--
