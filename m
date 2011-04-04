From: Sudarshan Bisht <sudarshan.bisht@nokia.com>
Subject: Re: [PATCH 3/3 v3] alsa-lib: fixed coverity reported
 issues under "USE_AFTER_FREE" checker.
Date: Mon, 04 Apr 2011 13:02:29 +0300
Message-ID: <1301911349.16314.228.camel@Sudarshan.research.nokia.com>
References: <1301907239-1873-1-git-send-email-sudarshan.bisht@nokia.com>
	<1301907239-1873-3-git-send-email-sudarshan.bisht@nokia.com>
	<1301908371.3970.29.camel@mattotaupa>
Reply-To: sudarshan.bisht@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CE56103828
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 12:04:47 +0200 (CEST)
In-Reply-To: <1301908371.3970.29.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGVsbG8gUGF1bCwKClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuICBJIHdpbGwgY29ycmVj
dCBpdCBhbmQgc2VuZCB1cGRhdGVkIHBhdGNoLgoKCkJyLApTdWRhcnNoYW4gQmlzaHQgIAoKT24g
TW9uLCAyMDExLTA0LTA0IGF0IDExOjEyICswMjAwLCBleHQgUGF1bCBNZW56ZWwgd3JvdGU6Cj4g
RGVhciBTdWRhcnNoYW4sCj4gCj4gCj4gQW0gTW9udGFnLCBkZW4gMDQuMDQuMjAxMSwgMTE6NTMg
KzAzMDAgc2NocmllYiBzdWRhcnNoYW4uYmlzaHRAbm9raWEuY29tOgo+IAo+IFvigKZdCj4gCj4g
PiBkaWZmIC0tZ2l0IGEvc3JjL21peGVyL3NpbXBsZV9hYnN0LmMgYi9zcmMvbWl4ZXIvc2ltcGxl
X2Fic3QuYwo+ID4gaW5kZXggOWU5YWFmNS4uZGQwZGZhMyAxMDA2NDQKPiA+IC0tLSBhL3NyYy9t
aXhlci9zaW1wbGVfYWJzdC5jCj4gPiArKysgYi9zcmMvbWl4ZXIvc2ltcGxlX2Fic3QuYwo+ID4g
QEAgLTMzNiw2ICszMzYsOCBAQCBpbnQgc25kX21peGVyX3NpbXBsZV9iYXNpY19yZWdpc3Rlcihz
bmRfbWl4ZXJfdAo+ID4gKm1peGVyLAo+ID4gICAgICAgICAgICAgICAgIGVyciA9IGZpbmRfbW9k
dWxlKGNsYXNzLCB0b3ApOwo+ID4gICAgICAgICBpZiAoZXJyID49IDApCj4gPiAgICAgICAgICAg
ICAgICAgZXJyID0gc25kX21peGVyX2F0dGFjaF9oY3RsKG1peGVyLCBwcml2LT5oY3RsKTsKPiA+
ICsgICAgICAgICAgICAgICBpZiAoZXJyIDwgMCkgCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgZ290byBfX2Vycm9yOyAgICAgICAgICAKPiAKPiBUaGVyZSBhcmUgc3RpbGwgdHJhaWxpbmcg
d2hpdGUgc3BhY2VzIGF0IHRoZSBlbmQgb2YgYm90aCBsaW5lcy4gVGhlCj4gZm9sbG93aW5nIGNv
bW1hbmQgc2hvdWxkIHNob3cgdGhlc2UgdG8geW91IHdpdGggcmVkIGNvbG9yLgo+IAo+IAlnaXQg
bG9nIC1wIC0tY29sb3Itd29yZHMKPiAKPiA+ICAgICAgICAgaWYgKGVyciA+PSAwKSB7Cj4gPiAg
ICAgICAgICAgICAgICAgcHJpdi0+YXR0YWNoX2ZsYWcgPSAxOwo+ID4gICAgICAgICAgICAgICAg
IGVyciA9IHNuZF9taXhlcl9jbGFzc19yZWdpc3RlcihjbGFzcywgbWl4ZXIpOwo+IAo+IAo+IFRo
YW5rcywKPiAKPiBQYXVsCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBBbHNhLWRldmVsIG1haWxpbmcgbGlzdAo+IEFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwo+IGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
