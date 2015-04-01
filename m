From: Yakir <ykk@rock-chips.com>
Subject: Re: [PATCH RFC 09/11] sound/core: add IEC958 channel
	status helper
Date: Wed, 01 Apr 2015 10:04:03 +0800
Message-ID: <551B5213.8070902@rock-chips.com>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfYA-0002vc-Al@rmk-PC.arm.linux.org.uk> <551A5B2F.50203@rock-chips.com>
 <20150331091329.GP24899@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.137])
 by alsa0.perex.cz (Postfix) with ESMTP id AC7432650E4
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 04:04:14 +0200 (CEST)
In-Reply-To: <20150331091329.GP24899@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGkgUnVzc2VsbCwKCuWcqCAyMDE1LzMvMzEgMTc6MTMsIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51
eCDlhpnpgZM6Cj4gT24gVHVlLCBNYXIgMzEsIDIwMTUgYXQgMDQ6MzA6MzlBTSAtMDQwMCwgWWFu
ZyBLdWFua3VhbiB3cm90ZToKPj4+ICsJY3NbMF0gPSBJRUM5NThfQUVTMF9DT05fTk9UX0NPUFlS
SUdIVCB8IElFQzk1OF9BRVMwX0NPTl9FTVBIQVNJU19OT05FOwo+Pj4gKwljc1sxXSA9IElFQzk1
OF9BRVMxX0NPTl9HRU5FUkFMOwo+Pj4gKwljc1syXSA9IElFQzk1OF9BRVMyX0NPTl9TT1VSQ0Vf
VU5TUEVDIHwgSUVDOTU4X0FFUzJfQ09OX0NIQU5ORUxfVU5TUEVDOwo+Pj4gKwljc1szXSA9IElF
Qzk1OF9BRVMzX0NPTl9DTE9DS18xMDAwUFBNIHwgZnM7Cj4+PiArCj4+IFByZXR0eSBnb29kLCBh
bHNvIHN1aXRhYmxlIHRvIHJvY2tjaGlwIHBsYXRmb3JtLCBidXQgd2h5IG5vdCBhZGQgdGhlCj4+
ICJJRUM5NThfQUVTMl9DT05fQ0hBTk5FTF9NQVNLIiAmICJJRUM5NThfQUVTMl9DT05fV09SRExF
TiIgPwo+Pgo+PiBTZWVtcyBzYW1wbGUgZnJlcXVlbmN5ICYgY2hhbm5sZSBudW1iZXIgJiB3b3Jk
IGxlbmd0aCBhcmUgdGhlIGJhc2ljCj4+IG1lc3NhZ2UgOikKPiBJIHdhcyBkZWJhdGluZyBhYm91
dCB0aGUgd29yZCBsZW5ndGgsIGFuZCB0aGF0J3Mgc29tZXRoaW5nIEknbGwgYWRkCj4gbGF0ZXIg
dG8gaXQgLSBidXQgb25seSBpZiBsZW5ndGggc2hvd3MgdGhhdCB3ZSBoYXZlIHRoZSA1dGggYnl0
ZQo+IGF2YWlsYWJsZSBpbiB0aGUgYnVmZmVyLiAgTW9zdCB1c2VycyBzZWVtIHRvIG9ubHkgdXNl
IHRoZSBmaXJzdCBmb3VyCj4gYnl0ZXMuCj4KPiBBcyBmb3IgdGhlIGNoYW5uZWwgbnVtYmVyLCB0
aGlzIGlzIGludGVudGlvbmFsbHkgbGVmdCB0byB0aGUgZHJpdmVyIC0KPiBtb3N0IGNhc2VzIEkn
dmUgZm91bmQgZWl0aGVyIHRoZSBkcml2ZXIgaXNuJ3QgaW50ZXJlc3RlZCwgb3Igd2hlcmUKPiB0
aGV5IGFyZSBpbnRlcmVzdGVkICh0aGUgb25seSBjYXNlIEkga25vdyBvZiBpcyBteSBkd19oZG1p
IGFoYiBhdWRpbwo+IGRyaXZlciksIGl0J3MgbW9yZSBhcHByb3ByaWF0ZSB0byBnZW5lcmF0ZSBh
IGJhc2VsaW5lIGNoYW5uZWwgc3RhdHVzLAo+IGFuZCBsZXQgdGhlIGRyaXZlciBpdGVyYXRlIG92
ZXIgdGhlIGNoYW5uZWxzIGFkZGluZyB0aGUgYXBwcm9wcmlhdGUKPiBjaGFubmVsIG51bWJlciBp
bi4KT2theSwgYWdyZWUgd2l0aCB5b3UgdG8ga2VlcCBiYXNlbGluZSBjaGFubmVsIHN0YXR1cywg
YnV0IHNlZW1zIGR3X2hkbWkKaTJzIGF1ZGlvIGFyZSBpbnRlcmVzdGVkIGluIGNoYW5ubGUgbnVt
YmVyICh0byBmaWxsIGluIHNjaG5sIHJlc2lnZXRlcnMpLgoKQmVzdCByZWdhcmRzLgpZYWtpciBZ
YW5nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
