From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 2/3] drm/vc4: Add HDMI audio support
Date: Tue, 28 Feb 2017 10:19:17 +0100
Message-ID: <20170228101917.40810aa9@bbrezillon>
References: <20170227202803.12855-1-eric@anholt.net>
 <20170227202803.12855-2-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170227202803.12855-2-eric@anholt.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, alsa-devel@alsa-project.org, Florian Fainelli <f.fainelli@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyNyBGZWIgMjAxNyAxMjoyODowMiAtMDgwMApFcmljIEFuaG9sdCA8ZXJpY0Bhbmhv
bHQubmV0PiB3cm90ZToKCj4gVGhlIEhETUkgZW5jb2RlciBJUCBlbWJlZHMgYWxsIG5lZWRlZCBi
bG9ja3MgdG8gb3V0cHV0IGF1ZGlvLCB3aXRoIGEKPiBjdXN0b20gREFJIGNhbGxlZCBNQUkgbW92
aW5nIGF1ZGlvIGJldHdlZW4gdGhlIHR3byBwYXJ0cyBvZiB0aGUgSERNSQo+IGNvcmUuICBUaGlz
IGRyaXZlciBub3cgZXhwb3NlcyBhIHNvdW5kIGNhcmQgdG8gbGV0IHVzZXJzIHN0cmVhbSBhdWRp
bwo+IHRvIHRoZWlyIGRpc3BsYXkuCj4gCj4gVXNpbmcgdGhlIGhkbWktY29kZWMgZHJpdmVyIGhh
cyBiZWVuIGNvbnNpZGVyZWQgaGVyZSwgYnV0IE1BSSBtZWFudAo+IGhhdmluZyB0byBzaWduaWZp
Y2FudGx5IHJld29yayBoZG1pLWNvZGVjLCBhbmQgaXQgd291bGQgaGF2ZSBsZWZ0Cj4gbGl0dGxl
IHNoYXJlZCBjb2RlIHdpdGggdGhlIEkyUyBtb2RlIGFueXdheS4KPiAKPiBUaGUgZW5jb2RlciBy
ZXF1aXJlcyB0aGF0IHRoZSBhdWRpbyBiZSBTUERJRi1mb3JtYXR0ZWQgZnJhbWVzIG9ubHksCj4g
d2hpY2ggYWxzYWxpYiB3aWxsIGZvcm1hdC1jb252ZXJ0IGZvciB1cy4KPiAKPiBUaGlzIHBhdGNo
IGlzIHRoZSBjb21iaW5lZCB3b3JrIG9mIEVyaWMgQW5ob2x0IChpbml0aWFsIHJlZ2lzdGVyIHNl
dHVwCj4gd2l0aCBhIHNlcGFyYXRlIGRtYWVuZ2luZSBkcml2ZXIgYW5kIHVzaW5nIHNpbXBsZS1h
dWRpby1jYXJkKSBhbmQKPiBCb3JpcyBCcmV6aWxsb24gKG1vdmluZyBpdCBhbGwgaW50byBIRE1J
LCBtYXNzaXZlIGRlYnVnIHRvIGdldCBpdAo+IGFjdHVhbGx5IHdvcmtpbmcpLCBhbmQgd2hpY2gg
RXJpYyBoYXMgdGhlIHBlcm1pc3Npb24gdG8gcmVsZWFzZS4KPiAKPiB2MjogRHJvcCAiLWF1ZGlv
IiBmcm9tIHNvdW5kIGNhcmQgbmFtZSwgc2luY2UgdGhhdCdzIGFscmVhZHkgaW1wbGllZAo+ICAg
ICAoc3VnZ2VzdGlvbiBieSBCb3JpcykKPiAKPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEFuaG9sdCA8
ZXJpY0BhbmhvbHQubmV0PgoKQWNrZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemls
bG9uQGZyZWUtZWxlY3Ryb25zLmNvbT4KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCg==
