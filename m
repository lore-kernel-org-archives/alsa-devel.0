From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 13/13] drm: bridge/dw_hdmi-ahb-audio: parse ELD from HDMI
 driver
Date: Wed, 27 May 2015 22:44:40 +0100
Message-ID: <20150527214439.GW2067@n2100.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1yD-0006lK-RC@rmk-PC.arm.linux.org.uk>
 <20150527104308.GA8341@phenom.ffwll.local>
 <20150527173125.GS2067@n2100.arm.linux.org.uk>
 <CAKMK7uFgqyHR4b+Q=_55S2Ojt-9+B-BRM4pKCRNwbRZ7kskpfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uFgqyHR4b+Q=_55S2Ojt-9+B-BRM4pKCRNwbRZ7kskpfA@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Yakir Yang <ykk@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXkgMjcsIDIwMTUgYXQgMTE6Mjk6NTJQTSArMDIwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBUaGUgb25seSBpc3N1ZSB0aGF0IG1pZ2h0IGJlCj4gdGhlcmUgd2l0aCB5b3VyIHN3
IGFwcHJvYWNoIGlzIHRoYXQgYSBjb25jdXJyZW50IHByb2JlL2hvdHBsdWcgaW4gZHJtCj4gbWln
aHQgZnJlZSB0aGUgZWRpZCBhbmQgaGVuY2UgdGhlIGVsZCwgd2hpbGUgdGhlIHNuZCBzaWRlIGlz
IHRyeWluZyB0bwo+IGNvcHkgdGhhdC4KClRhbGtpbmcgb25seSBhYm91dCB0aGUgcGFydGljdWxh
ciBjYXNlIG9mIGR3LWhkbWktYWhiLWF1ZGlvLi4uCgpUaGUgd29yc3QgdGhhdCBtYXkgaGFwcGVu
IGlzIHRoYXQgdGhlIEVMRCB3aWxsIGJlIG92ZXJ3cml0dGVuIHdpdGggYW4KdXBkYXRlIG9uIGhv
dHBsdWcgLSBpdCB3b24ndCBiZSBmcmVlZCB1bmxlc3MgdGhlIHVuZGVybHlpbmcgY29ubmVjdG9y
CmlzIGZyZWVkLCBhcyB0aGUgZWxkIGlzIHN0b3JlZCBhcyBhbiBhcnJheSBpbnNpZGUgc3RydWN0
IGRybV9jb25uZWN0b3IuCkJlZm9yZSB0aGUgRFJNIGNvbm5lY3RvciBpcyBmcmVlZCwgd2UgcHVs
bCB0aGUgYXVkaW8gZHJpdmVyJ3Mgc3RydWN0CmRldmljZSwgd2hpY2ggd2lsbCBkZXN0cm95IHRo
ZSBBTFNBIGRldmljZS4KCkhvcGVmdWxseSBBTFNBIGFscmVhZHkgY29wZXMgZ3JhY2VmdWxseSB3
aXRoIHRoZSByZW1vdmFsIG9mIGFuIGluLXVzZQpkZXZpY2UuLi4gaXQgc2hvdWxkIGRvLCBpdCdz
IG5vIGRpZmZlcmVudCBmcm9tIGhhdmluZyBhIFVTQiBhdWRpbyBkZXZpY2UKYW5kIHlvdSBwdWxs
IGl0IG91dCBvZiB0aGUgVVNCIHNvY2tldCB3aGlsZSB0aGUgZGV2aWNlIGlzIGluLXVzZS4KCihJ
dCdzIGFsc28gd29ydGggbm90aW5nIGFzIHdlJ3JlIHRhbGtpbmcgYWJvdXQgdGhpcywgdGhhdCBh
cyB0aGUgYXVkaW8Kc3RydWN0IGRldmljZSBpcyBhIGNoaWxkIG9mIHRoZSBIRE1JIGRldmljZSwg
YW55IFBNIGFjdGl2aXR5IHdpbGwgYmUKY29ycmVjdGx5IG9yZGVyZWQ6IHRoZSBjaGlsZCBnZXRz
IHN1c3BlbmRlZCBiZWZvcmUgdGhlIHBhcmVudC4uLiB0aGUKYXVkaW8gZGV2aWNlIGdldHMgc3Vz
cGVuZGVkIGJlZm9yZSB0aGUgdmlkZW8sIGFuZCByZXN1bWUgaXMgb2YgY291cnNlCnRoZSByZXZl
cnNlIG9yZGVyLikKCi0tIApGVFRDIGJyb2FkYmFuZCBmb3IgMC44bWlsZSBsaW5lOiBjdXJyZW50
bHkgYXQgMTAuNU1icHMgZG93biA0MDBrYnBzIHVwCmFjY29yZGluZyB0byBzcGVlZHRlc3QubmV0
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
