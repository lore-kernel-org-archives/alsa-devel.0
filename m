From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the
 process_option table with function
Date: Wed, 10 Apr 2019 10:34:05 +0000
Message-ID: <VE1PR04MB6479A2AA38FB6A27E120A441E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
 <20190410042638.GB3032@Asurada>
 <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190410080052.GA5180@Asurada>
 <VE1PR04MB6479C577E9C2C58E624C5611E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190410095129.GA3468@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150041.outbound.protection.outlook.com [40.107.15.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D78DF8068A
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 12:34:07 +0200 (CEST)
In-Reply-To: <20190410095129.GA3468@Asurada>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

SGkNCg0KPiANCj4gDQo+IE9uIFdlZCwgQXByIDEwLCAyMDE5IGF0IDA4OjI2OjU5QU0gKzAwMDAs
IFMuai4gV2FuZyB3cm90ZToNCj4gPiA+IElzIGl0IHBvc3NpYmxlIHRvIHVwZGF0ZSB0aGUgdGFi
bGU/IEl0J2QgYmUgd2F5IHF1aWNrZXIgdG8gdXNlDQo+ID4gPiBsb29rdXAgdGFibGUgdGhhbiBy
ZWFsLXRpbWUgY2FsY3VsYXRpb24gYWxsIHRoZSB0aW1lLiBJIGJlbGlldmUgeW91DQo+ID4gPiBj
YW4gc2ltcGx5IGNhbGN1bGF0ZSBhbGwgdGhlIHZhbHVlcyBvdXQgZm9yIDEyS0h6IGFuZCAyNEtI
eiBzaW5jZQ0KPiA+ID4geW91IGhhdmUgdGhlIGZ1bmN0aW9uLiBJZiB0aGVyZSBhcmUgY2VydGFp
biBjb21iaW5hdGlvbnMgb2YgdGhlc2UNCj4gPiA+IHR3byBub3QgYmVpbmcgc3VwcG9ydGVkLCB0
aGVuIHdlIGNvdWxkIG1hcmsgaXQgd2l0aCBhIHNwZWNpYWwgdmFsdWUgYW5kDQo+IGFkZCBhbiBp
Zi1jaGVjayB0byBlcnJvciBvdXQuDQo+ID4gPg0KPiA+DQo+ID4gWWVzLCAgYnV0IEkgdGhpbmsg
dGhlIGZ1bmN0aW9uIHNob3VsZCBiZSBtb3JlIGZsZXhpYmxlLCBpZiBzb21lZGF5IHdlDQo+ID4g
bmVlZCB0byBzdXBwb3J0IE90aGVyIHNhbXBsZSByYXRlLCBvbmx5IG5lZWQgdG8gdXBkYXRlIHRo
ZSBsaXN0Lg0KPiANCj4gR2l2ZW4gdGhlIGZhY3QgdGhhdCB0aGUgb3duZXIgb2YgdGhlIGZ1bmN0
aW9uIGNhbm5vdCBnaXZlIG1vcmUgY29tbWVudHMsIEkNCj4gZmVlbCB0aGUgZnVuY3Rpb24gd291
bGRuJ3QgYmUgdmVyeSBtYWludGFpbmFibGUgYXMgbm9uZSBvZiB1cyB1bmRlcnN0YW5kcyBpdA0K
PiB3ZWxsLiBPbiB0aGUgb3RoZXIgaGFuZCwgeW91J2xsIG5lZWQgdG8gdXBkYXRlIHRoZSBzdXBw
b3J0ZWQgSS9PIHJhdGUgbGlzdHMNCj4gYW55d2F5LCBzbyB3aHkgbm90IGp1c3QgdXBkYXRlIHRo
ZSB0YWJsZSBhcyB3ZWxsPyBUaGUgc3VwcG9ydGVkIHNhbXBsZQ0KPiByYXRlcyBmcm9tIEFMU0Eg
YXJlIGxpbWl0ZWQgdG9vLiBPdmVyYWxsLCBJIHRoaW5rIHRoYXQgY29udGludWUgdXNpbmcgYSBs
b29rdXANCj4gdGFibGUgd2lucy4NCg0KQWxzYSBzdXBwb3J0IFNORFJWX1BDTV9SQVRFX0tOT1Qs
IHdlIGNhbiBkZWZpbmUgdGhlIHJhdGUgdGhhdCB3ZSB3YW50DQpUbyBzdXBwb3J0LCAgYW5kIHVz
ZSBmdW5jdGlvbiBpcyBtb3JlIGZsZXhpYmxlLCBhbmQgd2UgaGF2ZSB1c2UgdGhlIGZ1bmN0aW9u
DQpJbnRlcm5hbGx5IGZvciBsb25nIHRpbWUsIGl0IGlzIHN0YWJsZfCfmIoNCg0KDQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
