From: Vasily <anarsoul@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: uda1380: Fix missed
 uda1380_reset call if pdata->gpio_power is a valid gpio
Date: Sun, 4 Dec 2011 21:55:19 +0300
Message-ID: <CA+E=qVdHiNf34m6O4XLaxAYEVFoLp608tBHMoJKMHQsQCP930w@mail.gmail.com>
References: <1322998520.12391.1.camel@phoenix>
	<1322998652.12391.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ACB25103835
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 19:55:44 +0100 (CET)
Received: by qcol42 with SMTP id l42so1114105qco.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 10:55:42 -0800 (PST)
In-Reply-To: <1322998652.12391.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

MjAxMS8xMi80IEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5jb20+Ogo+IEN1cnJlbnQgY29kZSBk
b2VzIG5vdCBjYWxsIHVkYTEzODBfcmVzZXQoKSBpbiB1ZGExMzgwX3Byb2JlKCkgaWYKPiBwZGF0
YS0+Z3Bpb19wb3dlciBpcyBhIHZhbGlkIGdwaW8uIEZpeCBpdC4KPgo+IEFsc28gcmVtb3ZlIGEg
cmVkdW5kYW50ICJGYWlsZWQgdG8gaXNzdWUgcmVzZXQiIGVycm9yIG1lc3NhZ2UuCj4gV2UgYWxy
ZWFkeSBzaG93IGVycm9yIG1lc3NhZ2UgaW4gdWRhMTM4MF9yZXNldCgpIGVycm9yIHBhdGguCj4K
PiBTaWduZWQtb2ZmLWJ5OiBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPgoKTkFLLiBJc3N1
aW5nIHJlc2V0IGNvbW1hbmQgd2hlbiBjb2RlYyBpcyBwb3dlcmVkIG9mZiBkb2VzIG5vdCBsb29r
IGFzCmEgc2FuZSB0aGluZwp0byBtZS4KCj4gLS0tCj4gSSBkb24ndCBoYXMgdGhpcyBoYXJkd2Fy
ZSwgSSdkIGFwcHJlY2lhdGUgaWYgc29tZW9uZSBjYW4gdGVzdCB0aGlzIHBhdGNoLgo+IEF4ZWwK
PiDCoHNvdW5kL3NvYy9jb2RlY3MvdWRhMTM4MC5jIHwgwqAgMTAgKysrKy0tLS0tLQo+IMKgMSBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvc291bmQvc29jL2NvZGVjcy91ZGExMzgwLmMgYi9zb3VuZC9zb2MvY29kZWNzL3VkYTEz
ODAuYwo+IGluZGV4IDNhMjM4Y2IuLjdlYmZiZWIgMTAwNjQ0Cj4gLS0tIGEvc291bmQvc29jL2Nv
ZGVjcy91ZGExMzgwLmMKPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL3VkYTEzODAuYwo+IEBAIC03
NDcsMTQgKzc0NywxMiBAQCBzdGF0aWMgaW50IHVkYTEzODBfcHJvYmUoc3RydWN0IHNuZF9zb2Nf
Y29kZWMgKmNvZGVjKQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gZ3Bpb19kaXJlY3Rp
b25fb3V0cHV0KHBkYXRhLT5ncGlvX3Bvd2VyLCAwKTsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChyZXQpCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVycl9n
cGlvX3Bvd2VyX2NvbmY7Cj4gLSDCoCDCoCDCoCB9IGVsc2Ugewo+IC0gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcmV0ID0gdWRhMTM4MF9yZXNldChjb2RlYyk7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBpZiAocmV0KSB7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZfZXJy
KGNvZGVjLT5kZXYsICJGYWlsZWQgdG8gaXNzdWUgcmVzZXRcbiIpOwo+IC0gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnJfcmVzZXQ7Cj4gLSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB9Cj4gwqAgwqAgwqAgwqB9Cj4KPiArIMKgIMKgIMKgIHJldCA9IHVkYTEzODBfcmVzZXQo
Y29kZWMpOwo+ICsgwqAgwqAgwqAgaWYgKHJldCkKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdv
dG8gZXJyX3Jlc2V0Owo+ICsKPiDCoCDCoCDCoCDCoElOSVRfV09SSygmdWRhMTM4MC0+d29yaywg
dWRhMTM4MF9mbHVzaF93b3JrKTsKPgo+IMKgIMKgIMKgIMKgLyogcG93ZXIgb24gZGV2aWNlICov
Cj4gLS0KPiAxLjcuNS40Cj4KPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBBbHNhLWRldmVsIG1haWxpbmcgbGlzdAo+IEFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwo+IGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
