From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: S3C: Fix PCM RX FIFO settings
Date: Wed, 8 Sep 2010 18:48:14 +0900
Message-ID: <AANLkTik-L-kFPxRNcLvA=ajaMH_JTQYXjxv775JPzM7-@mail.gmail.com>
References: <1283935896-18469-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id A2F202444A
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 11:48:14 +0200 (CEST)
Received: by wwc33 with SMTP id 33so3310853wwc.2
	for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2010 02:48:14 -0700 (PDT)
In-Reply-To: <1283935896-18469-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBTZXAgOCwgMjAxMCBhdCA1OjUxIFBNLCBTZXVuZ3doYW4gWW91biA8c3cueW91bkBz
YW1zdW5nLmNvbT4gd3JvdGU6Cj4gV2hlbiBQQ00gY2FwdHVyZSwgc291bmQgcmVjb3JkZWQgYWJu
b3JtYWxseSBiZWNhdXNlIG9mIFJYIEZJRk8KPiB0aHJlc2hvbGQgc2V0dGluZ3MgYXJlIG1pc3Np
bmcuIFNvLCBUaGlzIHBhdGNoIG1vZGlmeSBQQ00gUlggRklGTwo+IHNldHRpbmcgY29kZXMgc2Ft
ZSBhcyBUWC4KPgo+IFNpZ25lZC1vZmYtYnk6IFNldW5nd2hhbiBZb3VuIDxzdy55b3VuQHNhbXN1
bmcuY29tPgo+IC0tLQo+IMKgc291bmQvc29jL3MzYzI0eHgvczNjLXBjbS5jIHwgwqAgwqAzICsr
Kwo+IMKgc291bmQvc29jL3MzYzI0eHgvczNjLXBjbS5oIHwgwqAgwqAzICsrLQo+IMKgMiBmaWxl
cyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvc291bmQvc29jL3MzYzI0eHgvczNjLXBjbS5jIGIvc291bmQvc29jL3MzYzI0eHgvczNjLXBj
bS5jCj4gaW5kZXggNDNkY2M2Yi4uZGVhYTNmMiAxMDA2NDQKPiAtLS0gYS9zb3VuZC9zb2MvczNj
MjR4eC9zM2MtcGNtLmMKPiArKysgYi9zb3VuZC9zb2MvczNjMjR4eC9zM2MtcGNtLmMKPiBAQCAt
MTA3LDExICsxMDcsMTQgQEAgc3RhdGljIHZvaWQgczNjX3BjbV9zbmRfcnhjdHJsKHN0cnVjdCBz
M2NfcGNtX2luZm8gKnBjbSwgaW50IG9uKQo+Cj4gwqAgwqAgwqAgwqBjdGwgPSByZWFkbChyZWdz
ICsgUzNDX1BDTV9DVEwpOwo+IMKgIMKgIMKgIMKgY2xrY3RsID0gcmVhZGwocmVncyArIFMzQ19Q
Q01fQ0xLQ1RMKTsKPiArIMKgIMKgIMKgIGN0bCAmPSB+KFMzQ19QQ01fQ1RMX1JYRElQU1RJQ0tf
TUFTSwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8PCBTM0NfUENNX0NU
TF9SWERJUFNUSUNLX1NISUZUKTsKPgo+IMKgIMKgIMKgIMKgaWYgKG9uKSB7Cj4gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBjdGwgfD0gUzNDX1BDTV9DVExfUlhETUFfRU47Cj4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjdGwgfD0gUzNDX1BDTV9DVExfUlhGSUZPX0VOOwo+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgY3RsIHw9IFMzQ19QQ01fQ1RMX0VOQUJMRTsKPiArIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGN0bCB8PSAoMHgyMDw8UzNDX1BDTV9DVExfUlhESVBTVElDS19TSElGVCk7CgpZZXMsIHRo
ZSBjaGFuZ2UgaXMgbmVlZGVkLgpCdXQgSSB0aGluayB3ZSBzaG91bGQgdXNlIHNtYWxsIHZhbHVl
IGFzIGZpZm9fZGlwc3RpY2sgKG1heWJlIDB4NCA/KSwgYmVjYXVzZQpGaWZvIGlzIGNvbnNpZGVy
ZWQ6LQogICAgQWxtb3N0X2VtcHR5ICAgICAgd2hlbiAgICAgIGZpZm9fZGVwdGggPCBmaWZvX2Rp
cHN0aWNrCiAgIEFsbW9zdF9mdWxsICAgICAgICAgICAgIHdoZW4gICAgICBmaWZvX2RlcHRoID4g
KDMyIOKAkyBmaWZvX2RpcHN0aWNrKQoKQW5kLCBwbGVhc2UgbW9kaWZ5IGZvciBUWCBhcyB3ZWxs
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
