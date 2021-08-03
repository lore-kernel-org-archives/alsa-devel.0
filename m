Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1977FC4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 12:51:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8016A60F8F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 12:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8016A60F8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D4411772;
	Tue,  3 Aug 2021 14:50:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D4411772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627995075;
	bh=htcJhqVQ5bfIDLsQOHn4/XeIRAuYpu6hDAnuoD7ZZ/k=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NS1EF5bgJdvlx7bemr8uYaVL3/MZuUA0Ylg3PGQUww4J8gswZj7w1RsYSCGWbvbXd
	 KMnROP7d0fjuXmZVPm9/l6mZmxLFVPPFSJTaV2ScsGf3szO6BtmkIjiXGTgZvyPVLi
	 YCr5qFxrxwBLJeG5vnVA3lZpPZYVekHgrkWjFzgU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ACBECF8016D;
	Tue,  3 Aug 2021 14:50:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E03F0F802E8; Tue,  3 Aug 2021 14:50:22 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9703DF80082
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 14:50:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9703DF80082
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 173Co8ptD006771,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
 by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 173Co8ptD006771
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 3 Aug 2021 20:50:08 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 3 Aug 2021 20:50:07 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 3 Aug 2021 20:50:06 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::50bb:7602:98b5:697f]) by
 RTEXMBS01.realtek.com.tw ([fe80::50bb:7602:98b5:697f%5]) with mapi id
 15.01.2106.013; Tue, 3 Aug 2021 20:50:06 +0800
From: =?big5?B?RGVyZWsgW6TovHe4cV0=?= <derek.fang@realtek.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com"
 <lgirdwood@gmail.com>
Subject: RE: [PATCH 2/2] ASoC: rt5682: Adjust the headset volume button
 threshold
Thread-Topic: [PATCH 2/2] ASoC: rt5682: Adjust the headset volume button
 threshold
Thread-Index: AQHXh5s+fK0VyfnVaUm1zxXIMqEifathvGwS
Date: Tue, 3 Aug 2021 12:50:06 +0000
Message-ID: <bd0a523b242e40a298abe2431276e497@realtek.com>
References: <20210802123753.11762-1-derek.fang@realtek.com>,
 <20210802123753.11762-2-derek.fang@realtek.com>
In-Reply-To: <20210802123753.11762-2-derek.fang@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.27.10.140]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvMyCkV6TIIDA5OjQ4OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/03/2021 12:33:27
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165384 [Aug 03 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: derek.fang@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 449 449 5db59deca4a4f5e6ea34a93b13bc730e229092f4
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; realtek.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, from}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/03/2021 12:36:00
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>, Albert Chen <albertchen@realtek.com>,
 =?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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

SGkgTWFyaywNCg0KDQpQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2guDQoNClNvcnJ5Lg0KDQoNCg0K
VGhhbmtzLA0KDQpEZXJlaw0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQqx
SKXzqsw6IERlcmVrIFuk6Lx3uHFdDQqxSKXzpOm0wTogMjAyMaZ+OKTrMqTpIKRVpMggMDg6MzcN
CqaspfOqzDogYnJvb25pZUBrZXJuZWwub3JnOyBsZ2lyZHdvb2RAZ21haWwuY29tDQqwxqW7OiBh
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IGxhcnNAbWV0YWZvby5kZTsgRmxvdmUoSHNpbkZ1
KTsgT2RlciBDaGlvdTsgSmFjayBZdTsgU2h1bWluZyBbrVOu0bvKXTsgQWxiZXJ0IENoZW47IERl
cmVrIFuk6Lx3uHFdDQqlRKauOiBbUEFUQ0ggMi8yXSBBU29DOiBydDU2ODI6IEFkanVzdCB0aGUg
aGVhZHNldCB2b2x1bWUgYnV0dG9uIHRocmVzaG9sZA0KDQpGcm9tOiBEZXJlayBGYW5nIDxkZXJl
ay5mYW5nQHJlYWx0ZWsuY29tPg0KDQpTZXQgYSBzYWZlIHRocmVzaG9sZCBvZiBoZWFkc2V0IGJ1
dHRvbiB2b2x1bWUrIHRvIGZpeA0KdGhlIHdyb25nIGJ1dHRvbiBkZXRlY3Rpb24gaXNzdWUgd2l0
aCBzb21lIGJyYW5kIGhlYWRzZXRzLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZXJlayBGYW5nIDxkZXJl
ay5mYW5nQHJlYWx0ZWsuY29tPg0KDQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9ydDU2
ODIuYyBiL3NvdW5kL3NvYy9jb2RlY3MvcnQ1NjgyLmMNCmluZGV4IGZjZjQ0MmI4YTczMi4uZmFk
ODI3MzY4YzVlIDEwMDY0NA0KLS0tIGEvc291bmQvc29jL2NvZGVjcy9ydDU2ODIuYw0KKysrIGIv
c291bmQvc29jL2NvZGVjcy9ydDU2ODIuYw0KQEAgLTQ0LDYgKzQ0LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCByZWdfc2VxdWVuY2UgcGF0Y2hfbGlzdFtdID0gew0KICAgICAgICAge1JUNTY4Ml9J
MkNfQ1RSTCwgMHgwMDBmfSwNCiAgICAgICAgIHtSVDU2ODJfUExMMl9JTlRFUk5BTCwgMHg4MjY2
fSwNCiAgICAgICAgIHtSVDU2ODJfU0FSX0lMX0NNRF8zLCAweDgzNjV9LA0KKyAgICAgICB7UlQ1
NjgyX1NBUl9JTF9DTURfNiwgMHgwMTEwfSwNCiB9Ow0KDQogdm9pZCBydDU2ODJfYXBwbHlfcGF0
Y2hfbGlzdChzdHJ1Y3QgcnQ1NjgyX3ByaXYgKnJ0NTY4Miwgc3RydWN0IGRldmljZSAqZGV2KQ0K
LS0NCjIuMTcuMQ0KDQo=
