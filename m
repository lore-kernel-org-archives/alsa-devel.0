From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v8 0/6] drm/bridge: sii902x: HDMI-audio support and some
 fixes
Date: Fri, 31 May 2019 15:59:03 +0200
Message-ID: <0d627548-0b53-6da3-8468-9bfa2d66cca4@samsung.com>
References: <CGME20190527134816epcas1p1498005cdec8554f27e15281095d4958d@epcas1p1.samsung.com>
 <cover.1558964241.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1558964241.git.jsarha@ti.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com
List-Id: alsa-devel@alsa-project.org

T24gMjcuMDUuMjAxOSAxNTo0NywgSnlyaSBTYXJoYSB3cm90ZToKPiBJIHRoaW5rIHRoZXNlIHNo
b3VsZCBiZSByZWFkeSBmb3IgYXBwbHlpbmcgdG8gZHJtLW1pc2MuCj4KPiBDaGFuZ2VzIHNpbmNl
IHY3Ogo+ICAtIERlYmFzZWQgb24gdG9wIG9mIHRoZSBsYXN0cyBkcm0tbWlzYy1uZXh0IGFuZCB0
ZXN0ZWQKPiAgLSAiZHQtYmluZGluZ3M6IGRpc3BsYXk6IHNpaTkwMng6IEFkZCBIRE1JIGF1ZGlv
IGJpbmRpbmdzIgo+ICAgIC0gRHJvcHBlZCBvZmYgIm9yIGhpZ2hlciB0byBhdm9pZCBjb25mbGlj
dCB3aXRoIHZpZGVvIHBvcnRzIgo+ICAgICAgYW5kIGFkZGVkICJSZXZpZXdlZC1ieTogUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz4iCj4KPiBUaGVyIHByZXZpb3VzIHJvdW5kOgo+IGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTA5MTkxNzMvCj4KPiBKeXJpIFNhcmhhICg1
KToKPiAgIGRybS9icmlkZ2U6IHNpaTkwMng6IFNldCBvdXRwdXQgbW9kZSB0byBIRE1JIG9yIERW
SSBhY2NvcmRpbmcgdG8gRURJRAo+ICAgZHJtL2JyaWRnZTogc2lpOTAyeDogcGl4ZWwgY2xvY2sg
dW5pdCBpcyAxMGtIeiBpbnN0ZWFkIG9mIDFrSHoKPiAgIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBz
aWk5MDJ4OiBSZW1vdmUgdHJhaWxpbmcgd2hpdGUgc3BhY2UKPiAgIGR0LWJpbmRpbmdzOiBkaXNw
bGF5OiBzaWk5MDJ4OiBBZGQgSERNSSBhdWRpbyBiaW5kaW5ncwo+ICAgZHJtL2JyaWRnZTogc2lp
OTAyeDogSW1wbGVtZW50IEhETUkgYXVkaW8gc3VwcG9ydAo+Cj4gVG9taSBWYWxrZWluZW4gKDEp
Ogo+ICAgZHJtL2JyaWRnZTogc2lpOTAyeDogYWRkIGlucHV0X2J1c19mbGFncwo+Cj4gIC4uLi9i
aW5kaW5ncy9kaXNwbGF5L2JyaWRnZS9zaWk5MDJ4LnR4dCAgICAgICB8ICA0MiArLQo+ICBkcml2
ZXJzL2dwdS9kcm0vYnJpZGdlL3NpaTkwMnguYyAgICAgICAgICAgICAgfCA0ODggKysrKysrKysr
KysrKysrKystCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTIyIGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pCj4KUXVldWVkIHRvIGRybS1taXNjLW5leHQuCgotLQpSZWdhcmRzCkFuZHJ6ZWoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
