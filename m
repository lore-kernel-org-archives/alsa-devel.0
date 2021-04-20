Return-Path: <SRS0=gQoH=JR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62660C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 01:11:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33769613AB
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 01:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33769613AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFC5D1607;
	Tue, 20 Apr 2021 03:10:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFC5D1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618881108;
	bh=qqNIRfgnAilRapCBWuH/jcw/rwtD5eda7fX918x+iv4=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=heci1EUE34MXeoSbxpyMdlqX+lKMZ/p3hDwV+n1d6Ft1cGTLtCpatwMvksa5h1VcV
	 7CIVVi1+4qq+1A3p/exU183stPLMHjvYsMeaZgRCWOyS57Wv1XLCWYi0rTw09Ap/Ny
	 cxS0DTT3p7P3KyrmCsClM6k29p4RNgED6K4Ag1DI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 496D4F8019B;
	Tue, 20 Apr 2021 03:10:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15EDCF800C5; Tue, 20 Apr 2021 03:10:54 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DD94F80164
 for <alsa-devel@alsa-project.org>; Tue, 20 Apr 2021 03:10:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DD94F80164
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13K1AdXE2015376,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
 by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13K1AdXE2015376
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 20 Apr 2021 09:10:39 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 09:10:39 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 09:10:38 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::e1bc:d5c7:d79c:2ab7]) by
 RTEXMBS01.realtek.com.tw ([fe80::e1bc:d5c7:d79c:2ab7%13]) with mapi id
 15.01.2106.013; Tue, 20 Apr 2021 09:10:38 +0800
From: =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>
To: "Yang, Libin" <libin.yang@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com"
 <lgirdwood@gmail.com>
Subject: RE: [PATCH] ASoC: rt711-sdca: remove capture switch controls
Thread-Topic: [PATCH] ASoC: rt711-sdca: remove capture switch controls
Thread-Index: AQHXMdf+QTvRr7HRpkiQCAuq7WsuWKq06kgAgAXhsoCAABWwgIAABPgAgAAB7gCAAAXIAIAAGqEAgAECOgCAAIw2AA==
Date: Tue, 20 Apr 2021 01:10:38 +0000
Message-ID: <ba277a0457da4ab09f5120f30a9dc699@realtek.com>
References: <20210415091609.13695-1-shumingf@realtek.com>
 <6c5b52e2-c875-9b30-60dd-d4bec77a9215@linux.intel.com>
 <BN6PR11MB1652220DB80760FD18B8308290499@BN6PR11MB1652.namprd11.prod.outlook.com>
 <9146794c-d4a1-8dd8-4ab1-7c9c44a7703b@perex.cz>
 <MWHPR11MB1663671582DCB35BE88C5B5590499@MWHPR11MB1663.namprd11.prod.outlook.com>
 <606f8e2d-40d5-8de0-1a06-9c8da016652d@perex.cz>
 <MWHPR11MB1663B46AB115359FDBDDB29F90499@MWHPR11MB1663.namprd11.prod.outlook.com>
 <d3aa7b7c-4384-9fd8-d814-e2bcbf0da9d2@perex.cz>
 <MWHPR11MB16631ECF778944604073DD9190489@MWHPR11MB1663.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB16631ECF778944604073DD9190489@MWHPR11MB1663.namprd11.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.209]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMTkg5LiL5Y2IIDExOjQzOjAw?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/20/2021 00:48:50
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163215 [Apr 19 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: shumingf@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2; realtek.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, from}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/20/2021 00:52:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/20/2021 00:58:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163215 [Apr 19 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: shumingf@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 realtek.com:7.1.1; 127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, from}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/20/2021 01:02:00
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 =?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
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

