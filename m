From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: kmemleak findings about USB audio recording on
	3.3.2
Date: Sun, 27 May 2012 17:18:38 +0600
Message-ID: <CAN_LGv3a=X2GSjanvJAPG_0H14PUbw+XZZ+yoo6QnXwxunRDFw@mail.gmail.com>
References: <1335112621.20322.8.camel@home>
	<4FB6722B.6050103@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B86C24697
	for <alsa-devel@alsa-project.org>;
	Sun, 27 May 2012 13:18:39 +0200 (CEST)
Received: by qcha6 with SMTP id a6so1264067qch.38
	for <alsa-devel@alsa-project.org>; Sun, 27 May 2012 04:18:38 -0700 (PDT)
In-Reply-To: <4FB6722B.6050103@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

MjAxMi81LzE4IENsZW1lbnMgTGFkaXNjaCA8Y2xlbWVuc0BsYWRpc2NoLmRlPjoKPiBQbGVhc2Ug
dHJ5IHRoaXMgcGF0Y2guCj4KPiAtLTg8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0KPiBBTFNBOiB1c2ItYXVkaW86IGZp
eCByYXRlX2xpc3QgbWVtb3J5IGxlYWsKPgo+IFRoZSBhcnJheSBvZiBzYW1wbGUgcmF0ZXMgaXMg
cmVhbGxvY2F0ZWQgZXZlcnkgdGltZSB3aGVuIG9wZW5pbmcKPiB0aGUgUENNIGRldmljZSwgYnV0
IHdhcyBmcmVlZCBvbmx5IG9uY2Ugd2hlbiB1bnBsdWdnaW5nIHRoZSBkZXZpY2UuCj4KPiBSZXBv
cnRlZC1ieTogIkFsZXhhbmRlciBFLiBQYXRyYWtvdiIgPHBhdHJha292QGdtYWlsLmNvbT4KPiBT
aWduZWQtb2ZmLWJ5OiBDbGVtZW5zIExhZGlzY2ggPGNsZW1lbnNAbGFkaXNjaC5kZT4KPiAtLS0K
PiDCoHNvdW5kL3VzYi9wY20uYyB8IMKgIMKgMyArKysKPiDCoDEgZmlsZXMgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQo+Cj4gLS0tIGEvc291bmQvdXNiL3BjbS5jCj4g
KysrIGIvc291bmQvdXNiL3BjbS5jCj4gQEAgLTc4Myw2ICs3ODMsOSBAQCBzdGF0aWMgaW50IHNu
ZF91c2JfcGNtX2NoZWNrX2tub3Qoc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSwKPiDC
oCDCoCDCoCDCoGludCBjb3VudCA9IDAsIG5lZWRzX2tub3QgPSAwOwo+IMKgIMKgIMKgIMKgaW50
IGVycjsKPgo+ICsgwqAgwqAgwqAga2ZyZWUoc3Vicy0+cmF0ZV9saXN0Lmxpc3QpOwo+ICsgwqAg
wqAgwqAgc3Vicy0+cmF0ZV9saXN0Lmxpc3QgPSBOVUxMOwo+ICsKPiDCoCDCoCDCoCDCoGxpc3Rf
Zm9yX2VhY2hfZW50cnkoZnAsICZzdWJzLT5mbXRfbGlzdCwgbGlzdCkgewo+IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgKGZwLT5yYXRlcyAmIFNORFJWX1BDTV9SQVRFX0NPTlRJTlVPVVMpCj4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDsKCkkgaGF2ZSBhcHBs
aWVkIHRoaXMgb24gdG9wIG9mIDMuNC4wLiBTbyBmYXIsIHRoZSBtaWNyb3Bob25lIHdvcmtzLCBh
bmQKdGhlcmUgYXJlIG5vIGxlYWtzIGRldGVjdGVkLgoKLS0gCkFsZXhhbmRlciBFLiBQYXRyYWtv
dgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
