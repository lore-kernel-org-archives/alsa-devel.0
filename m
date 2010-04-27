From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] ad193x: add set_pll entry to support
	different clock input
Date: Tue, 27 Apr 2010 18:12:23 +0800
Message-ID: <o2o3c17e3571004270312q9326cb13k2b57f91956c2b08b@mail.gmail.com>
References: <1271842609-18276-1-git-send-email-21cnbao@gmail.com>
	<1271842609-18276-2-git-send-email-21cnbao@gmail.com>
	<20100423150659.GC27232@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
	[209.85.211.176])
	by alsa0.perex.cz (Postfix) with ESMTP id CFA55248B2
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 12:12:44 +0200 (CEST)
Received: by ywh6 with SMTP id 6so6882394ywh.16
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 03:12:43 -0700 (PDT)
In-Reply-To: <20100423150659.GC27232@rakim.wolfsonmicro.main>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBBcHIgMjMsIDIwMTAgYXQgMTE6MDYgUE0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBXZWQsIEFwciAyMSwgMjAxMCBh
dCAwNTozNjo0N1BNICswODAwLCBCYXJyeSBTb25nIHdyb3RlOgo+PiBTaWduZWQtb2ZmLWJ5OiBC
YXJyeSBTb25nIDwyMWNuYmFvQGdtYWlsLmNvbT4KPgo+PiArc3RhdGljIGludCBhZDE5M3hfc2V0
X2RhaV9wbGwoc3RydWN0IHNuZF9zb2NfZGFpICpjb2RlY19kYWksCj4+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgaW50IHBsbF9pZCwgaW50IHNvdXJjZSwgdW5zaWduZWQgaW50IGZyZXFfaW4sIHVuc2ln
bmVkIGludCBmcmVxX291dCkKPj4gK3sKPj4gKyDCoCDCoCBzdHJ1Y3Qgc25kX3NvY19jb2RlYyAq
Y29kZWMgPSBjb2RlY19kYWktPmNvZGVjOwo+PiArIMKgIMKgIGludCByZWc7Cj4+ICsKPj4gKyDC
oCDCoCByZWcgPSBzbmRfc29jX3JlYWQoY29kZWMsIEFEMTkzWF9QTExfQ0xLX0NUUkwwKTsKPj4g
Kwo+PiArIMKgIMKgIHN3aXRjaCAoZnJlcV9pbikgewo+PiArIMKgIMKgIGNhc2UgMTIyODgwMDA6
Cj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgcmVnID0gKHJlZyAmIEFEMTkzWF9QTExfSU5QVVRfTUFT
SykgfCBBRDE5M1hfUExMX0lOUFVUXzI1NjsKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazsK
Pgo+IFRoaXMgYWxsIGxvb2tzIGxpa2UgeW91IHNob3VsZCBqdXN0IGltcGxlbWVudCBzZXRfc3lz
Y2xrKCkgbm90IHNldF9wbGwoKQo+IC0gZnJvbSB0aGUgdXNlciBwb2ludCBvZiB2aWV3IHRoZSBm
YWN0IHRoYXQgYSBQTEwgZW5kcyB1cCBnZXR0aW5nIHR1bmVkCj4gaXMgaW1tYXRlcmlhbCBoZXJl
LCB0aGV5IGNhbid0IGNvbnRyb2wgdGhlIG91dHB1dCBmcmVxdWVuY3kgYXQgYWxsLgo+IEZyb20g
dGhlaXIgcG9pbnQgb2YgdmlldyB0aGV5IGp1c3Qgc3BlY2lmeSB0aGUgY2xvY2sgZ29pbmcgaW50
byB0aGUKPiBDT0RFQyBhbmQgdGhlIGRyaXZlciB3b3JrcyBvdXQgZXZlcnl0aGluZyBlbHNlIGZv
ciB0aGVtLgpTb3JyeSBmb3IgSSBoYXZlIG5vdCBub3RpY2VkIHRoaXMgZW50cnkuIFRoZW4gaSds
bCB1c2Ugc2V0X3N5c2NsaygpIHRvCnNldCB0aGUgTUNMSyBpbnN0ZWFkIG9mIHNldF9wbGwoKS4K
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
