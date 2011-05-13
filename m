From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: codecs: max98088: Added digital
 mute function in DAI1 and DAI2
Date: Fri, 13 May 2011 12:41:23 +0530
Message-ID: <BANLkTikw26WY0RTkxwip9QAYQWBT=j2HiQ@mail.gmail.com>
References: <1305179918-19317-1-git-send-email-jinyoungp@nvidia.com>
	<1305179918-19317-4-git-send-email-jinyoungp@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B025E10382F
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 09:11:23 +0200 (CEST)
Received: by bwz10 with SMTP id 10so2181530bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2011 00:11:23 -0700 (PDT)
In-Reply-To: <1305179918-19317-4-git-send-email-jinyoungp@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jinyoungp@nvidia.com
Cc: Peter.Hsiang@maxim-ic.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBNYXkgMTIsIDIwMTEgYXQgMTE6MjggQU0sICA8amlueW91bmdwQG52aWRpYS5jb20+
IHdyb3RlOgoKPiArc3RhdGljIGludCBtYXg5ODA4OF9kYWkxX2RpZ2l0YWxfbXV0ZShzdHJ1Y3Qg
c25kX3NvY19kYWkgKmNvZGVjX2RhaSwgaW50IG11dGUpCj4gK3sKPiArIMKgIMKgIMKgIHN0cnVj
dCBzbmRfc29jX2NvZGVjICpjb2RlYyA9IGNvZGVjX2RhaS0+Y29kZWM7Cj4gKyDCoCDCoCDCoCBp
bnQgcmVnOwo+ICsKPiArIMKgIMKgIMKgIGlmIChtdXRlKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcmVnID0gTTk4MDg4X0RBSV9NVVRFOwo+ICsgwqAgwqAgwqAgZWxzZQo+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgcmVnID0gMDsKPiArCj4gKyDCoCDCoCDCoCBzbmRfc29jX3VwZGF0ZV9iaXRz
KGNvZGVjLCBNOTgwODhfUkVHXzJGX0xWTF9EQUkxX1BMQVksCj4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNOTgwODhfREFJX01VVEVfTUFTSywgcmVnKTsKPiArIMKg
IMKgIMKgIHJldHVybiAwOwo+ICt9Cj4gKwo+ICtzdGF0aWMgaW50IG1heDk4MDg4X2RhaTJfZGln
aXRhbF9tdXRlKHN0cnVjdCBzbmRfc29jX2RhaSAqY29kZWNfZGFpLCBpbnQgbXV0ZSkKPiArewo+
ICsgwqAgwqAgwqAgc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjID0gY29kZWNfZGFpLT5jb2Rl
YzsKPiArIMKgIMKgIMKgIGludCByZWc7Cj4gKwo+ICsgwqAgwqAgwqAgaWYgKG11dGUpCj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCByZWcgPSBNOTgwODhfREFJX01VVEU7Cj4gKyDCoCDCoCDCoCBl
bHNlCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZWcgPSAwOwo+ICsKPiArIMKgIMKgIMKgIHNu
ZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIE05ODA4OF9SRUdfMzFfTFZMX0RBSTJfUExBWSwKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE05ODA4OF9EQUlfTVVURV9N
QVNLLCByZWcpOwo+ICsgwqAgwqAgwqAgcmV0dXJuIDA7Cj4gK30KCm1heDk4MDg4X2RhaTFfZGln
aXRhbF9tdXRlICAgICBtYXg5ODA4OF9kYWkyX2RpZ2l0YWxfbXV0ZQptYXg5ODA4OF9kYWkxX3Nl
dF9mbXQgICAgICAgICAgICAgbWF4OTgwODhfZGFpMl9zZXRfZm10Cm1heDk4MDg4X2RhaTFfaHdf
cGFyYW1zICAgICAgbWF4OTgwODhfZGFpMl9od19wYXJhbXMKClRoZXNlIHBhaXJzIGFyZSBlc3Nl
bnRpYWxseSBzYW1lIGZ1bmN0aW9uIG9wZXJhdGluZyBvbiBkaWZmZXJlbnQKcmVnaXN0ZXJzLiBD
YW4ndCB3ZSBjb21wcmVzcyB0aGVtID8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
