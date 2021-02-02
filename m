Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C572BC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 00:31:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D997464E7B
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 00:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D997464E7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C515174F;
	Tue,  2 Feb 2021 01:31:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C515174F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612225911;
	bh=kbfGPp4wCqHujSW2NVxZzS0FYGQQLCiATz3Wno6fUcg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YMZLYFsJ/Tj1wiuQY+PxLX8e+/+w2HpC737Ul86nNmzrNICwVtb9KtsIym7hJ6HyM
	 IS/nKV6fp+8OIc/2gRa0lQKm3s6cyTelmg38LzR7o27VwaDK55mGeteofdQDhhvA9O
	 OZrkLykxVoGc5zYGD0BkfEPhrNmilodlJbMTV/WY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11796F80152;
	Tue,  2 Feb 2021 01:31:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97C4CF80153; Tue,  2 Feb 2021 01:30:59 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0059F80151
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 01:30:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0059F80151
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1120UhRqA011333,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs02.realtek.com.tw[172.21.6.95])
 by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 1120UhRqA011333
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 2 Feb 2021 08:30:44 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 08:30:43 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 08:30:43 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee]) by
 RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee%5]) with mapi id
 15.01.2106.006; Tue, 2 Feb 2021 08:30:43 +0800
From: Pshou <pshou@realtek.com>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: add one Advantech  SSID in the ALC886
Thread-Topic: add one Advantech  SSID in the ALC886
Thread-Index: Adb4+oGLi4X7VxZfS4e3AE9yXN415Q==
Date: Tue, 2 Feb 2021 00:30:43 +0000
Message-ID: <e62c5058957f48d8b8953e97135ff108@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.210]
Content-Type: multipart/mixed;
 boundary="_004_e62c5058957f48d8b8953e97135ff108realtekcom_"
MIME-Version: 1.0
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Takashi Iwai <tiwai@suse.de>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

--_004_e62c5058957f48d8b8953e97135ff108realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alsa-devel ML:



Can you help me add some source code to patch_realtek.c?



Add one Advantech SSID in the alc886.



Best regards

Pshou


--_004_e62c5058957f48d8b8953e97135ff108realtekcom_
Content-Type: application/octet-stream;
	name="0001-modify-EAPD-in-the-ALC886.patch"
Content-Description: 0001-modify-EAPD-in-the-ALC886.patch
Content-Disposition: attachment;
	filename="0001-modify-EAPD-in-the-ALC886.patch"; size=1580;
	creation-date="Wed, 27 Jan 2021 08:55:01 GMT";
	modification-date="Wed, 27 Jan 2021 08:55:01 GMT"
Content-Transfer-Encoding: base64

RnJvbTpQZWlTZW4gSG91IDxwc2hvdUByZWFsdGVrLmNvbT4KU3ViamVjdDpBTFNBOmhkYS9yZWFs
dGVrOm1vZGlmeSBFQVBEIGluIHRoZSBBTEM4ODYKCk1vZGlmeSAweDIwIGluZGV4IDcgYml0IDUg
dG8gMSwgbWFrZSB0aGUgMHgxNSBFQVBEIHRoZSBzYW1lIGFzIDB4MTQuCgpTaWduZWQtb2ZmLWJ5
OlBlaVNlbiBIb3UgPHBzaG91QHJlYWx0ZWsuY29tPgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCAy
OTA2NDU1Li41YmQ3NGZhIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtMTkwNSw2ICsxOTA1LDcg
QEAgZW51bSB7CiAJQUxDODg5X0ZJWFVQX0ZST05UX0hQX05PX1BSRVNFTkNFLAogCUFMQzg4OV9G
SVhVUF9WQUlPX1RULAogCUFMQzg4OF9GSVhVUF9FRUUxNjAxLAorCUFMQzg4Nl9GSVhVUF9FQVBE
LAogCUFMQzg4Ml9GSVhVUF9FQVBELAogCUFMQzg4M19GSVhVUF9FQVBELAogCUFMQzg4M19GSVhV
UF9BQ0VSX0VBUEQsCkBAIC0yMjM4LDYgKzIyMzksMTUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBo
ZGFfZml4dXAgYWxjODgyX2ZpeHVwc1tdID0gewogCQkJeyB9CiAJCX0KIAl9LAorCVtBTEM4ODZf
RklYVVBfRUFQRF0gPSB7CisJCS50eXBlID0gSERBX0ZJWFVQX1ZFUkJTLAorCQkudi52ZXJicyA9
IChjb25zdCBzdHJ1Y3QgaGRhX3ZlcmJbXSkgeworCQkJLyogY2hhbmdlIHRvIEVBUEQgbW9kZSAq
LworCQkJeyAweDIwLCBBQ19WRVJCX1NFVF9DT0VGX0lOREVYLCAweDA3IH0sCisJCQl7IDB4MjAs
IEFDX1ZFUkJfU0VUX1BST0NfQ09FRiwgMHgwMDY4IH0sCisJCQl7IH0KKwkJfQorCX0sCiAJW0FM
Qzg4Ml9GSVhVUF9FQVBEXSA9IHsKIAkJLnR5cGUgPSBIREFfRklYVVBfVkVSQlMsCiAJCS52LnZl
cmJzID0gKGNvbnN0IHN0cnVjdCBoZGFfdmVyYltdKSB7CkBAIC0yNTEwLDYgKzI1MjAsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjODgyX2ZpeHVwX3RibFtdID0gewog
CVNORF9QQ0lfUVVJUksoMHgxMDZiLCAweDRhMDAsICJNYWNib29rIDUsMiIsIEFMQzg4OV9GSVhV
UF9NQkExMV9WUkVGKSwKIAogCVNORF9QQ0lfUVVJUksoMHgxMDcxLCAweDgyNTgsICJFdmVzaGFt
IFZveWFlZ2VyIiwgQUxDODgyX0ZJWFVQX0VBUEQpLAorCVNORF9QQ0lfUVVJUksoMHgxM2ZlLCAw
eDEwMDksICJBZHZhbnRlY2ggTUlULVcxMDEiLCBBTEM4ODZfRklYVVBfRUFQRCksCQogCVNORF9Q
Q0lfUVVJUksoMHgxNDU4LCAweGEwMDIsICJHaWdhYnl0ZSBFUDQ1LURTMy9aODdYLVVEM0giLCBB
TEM4ODlfRklYVVBfRlJPTlRfSFBfTk9fUFJFU0VOQ0UpLAogCVNORF9QQ0lfUVVJUksoMHgxNDU4
LCAweGEwYjgsICJHaWdhYnl0ZSBBWjM3MC1HYW1pbmciLCBBTEMxMjIwX0ZJWFVQX0dCX0RVQUxf
Q09ERUNTKSwKIAlTTkRfUENJX1FVSVJLKDB4MTQ1OCwgMHhhMGNkLCAiR2lnYWJ5dGUgWDU3MCBB
b3J1cyBNYXN0ZXIiLCBBTEMxMjIwX0ZJWFVQX0NMRVZPX1A5NTApLAo=

--_004_e62c5058957f48d8b8953e97135ff108realtekcom_--
