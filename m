From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [alsa-devel] [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
Date: Sat, 9 May 2015 17:55:36 +0100
Message-ID: <20150509165536.GS2067@n2100.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk>
 <554E3AA8.8060601@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <554E3AA8.8060601@iki.fi>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Yakir Yang <ykk@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBNYXkgMDksIDIwMTUgYXQgMDc6NDk6NDRQTSArMDMwMCwgQW5zc2kgSGFubnVsYSB3
cm90ZToKPiAoT2YgY291cnNlIGhhdmluZyB1c2Vyc3BhY2Ugc2V0IHRoZW0gcmVxdWlyZXMgdGhh
dCB0aGUgZGV2aWNlIGhhcyBhCj4gcHJvcGVyIGVudHJ5IGluIC91c3Ivc2hhcmUvYWxzYS9jYXJk
cyBhbmQgdGhlIHBjbSBkZXZpY2UgaXMgYWNjZXNzZWQgdmlhCj4gdGhlIHN0YW5kYXJkICJoZG1p
IiBvciAiaWVjOTU4IiBkZXZpY2UgbmFtZXMgd2hpY2ggcGVyZm9ybSB0aGUgY2hhbm5lbAo+IHN0
YXR1cyB3b3JkIHNldHVwLiBJIGd1ZXNzIHRoZSBBUk0gU29DIHN0dWZmIGdlbmVyYWxseSBkb2Vz
bid0IGJvdGhlcgo+IHdpdGggdGhhdCwgZXhwbGFpbmluZyBhIGJpdCB3aHkgc29tZSBrZXJuZWwg
ZHJpdmVycyBzZXQgdGhlbSBieSB0aGVtc2VsdmVzKS4KCkknbSBub3Qgc3VyZSB0aGF0J3Mgc3Vm
ZmljaWVudCAtIEkgaGF2ZW4ndCB5ZXQgZm91bmQgd2hlcmUgaW4gdGhlIEFMU0EKdXNlcnNwYWNl
LCB0aGUgQUVTIGJpdHMgYXJlIGFwcHJvcHJpYXRlbHkgc2V0IGFjY29yZGluZyB0byB0aGUgc2Ft
cGxlCnJhdGUuCgo+IEhETUlfRkNfQVVESUNPTkYyIHJlZ2lzdGVyIGRlZmF1bHQgdmFsdWUgaXMg
MHgwMCwgd2hpY2ggbWVhbnMgcGxhaW4KPiBzdGVyZW8gKHBlciBDRUEtODYxKS4gSWYgdGhpcyBp
cyB3aGF0IGdvZXMgb24gdG8gdGhlIEhETUkgbGluayBhcyB3ZWxsLAo+IHRoZSBhdWRpbyBzaW5r
IHNob3VsZCBpZ25vcmUgdGhlIG90aGVyIGNoYW5uZWxzLgo+IERpZCB5b3UgY2hlY2sgdGhhdCBt
dWx0aWNoYW5uZWwgUENNIGFjdHVhbGx5IHdvcmtzPyAobWF5YmUgSSdtIGp1c3QKPiBtaXNzaW5n
IHdoZXJlIENBIGlzIHNldCkKCkkgaGF2ZSBubyB3YXkgdG8gdGVzdCBtdWx0aWNoYW5uZWwgc3Vw
cG9ydCAtIG5vdCBldmVyeW9uZSBoYXMgYSBwbGV0aG9yYQpvZiBIRE1JIGRldmljZXMgcmVhZGls
eSBhY2Nlc3NpYmxlLgoKLS0gCkZUVEMgYnJvYWRiYW5kIGZvciAwLjhtaWxlIGxpbmU6IGN1cnJl
bnRseSBhdCAxMC41TWJwcyBkb3duIDQwMGticHMgdXAKYWNjb3JkaW5nIHRvIHNwZWVkdGVzdC5u
ZXQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
