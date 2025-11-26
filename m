Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A40CD1037E
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Nov 2025 05:51:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CE7F6013A;
	Wed, 26 Nov 2025 06:51:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CE7F6013A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1764136275;
	bh=wmzjSsBhlXEWM4QxxT3+EGsNGNOkZJNwvaEL1+tCRu4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=nO0vNNSs+6oMHr1Al5CiNdrTHGz0RS05RR4EXi6gtL/CA1tpTRialqoFmfQq+xrgO
	 cWYyX+lTHudIy79B8PPY0KnARvb3NPHfOuW2bfuMiMvedRH49+EtAlOfYe0gd0xJnh
	 h/fH28KD9RUFSe9twfA4KSMhvsuUOrHdan6QWUts=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5EA7AF805D6; Wed, 26 Nov 2025 06:50:40 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BD1FF805C1;
	Wed, 26 Nov 2025 06:50:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CA15F80087; Wed, 26 Nov 2025 06:50:29 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 41ABEF80087
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2025 06:50:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41ABEF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=a7+gk/9i
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AQ5o9vnD302770,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764136209; bh=qZ92AFOovApTwjLq37Ta5WdkcJDWsPYDVEURVm5QYO0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=a7+gk/9ivr5tEcY5YIci55RjajBtyfV/w48ngP1yfsEe3uT6O0yk38tf4vfoP7j6z
	 aIgZD6MBgUiQKdirfqy89EH2REkDjBIX+bPYokYhSItaeSDM1FsqqaLP/MxoJOOmmh
	 eeQdX61mh7pH2E27CnnLftcANm7HWNUPVxDLO1qgaLlSUXz3kr3nv5j8G9qTtEADzo
	 l6FTd7SayOcpkAKYJr2mla6KtaSvlaosWaeVFAY3BkNkabnWrkQ5pKJk9EmBWF8dEd
	 Gzg9f/D1hnmUq85OpNdNQTyWiqMkRFAvPbKlKpDbdp+pq/G66NSjat5z1gxHIHj/t2
	 aQcGuDBaObO/A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AQ5o9vnD302770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 13:50:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 26 Nov 2025 13:50:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 26 Nov 2025 13:50:09 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
CC: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Enable Mute LED for HP platform
Thread-Topic: Enable Mute LED for HP platform
Thread-Index: AdxemE7aGuCbnqKWSxinciYEbEDtdw==
Date: Wed, 26 Nov 2025 05:50:09 +0000
Message-ID: <ab5d4498f7454b25b245a3bad8fb95b3@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-originating-ip: [172.21.6.42]
Content-Type: multipart/mixed;
	boundary="_002_ab5d4498f7454b25b245a3bad8fb95b3realtekcom_"
MIME-Version: 1.0
Message-ID-Hash: ZR6RFCDTDNKWGVYHE6ULQWAD64DNNNH4
X-Message-ID-Hash: ZR6RFCDTDNKWGVYHE6ULQWAD64DNNNH4
X-MailFrom: kailang@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZR6RFCDTDNKWGVYHE6ULQWAD64DNNNH4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_002_ab5d4498f7454b25b245a3bad8fb95b3realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Attach patch was enable mute led functions.

Many Thanks.
Kailang

--_002_ab5d4498f7454b25b245a3bad8fb95b3realtekcom_
Content-Type: application/octet-stream;
	name="0000-hp-ZbookX-G2i-mute-led.patch"
Content-Description: 0000-hp-ZbookX-G2i-mute-led.patch
Content-Disposition: attachment;
	filename="0000-hp-ZbookX-G2i-mute-led.patch"; size=1258;
	creation-date="Wed, 26 Nov 2025 05:40:58 GMT";
	modification-date="Wed, 26 Nov 2025 05:48:01 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiMTM1OGM3N2JmZGZiNTU2ZDI0Y2Q5MDcwOTFjNmQ5MWNiZjc1ZjViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMjYgTm92IDIwMjUgMTM6NDE6MDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEVuYWJsZSBNdXRlIExFRCBmb3IgSFAgWkJvb2sgWCBHMmkgcGxhdGZv
cm0KCkVuYWJsZSBTUEsgTXV0ZSBMZWQgYW5kIE1pYyBNdXRlIExlZCBmb3IgSFAgWkJvb2sgWCBH
MmkgcGxhdGZvcm0uCgpQcmlvcml0eTogUDEKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxr
YWlsYW5nQHJlYWx0ZWsuY29tPgpkaWZmIC0tZ2l0IGEvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVr
L2FsYzI2OS5jIGIvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jCmluZGV4IGU3NGU2
NzIzZGYzYS4uOTMyZmQxYmNmMjRiIDEwMDY0NAotLS0gYS9zb3VuZC9oZGEvY29kZWNzL3JlYWx0
ZWsvYWxjMjY5LmMKKysrIGIvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jCkBAIC02
NzAwLDYgKzY3MDAsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9xdWlyayBhbGMyNjlfZml4
dXBfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4OGVkOCwgIkhQIE1lcmlubzE2
IiwgQUxDMjQ1X0ZJWFVQX1RBUzI3ODFfU1BJXzIpLAogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAw
eDhlZDksICJIUCBNZXJpbm8xNFciLCBBTEMyNDVfRklYVVBfVEFTMjc4MV9TUElfMiksCiAJU05E
X1BDSV9RVUlSSygweDEwM2MsIDB4OGVkYSwgIkhQIE1lcmlubzE2VyIsIEFMQzI0NV9GSVhVUF9U
QVMyNzgxX1NQSV8yKSwKKwlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4ZjBjLCAiSFAgWkJvb2sg
WCBHMmkgMTZXIiwgQUxDMjM2X0ZJWFVQX0hQX0dQSU9fTEVEKSwKKwlTTkRfUENJX1FVSVJLKDB4
MTAzYywgMHg4ZjBlLCAiSFAgWkJvb2sgWCBHMmkgMTZXIiwgQUxDMjM2X0ZJWFVQX0hQX0dQSU9f
TEVEKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4ZjQwLCAiSFAgTGFtcGFzMTQiLCBBTEMy
ODdfRklYVVBfVFhOVzI3ODFfSTJDKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4ZjQxLCAi
SFAgTGFtcGFzMTYiLCBBTEMyODdfRklYVVBfVFhOVzI3ODFfSTJDKSwKIAlTTkRfUENJX1FVSVJL
KDB4MTAzYywgMHg4ZjQyLCAiSFAgTGFtcGFzVzE0IiwgQUxDMjg3X0ZJWFVQX1RYTlcyNzgxX0ky
QyksCg==

--_002_ab5d4498f7454b25b245a3bad8fb95b3realtekcom_--
