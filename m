Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A61C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 05:55:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0142083E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 05:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a0CIB2cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0142083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A6461740;
	Thu, 30 Jul 2020 07:54:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A6461740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596088501;
	bh=eIrHA4d9FhPf7qdxaZJmhMsWiZmKWIWZ4tHl4jKoYwk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a0CIB2csqv0rwHlogU5nCxxpIlmtcpxO3oRDZSETq4SFy9qAA8ERs/bhBsKwsEBTd
	 0/3yxjAGcLOeDe3Rt7kMFGtsX7a+7SKAEYI6Veysya+hHjPL3yczPHxP9/EuiJMyKC
	 OjjlxR+xSK8qDcRCEvpJ2hFgv+ibVMU/JUo86YB4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31928F8021C;
	Thu, 30 Jul 2020 07:54:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0E58F8021E; Thu, 30 Jul 2020 07:54:09 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58477F8012F
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 07:54:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58477F8012F
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06U5rwcwF020169,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
 by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06U5rwcwF020169
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 30 Jul 2020 13:53:58 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Jul 2020 13:53:58 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Jul 2020 13:53:58 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8]) by
 RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8%5]) with mapi id
 15.01.1779.005; Thu, 30 Jul 2020 13:53:58 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Subject: HP NB right speaker no sound
Thread-Topic: HP NB right speaker no sound
Thread-Index: AdZmNYjtwJeLXA6YQTiGlZ0FEYdtow==
Date: Thu, 30 Jul 2020 05:53:57 +0000
Message-ID: <01285f623ac7447187482fb4a8ecaa7c@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.211]
Content-Type: multipart/mixed;
 boundary="_002_01285f623ac7447187482fb4a8ecaa7crealtekcom_"
MIME-Version: 1.0
Cc: " \(alsa-devel@alsa-project.org\)" <alsa-devel@alsa-project.org>
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

--_002_01285f623ac7447187482fb4a8ecaa7crealtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

HP NB platform right side speaker no sound.
Attach patch was help EC to initial I2S Amp normally.
Thanks.

BR,
Kailang

--_002_01285f623ac7447187482fb4a8ecaa7crealtekcom_
Content-Type: application/octet-stream; name="0000-alc285-hp-amp-init.patch"
Content-Description: 0000-alc285-hp-amp-init.patch
Content-Disposition: attachment; filename="0000-alc285-hp-amp-init.patch";
	size=2305; creation-date="Wed, 29 Jul 2020 06:13:27 GMT";
	modification-date="Thu, 30 Jul 2020 05:51:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkNWQ3MjBhZTY4ZDcxM2Y3OGFmYzRmOGJmMGUwODk3YmIyY2NmMzNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMjkgSnVsIDIwMjAgMTU6MDk6MjcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEZpeGVkIEhQIHJpZ2h0IHNwZWFrZXIgbm8gc291bmQKCkhQIE5CIHJp
Z2h0IHNwZWFrZXIgaGFkIG5vIHNvdW5kIG91dHB1dC4KVGhpcyBwbGF0Zm9ybSB3YXMgY29ubmVj
dGVkIHRvIEkyUyBBbXAgZm9yIHNwZWFrZXIgb3V0LihOb25lIFJlYWx0ZWsgSTJTIEFtcCBJQykK
RUMgbmVlZCB0byBjaGVjayBjb2RlYyBHUElPMSBwaW4gdG8gaW5pdGlhbCBJMlMgQW1wLgoKU2ln
bmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdp
dCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9y
ZWFsdGVrLmMKaW5kZXggZTk1ZmVhODQzMGIwLi44YWZkN2UwNzEyOWMgMTAwNjQ0Ci0tLSBhL3Nv
dW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVh
bHRlay5jCkBAIC01OTYzLDYgKzU5NjMsMTYgQEAgc3RhdGljIHZvaWQgYWxjX2ZpeHVwX2Rpc2Fi
bGVfbWljX3ZyZWYoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsCiAJCXNuZF9oZGFfY29kZWNfc2V0
X3Bpbl90YXJnZXQoY29kZWMsIDB4MTksIFBJTl9WUkVGSElaKTsKIH0KIAorc3RhdGljIHZvaWQg
IGFsYzI4NV9maXh1cF9ocF9ncGlvX2FtcF9pbml0KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAor
CQkJICAgICAgY29uc3Qgc3RydWN0IGhkYV9maXh1cCAqZml4LCBpbnQgYWN0aW9uKQoreworCWlm
IChhY3Rpb24gIT0gSERBX0ZJWFVQX0FDVF9JTklUKQorCQlyZXR1cm47CisKKwltc2xlZXAoMTAw
KTsKKwlhbGNfd3JpdGVfY29lZl9pZHgoY29kZWMsIDB4NjUsIDB4MCk7Cit9CisKIC8qIGZvciBo
ZGFfZml4dXBfdGhpbmtwYWRfYWNwaSgpICovCiAjaW5jbHVkZSAidGhpbmtwYWRfaGVscGVyLmMi
CiAKQEAgLTYxNDMsNiArNjE1Myw3IEBAIGVudW0gewogCUFMQzI4OV9GSVhVUF9BU1VTX0dBNDAx
LAogCUFMQzI4OV9GSVhVUF9BU1VTX0dBNTAyLAogCUFMQzI1Nl9GSVhVUF9BQ0VSX01JQ19OT19Q
UkVTRU5DRSwKKwlBTEMyODVfRklYVVBfSFBfR1BJT19BTVBfSU5JVCwKIH07CiAKIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgaGRhX2ZpeHVwIGFsYzI2OV9maXh1cHNbXSA9IHsKQEAgLTczNzUsNiArNzM4
NiwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9maXh1cCBhbGMyNjlfZml4dXBzW10gPSB7
CiAJCS5jaGFpbmVkID0gdHJ1ZSwKIAkJLmNoYWluX2lkID0gQUxDMjU2X0ZJWFVQX0FTVVNfSEVB
RFNFVF9NT0RFCiAJfSwKKwlbQUxDMjg1X0ZJWFVQX0hQX0dQSU9fQU1QX0lOSVRdID0geworCQku
dHlwZSA9IEhEQV9GSVhVUF9GVU5DLAorCQkudi5mdW5jID0gYWxjMjg1X2ZpeHVwX2hwX2dwaW9f
YW1wX2luaXQsCisJCS5jaGFpbmVkID0gdHJ1ZSwKKwkJLmNoYWluX2lkID0gQUxDMjg1X0ZJWFVQ
X0hQX0dQSU9fTEVECisJfSwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3BjaV9xdWly
ayBhbGMyNjlfZml4dXBfdGJsW10gPSB7CkBAIC03NTI1LDcgKzc1NDIsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjMjY5X2ZpeHVwX3RibFtdID0gewogCVNORF9QQ0lf
UVVJUksoMHgxMDNjLCAweDg0ZTcsICJIUCBQYXZpbGlvbiAxNSIsIEFMQzI2OV9GSVhVUF9IUF9N
VVRFX0xFRF9NSUMzKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4NjlkLCAiSFAiLCBBTEMy
MzZfRklYVVBfSFBfTVVURV9MRUQpLAogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDg3MjksICJI
UCIsIEFMQzI4NV9GSVhVUF9IUF9HUElPX0xFRCksCi0JU05EX1BDSV9RVUlSSygweDEwM2MsIDB4
ODczNiwgIkhQIiwgQUxDMjg1X0ZJWFVQX0hQX0dQSU9fTEVEKSwKKwlTTkRfUENJX1FVSVJLKDB4
MTAzYywgMHg4NzM2LCAiSFAiLCBBTEMyODVfRklYVVBfSFBfR1BJT19BTVBfSU5JVCksCiAJU05E
X1BDSV9RVUlSSygweDEwM2MsIDB4ODc3YSwgIkhQIiwgQUxDMjg1X0ZJWFVQX0hQX01VVEVfTEVE
KSwKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4NzdkLCAiSFAiLCBBTEMyMzZfRklYVVBfSFBf
TVVURV9MRUQpLAogCVNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDEwM2UsICJBU1VTIFg1NDBTQSIs
IEFMQzI1Nl9GSVhVUF9BU1VTX01JQyksCg==

--_002_01285f623ac7447187482fb4a8ecaa7crealtekcom_--
