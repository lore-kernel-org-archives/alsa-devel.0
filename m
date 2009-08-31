From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH V2 2/3] add set_tdm_slot in tdm dai to
	define the relationship between audio channel and tdm slot
Date: Mon, 31 Aug 2009 11:14:54 +0800
Message-ID: <3c17e3570908302014n2cdd62fdga2642b7f968b0e65@mail.gmail.com>
References: <1250137511-24034-1-git-send-email-21cnbao@gmail.com>
	<20090817175010.GA19707@rakim.wolfsonmicro.main>
	<3c17e3570908171953l65c9d04i99ad6fa72b88d001@mail.gmail.com>
	<20090818131117.GA12512@rakim.wolfsonmicro.main>
	<3c17e3570908181834q6dd0e0c5n157697bd02836b35@mail.gmail.com>
	<20090819113400.GC18285@rakim.wolfsonmicro.main>
	<3c17e3570908191937h53f5bcf0mb9c753b94402e3f5@mail.gmail.com>
	<1251463341.5039.28.camel@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 7408E244CB
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Aug 2009 05:15:15 +0200 (CEST)
Received: by ywh37 with SMTP id 37so5083923ywh.28
	for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2009 20:15:14 -0700 (PDT)
In-Reply-To: <1251463341.5039.28.camel@finisterre.sirena.org.uk>
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

T24gRnJpLCBBdWcgMjgsIDIwMDkgYXQgODo0MiBQTSwgTWFyawpCcm93bjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCAyMDA5LTA4LTIwIGF0IDEw
OjM3ICswODAwLCBCYXJyeSBTb25nIHdyb3RlOgo+PiBPbiBXZWQsIEF1ZyAxOSwgMjAwOSBhdCA3
OjM0IFBNLCBNYXJrCj4+IEJyb3duPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29t
PiB3cm90ZToKPgo+PiA+IFl1cCwgdGhhdCBEU1AgbW9kZSB3aXRoIEkyUyBsaWtlIGNoYW5uZWwg
bGF5b3V0IChkb2VzIGl0IGFsc28gZG8gVERNIGluCj4+ID4gSTJTIG1vZGUgYnkgYW55IGNoYW5j
ZT8pLiDCoENvdWxkIHlvdSBzdWJtaXQgYSB2ZXJzaW9uIG9mIHlvdXIgcGF0Y2gKPj4gPiB3aGlj
aCB1c2VzIHRoZSBkZWZhdWx0IFRETSBsYXlvdXQgLSBhbiBBUEkgdG8gcmV3cml0ZSB0aGluZ3Mg
aXMgbGlrZWx5Cj4+ID4gdG8gYmUgYSBzZXBhcmF0ZSBBUEk/Cj4KPj4gSSBkb24ndCBrbm93IHdo
YXQgaXMgeW91ciBleGFjdCBtZWFuaW5nLiDCoERvIHlvdSBtZWFuIEkgc2VuZCBhIHBhdGNoCj4+
IHdob3NlIHRkbSBzbG90IGlzIG5vdCBjaGFuZ2VkLCB0aGVuIHNlbmQgYSBwYXRjaCB3aGljaCBj
aGFuZ2UgdGhlIHRkbQo+PiBzbG90Pwo+Cj4gU2VuZCBhIHBhdGNoIHRoYXQgYWxsb3dzIHNlbGVj
dGlvbiBvZiB0aGUgYWN0aXZlIHNsb3RzIHdpdGhvdXQgcmV3cml0aW5nCj4KU29ycnkuIEkgYW0g
bm90IHN1cmUgYWJvdXQgeW91ciBtZWFuaW5nIHlldC4gVGhlIHByb2JsZW0gaXMgdGhlIHNsb3QK
b3JkZXIsIHRoZSBtYXRjaCBiZXR3ZWVuIHNsb3QgbnVtYmVyIGFuZCBjaGFubmVsIG51bWJlciwg
bm90IG9ubHkKd2hpY2ggc2xvdCBpcyBhY3RpdmUsIGFuZCB3aGljaCBpcyBub3QgYWN0aXZlLgoK
PiBBbHRob3VnaCB0aGlua2luZyBhYm91dCBpdCBJJ20gbm90IHN1cmUgaWYgdGhlIGRyaXZlciBp
cyBhY3R1YWxseQo+IGltcGxlbWVudGluZyBURE0gb3Igbm90IC0gZG9lcyB0aGUgQ1BVIGFjdHVh
bGx5IGdldCBjb25maWd1cmVkIHRvIHN0b3AKPiBkcml2aW5nIHRoZSBkYXRhIGxpbmUgZHVyaW5n
IGFuIGluYWN0aXZlIHNsb3QgKHNvIHNvbWV0aGluZyBlbHNlIGNhbgo+IGRyaXZlIGl0KSBvciBp
cyBpdCBzaW1wbHkgc2VuZGluZyB6ZXJvcyBvbiB0aG9zZSBzbG90cz8KCkl0J3MgdGhlIGxhdGVy
LiBUaGUgaGFyZHdhcmUgc2lnbmFsIGlzIHN0aWxsIGFjdGl2ZSBidXQgbm8gdmFsaWQgZGF0YQpp
biBpbmFjdGl2ZSBzbG90Lgo+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
