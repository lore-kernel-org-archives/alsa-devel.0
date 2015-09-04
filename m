From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 7/9] drm: bridge/dw_hdmi: remove ratio support from ACR
 code
Date: Fri, 4 Sep 2015 11:24:20 -0700
Message-ID: <CAD=FV=VFHt5PSJ_ocsL5pORwhuZHd3fSRa9DXdcKL2_7xW23Hg@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hh-0003Nc-A7@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <E1ZO6hh-0003Nc-A7@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jaroslav Kysela <perex@perex.cz>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Mark Brown <broonie@kernel.org>, Yakir Yang <ykk@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

UnVzc2VsbCwKCk9uIFNhdCwgQXVnIDgsIDIwMTUgYXQgOToxMCBBTSwgUnVzc2VsbCBLaW5nCjxy
bWsra2VybmVsQGFybS5saW51eC5vcmcudWs+IHdyb3RlOgo+IFdlIG5ldmVyIHNldCB0aGUgcmF0
aW8gZm9yIENUUy9OIGNhbGN1bGF0aW9uIGZvciB0aGUgYXVkaW8gY2xvY2sKPiByZWdlbmVyYXRv
ciAoQUNSKSB0byBhbnl0aGluZyBidXQgMTAwLCBzbyB0aGlzIGFkZHMgcG9pbnRsZXNzCj4gY29t
cGxleGl0eS4gIFNob3VsZCB3ZSBzdXBwb3J0IHBpeGVsIHJlcGV0aXRpb24sIHdlIHNob3VsZCB1
cGRhdGUgdGhlCj4gQ1RTL04gY2FsY3VsYXRpb24gY29kZSB0byB1c2UgdGhvc2UgcGFyYW1ldGVy
cyBvciB0aGUgYWN0dWFsIFRNRFMgY2xvY2sKPiByYXRlIGluc3RlYWQgb2YgYSByYXRpby4KPgo+
IFNpZ25lZC1vZmYtYnk6IFJ1c3NlbGwgS2luZyA8cm1rK2tlcm5lbEBhcm0ubGludXgub3JnLnVr
Pgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2R3X2hkbWkuYyB8IDQ0ICsrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGlu
c2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQoKSXQgbG9va3MgbGlrZSBJJ3ZlIGdvdCBhIHNs
aWdodGx5IG9sZGVyIHZlcnNpb24gb2YgdGhlIGRyaXZlciBpbiBteQp0cmVlIChiYXNlZCBvbiBz
b21lIGVhcmxpZXIgbWFpbGluZyBsaXN0IHBvc3RpbmdzKSwgYnV0IGJhY2twb3J0aW5nCnRoaXMg
d2FzIHByZXR0eSB0cml2aWFsIGFuZCBJJ3ZlIHRyaWVkIGl0IGluIG15IDMuMTQga2VybmVsLiAg
SXQKZG9lc24ndCBjYXVzZSBhbnkgcHJvYmxlbXMgZm9yIG1lIHRvIHJlbW92ZSB0aGUgInJhZGlv
IiBhbmQgSSBhZ3JlZQp0aGF0IHdlIHNob3VsZCBhZGQgaXQgaWYvd2hlbiBwaXhlbCByZXBldGl0
aW9uIGlzIGFkZGVkLgoKUmV2aWV3ZWQtYnk6IERvdWdsYXMgQW5kZXJzb24gPGRpYW5kZXJzQGNo
cm9taXVtLm9yZz4KVGVzdGVkLWJ5OiBEb3VnbGFzIEFuZGVyc29uIDxkaWFuZGVyc0BjaHJvbWl1
bS5vcmc+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
