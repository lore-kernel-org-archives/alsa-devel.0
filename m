From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] add support to reorder CPU and Codec DAI
	suspend/resume
Date: Wed, 11 Nov 2009 20:48:19 +0800
Message-ID: <3c17e3570911110448v7f7da90bs8ecad60c4afda5bc@mail.gmail.com>
References: <1257923457-31470-1-git-send-email-21cnbao@gmail.com>
	<20091111112431.GA18005@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F7F21037F3
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 13:48:47 +0100 (CET)
Received: by yxe34 with SMTP id 34so889145yxe.16
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 04:48:45 -0800 (PST)
In-Reply-To: <20091111112431.GA18005@opensource.wolfsonmicro.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBOb3YgMTEsIDIwMDkgYXQgNzoyNCBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFdlZCwgTm92IDExLCAyMDA5IGF0
IDAzOjEwOjU3UE0gKzA4MDAsIEJhcnJ5IFNvbmcgd3JvdGU6Cj4+IER1ZSB0byBzb21lIGhhcmR3
YXJlIGRlcGVuZGVuY2UgaXNzdWVzLCBzb21lIGRldmljZXMgbWF5YmUgcmVxdWlyZQo+PiBkaWZm
ZXJlbnQgc3VzcGVuZC9yZXN1bWUgZXhlY3V0aW9uIG9yZGVyIGZvciBDUFUgYW5kIENvZGVjIERB
SSB0bwo+PiBtYWtlIHN1cmUgdGhlIGhhcmR3YXJlIGNhbiB3b3JrIG5vcm1hbGx5IGFmdGVyIGV4
ZWN1dGluZyBzbGVlcCBhbmQKPj4gd2FrZXVwLgo+Cj4gQXJlIHRoZXJlIGFueSBhY3R1YWwgc3lz
dGVtcyB0aGF0IHRoaXMgc29sdmVzIHByb2JsZW1zIGZvciAtIGlmIHNvLCB3aGF0Cj4gYXJlIHRo
ZSBwcm9ibGVtcz8gwqBJIGRvbid0IHRoaW5rIHRoaXMgc29sdXRpb24gaXMgZ2VuZXJhbCBlbm91
Z2ggdG8gYmUKPiBzY2FsYWJsZSwgaXQnbGwgd29yayBmb3Igb25lIHBhcnRpY3VsYXIgdXNlIGNh
c2UgYnV0IGlmIHdlIGdldCBmdXJ0aGVyCj4gcmVvcmRlcmluZ3MgbmVlZGVkIGl0J2xsIGJlY29t
ZSBkaWZmaWN1bHQgdG8gbWFuYWdlLgo+Cj4gSWYgd2UncmUgZ29pbmcgdG8gYmUgZG9pbmcgYW55
dGhpbmcgd2l0aCB0aGlzIEkgdGhpbmsgaXQgd291bGQgYmUgbXVjaAo+IGJldHRlciB0byB1c2Ug
dGhlIHBtX2xpbmsgaW5mcmFzdHJ1Y3R1cmUgd2hpY2ggd2lsbCBiZSBhcHBlYXJpbmcgaW4KPiAy
LjYuMzQuIMKgVGhpcyBzaG91bGQgYWxsb3cgdXMgdG8gcHJvdmlkZSBhcmJhdHJhcnkgb3JkZXJp
bmcgb2YgZGV2aWNlCj4gbGV2ZWwgc3VzcGVuZCBhbmQgcmVzdW1lLgpJIGFtIGdsYWQgdG8gaGVh
ciB0aGVyZSBpcyBhIHBsYW4gYWJvdXQgcG1fbGluay4gSSB0aGluayB0aGF0IHdpbGwKcHJvdmlk
ZSBnZW5lcmljIHN1cHBvcnQgZm9yIGFsbCByZWxhdGVkIGlzc3Vlcy4gQW5kIEkgYWxzbyB0aGlu
ayBteQpzb2x1dGlvbiBjYW4gb25seSBzb2x2ZSBzb21lIHBhcnRpY3VsYXIgY2FzZXMuCkhlcmUg
SSBoYXZlIGEgcHJvYmxlbSBhYm91dCBibGFja2ZpbiBURE0uIEFmdGVyIGEgZGVlcCBzbGVlcChh
bGwKc3VzcGVuZCB0byBtZW1vcnkgYW5kIG1vc3QgcGFydHMgcG93ZXItZG93biksIElmIGNvZGVj
IHJlc3VtZXMgYXQKZmlyc3QsIGNsb2NrIGFucyBzeW5jIGFyZSBwcm92aWRlZCBieSBpdCBhdCBv
bmVjZS4gVGhlbiB3aGlsZSBDUFUgVERNCmludGVyZmFjZSByZXN1bWVzLCBpdCB3aWxsIGZhaWwg
dG8gZ28gYmFjayB0byByaWdodCBzdGF0dXMgZm9yIHdvcmsuCkluIHRoZSByZXZlcnNlIG9yZGVy
cywgIENQVSBpbnRlcmZhY2VzIHN0YW5kIHRoZXJlIGF0IGZpcnN0IGFuZCB3YWl0CmNvbWluZyBz
eW5jIGFuZCBjbG9ja3MsIGl0IGNhbiBnbyB0byByaWdodCBzdGF0dXMuCkRvIHlvdSBoYXZlIGFu
eSBpZGVhIGFib3V0IGZpeGluZyBpdCBiZXR0ZXI/Cgo+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
