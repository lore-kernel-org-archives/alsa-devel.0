From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: WM8580: Debug BCLK and sample size
Date: Tue, 7 Dec 2010 19:11:52 +0530
Message-ID: <AANLkTi=62mz_bJDp5ydr2=RO0vuXdRJYJ9CFBw7SUoC_@mail.gmail.com>
References: <1291717387-11961-1-git-send-email-jassi.brar@samsung.com>
	<1291726112.3275.23.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42])
	by alsa0.perex.cz (Postfix) with ESMTP id AF159103BC6
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 14:41:53 +0100 (CET)
Received: by bwz13 with SMTP id 13so12015864bwz.29
	for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2010 05:41:53 -0800 (PST)
In-Reply-To: <1291726112.3275.23.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBEZWMgNywgMjAxMCBhdCA2OjE4IFBNLCBMaWFtIEdpcmR3b29kIDxscmdAc2xpbWxv
Z2ljLmNvLnVrPiB3cm90ZToKPiBPbiBUdWUsIDIwMTAtMTItMDcgYXQgMTk6MjMgKzA5MDAsIEph
c3NpIEJyYXIgd3JvdGU6Cj4+IEluIGNhc2Ugb2YgU05EUlZfUENNX0ZPUk1BVF9TMzJfTEUsIHdl
IG5lZWQgdG8gc2V0IFdNODU4MF9BSUZfTEVOR1RIXzMyLAo+PiByYXRoZXIgdGhhbiBXTTg1ODBf
QUlGX0xFTkdUSF8yNC4KPj4gQWxzbywgdGhlIEJDTEsgaGFzIHRvIGJlIDY0ZnMsIGZvciBzYW1w
bGUgc2l6ZSBvZiAyMCwgMjQgYW5kIDMyIGJpdHMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEphc3Np
IEJyYXIgPGphc3NpLmJyYXJAc2Ftc3VuZy5jb20+Cj4+IC0tLQo+PiDCoHNvdW5kL3NvYy9jb2Rl
Y3Mvd204NTgwLmMgfCDCoCDCoDggKysrKy0tLS0KPj4gwqAxIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9j
b2RlY3Mvd204NTgwLmMgYi9zb3VuZC9zb2MvY29kZWNzL3dtODU4MC5jCj4+IGluZGV4IGNiNzc2
NWYuLjQ1ZWZjOTQgMTAwNjQ0Cj4+IC0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mvd204NTgwLmMKPj4g
KysrIGIvc291bmQvc29jL2NvZGVjcy93bTg1ODAuYwo+PiBAQCAtNDkxLDE2ICs0OTEsMTYgQEAg
c3RhdGljIGludCB3bTg1ODBfcGFpZl9od19wYXJhbXMoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFt
ICpzdWJzdHJlYW0sCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhaWZhIHw9IDB4ODsKPj4gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgYnJlYWs7Cj4+IMKgIMKgIMKgIGNhc2UgU05EUlZfUENNX0ZPUk1B
VF9TMjBfM0xFOgo+PiAtIMKgIMKgIMKgIMKgIMKgIMKgIHBhaWZhIHw9IDB4MTA7Cj4+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgcGFpZmEgfD0gMHgwOwo+Cj4gQW55IHJlYXNvbiB3aHkgd2UgYXJlIE9S
IGluZyBwYWlmYSB3aXRoIDAgPwoKTm9uZSByZWFsbHksIGp1c3QgZ290IGNhcnJpZWQgYXdheSAn
c2V0dGluZycgY29ycmVjdCB2YWx1ZSA6KQpXaWxsIHJlc2VuZC4KVGhhbmtzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
