From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
Date: Fri, 9 Oct 2015 13:02:11 -0300
Message-ID: <CAOMZO5Ah=AKXr__uuYsYp1KvSHptVp1NR7YUr7akzQJ3xW2XiA@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <CAOMZO5COgoGU-3YNpnmSkctHMRDJ3=DuKc82Wb5zTTX7Bx2jNw@mail.gmail.com>
 <20151006181806.GS21513@n2100.arm.linux.org.uk>
 <CAOMZO5DaowTGQqN_NW7T2zv-P6a_YZUCumq4-m+OtpsKqFzELw@mail.gmail.com>
 <20151006185429.GU21513@n2100.arm.linux.org.uk>
 <CAOMZO5C8O0p6C0hrAvHzanru9W2f8-C7MWsm3+HumoyZ9Hu6Jw@mail.gmail.com>
 <20151009160036.GZ32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20151009160036.GZ32532@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, Jaroslav Kysela <perex@perex.cz>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBPY3QgOSwgMjAxNSBhdCAxOjAwIFBNLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXgK
PGxpbnV4QGFybS5saW51eC5vcmcudWs+IHdyb3RlOgoKPj4gVGhhbmtzLCBSdXNzZWxsIQo+Pgo+
PiBHb3QgYXVkaW8gdG8gcGxheSBvbiBteSBIRE1JIFRWIDotKQo+Pgo+PiBGb3IgdGhlIGVudGly
ZSBzZXJpZXM6Cj4+Cj4+IFRlc3RlZC1ieTogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBm
cmVlc2NhbGUuY29tPgo+Cj4gSnVzdCB0byBjb25maXJtIC0gdGhhdCdzIGZvciBfYWxsXyBvZiB0
aGVzZSA4IHBhdGNoZXMsIGluY2x1ZGluZyB0aGUKPiBjaGFuZ2VzIHRvIHRoZSBBQ1IgY29kZSBp
biB0aGUgbGFzdCBmb3VyIHBhdGNoZXMsIGFuZCB5b3UncmUgaGFwcHkgdGhhdAo+IEkgc2VuZCBh
bGwgb2YgdGhlc2U6Cj4KPiBkcm06IGJyaWRnZS9kd19oZG1pLWFoYi1hdWRpbzogYWRkIGF1ZGlv
IGRyaXZlcgo+IGRybTogYnJpZGdlL2R3X2hkbWktYWhiLWF1ZGlvOiBwYXJzZSBFTEQgZnJvbSBI
RE1JIGRyaXZlcgo+IGRybTogYnJpZGdlL2R3X2hkbWktYWhiLWF1ZGlvOiBiYXNpYyBzdXBwb3J0
IGZvciBtdWx0aS1jaGFubmVsIFBDTSBhdWRpbwo+IGRybTogYnJpZGdlL2R3X2hkbWktYWhiLWF1
ZGlvOiBhbGxvdyBsYXJnZXIgYnVmZmVyIHNpemVzCj4gZHJtOiBicmlkZ2UvZHdfaGRtaTogYXZv
aWQgYmVpbmcgcmVjdXJzaXZlIGluIE4gY2FsY3VsYXRpb24KPiBkcm06IGJyaWRnZS9kd19oZG1p
OiBhZGp1c3QgcGl4ZWwgY2xvY2sgdmFsdWVzIGluIE4gY2FsY3VsYXRpb24KPiBkcm06IGJyaWRn
ZS9kd19oZG1pOiByZW1vdmUgcmF0aW8gc3VwcG9ydCBmcm9tIEFDUiBjb2RlCj4gZHJtOiBicmlk
Z2UvZHdfaGRtaTogcmVwbGFjZSBDVFMgY2FsY3VsYXRpb24gZm9yIHRoZSBBQ1IKClRoYXQncyBj
b3JyZWN0LiBUaGFua3MsIFJ1c3NlbGwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
