Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B035C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:13:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAB72070E
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RqO526CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAB72070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52335852;
	Thu, 16 Jul 2020 09:12:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52335852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594883612;
	bh=JZcYt2OWDsVHe4soumwq0cKKXgpwCErDRuOgxP23KZY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RqO526CDkkOB4wwn2oBdW6u8OdwmNrKh3mGhh51ewpVx8xzyK3K23RLvznCq5Xf8t
	 i3qsrMMV5Ybe1AEiZZK1VgI2e3eGRXL5xa6xfuTyOB1uFDLqzIgW3e0kn+LDMEeeIs
	 hUzVXwHq9vJuzI7n5s7d+v/kulGU7XZB5wR5yj8A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E379DF8016F;
	Thu, 16 Jul 2020 09:12:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 051ACF801EC; Thu, 16 Jul 2020 09:12:40 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0073F8014E
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 09:12:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0073F8014E
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06G7CQs74019988,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
 by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06G7CQs74019988
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 16 Jul 2020 15:12:26 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jul 2020 15:12:26 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8]) by
 RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8%5]) with mapi id
 15.01.1779.005; Thu, 16 Jul 2020 15:12:26 +0800
From: Kailang <kailang@realtek.com>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Subject: ASUS UX533 and UX534 speaker no ouput
Thread-Topic: ASUS UX533 and UX534 speaker no ouput
Thread-Index: AdZbQCGJqMtJgU9eQ2uzVg7+ytsx2w==
Date: Thu, 16 Jul 2020 07:12:26 +0000
Message-ID: <80334402a93b48e385f8f4841b59ae09@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.211]
Content-Type: multipart/mixed;
 boundary="_002_80334402a93b48e385f8f4841b59ae09realtekcom_"
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

--_002_80334402a93b48e385f8f4841b59ae09realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Attach patch will solve speaker no output issue for ASUS platform.
Many Thanks.

BR,
Kailang

--_002_80334402a93b48e385f8f4841b59ae09realtekcom_
Content-Type: application/octet-stream;
	name="0000-asus-ux533-ux534-spk.patch"
Content-Description: 0000-asus-ux533-ux534-spk.patch
Content-Disposition: attachment; filename="0000-asus-ux533-ux534-spk.patch";
	size=996; creation-date="Thu, 16 Jul 2020 06:47:38 GMT";
	modification-date="Thu, 16 Jul 2020 07:08:57 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2OGZmMTZiYzI3ZTk3MjhjYjdmZDJhZmJlYjg3YmQ1NTRkNTIyODVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFRodSwgMTYgSnVsIDIwMjAgMTQ6NDI6MzMgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEVuYWJsZSBTcGVha2VyIGZvciBBU1VTIFVYNTMzIGFuZCBVWDUzNAoK
QVNVUyBVWDUzMyBhbmQgVVg1MzQgc3BlYWtlciBzdGlsbCBjYW4ndCBvdXRwdXQuCkVuZCBVc2Vy
IGZlZWRiYWNrIHNwZWFrZXIgZGlkbid0IGhhdmUgb3V0cHV0LgpBZGQgdGhpcyBDT0VGIHZhbHVl
IHdpbGwgZW5hYmxlIGl0LgoKRml4ZXM6IDRlMDUxMTA2NzMwZCAoIkFMU0E6IGhkYS9yZWFsdGVr
OiBFbmFibGUgYXVkaW8gamFja3Mgb2YgQVNVUyBVWDUzM0ZEIHdpdGggQUxDMjk0IikKU2lnbmVk
LW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBh
L3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMKaW5kZXggYzFhMTNjOGVhYjQ3Li4wZjc2MjU0NmMzZGEgMTAwNjQ0Ci0tLSBhL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRl
ay5jCkBAIC03MTI0LDYgKzcxMjQsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9maXh1cCBh
bGMyNjlfZml4dXBzW10gPSB7CiAJCQkvKiBTZXQgRUFQRCBoaWdoICovCiAJCQl7IDB4MjAsIEFD
X1ZFUkJfU0VUX0NPRUZfSU5ERVgsIDB4NDAgfSwKIAkJCXsgMHgyMCwgQUNfVkVSQl9TRVRfUFJP
Q19DT0VGLCAweDg4MDAgfSwKKwkJCXsgMHgyMCwgQUNfVkVSQl9TRVRfQ09FRl9JTkRFWCwgMHgw
ZiB9LAorCQkJeyAweDIwLCBBQ19WRVJCX1NFVF9QUk9DX0NPRUYsIDB4Nzc3NCB9LAogCQkJeyB9
CiAJCX0sCiAJCS5jaGFpbmVkID0gdHJ1ZSwK

--_002_80334402a93b48e385f8f4841b59ae09realtekcom_--
