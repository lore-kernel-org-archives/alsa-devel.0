Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E6FC4167B
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Nov 2023 07:18:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F87684D;
	Tue, 28 Nov 2023 08:17:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F87684D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701155884;
	bh=2E89snDLQpFnug01nJ9nYv8GICH1lzF8xP3b8/yMhXE=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=kzClnX9ewHSuM/hpkvgexYD0pA1LdDTMkBZb4RYjsPLTxaMEbEWULOVaN0Bc8SjD1
	 dM5QJfKDRQnatK6vBSpUbzgDe5WgFw5nXWI0oYedfiuMZlH0MqOGscrZJ0CRZBdOzZ
	 PsG96gjF9ty6IqGYJKcqGw56A8VOwvc+0Jdrd+Nk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7817CF80571; Tue, 28 Nov 2023 08:17:32 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D786F8057F;
	Tue, 28 Nov 2023 08:17:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14131F8016E; Tue, 28 Nov 2023 08:11:48 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3BA80F800F5
	for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2023 08:09:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BA80F800F5
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AS794ysC1877530,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AS794ysC1877530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 15:09:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 28 Nov 2023 15:09:05 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 28 Nov 2023 15:09:05 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::540c:c8d6:1d0f:ab9f]) by
 RTEXMBS01.realtek.com.tw ([fe80::540c:c8d6:1d0f:ab9f%5]) with mapi id
 15.01.2507.034; Tue, 28 Nov 2023 15:09:05 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
CC: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
Subject: Set Mic VREF to 100
Thread-Topic: Set Mic VREF to 100
Thread-Index: AdohyWjTqanBMwf/QCiux5ttvGyZHw==
Date: Tue, 28 Nov 2023 07:09:04 +0000
Message-ID: <0916af40f08a4348a3298a9a59e6967e@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-originating-ip: [172.22.102.106]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: multipart/mixed;
	boundary="_002_0916af40f08a4348a3298a9a59e6967erealtekcom_"
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
Message-ID-Hash: AGAOZWFGZY36TVZLLBWY564KDNL2Z6KQ
X-Message-ID-Hash: AGAOZWFGZY36TVZLLBWY564KDNL2Z6KQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AGAOZWFGZY36TVZLLBWY564KDNL2Z6KQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_002_0916af40f08a4348a3298a9a59e6967erealtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

This platform need to set MIC vref to 100%.

BR,
Kailang

--_002_0916af40f08a4348a3298a9a59e6967erealtekcom_
Content-Type: application/octet-stream;
	name="0000-ALC888VD-MIC1-VREF100.patch"
Content-Description: 0000-ALC888VD-MIC1-VREF100.patch
Content-Disposition: attachment;
	filename="0000-ALC888VD-MIC1-VREF100.patch"; size=1587;
	creation-date="Wed, 25 Oct 2023 07:25:59 GMT";
	modification-date="Tue, 28 Nov 2023 07:05:39 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiMjgzNjkxZGU1OWVlMDlmMGEyMjFkZWFkNDVmYjA5OTgzMDQ5YzA2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMjUgT2N0IDIwMjMgMTU6MjQ6MDYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlazogSGVhZHNldCBNaWMgVlJFRiB0byAxMDAlCgpUaGlzIHBsYXRmb3JtIG5l
ZWQgdG8gc2V0IE1pYyBWUkVGIHRvIDEwMCUuCgpTaWduZWQtb2ZmLWJ5OiBLYWlsYW5nIFlhbmcg
PGthaWxhbmdAcmVhbHRlay5jb20+CmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IDU4MDA2YzhiY2Zi
OS4uZTM3ZThmYzYyYjE5IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtMTk4Nyw2ICsxOTg3LDcg
QEAgZW51bSB7CiAJQUxDODg3X0ZJWFVQX0FTVVNfQVVESU8sCiAJQUxDODg3X0ZJWFVQX0FTVVNf
SE1JQywKIAlBTENTMTIwMEFfRklYVVBfTUlDX1ZSRUYsCisJQUxDODg4VkRfRklYVVBfTUlDXzEw
MFZSRUYsCiB9OwogCiBzdGF0aWMgdm9pZCBhbGM4ODlfZml4dXBfY29lZihzdHJ1Y3QgaGRhX2Nv
ZGVjICpjb2RlYywKQEAgLTI1NDAsNiArMjU0MSwxMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhk
YV9maXh1cCBhbGM4ODJfZml4dXBzW10gPSB7CiAJCQl7fQogCQl9CiAJfSwKKwlbQUxDODg4VkRf
RklYVVBfTUlDXzEwMFZSRUZdID0geworCQkudHlwZSA9IEhEQV9GSVhVUF9QSU5DVExTLAorCQku
di5waW5zID0gKGNvbnN0IHN0cnVjdCBoZGFfcGludGJsW10pIHsKKwkJCXsgMHgxOCwgUElOX1ZS
RUYxMDAgfSwgLyogaGVhZHNldCBtaWMgKi8KKwkJCXt9CisJCX0KKwl9LAogfTsKIAogc3RhdGlj
IGNvbnN0IHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzg4Ml9maXh1cF90YmxbXSA9IHsKQEAgLTI2
MDksNiArMjYxNyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhbGM4ODJf
Zml4dXBfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDEwNmIsIDB4NGEwMCwgIk1hY2Jvb2sg
NSwyIiwgQUxDODg5X0ZJWFVQX01CQTExX1ZSRUYpLAogCiAJU05EX1BDSV9RVUlSSygweDEwNzEs
IDB4ODI1OCwgIkV2ZXNoYW0gVm95YWVnZXIiLCBBTEM4ODJfRklYVVBfRUFQRCksCisJU05EX1BD
SV9RVUlSSygweDEwZWMsIDB4MTJkOCwgImlCYXNlIEVsbyBUb3VjaCIsIEFMQzg4OFZEX0ZJWFVQ
X01JQ18xMDBWUkVGKSwKIAlTTkRfUENJX1FVSVJLKDB4MTNmZSwgMHgxMDA5LCAiQWR2YW50ZWNo
IE1JVC1XMTAxIiwgQUxDODg2X0ZJWFVQX0VBUEQpLAogCVNORF9QQ0lfUVVJUksoMHgxNDU4LCAw
eGEwMDIsICJHaWdhYnl0ZSBFUDQ1LURTMy9aODdYLVVEM0giLCBBTEM4ODlfRklYVVBfRlJPTlRf
SFBfTk9fUFJFU0VOQ0UpLAogCVNORF9QQ0lfUVVJUksoMHgxNDU4LCAweGEwYjgsICJHaWdhYnl0
ZSBBWjM3MC1HYW1pbmciLCBBTEMxMjIwX0ZJWFVQX0dCX0RVQUxfQ09ERUNTKSwK

--_002_0916af40f08a4348a3298a9a59e6967erealtekcom_--
