From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: [PATCH 3/3] ASoC: codecs: max98088: Added digital
 mute function in DAI1 and DAI2
Date: Tue, 17 May 2011 17:28:52 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40DDDA17963@ITSVLEX06.it.maxim-ic.internal>
References: <1305179918-19317-1-git-send-email-jinyoungp@nvidia.com>
	<1305179918-19317-4-git-send-email-jinyoungp@nvidia.com>
	<BANLkTikw26WY0RTkxwip9QAYQWBT=j2HiQ@mail.gmail.com>
	<D9A2FA38A1E15B4E832469E5FE40C7ABFA02963582@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EADE243C8
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 02:30:05 +0200 (CEST)
In-Reply-To: <D9A2FA38A1E15B4E832469E5FE40C7ABFA02963582@HKMAIL01.nvidia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jinyoung Park <jinyoungp@nvidia.com>, 'Jassi Brar' <jassisinghbrar@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gRnJpZGF5LCBNYXkgMTMsIDIwMTEsICA8amlueW91bmdwQG52aWRpYS5jb20+IHdyb3RlOg0K
PiBQZXRlciwNCj4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0aGF0Pw0KPiANCj4gT24gRnJpZGF5
LCBNYXkgMTMsIDIwMTEsICBKYXNzaSBCcmFyIHdyb3RlOg0KPiA+ICtzdGF0aWMgaW50IG1heDk4
MDg4X2RhaTFfZGlnaXRhbF9tdXRlKHN0cnVjdCBzbmRfc29jX2RhaSAqY29kZWNfZGFpLA0KPiA+
ICtpbnQgbXV0ZSkgew0KPiA+ICsgwqAgwqAgwqAgc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVj
ID0gY29kZWNfZGFpLT5jb2RlYzsNCj4gPiArIMKgIMKgIMKgIGludCByZWc7DQo+ID4gKw0KPiA+
ICsgwqAgwqAgwqAgaWYgKG11dGUpDQo+ID4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZWcgPSBN
OTgwODhfREFJX01VVEU7DQo+ID4gKyDCoCDCoCDCoCBlbHNlDQo+ID4gKyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCByZWcgPSAwOw0KPiA+ICsNCj4gPiArIMKgIMKgIMKgIHNuZF9zb2NfdXBkYXRlX2Jp
dHMoY29kZWMsIE05ODA4OF9SRUdfMkZfTFZMX0RBSTFfUExBWSwNCj4gPiArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE05ODA4OF9EQUlfTVVURV9NQVNLLCByZWcpOw0K
PiA+ICsgwqAgwqAgwqAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gbWF4OTgwODhfZGFp
MV9kaWdpdGFsX211dGUgICAgIG1heDk4MDg4X2RhaTJfZGlnaXRhbF9tdXRlDQo+ID4gbWF4OTgw
ODhfZGFpMV9zZXRfZm10ICAgICAgICAgICAgIG1heDk4MDg4X2RhaTJfc2V0X2ZtdA0KPiA+IG1h
eDk4MDg4X2RhaTFfaHdfcGFyYW1zICAgICAgbWF4OTgwODhfZGFpMl9od19wYXJhbXMNCj4gPg0K
PiA+IFRoZXNlIHBhaXJzIGFyZSBlc3NlbnRpYWxseSBzYW1lIGZ1bmN0aW9uIG9wZXJhdGluZyBv
biBkaWZmZXJlbnQNCj4gPiByZWdpc3RlcnMuIENhbid0IHdlIGNvbXByZXNzIHRoZW0gPw0KIA0K
SGkgSmlueW91bmcsDQoNClRoYW5rIHlvdSBmb3IgbG9va2luZyBhdCB0aGlzLg0KDQpUaGUgZGln
aXRhbCBtdXRlIGZ1bmN0aW9uIGlzIHJlbGF0aXZlbHkgc21hbGwuICANCkl0IGlzIG9rIGFzIHNl
cGFyYXRlIGZ1bmN0aW9ucy4NCg0KcmVndmFsID0gbXV0ZSA/IE05ODA4OF9EQUlfTVVURSA6IDA7
DQoNCkZvciBod19wYXJhbXMsIEkgaGFkIHdhbnRlZCB0byBjb21iaW5lIHRoZW0gdG9vIGluaXRp
YWxseS4NCkhvd2V2ZXIsIHRoZXJlIGFyZSBxdWl0ZSBhIGZldyBkaWZmZXJlbnQgcmVnaXN0ZXJz
IGluIHRoZXJlLg0KRm9yIG9ubHkgMiBpbnN0YW50aWF0aW9ucywgdGhlIGV4dHJhIGNvbmRpdGlv
bmFsIGNvZGUgdG8gDQplbmFibGUgY29tYmluaW5nIHRoZW0gd2lsbCBzb21ld2hhdCBkaW1pbmlz
aCB0aGUgYmVuZWZpdC4NCkkgYW0gbGVhbmluZyB0b3dhcmQga2VlcGluZyB0aGVtIHRoZSB3YXkg
dGhleSBhcmUuDQpCdXQgaXQncyBvayB3aXRoIG1lIGlmIHlvdSB0aGluayBvZiBhIGdvb2Qgd2F5
IHRvIGRvIGl0Lg0KVGhlIHNldF9mbXQgaXMgYSBwb3NzaWJpbGl0eS4NCg0KUGV0ZXINCg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBt
YWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
