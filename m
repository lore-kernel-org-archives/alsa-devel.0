From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH] ASoC: S3C: Fix PCM RX FIFO settings
Date: Thu, 9 Sep 2010 10:47:50 +0900
Message-ID: <AANLkTimWZ-eSr4boXbyxbunDcm3Da1vEAZvP65Up63uE@mail.gmail.com>
References: <1283935896-18469-1-git-send-email-sw.youn@samsung.com>
	<AANLkTik-L-kFPxRNcLvA=ajaMH_JTQYXjxv775JPzM7-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0350410388B
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 03:47:51 +0200 (CEST)
Received: by wyb32 with SMTP id 32so677576wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2010 18:47:51 -0700 (PDT)
In-Reply-To: <AANLkTik-L-kFPxRNcLvA=ajaMH_JTQYXjxv775JPzM7-@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBTZXAgOCwgMjAxMCBhdCA2OjQ4IFBNLCBKYXNzaSBCcmFyIDxqYXNzaXNpbmdoYnJh
ckBnbWFpbC5jb20+IHdyb3RlOgo+IE9uIFdlZCwgU2VwIDgsIDIwMTAgYXQgNTo1MSBQTSwgU2V1
bmd3aGFuIFlvdW4gPHN3LnlvdW5Ac2Ftc3VuZy5jb20+IHdyb3RlOgo+PiBXaGVuIFBDTSBjYXB0
dXJlLCBzb3VuZCByZWNvcmRlZCBhYm5vcm1hbGx5IGJlY2F1c2Ugb2YgUlggRklGTwo+PiB0aHJl
c2hvbGQgc2V0dGluZ3MgYXJlIG1pc3NpbmcuIFNvLCBUaGlzIHBhdGNoIG1vZGlmeSBQQ00gUlgg
RklGTwo+PiBzZXR0aW5nIGNvZGVzIHNhbWUgYXMgVFguCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNl
dW5nd2hhbiBZb3VuIDxzdy55b3VuQHNhbXN1bmcuY29tPgo+PiAtLS0KPj4gwqBzb3VuZC9zb2Mv
czNjMjR4eC9zM2MtcGNtLmMgfCDCoCDCoDMgKysrCj4+IMKgc291bmQvc29jL3MzYzI0eHgvczNj
LXBjbS5oIHwgwqAgwqAzICsrLQo+PiDCoDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3MzYzI0eHgvczNj
LXBjbS5jIGIvc291bmQvc29jL3MzYzI0eHgvczNjLXBjbS5jCj4+IGluZGV4IDQzZGNjNmIuLmRl
YWEzZjIgMTAwNjQ0Cj4+IC0tLSBhL3NvdW5kL3NvYy9zM2MyNHh4L3MzYy1wY20uYwo+PiArKysg
Yi9zb3VuZC9zb2MvczNjMjR4eC9zM2MtcGNtLmMKPj4gQEAgLTEwNywxMSArMTA3LDE0IEBAIHN0
YXRpYyB2b2lkIHMzY19wY21fc25kX3J4Y3RybChzdHJ1Y3QgczNjX3BjbV9pbmZvICpwY20sIGlu
dCBvbikKPj4KPj4gwqAgwqAgwqAgwqBjdGwgPSByZWFkbChyZWdzICsgUzNDX1BDTV9DVEwpOwo+
PiDCoCDCoCDCoCDCoGNsa2N0bCA9IHJlYWRsKHJlZ3MgKyBTM0NfUENNX0NMS0NUTCk7Cj4+ICsg
wqAgwqAgwqAgY3RsICY9IH4oUzNDX1BDTV9DVExfUlhESVBTVElDS19NQVNLCj4+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8PCBTM0NfUENNX0NUTF9SWERJUFNUSUNLX1NI
SUZUKTsKPj4KPj4gwqAgwqAgwqAgwqBpZiAob24pIHsKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBjdGwgfD0gUzNDX1BDTV9DVExfUlhETUFfRU47Cj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Y3RsIHw9IFMzQ19QQ01fQ1RMX1JYRklGT19FTjsKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBj
dGwgfD0gUzNDX1BDTV9DVExfRU5BQkxFOwo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGN0bCB8
PSAoMHgyMDw8UzNDX1BDTV9DVExfUlhESVBTVElDS19TSElGVCk7Cj4KPiBZZXMsIHRoZSBjaGFu
Z2UgaXMgbmVlZGVkLgo+IEJ1dCBJIHRoaW5rIHdlIHNob3VsZCB1c2Ugc21hbGwgdmFsdWUgYXMg
Zmlmb19kaXBzdGljayAobWF5YmUgMHg0ID8pLCBiZWNhdXNlCj4gRmlmbyBpcyBjb25zaWRlcmVk
Oi0KPiDCoCDCoEFsbW9zdF9lbXB0eSDCoCDCoCDCoHdoZW4gwqAgwqAgwqBmaWZvX2RlcHRoIDwg
Zmlmb19kaXBzdGljawo+IMKgIEFsbW9zdF9mdWxsIMKgIMKgIMKgIMKgIMKgIMKgIHdoZW4gwqAg
wqAgwqBmaWZvX2RlcHRoID4gKDMyIOKAkyBmaWZvX2RpcHN0aWNrKQoKWWVzLCB5b3UncmUgcmln
aHQuCgo+Cj4gQW5kLCBwbGVhc2UgbW9kaWZ5IGZvciBUWCBhcyB3ZWxsLgo+CgpJJ2xsIGZpeCB0
aGlzIGZpZm9fZGlwc3RpY2sgdmFsdWUgdG8gYmUgYSBzdWl0YWJsZSBvbmUgYW5kIHJlLXN1Ym1p
dAp3aXRoIFRYJ3MgZmlmb19kaXBzdGljay4KClRoYW5rcyBmb3IgeW91ciBvcGluaW9uLgpDbGF1
ZGUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
