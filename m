From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 8/9] drm: bridge/dw_hdmi: replace CTS calculation for the
 ACR
Date: Fri, 4 Sep 2015 13:00:11 -0700
Message-ID: <CAD=FV=X6Qhuw6DF7HFqQ-uMMC1TRRNYoPZs=aUhqs9q--gEO3w@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hm-0003Ni-E0@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <E1ZO6hm-0003Ni-E0@rmk-PC.arm.linux.org.uk>
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
bWsra2VybmVsQGFybS5saW51eC5vcmcudWs+IHdyb3RlOgo+IEdpdmVuIHRoZSBURE1TIGNsb2Nr
LCBhdWRpbyBzYW1wbGUgcmF0ZSwgYW5kIHRoZSBOIHBhcmFtZXRlciwgd2UgY2FuCj4gY2FsY3Vs
YXRlIHRoZSBDVFMgdmFsdWUgZm9yIHRoZSBhdWRpbyBjbG9jayByZWdlbmVyYXRvciAoQUNSKSB1
c2luZyB0aGUKPiBmb2xsb3dpbmcgY2FsY3VsYXRpb24gZ2l2ZW4gaW4gdGhlIEhETUkgc3BlY2lm
aWNhdGlvbjoKPgo+ICAgICAgICAgQ1RTID0gZnRkbXMgKiBOIC8gKDEyOCAqIGZzKQo+Cj4gVGhl
IHNwZWNpZmljYXRpb24gc2F5cyB0aGF0IHRoZSBDVFMgdmFsdWUgaXMgYW4gYXZlcmFnZSB2YWx1
ZSwgd2hpY2ggaXMKPiB0cnVlIGlmIHRoZSBzb3VyY2UgaGFyZHdhcmUgbWVhc3VyZXMgaXQuICBX
aGVyZSBzb3VyY2UgaGFyZHdhcmUgbmVlZHMgaXQKPiB0byBiZSBwcm9ncmFtbWVkLCBpdCBpcyBw
YXJ0aWN1bGFybHkgZGlmZmljdWx0IHRvIGFsdGVybmF0ZSBpdCBiZXR3ZWVuCj4gdHdvIHZhbHVl
cyBjb3JyZWN0bHkgdG8gZW5zdXJlIHRoYXQgd2UgYWNoaWV2ZSBhIGNvcnJlY3QgImF2ZXJhZ2Ui
Cj4gZnJhY3Rpb25hbCB2YWx1ZSBhdCB0aGUgc2luay4KPgo+IEFsc28sIHRoZXJlJ3MgdGhlIHBy
b2JsZW0gdGhhdCBvdXIgImZ0ZG1zIiBpcyBub3QgYSBmdWxseSBhY2N1cmF0ZQo+IHZhbHVlOyBp
dCBpcyByb3VuZGVkIHRvIGEga0h6IHZhbHVlLiAgVGhpcyBpbnRyb2R1Y2VzIGFuIHVubmVjZXNz
YXJ5Cj4gKGFuZCBoYXJtbGVzcykgZnJhY3Rpb25hbCB2YWx1ZSBpbnRvIHRoZSBhYm92ZSBlcXVh
dGlvbiBmb3IgY29tYmluYXRpb25zCj4gbGlrZSAxNDguNU1Iei8xLjAwMSBmb3IgNDQxMDBIeiAt
IHdlIHN0aWxsIGNhbGN1bGF0ZSB0aGUgY29ycmVjdCBDVFMKPiB2YWx1ZS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFJ1c3NlbGwgS2luZyA8cm1rK2tlcm5lbEBhcm0ubGludXgub3JnLnVrPgo+IC0tLQo+
ICBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2R3X2hkbWkuYyB8IDkyICsrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMo
KyksIDc2IGRlbGV0aW9ucygtKQoKSWYgeW91IHRha2UgbXkgZmVlZGJhY2sgYWJvdXQgeW91ciAi
ZHJtOiBicmlkZ2UvZHdfaGRtaTogYWRqdXN0IHBpeGVsCmNsb2NrIHZhbHVlcyBpbiBOIGNhbGN1
bGF0aW9uIiBwYXRjaCBbMV0sIGFsbCB0aGlzIG1hdGgganVzdCB3b3JrcyBvdXQKdG8gImN0cyA9
IHBpeGVsX2NsayAvIDEwMDAiLiAgLi4uYnV0IGRvaW5nIHRoZSBtYXRoIGRvZXMgZnV0dXJlIHBy
b29mCnVzIGEgYml0LCBzbyBpdCBzZWVtcyBsaWtlIGEgZ29vZCBpZGVhLgoKUmV2aWV3ZWQtYnk6
IERvdWdsYXMgQW5kZXJzb24gPGRpYW5kZXJzQGNocm9taXVtLm9yZz4KVGVzdGVkLWJ5OiBEb3Vn
bGFzIEFuZGVyc29uIDxkaWFuZGVyc0BjaHJvbWl1bS5vcmc+CgoKWzFdIGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcGF0Y2gvNjk3NTIyMS8KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwK
