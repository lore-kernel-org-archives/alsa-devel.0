From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm: sti: fix prototypes after API change
Date: Tue, 5 Jul 2016 09:46:37 +1000
Message-ID: <20160705094637.5076b8a0@canb.auug.org.au>
References: <20160704131651.1083630-1-arnd@arndb.de>
 <20160704132230.GD6247@sirena.org.uk> <6436978.7TJhubtDTK@wuerfel>
 <20160704133810.GF6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160704133810.GF6247@sirena.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: David Airlie <airlied@linux.ie>
Cc: alsa-devel@alsa-project.org, kernel@stlinux.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

SGkgRGF2ZSwKCk9uIE1vbiwgNCBKdWwgMjAxNiAxNTozODoxMCArMDIwMCBNYXJrIEJyb3duIDxi
cm9vbmllQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gTW9uLCBKdWwgMDQsIDIwMTYgYXQgMDM6
MzY6NTdQTSArMDIwMCwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiA+IE9uIE1vbmRheSwgSnVseSA0
LCAyMDE2IDM6MjI6MzAgUE0gQ0VTVCBNYXJrIEJyb3duIHdyb3RlOiAgCj4gCj4gPiA+IEkgc2Vu
dCBhIHB1bGwgcmVxdWVzdCBmb3IgdGhlIEFQSSBjaGFuZ2UgdG8gdGhlIERSTSBwZW9wbGUgd2hp
Y2ggbWlnaHQKPiA+ID4gYmUgZWFzaWVyIGdpdmVuIHRoYXQgaXQncyBhIHNpbmdsZSBjb21taXQg
dG9waWMgYnJhbmNoIHJhdGhlciB0aGFuIHRoZQo+ID4gPiB3aG9sZSBvZiBEUk0uICAKPiAKPiA+
IEFncmVlZCwgdGhhdCBpcyBwcm9iYWJseSB0aGUgYmVzdCB3YXkgZm9yd2FyZC4gRG9lcyB5b3Vy
IHB1bGwgcmVxdWVzdAo+ID4gYWxzbyBjb250YWluIGFuIGVxdWl2YWxlbnQgb2YgbXkgdHdvIHBh
dGNoZXM/ICAKPiAKPiBObywgSSBqdXN0IHNlbnQgYSBwdWxsIHJlcXVlc3QgZm9yIHRoZSBBUEkg
Y2hhbmdlIC0gSSBkb24ndCBoYXZlIHRoZSBuZXcKPiBwYXRjaGVzIGluIG15IHRyZWUuCgpTbyB0
byBiZSB2ZXJ5IGNsZWFyLCB3aGF0IHlvdSB3b3VsZCBuZWVkIHRvIGRvIGlzIG1lcmdlIHRoZSBv
bmUgY29tbWl0CmJyYW5jaCB0aGF0IE1hcmsgc2VudCB5b3UgYSBwdWxsIHJlcXVlc3QgZm9yOgoK
ICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYnJvb25pZS9z
b3VuZC5naXQgdGFncy9hc29jLWhkbWktY29kZWMtcGRhdGEKCmFuZCBhcyBwYXJ0IG9mIHRoZSBt
ZXJnZSBjb21taXQgKHNvIGUuZy4gImdpdCBhcHBseSA8cGF0Y2g+OyBnaXQgY29tbWl0Ci0tYW1l
bmQiIG9uIHRvcCBvZiB0aGUgbWVyZ2UpLCBhZGQgdGhlIHR3byBwYXRjaGVzIHdlIGFyZSB0YWxr
aW5nIGFib3V0OgoKICAiZHJtOiBzdGk6IGZpeCBwcm90b3R5cGVzIGFmdGVyIEFQSSBjaGFuZ2Ui
CiAgImRybTogbWVkaWF0ZWs6IGZpeCBwcm90b3R5cGVzIGFmdGVyIEFQSSBjaGFuZ2UiCgpUaGVu
IGFueSBmdXJ0aGVyIGNvbmZsaWN0cyBjYW4gaG9wZWZ1bGx5IGJlIGZpeGVkIHVwIGFzIHRoZXkg
YXBwZWFyIGluCnlvdXIgdHJlZSAoaWYgYW55KS4gIE9yIGJlIGF2b2lkZWQgYnkgcGVvcGxlIGRl
dmVsb3BpbmcgYWdhaW5zdCB5b3VyCnRyZWUuCgotLSAKQ2hlZXJzLApTdGVwaGVuIFJvdGh3ZWxs
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
