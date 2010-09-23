From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: Clean up the CODEC device as
 well as the board for SMDK WM9713
Date: Thu, 23 Sep 2010 23:53:00 +0900
Message-ID: <AANLkTi=8G9jt7KWafeUhinWCQMqRtxfXY1ZxwSNZBby1@mail.gmail.com>
References: <1285252845-24171-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1285252845-24171-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A0A3C10394B
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 16:53:00 +0200 (CEST)
Received: by bwz13 with SMTP id 13so703238bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2010 07:53:00 -0700 (PDT)
In-Reply-To: <1285252845-24171-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBTZXAgMjMsIDIwMTAgYXQgMTE6NDAgUE0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPdGhlcndpc2Ugd2UgdHJ5IHRvIHJl
LXJlZ2lzdGVyIHRoZSBDT0RFQyBkZXZpY2UgaWYgdGhlIG1vZHVsZSBpcyByZWxvYWRlZAo+IGFu
ZCBzeXNmcyBiZWNvbWVzIG1pc2VyYWJsZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgQnJvd24g
PGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgo+IC0tLQo+IMKgc291bmQvc29j
L3MzYzI0eHgvc21ka193bTk3MTMuYyB8IMKgIMKgMSArCj4gwqAxIGZpbGVzIGNoYW5nZWQsIDEg
aW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
czNjMjR4eC9zbWRrX3dtOTcxMy5jIGIvc291bmQvc29jL3MzYzI0eHgvc21ka193bTk3MTMuYwo+
IGluZGV4IDc4YTRhMzAuLjMzYmE4ZmQgMTAwNjQ0Cj4gLS0tIGEvc291bmQvc29jL3MzYzI0eHgv
c21ka193bTk3MTMuYwo+ICsrKyBiL3NvdW5kL3NvYy9zM2MyNHh4L3NtZGtfd205NzEzLmMKPiBA
QCAtOTUsNiArOTUsNyBAQCBlcnI6Cj4gwqBzdGF0aWMgdm9pZCBfX2V4aXQgc21ka19leGl0KHZv
aWQpCj4gwqB7Cj4gwqAgwqAgwqAgwqBwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3RlcihzbWRrX3Nu
ZF9hYzk3X2RldmljZSk7Cj4gKyDCoCDCoCDCoCBwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3Rlcihz
bWRrX3NuZF93bTk3MTNfZGV2aWNlKTsKPiDCoH0KPgo+IMKgbW9kdWxlX2luaXQoc21ka19pbml0
KTsKCkkgdGhpbmsgd2UgbmVlZCBtb3JlIHRoYW4gdGhpcyB0byBtYWtlIG1vZHVsZSBsb2FkL3Vu
bG9hZC9sb2FkIHdvcmsuCkxpa2UgdGhlIHNvYy1hdWRpbyBkZXZpY2UgYWRkZWQuIFdvdWxkbid0
IHRoYXQgc3BvaWwgdGhlIHBhcnR5IG5leHQgdGltZQp0aGUgbW9kdWxlIGlzIHRyaWVkIHRvIGxv
YWRlZCA/Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
