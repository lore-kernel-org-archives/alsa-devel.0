From: Yakir Yang <ykk@rock-chips.com>
Subject: Re: [PATCH v5 4/6] drm: bridge/dw_hdmi-i2s-audio: add audio driver
Date: Tue, 23 Jun 2015 11:06:19 +0800
Message-ID: <5588CD2B.3040807@rock-chips.com>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
 <1434967564.31094.20.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1434967564.31094.20.camel@x220>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

UGF1bCwKCuWcqCAyMDE1LzYvMjIgMTg6MDYsIFBhdWwgQm9sbGUg5YaZ6YGTOgo+IFNvbWV0aGlu
ZyBJIGRpZG4ndCBub3RpY2UgaW4gdjQsIHNvcnJ5Lgo+Cj4gT24gU2F0LCAyMDE1LTA2LTIwIGF0
IDAwOjI4ICswODAwLCBZYWtpciBZYW5nIHdyb3RlOgo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvZHdfaGRtaS1pMnMtYXVkaW8uYwo+PiArI2RlZmluZSBE
UklWRVJfTkFNRSAiZHctaGRtaS1pMnMtYXVkaW8iCj4+ICtNT0RVTEVfQUxJQVMoUExBVEZPUk1f
TU9EVUxFX1BSRUZJWCBEUklWRVJfTkFNRSk7Cj4gMCkgU2lkZSBub3RlOiB0aGlzIGlzIHRoZSBm
aXJzdCB0aW1lIHRoYXQgUExBVEZPUk1fTU9EVUxFX1BSRUZJWCBpcyB1c2VkCj4gaW5zaWRlIE1P
RFVMRV9BTElBUygpLiBCdXQgbm9uZSBvZiB0aGUgMTAwMCsgb3RoZXIgInBsYXRmb3JtOiIgYWxp
YXNlcwo+IGRvIHRoYXQuIEFuZCBuZWl0aGVyIGRvZXMgNS82IG9mIHRoaXMgc2VyaWVzISBUaGF0
IHN1Z2dlc3RzLCBJIHRoaW5rLAo+IHRoYXQgdGhpcyBzaG91bGRuJ3QgYmUgZG9uZS4KPgo+IFlv
dSBjb3VsZCBjb25zaWRlciBhZGRpbmcgc29tZXRoaW5nIGxpa2UKPiAgICAgICNkZWZpbmUgTU9E
VUxFX0FMSUFTX1BMQVRGT1JNKE5BTUUpIE1PRFVMRV9BTElBUyhQTEFURk9STV9NT0RVTEVfUFJF
RklYIE5BTUUpCj4KPiBCdXQgdGhlbiwgSSB0aGluaywgYWxsIHRoZSBjdXJyZW50IDEwMDArIHBs
YXRmb3JtOiBhbGlhc2VzIHNob3VsZCBiZQo+IGNvbnZlcnRlZCB0byB0aGF0IG1hY3JvLiBXb3Vs
ZCB0aGF0IGJlIHdvcnRoIGl0PwpZZWFoLCBJdCB3b3VsZCBiZSBob3JyaWJsZSB0byBjb3ZlcnRl
ZCB0byB0aGF0IG1hY3JvICA7KQoKPiAxKSBOb3cgb24gdG8gbXkgcmVtYXJrOiB0aGlzIGFsaWFz
IHNlZW1zIHRvIGJlIG9ubHkgdXNlZnVsIGlmIHRoZXJlIGFsc28KPiBpcyBhIHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2Ugd2l0aCBhICJkdy1oZG1pLWkycy1hdWRpbyIgbmFtZS4gQmVjYXVzZQo+IHRo
YXQgcGxhdGZvcm1fZGV2aWNlIHdvdWxkLCBiYWRseSBzdW1tYXJpemVkLCBmaXJlIG9mIGEKPiAi
TU9EQUxJQVM9cGxhdGZvcm06ZHctaGRtaS1pMnMtYXVkaW8iIHVldmVudCB3aGVuIGNyZWF0ZWQu
IFdoaWNoLCBpbiBpdHMKPiB0dXJuLCB3b3VsZCB0cmlnZ2VyIHVzZXJzcGFjZSB0byBsb2FkIHRo
aXMgbW9kdWxlLCBjb3JyZWN0Pwo+Cj4gQnV0IEkgdGhpbmsgdGhlcmUncyBubyBwbGF0Zm9ybV9k
ZXZpY2Ugd2l0aCBhICJkdy1oZG1pLWkycy1hdWRpbyIgbmFtZS4KPiBTbyBJIHdvbmRlciB3aGV0
aGVyIHRoaXMgTU9EVUxFX0FMSUFTKCkgaXMgYWN0dWFsbHkgbmVlZGVkLiBXaGF0IGJyZWFrcwo+
IGlmIHlvdSBsZWF2ZSBpdCBvdXQ/ClRoYW5rcyBmb3IgeW91ciBhdHRlbnRpdmUgY29tbWVudCAu
ICBBY3R1YWxseSB0aGVyZSBzaG91bGQgYmUgYW4gCnBsYXRmb3JtIGRldmljZSB0aGF0IG5hbWVk
ICJkdy1oZG1pLWkycy1hdWRpbyIgd2hpY2ggSSBtaXNzcGVsdCBpbiAKZHdfaGRtaS5jIGRyaXZl
ci4KCnRoYW5rcywKLSBZYWtpcgoKPiAoTGlrZXdpc2UgZm9yIDUvNiwgYnV0IHRoZXJlIHRoZSBw
bGF0Zm9ybV9kZXZpY2Ugc2hvdWxkIGhhdmUgYQo+ICJyb2NrY2hpcC1oZG1pLWF1ZGlvIiBuYW1l
LikKPgo+IFRoYW5rcywKPgo+Cj4gUGF1bCBCb2xsZQo+Cj4KPgo+CgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
