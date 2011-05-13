From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: codecs: max98088: Added digital
 mute function in DAI1 and DAI2
Date: Fri, 13 May 2011 12:36:21 +0530
Message-ID: <BANLkTikpAL_aPU=p=3ftEiEKi2+V4QLM5w@mail.gmail.com>
References: <1305179918-19317-1-git-send-email-jinyoungp@nvidia.com>
	<1305179918-19317-4-git-send-email-jinyoungp@nvidia.com>
	<BANLkTim7ZQ+Uq8M1p7EX=ma80wCO8MsPdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D31F8103835
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 09:06:21 +0200 (CEST)
Received: by bwz10 with SMTP id 10so2178321bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2011 00:06:21 -0700 (PDT)
In-Reply-To: <BANLkTim7ZQ+Uq8M1p7EX=ma80wCO8MsPdQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: Peter.Hsiang@maxim-ic.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, jinyoungp@nvidia.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBNYXkgMTMsIDIwMTEgYXQgMjoxMyBBTSwgU2V1bmd3aGFuIFlvdW4gPGNsYXVkZS55
b3VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4gSGkgTXIuIEppbiBQYXJrLAo+Cj4gT24gVGh1LCBNYXkg
MTIsIDIwMTEgYXQgMjo1OCBQTSwgwqA8amlueW91bmdwQG52aWRpYS5jb20+IHdyb3RlOgo+PiBG
cm9tOiBKaW4gUGFyayA8amlueW91bmdwQG52aWRpYS5jb20+Cj4+Cj4+IEFkZGVkIGRpZ2l0YWwg
bXV0ZSBmdW5jdGlvbiBpbiBEQUkxIGFuZCBEQUkyLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKaW4g
UGFyayA8amlueW91bmdwQG52aWRpYS5jb20+Cj4+IC0tLQo+PiDCoHNvdW5kL3NvYy9jb2RlY3Mv
bWF4OTgwODguYyB8IMKgIDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+IMKg
c291bmQvc29jL2NvZGVjcy9tYXg5ODA4OC5oIHwgwqAgMTMgKysrKysrKysrKysrKwo+PiDCoDIg
ZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvbWF4OTgwODguYyBiL3NvdW5kL3NvYy9jb2RlY3Mv
bWF4OTgwODguYwo+PiBpbmRleCBjNTIwMDkzLi5iNWNjZjM3IDEwMDY0NAo+PiAtLS0gYS9zb3Vu
ZC9zb2MvY29kZWNzL21heDk4MDg4LmMKPj4gKysrIGIvc291bmQvc29jL2NvZGVjcy9tYXg5ODA4
OC5jCj4+IEBAIC0xNTgyLDYgKzE1ODIsMzYgQEAgc3RhdGljIGludCBtYXg5ODA4OF9kYWkyX3Nl
dF9mbXQoc3RydWN0IHNuZF9zb2NfZGFpICpjb2RlY19kYWksCj4+IMKgIMKgIMKgIMKgcmV0dXJu
IDA7Cj4+IMKgfQo+Pgo+PiArc3RhdGljIGludCBtYXg5ODA4OF9kYWkxX2RpZ2l0YWxfbXV0ZShz
dHJ1Y3Qgc25kX3NvY19kYWkgKmNvZGVjX2RhaSwgaW50IG11dGUpCj4+ICt7Cj4+ICsgwqAgwqAg
wqAgc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjID0gY29kZWNfZGFpLT5jb2RlYzsKPj4gKyDC
oCDCoCDCoCBpbnQgcmVnOwo+PiArCj4+ICsgwqAgwqAgwqAgaWYgKG11dGUpCj4+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcmVnID0gTTk4MDg4X0RBSV9NVVRFOwo+PiArIMKgIMKgIMKgIGVsc2UK
Pj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZWcgPSAwOwo+Cj4gSW4gdGhpcyBjYXNlLCB+TTk4
MDg4X0RBSV9NVVRFIGlzIG1vcmUgbmljZSB0aGVuICIwIiB0byBtZS4KCk5vIG5lZWQuClRoZSBz
bmRfc29jX3VwZGF0ZV9iaXRzIHRha2VzIGNhcmUgb2YgbWFza2luZy4KQmV0dGVyIHN0aWxsLCBv
bmUgY291bGQgc2ltcGx5IGluaXQgcmVnIHRvIDAgYW5kIGRpc2NhcmQgdGhlIGVsc2UgY2xhdXNl
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
