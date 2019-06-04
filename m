From: Jurgen Lambrecht <J.Lambrecht@TELEVIC.com>
Subject: why error return in
 sound/soc/codecs/pcm3168a.c::pcm3168a_set_dai_fmt ?
Date: Tue, 4 Jun 2019 06:37:48 +0000
Message-ID: <8e4d6674-0a5b-7063-534d-cea4e55056d5@televic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00112.outbound.protection.outlook.com [40.107.0.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9872EF89673
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2019 08:37:50 +0200 (CEST)
Content-Language: en-US
Content-ID: <0ABC482D4FD47D43898E715D4AA122F9@eurprd07.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SGksDQoNCldoZW4gZm9sbG93aW5nIA0KaHR0cHM6Ly9ib290bGluLmNvbS9ibG9nL2VpZ2h0LWNo
YW5uZWxzLWF1ZGlvLW9uLWktbXg3LXdpdGgtcGNtMzE2OC8gSSANCmdldCB0aGlzIGVycm9yIChm
cm9tIHNvY19jb3JlLmMpOg0KDQouLi4ga2VybmVsOiBbwqDCoMKgIDMuMDU5NjM0XVvCoMKgIFQx
NV0gcGNtMzE2OGEgMy0wMDM5OiBBU29DOiBGYWlsZWQgdG8gc2V0IA0KREFJIGZvcm1hdDogLTIy
DQoNCkkgY291bGQgcHJvcG9zZSB0aGlzIHBhdGNoIChJIGdldCB0aGF0IHByaW50ZiB3aGVuIGFw
cGx5aW5nIHRoZSBwYXRjaCkNCihhbGwgb3RoZXIgZXJyb3JzIGluIHRoYXQgZmlsZSBoYXZlIGEg
cHJpbnRmKToNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvcGNtMzE2OGEuYyBiL3Nv
dW5kL3NvYy9jb2RlY3MvcGNtMzE2OGEuYw0KaW5kZXggMDhkM2ZlMTkyZTY1Li43NWNjYmI5MTk5
MDIgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvY29kZWNzL3BjbTMxNjhhLmMNCisrKyBiL3NvdW5k
L3NvYy9jb2RlY3MvcGNtMzE2OGEuYw0KQEAgLTM1Myw2ICszNTMsNyBAQCBzdGF0aWMgaW50IHBj
bTMxNjhhX3NldF9kYWlfZm10KHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpLA0KIMKgwqDCoMKgwqDC
oMKgIGNhc2UgU05EX1NPQ19EQUlGTVRfTkJfTkY6DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJyZWFrOw0KIMKgwqDCoMKgwqDCoMKgIGRlZmF1bHQ6DQorwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkZXZfZXJyKGNvbXBvbmVudC0+ZGV2LCAid3JvbmcgSU5WX01BU0tcbiIp
Ow0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsNCiDCoMKg
wqDCoMKgwqDCoCB9DQoNCkJ1dCB3aHkgZG9lcyB0aGlzIGNvZGUgcmV0dXJucyBhbiBlcnJvciBm
b3IgY29kZSB0aGF0IGhhcyBubyBlZmZlY3Q/DQpPSywgaXQgY291bGQgYmUgYmVjYXVzZSBTTkRf
U09DX0RBSUZNVF9JTlZfTUFTSyBtdXN0IGJlIA0KU05EX1NPQ19EQUlGTVRfTkJfTkYuIEJ1dCB0
aGVuIEFsZXhhbmRyZSdzIGJsb2cgY29udGFpbnMgYW4gZXJyb3IsIA0KYmVjYXVzZSB0aGUgZGFj
IFRETSBzZXRzIGZyYW1lLWludmVyc2lvbiBpbiBpdHMgZHRzIChhbmQgaXQgc2hvdWxkIG5vdCku
DQoNCi0tIA0KDQpLaW5kIFJlZ2FyZHMsDQoNCipKw7xyZ2VuIExhbWJyZWNodCoNClImRCBBc3Nv
Y2lhdGUNCg0KVGVsOiArMzIgNTEgMzAzMDQ1DQoNCnd3dy50ZWxldmljLXJhaWwuY29tIDxodHRw
czovL3d3dy50ZWxldmljLXJhaWwuY29tPg0KDQpUZWxldmljIFJhaWwgTlYgLSBMZW8gQmVrYWVy
dGxhYW4gMSAtIDg4NzAgSXplZ2VtIC0gQmVsZ2l1bQ0KQ29tcGFueSBudW1iZXIgMDgyNSA1Mzkg
NTgxIC0gUlBSIEtvcnRyaWprDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
