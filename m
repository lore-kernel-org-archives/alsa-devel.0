From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 5/5] ASoC: Fix indentiation in S3C DMA
	driver
Date: Fri, 13 Aug 2010 15:20:20 +0900
Message-ID: <AANLkTinZ9D6p8fwgFBJmHSHB2pr0=FFvmY62O_mArQA6@mail.gmail.com>
References: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1281607342-13127-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTik=zq9ZL1bN=YcMivTNS8Lu88M9GnaQfC=39DQX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 24CE724495
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 08:20:21 +0200 (CEST)
Received: by wwi17 with SMTP id 17so358500wwi.20
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2010 23:20:20 -0700 (PDT)
In-Reply-To: <AANLkTik=zq9ZL1bN=YcMivTNS8Lu88M9GnaQfC=39DQX@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBBdWcgMTMsIDIwMTAgYXQgMjozOCBQTSwgSmFzc2kgQnJhciA8amFzc2lzaW5naGJy
YXJAZ21haWwuY29tPiB3cm90ZToKPiBPbiBUaHUsIEF1ZyAxMiwgMjAxMCBhdCA3OjAyIFBNLCBN
YXJrIEJyb3duCj4gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToK
Pj4gU2lnbmVkLW9mZi1ieTogTWFyayBCcm93biA8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25t
aWNyby5jb20+Cj4+IC0tLQo+PiDCoHNvdW5kL3NvYy9zM2MyNHh4L3MzYy1kbWEuYyB8IMKgIMKg
NCArKy0tCj4+IMKgMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvczNjMjR4eC9zM2MtZG1hLmMgYi9zb3Vu
ZC9zb2MvczNjMjR4eC9zM2MtZG1hLmMKPj4gaW5kZXggYmI4YmEwNy4uNTRiZmY4MyAxMDA2NDQK
Pj4gLS0tIGEvc291bmQvc29jL3MzYzI0eHgvczNjLWRtYS5jCj4+ICsrKyBiL3NvdW5kL3NvYy9z
M2MyNHh4L3MzYy1kbWEuYwo+PiBAQCAtNDc3LDggKzQ3Nyw4IEBAIHN0YXRpYyBpbnQgX19kZXZl
eGl0IHMzYzI0eHhfc29jX3BsYXRmb3JtX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQo+Pgo+PiDCoHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHMzYzI0eHhfcGNtX2Ry
aXZlciA9IHsKPj4gwqAgwqAgwqAgwqAuZHJpdmVyID0gewo+PiAtIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIC5uYW1lID0gInMzYzI0eHgtcGNtLWF1ZGlvIiwKPj4gLSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAub3duZXIgPSBUSElTX01PRFVMRSwKPj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAubmFtZSA9ICJzM2MyNHh4LXBjbS1hdWRpbyIsCj4+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgLm93bmVyID0gVEhJU19NT0RVTEUsCj4+IMKgIMKgIMKgIMKgfSwKPj4K
Pj4gwqAgwqAgwqAgwqAucHJvYmUgPSBzM2MyNHh4X3NvY19wbGF0Zm9ybV9wcm9iZSwKPiBPayBi
dXQgSSB0aGluayB3ZSBuZWVkIHRvIGludm9sdmUgQmVuIHRvbywgZm9yIEkgaGF2ZSB0aGUgaW1w
cmVzc2lvbgo+IHRoYXQgaGUgaXMgbm90IHZlcnkgaW50ZXJlc3RlZCBpbiBzdWNoIHZhbGlkIGJ1
dCBpbmNvbnNlcXVlbnRpYWwKPiBjaGFuZ2VzLgo+IElmIGhlIGFncmVlcywgbWF5YmUgd2UgY2Fu
IHByZXBhcmUgYSBwYXRjaHNldCBmb3IgY29tcGxldGUgcG9saXNoCj4gYW5kIG92ZXJoYXVsaW5n
IHRoZSBkcml2ZXJzLgoKWWVzLCBJIGFncmVlLiBBbmQgSSByZWFsbHkgaG9wZSB0aGF0IHdlIGNh
biBtYWtlIGEgZmluZSBjb25jbHVzaW9uCmFib3V0IG5hbWluZyBhbmQgbG9jYXRpb24gaW4gdGhp
cyB0aW1lIHdpdGgsIGlmIHdlIGhhdmUgYSB0aW1lIGVub3VnaC4KCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBBbHNhLWRldmVsIG1haWxpbmcgbGlz
dAo+IEFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwo+IGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCj4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
