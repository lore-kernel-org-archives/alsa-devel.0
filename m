From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5 4/6] drm: bridge/dw_hdmi-i2s-audio: add audio driver
Date: Sat, 8 Aug 2015 16:35:41 +0100
Message-ID: <20150808153540.GL7557@n2100.arm.linux.org.uk>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Yakir Yang <ykk@rock-chips.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, Paul Bolle <pebolle@tiscali.nl>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBKdW4gMjAsIDIwMTUgYXQgMTI6Mjg6MTVBTSArMDgwMCwgWWFraXIgWWFuZyB3cm90
ZToKPiBBZGQgQUxTQSBiYXNlZCBIRE1JIEkyUyBhdWRpbyBkcml2ZXIgZm9yIGR3X2hkbWkuIFNv
dW5kIGNhcmQKPiBkcml2ZXIgY291bGQgY29ubmVjdCB0byB0aGlzIGNvZGVjIHRocm91Z2ggdGhl
IGNvZGVjIGRhaSBuYW1lCj4gImR3LWhkbWktaTJzLWF1ZGlvIi4KCkknbSBhcHBseWluZyB0aGlz
IHBhdGNoIHRvIG15IHRyZWUgd2l0aCBzb21lIGNoYW5nZXMuICBJIGhhdmVuJ3Qgc2Vlbgphbnlv
bmUgYWNrIGl0LCBub3IgcmV2aWV3IGl0IGFueSBmdXJ0aGVyLiAgSSdtIGhvcGluZyBzb21lb25l
IGNhbiBhY2sKdGhpcyBwYXRjaCB3aXRoIHRoZSBmb2xsb3dpbmcgY2hhbmdlcyBiZWxvdyAtIEkn
bGwgYmUgcG9zdGluZyBpdCBhcwpwYXJ0IG9mIG15IGR3LWhkbWkgZGV2ZWwgdXBkYXRlcyBsYXRl
ciB0b2RheS4KCj4gKwlyZXQgPSByZXF1ZXN0X2lycShkdy0+ZGF0YS5pcnEsIHNuZF9kd19oZG1p
X2lycSwgSVJRRl9TSEFSRUQsCj4gKwkJCSAgImR3LWR3LWF1ZGlvIiwgZHcpOwoKCQkJICBEUklW
RVJfTkFNRSwgZHcpOwoKPiArTU9EVUxFX0FVVEhPUigiWWFraXIgWWFuZyA8eWtrQHJvY2stY2hp
cHMuY29tPiIpOwo+ICtNT0RVTEVfREVTQ1JJUFRJT04oIkRXIGR3IEF1ZGlvIEFTb0MgSW50ZXJm
YWNlIik7CgpGaXhpbmcgdGhpcyB0byBiZSAiU3lub3BzaXMgRGVzaWduV2FyZSBIRE1JIEkyUyBB
U29DIGludGVyZmFjZSIuCgo+ICtNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7Cj4gK01PRFVMRV9B
TElBUyhQTEFURk9STV9NT0RVTEVfUFJFRklYIERSSVZFUl9OQU1FKTsKClJlcGxhY2luZyBQTEFU
Rk9STV9NT0RVTEVfUFJFRklYIHdpdGggdGhlICJwbGF0Zm9ybToiIHN0cmluZy4KCj4gKwlpZiAo
aGRtaV9yZWFkYihoZG1pLCBIRE1JX0NPTkZJRzFfSUQpICYgSERNSV9DT05GSUcxX0FIQikgewo+
ICAJCXBkZXZpbmZvLm5hbWUgPSAiZHctaGRtaS1haGItYXVkaW8iOwoKRml4aW5nIHRoaXMgdG8g
YmUgImR3LWhkbWktaTJzLWF1ZGlvIi4KCi0tIApGVFRDIGJyb2FkYmFuZCBmb3IgMC44bWlsZSBs
aW5lOiBjdXJyZW50bHkgYXQgMTAuNU1icHMgZG93biA0MDBrYnBzIHVwCmFjY29yZGluZyB0byBz
cGVlZHRlc3QubmV0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bAo=
