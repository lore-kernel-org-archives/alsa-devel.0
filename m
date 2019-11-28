Return-Path: <SRS0=87PQ=ZU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BD0C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 06:53:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8684C2154A
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 06:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aXi131xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8684C2154A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF58616D1;
	Thu, 28 Nov 2019 07:52:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF58616D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574923991;
	bh=wShzIfDxW3uqt1/fgv80GJjQ3SbGrTMzBK9RHYkIcKE=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aXi131xke3dB2lyXeCAxbAy4Tsq152Rsp21hVN2fh0PtlKbfVMFQUumjtHS3JwX+4
	 RiBWp+nms26x7/GlJE5ChbYJQZWl7i9f5ug08qiF/K6fz0MjmGIqwMoCy3GNcumego
	 3lnNmH9d0FafqeC81sxPk73FBDW/3579kXBXAqM4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33B8FF800CB;
	Thu, 28 Nov 2019 07:52:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F289F80149; Thu, 28 Nov 2019 07:52:19 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C89DCF800CB
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2019 07:52:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C89DCF800CB
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAS6q8gR024365,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
 by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAS6q8gR024365
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Nov 2019 14:52:08 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Thu, 28 Nov 2019 14:52:08 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 28 Nov 2019 14:52:08 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::3d62:4ced:fdc4:e28b]) by
 RTEXMB01.realtek.com.tw ([fe80::3d62:4ced:fdc4:e28b%13]) with mapi id
 15.01.1779.005; Thu, 28 Nov 2019 14:52:08 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Thread-Topic: Dell  headphone has noise on unmute state for ALC236
Thread-Index: AdWluBMjYH/cNxarTTiv6V9Jo3jwDQ==
Date: Thu, 28 Nov 2019 06:52:08 +0000
Message-ID: <9ae47f23a64d4e41a9c81e263cd8a250@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.105.211]
Content-Type: multipart/mixed;
 boundary="_002_9ae47f23a64d4e41a9c81e263cd8a250realtekcom_"
MIME-Version: 1.0
Cc: " \(alsa-devel@alsa-project.org\)" <alsa-devel@alsa-project.org>
Subject: [alsa-devel] Dell  headphone has noise on unmute state for ALC236
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

--_002_9ae47f23a64d4e41a9c81e263cd8a250realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

headphone have noise even the volume is very small.
Let it fill up pcbeep hidden register to default value.
The issue was gone.
The patch as attach file.
Many thanks.

BR,
Kailang



--_002_9ae47f23a64d4e41a9c81e263cd8a250realtekcom_
Content-Type: application/octet-stream; name="0000-dell-hp-noise.patch"
Content-Description: 0000-dell-hp-noise.patch
Content-Disposition: attachment; filename="0000-dell-hp-noise.patch";
	size=1212; creation-date="Tue, 26 Nov 2019 09:08:58 GMT";
	modification-date="Thu, 28 Nov 2019 06:50:41 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzNmFmODRiNWI4OGFmODlhZjg1MjQxOGJmZWYxZWI2ZDBmZjNhYmJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFR1ZSwgMjYgTm92IDIwMTkgMTc6MDQ6MjMgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIERlbGwgaGVhZHBob25lIGhhcyBub2lzZSBvbiB1bm11dGUgZm9yIEFM
QzIzNgoKaGVhZHBob25lIGhhdmUgbm9pc2UgZXZlbiB0aGUgdm9sdW1lIGlzIHZlcnkgc21hbGwu
CkxldCBpdCBmaWxsIHVwIHBjYmVlcCBoaWRkZW4gcmVnaXN0ZXIgdG8gZGVmYXVsdCB2YWx1ZS4K
VGhlIGlzc3VlIHdhcyBnb25lLgoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5n
QHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5j
IGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggZDJiZjcwYTFkMmZkLi45ZjM1
NWIyZjdkN2IgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBi
L3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC0zNjcsOSArMzY3LDcgQEAgc3RhdGlj
IHZvaWQgYWxjX2ZpbGxfZWFwZF9jb2VmKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWNhc2Ug
MHgxMGVjMDIxNToKIAljYXNlIDB4MTBlYzAyMzM6CiAJY2FzZSAweDEwZWMwMjM1OgotCWNhc2Ug
MHgxMGVjMDIzNjoKIAljYXNlIDB4MTBlYzAyNTU6Ci0JY2FzZSAweDEwZWMwMjU2OgogCWNhc2Ug
MHgxMGVjMDI1NzoKIAljYXNlIDB4MTBlYzAyODI6CiAJY2FzZSAweDEwZWMwMjgzOgpAQCAtMzgx
LDYgKzM3OSwxMSBAQCBzdGF0aWMgdm9pZCBhbGNfZmlsbF9lYXBkX2NvZWYoc3RydWN0IGhkYV9j
b2RlYyAqY29kZWMpCiAJY2FzZSAweDEwZWMwMzAwOgogCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNv
ZGVjLCAweDEwLCAxPDw5LCAwKTsKIAkJYnJlYWs7CisJY2FzZSAweDEwZWMwMjM2OgorCWNhc2Ug
MHgxMGVjMDI1NjoKKwkJYWxjX3dyaXRlX2NvZWZfaWR4KGNvZGVjLCAweDM2LCAweDU3NTcpOwor
CQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDEwLCAxPDw5LCAwKTsKKwkJYnJlYWs7CiAJ
Y2FzZSAweDEwZWMwMjc1OgogCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweGUsIDAsIDE8
PDApOwogCQlicmVhazsK

--_002_9ae47f23a64d4e41a9c81e263cd8a250realtekcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_002_9ae47f23a64d4e41a9c81e263cd8a250realtekcom_--
