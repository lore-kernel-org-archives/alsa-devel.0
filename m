From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
Date: Fri, 9 Oct 2015 17:00:36 +0100
Message-ID: <20151009160036.GZ32532@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <CAOMZO5COgoGU-3YNpnmSkctHMRDJ3=DuKc82Wb5zTTX7Bx2jNw@mail.gmail.com>
 <20151006181806.GS21513@n2100.arm.linux.org.uk>
 <CAOMZO5DaowTGQqN_NW7T2zv-P6a_YZUCumq4-m+OtpsKqFzELw@mail.gmail.com>
 <20151006185429.GU21513@n2100.arm.linux.org.uk>
 <CAOMZO5C8O0p6C0hrAvHzanru9W2f8-C7MWsm3+HumoyZ9Hu6Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5C8O0p6C0hrAvHzanru9W2f8-C7MWsm3+HumoyZ9Hu6Jw@mail.gmail.com>
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

T24gVHVlLCBPY3QgMDYsIDIwMTUgYXQgMDU6MjU6MTZQTSAtMDMwMCwgRmFiaW8gRXN0ZXZhbSB3
cm90ZToKPiBPbiBUdWUsIE9jdCA2LCAyMDE1IGF0IDM6NTQgUE0sIFJ1c3NlbGwgS2luZyAtIEFS
TSBMaW51eAo+IDxsaW51eEBhcm0ubGludXgub3JnLnVrPiB3cm90ZToKPiAKPiA+IE1ha2Ugc3Vy
ZSB5b3UgaGF2ZSB0aGUgQUxTQSBjb25maWcgZmlsZSwgYXMgYWxzYWxpYiB3b24ndCBnZXQgb24K
PiA+IHdpdGggZHctaGRtaSBvbmx5IGFjY2VwdGluZyAyNC1iaXQgYXVkaW8gd2l0aG91dCB0aGlz
LiAgQSBjb3B5IGlzCj4gPiBhdHRhY2hlZC4gIEl0IGFsc28gdGVsbHMgQUxTQSBob3cgdG8gZGVh
bCB3aXRoIG11bHRpLWNoYW5uZWwgYXVkaW8KPiA+IGFzIHdlbGwuCj4gCj4gVGhhbmtzLCBSdXNz
ZWxsIQo+IAo+IEdvdCBhdWRpbyB0byBwbGF5IG9uIG15IEhETUkgVFYgOi0pCj4gCj4gRm9yIHRo
ZSBlbnRpcmUgc2VyaWVzOgo+IAo+IFRlc3RlZC1ieTogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0
ZXZhbUBmcmVlc2NhbGUuY29tPgoKSnVzdCB0byBjb25maXJtIC0gdGhhdCdzIGZvciBfYWxsXyBv
ZiB0aGVzZSA4IHBhdGNoZXMsIGluY2x1ZGluZyB0aGUKY2hhbmdlcyB0byB0aGUgQUNSIGNvZGUg
aW4gdGhlIGxhc3QgZm91ciBwYXRjaGVzLCBhbmQgeW91J3JlIGhhcHB5IHRoYXQKSSBzZW5kIGFs
bCBvZiB0aGVzZToKCmRybTogYnJpZGdlL2R3X2hkbWktYWhiLWF1ZGlvOiBhZGQgYXVkaW8gZHJp
dmVyCmRybTogYnJpZGdlL2R3X2hkbWktYWhiLWF1ZGlvOiBwYXJzZSBFTEQgZnJvbSBIRE1JIGRy
aXZlcgpkcm06IGJyaWRnZS9kd19oZG1pLWFoYi1hdWRpbzogYmFzaWMgc3VwcG9ydCBmb3IgbXVs
dGktY2hhbm5lbCBQQ00gYXVkaW8KZHJtOiBicmlkZ2UvZHdfaGRtaS1haGItYXVkaW86IGFsbG93
IGxhcmdlciBidWZmZXIgc2l6ZXMKZHJtOiBicmlkZ2UvZHdfaGRtaTogYXZvaWQgYmVpbmcgcmVj
dXJzaXZlIGluIE4gY2FsY3VsYXRpb24KZHJtOiBicmlkZ2UvZHdfaGRtaTogYWRqdXN0IHBpeGVs
IGNsb2NrIHZhbHVlcyBpbiBOIGNhbGN1bGF0aW9uCmRybTogYnJpZGdlL2R3X2hkbWk6IHJlbW92
ZSByYXRpbyBzdXBwb3J0IGZyb20gQUNSIGNvZGUKZHJtOiBicmlkZ2UvZHdfaGRtaTogcmVwbGFj
ZSBDVFMgY2FsY3VsYXRpb24gZm9yIHRoZSBBQ1IKCi0tIApGVFRDIGJyb2FkYmFuZCBmb3IgMC44
bWlsZSBsaW5lOiBjdXJyZW50bHkgYXQgOS42TWJwcyBkb3duIDQwMGticHMgdXAKYWNjb3JkaW5n
IHRvIHNwZWVkdGVzdC5uZXQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