PiA+IEkgc2VlLiBJbiB0aGlzIGNhc2UsIHRoZSBhdXRvLXJvdXRlIHNldHRpbmdzIHNob3VsZCBk
aWZmZXIgZnJvbSB0aGUNCj4gPiBtaXhlciBzZXR0aW5ncy4gU28gdGhlIG11dGUgZmxhZyBzaG91
bGQgYmUgbG9naWNhbCBfT1JfIGZyb20gYm90aCBEQVBNDQo+ID4gYW5kIHRoZSBtaXhlciBzZXR0
aW5ncy4gQW5kIGJlY2F1c2UgdGhlIGNvZGVjIGlzIGFibGUgdG8gZG8gdGhlIGh3DQo+ID4gbXV0
ZSwgd2h5IHRvIHByZXZlbnQgdGhlIGV4cG9ydCBvZiB0aGlzIGZlYXR1cmU/DQo+ID4NCj4gPiBT
byBJIHByb3Bvc2UgZG8gZG8gKHBzZXVkbyBjb2RlKToNCj4gPg0KPiA+IHN0cnVjdCBydDcxMV9z
ZGNhX3ByaXYgew0KPiA+IAlib29sIGZ1MGZfZGFwbV9tdXRlOw0KPiA+IAlib29sIGZ1MGZfbWl4
ZXJfbXV0ZTsNCj4gPiB9Ow0KPiA+DQo+ID4gLyogY2FsbGVkIGZyb20gYm90aCBkYXBtIGV2ZW50
IGFuZCBrb250cm9sIHB1dCBjYWxsYmFjayAob24gY2hhbmdlKSAqLw0KPiA+IC8qIHRoZSBkYXBt
IGV2ZW50IGFuZCBwdXQgY2FsbGJhY2sgd2lsbCBtb2RpZnkgb25seSBydDcxMV9zZGNhX3ByaXYN
Cj4gPiBmaWVsZHMgKi8gc3RhdGljIHZvaWQgc2V0X2YwZl9tdXRlKHJ0NzExX3ByaXYpIHsNCj4g
PiAJaW50IG11dGUgPSBydDcxMV9wcml2LT5mdTBmX2RhcG1fbXV0ZSB8fCBydDcxMV9wcml2LQ0K
PiA+ID5mdTBmX21peGVyX211dGU7DQo+ID4gCXNldF9mdTBmX211dGVfcmVnaXN0ZXIobXV0ZSk7
DQo+ID4gfQ0KPiA+DQo+ID4gV2l0aCB0aGlzIGltcGxlbWVudGF0aW9uLCBhbGwgaXMgY29uc2lz
dGVudCB0byB0aGUgdXNlciBzcGFjZS4NCj4gDQo+IElmIHNvOg0KPiBXaGVuIGNhcHR1cmUsIGlm
IHVzZXIgc2V0dGluZyBpcyBtdXRlLCBpdCB3aWxsIGFsd2F5cyBtdXRlIGFuZCBpZiB1c2VyIHNl
dHRpbmcgaXMNCj4gdW5tdXRlLCBpdCB3aWxsIGFsd2F5cyB1bm11dGUuDQo+IA0KPiBXaGVuIHN0
b3AgY2FwdHVyZSwgaXQgd2lsbCBhbHdheXMgbXV0ZSByZWdhcmRsZXNzIHRoZSB1c2VyIHNldHRp
bmcuDQo+IA0KPiBTaHVtaW5nLCB3aGF0IGRvIHlvdSB0aGluaz8NCg0KSSB0aGluayB0aGUgZnVu
Y3Rpb24gY291bGQgbXV0ZS91bm11dGUgYm90aC4gSXQgY291bGQgYXZvaWQgdGhhdCB0aGUgc2V0
dGluZyBhbHdheXMgbXV0ZXMgaWYgdGhlIHVzZXIgc2V0dGluZyBpcyB1bm11dGUuDQplLmcuDQpz
dGF0aWMgdm9pZCBzZXRfZnUwZl9jYXB0dXJlX2N0bChydDcxMV9wcml2KSB7DQogICAgaW50IG11
dGUgPSBydDcxMV9wcml2LT5mdTBmX2RhcG1fbXV0ZSB8fCBydDcxMV9wcml2LT5mdTBmX21peGVy
X211dGU7DQogICAgaWYgKG11dGUpDQogICAgICAgIHNldF9mdTBmX211dGVfcmVnaXN0ZXIoKTsN
CiAgICBlbHNlDQogICAgICAgIHNldF9mdTBmX3VubXV0ZV9yZWdpc3RlcigpOw0KfQ0KDQpIaSBK
YXJvc2xhdiwNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9ucy4gQWZ0ZXIgdGhlIHRlc3Rpbmcs
IEkgd2lsbCBzZW5kIHRoZSB2MiB2ZXJzaW9uLg0KDQo+ID4NCj4gPiA+PiBBbnl3YXksIHRoZSBz
d2l0Y2ggYW5kIHZvbHVtZSBmb3IgdGhlIGdpdmVuIEkvTyBzaG91bGQgaGF2ZQ0KPiA+ID4+IGlk
ZW50aWNhbCBuYW1lIGFuZCB0aGV5IHNob3VsZCBkaWZmZXIgb25seSBpbiB0aGUgc3VmZml4IGRl
c2NyaWJpbmcNCj4gPiA+PiB0aGUgc3RyZWFtIGFuZCBmdW5jdGlvbmFsaXR5Lg0KPiA+ID4NCj4g
PiA+IFdlIHdvbid0IHRvdWNoICJDYXB0dXJlU3dpdGNoIiBhbmQgIkNhcHR1cmVWb2x1bWUiIGZv
ciBydDcxMS1zZGNhLg0KPiA+DQo+ID4gWWVzLCBidXQgdGhlIGh3IGNvbnRyb2xzIHNob3VsZCBi
ZSB1c2VkIGluc3RlYWQgRFNQIGNvbnRyb2xzLCBpZiB0aGV5DQo+ID4gYXJlIGF2YWlsYWJsZS4N
Cj4gDQo+IFllcywgd2Ugd2lsbCB0cnkgdG8gdXNlIHRoZSBjb2RlYyBodyBjb250cm9scyBpbnN0
ZWFkIG9mIHRoZSBEU1AgY29udHJvbHMuDQo+IA0KPiBSZWdhcmRzLA0KPiBMaWJpbg0KPiAtLS0t
LS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUt
bWFpbC4NCg==
