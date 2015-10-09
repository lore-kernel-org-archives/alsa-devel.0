From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
Date: Fri, 9 Oct 2015 17:11:52 +0100
Message-ID: <20151009161152.GB32532@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <CAOMZO5COgoGU-3YNpnmSkctHMRDJ3=DuKc82Wb5zTTX7Bx2jNw@mail.gmail.com>
 <20151006181806.GS21513@n2100.arm.linux.org.uk>
 <CAOMZO5DaowTGQqN_NW7T2zv-P6a_YZUCumq4-m+OtpsKqFzELw@mail.gmail.com>
 <20151006185429.GU21513@n2100.arm.linux.org.uk>
 <CAOMZO5C8O0p6C0hrAvHzanru9W2f8-C7MWsm3+HumoyZ9Hu6Jw@mail.gmail.com>
 <20151009160036.GZ32532@n2100.arm.linux.org.uk>
 <CAOMZO5Ah=AKXr__uuYsYp1KvSHptVp1NR7YUr7akzQJ3xW2XiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5Ah=AKXr__uuYsYp1KvSHptVp1NR7YUr7akzQJ3xW2XiA@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, Jaroslav Kysela <perex@perex.cz>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBPY3QgMDksIDIwMTUgYXQgMDE6MDI6MTFQTSAtMDMwMCwgRmFiaW8gRXN0ZXZhbSB3
cm90ZToKPiBPbiBGcmksIE9jdCA5LCAyMDE1IGF0IDE6MDAgUE0sIFJ1c3NlbGwgS2luZyAtIEFS
TSBMaW51eAo+IDxsaW51eEBhcm0ubGludXgub3JnLnVrPiB3cm90ZToKPiAKPiA+PiBUaGFua3Ms
IFJ1c3NlbGwhCj4gPj4KPiA+PiBHb3QgYXVkaW8gdG8gcGxheSBvbiBteSBIRE1JIFRWIDotKQo+
ID4+Cj4gPj4gRm9yIHRoZSBlbnRpcmUgc2VyaWVzOgo+ID4+Cj4gPj4gVGVzdGVkLWJ5OiBGYWJp
byBFc3RldmFtIDxmYWJpby5lc3RldmFtQGZyZWVzY2FsZS5jb20+Cj4gPgo+ID4gSnVzdCB0byBj
b25maXJtIC0gdGhhdCdzIGZvciBfYWxsXyBvZiB0aGVzZSA4IHBhdGNoZXMsIGluY2x1ZGluZyB0
aGUKPiA+IGNoYW5nZXMgdG8gdGhlIEFDUiBjb2RlIGluIHRoZSBsYXN0IGZvdXIgcGF0Y2hlcywg
YW5kIHlvdSdyZSBoYXBweSB0aGF0Cj4gPiBJIHNlbmQgYWxsIG9mIHRoZXNlOgo+ID4KPiA+IGRy
bTogYnJpZGdlL2R3X2hkbWktYWhiLWF1ZGlvOiBhZGQgYXVkaW8gZHJpdmVyCj4gPiBkcm06IGJy
aWRnZS9kd19oZG1pLWFoYi1hdWRpbzogcGFyc2UgRUxEIGZyb20gSERNSSBkcml2ZXIKPiA+IGRy
bTogYnJpZGdlL2R3X2hkbWktYWhiLWF1ZGlvOiBiYXNpYyBzdXBwb3J0IGZvciBtdWx0aS1jaGFu
bmVsIFBDTSBhdWRpbwo+ID4gZHJtOiBicmlkZ2UvZHdfaGRtaS1haGItYXVkaW86IGFsbG93IGxh
cmdlciBidWZmZXIgc2l6ZXMKPiA+IGRybTogYnJpZGdlL2R3X2hkbWk6IGF2b2lkIGJlaW5nIHJl
Y3Vyc2l2ZSBpbiBOIGNhbGN1bGF0aW9uCj4gPiBkcm06IGJyaWRnZS9kd19oZG1pOiBhZGp1c3Qg
cGl4ZWwgY2xvY2sgdmFsdWVzIGluIE4gY2FsY3VsYXRpb24KPiA+IGRybTogYnJpZGdlL2R3X2hk
bWk6IHJlbW92ZSByYXRpbyBzdXBwb3J0IGZyb20gQUNSIGNvZGUKPiA+IGRybTogYnJpZGdlL2R3
X2hkbWk6IHJlcGxhY2UgQ1RTIGNhbGN1bGF0aW9uIGZvciB0aGUgQUNSCj4gCj4gVGhhdCdzIGNv
cnJlY3QuIFRoYW5rcywgUnVzc2VsbAoKVGhhbmtzLiAgSSdsbCBkcm9wIHRoYXQgc2V0IGludG8g
bGludXgtbmV4dCB0b25pZ2h0LCBhbG9uZyB3aXRoIHRoZSBUREE5OTh4CmFuZCBBcm1hZGEgRFJN
IHBhdGNoZXMgdGhhdCBoYXZlbid0IHNlZW4gYW4gYWlyaW5nIHRoZXJlIHlldCAtIGJlZm9yZSBh
c2tpbmcKRGF2aWQgdG8gcHVsbCB0aGVtIG5leHQgd2VlayAodGhlIHRpbWVzY2FsZSBoYXMgc2xp
cHBlZC4uLikKCi0tIApGVFRDIGJyb2FkYmFuZCBmb3IgMC44bWlsZSBsaW5lOiBjdXJyZW50bHkg
YXQgOS42TWJwcyBkb3duIDQwMGticHMgdXAKYWNjb3JkaW5nIHRvIHNwZWVkdGVzdC5uZXQuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
